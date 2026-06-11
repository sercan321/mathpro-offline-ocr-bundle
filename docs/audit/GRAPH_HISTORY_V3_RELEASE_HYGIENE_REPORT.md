# GRAPH/HISTORY V3 — Release Hygiene Report

## ZIP hygiene rule

The generated full ZIP excludes:

- `build/`
- `.dart_tool/`
- `.gradle/`
- `__pycache__/`
- `*.pyc`
- `.pytest_cache/`
- temporary package staging folders
- stale generated output folders

## Static hygiene result

No forbidden cache/build paths were found before packaging.

## Delivery form

- Full project ZIP is provided.
- Meta/audit ZIP is provided separately.
- This is not a patch-only delivery.
