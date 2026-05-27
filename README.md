# Deno 2.8 `nodeModulesLinker: "hoisted"` — direct dep pin ignored

`package.json` pins `cli-cursor@3.1.0` as a direct dependency. A transitive
dep (`log-update` → `cli-cursor@^4.0.0`) wants a higher version. Deno hoists
`4.0.0` to the root, ignoring the direct pin. npm honors the pin.

Related: [denoland/deno#32788](https://github.com/denoland/deno/pull/32788).

## Expected (npm)

```bash
$ npm install
$ jq -r .version node_modules/cli-cursor/package.json
3.1.0
$ jq -r .version node_modules/cli-cursor/node_modules/restore-cursor/package.json
4.0.0
```

## Actual (deno)

```bash
$ deno install
$ jq -r .version node_modules/cli-cursor/package.json
4.0.0
$ jq -r .version node_modules/cli-cursor/node_modules/restore-cursor/package.json
3.1.0
```

## Summary

Two versions are swapped:

1. The direct pin `cli-cursor@3.1.0` is overridden — root gets `4.0.0`.
2. The nested `restore-cursor` under `cli-cursor@4.0.0` is `3.1.0`, even
   though `cli-cursor@4.0.0` declares `restore-cursor: ^4.0.0`.

The 3.1.0 / 4.0.0 pair that belongs together ends up split across levels.

Versions: deno 2.8.0, npm 11.11.0, node 24.13.0.
