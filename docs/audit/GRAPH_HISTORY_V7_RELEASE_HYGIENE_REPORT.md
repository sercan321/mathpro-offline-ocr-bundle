# GRAPH / HISTORY V7 — Release Hygiene Report

## ZIP policy

Full project ZIP only. No patch-only delivery.

## Exclusions

The release ZIP excludes:

- `build/`
- `.dart_tool/`
- `.gradle/`
- `.pytest_cache/`
- `__pycache__/`
- `*.pyc`
- temporary package staging directories

## Status

Static scan did not find forbidden build/cache artifacts in the packaged project tree before ZIP creation.
