# Final Release Hygiene Report

## Required exclusions

The final ZIP must not include:

- `build/`
- `.dart_tool/`
- `.gradle/`
- `__pycache__/`
- `.pyc`
- `.pytest_cache/`
- temporary interpreter/cache outputs

## Verification

A package hygiene scan is performed before final ZIP creation. See the final chat delivery note for the exact scan result.
