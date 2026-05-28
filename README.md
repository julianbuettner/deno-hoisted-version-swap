# Deno 2.8 `nodeModulesLinker: "hoisted"` version mismatch

`package.json` pins `cli-cursor@3.1.0` as a direct dependency. A transitive
dep (`log-update` → `cli-cursor@^4.0.0`) wants a higher version. Deno hoists
`4.0.0` to the root and gives `log-update` version `3.1.0`. This differs from npm.

Originale feature PR: [denoland/deno#32788](https://github.com/denoland/deno/pull/32788).

Use `print-package-versions.sh` to print requested vs installed versions.

## Expected (npm)

```bash
rm -rf node_modules
npm install --install-strategy=hoisted
bash print-package-versions.sh
```

`npm` hoisted remains correct for this case.

## Actual (deno hoisted)

```bash
rm -rf node_modules
deno install --node-modules-dir=manual --node-modules-linker=hoisted
bash print-package-versions.sh
```

Versions: deno 2.8.0, npm 11.11.0, node 24.13.0.
