#!/bin/bash
# build home configs

set -x
cd "$(dirname "$0")" || exit

git config --global user.email "bryanlais@gmail.com"
git config --global user.name "Bryan Lai"

git clone --filter=blob:none --branch=master --single-branch --verbose https://github.com/NixOS/nixpkgs.git
cd nixpkgs || exit

nix run nixpkgs#nixpkgs-review -- pr --system aarch64-linux --extra-nixpkgs-config '{ allowInsecurePredicate = x: true; }' --eval local --build-args="$*" --no-shell --print-result 292611 || true
