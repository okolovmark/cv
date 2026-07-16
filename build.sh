#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
mkdir -p out
for v in ai odoo python; do
  typst compile --root . --input variant="$v" src/cv.typ "out/cv-mark-okolov-$v.pdf"
  echo "built out/cv-mark-okolov-$v.pdf"
done
