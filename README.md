# CV as code

One fact core, four targeted builds.

- `data/core.yaml` -- single source of truth: positions, dates, metrics, bullet pool.
- `data/variants/{ai,odoo,python,fde}.yaml` -- per-variant title, summary, skills line and bullet selection (by key, in order).
- `src/cv.typ` -- Typst template.

## Build

```bash
nix develop -c ./build.sh   # or: nix run .
```

PDFs land in `out/`.

## Editing rules

Facts and numbers live only in `core.yaml`. Variants only select and order them.
