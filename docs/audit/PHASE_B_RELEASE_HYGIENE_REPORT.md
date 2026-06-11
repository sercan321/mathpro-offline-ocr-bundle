# PHASE B RELEASE HYGIENE REPORT

## Forbidden artifacts policy

The release ZIP must not contain:

- `build/`
- `.dart_tool/`
- `.gradle/`
- `__pycache__/`
- `.pyc`
- `.pytest_cache/`
- temporary editor/cache folders

## Pre-package scan

Pre-package scan found no forbidden cache/build artifacts in the project tree.

## Package type

Full project ZIP, not patch ZIP.

## Meta package

A separate meta/audit ZIP is produced with audit reports and keyboard diff evidence.
