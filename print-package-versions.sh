#!/bin/bash


echo top level cli-cursor wanted:
jq -r '.dependencies."cli-cursor"' package.json
echo top level cli-cursor installed:
jq -r .version node_modules/cli-cursor/package.json
echo

echo log-update cli-cursor wanted:
jq -r '.dependencies."cli-cursor"' ./node_modules/log-update/package.json
echo log-update cli-cursor installed:
jq -r .version ./node_modules/log-update/node_modules/cli-cursor/package.json
