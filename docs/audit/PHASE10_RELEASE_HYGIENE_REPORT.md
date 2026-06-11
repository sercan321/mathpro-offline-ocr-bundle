# MathPro Flutter Phase 10 — Release Hygiene Report

## Intended archive hygiene

The final full ZIP must not contain:

- `build/`
- `.dart_tool/`
- `.gradle/`
- `__pycache__/`
- `.pyc`
- `.pytest_cache/`
- temporary editor/cache files

## Package type

Phase 10 is a full project package. It is not a patch zip.

## Platform note

The Android source tree includes Flutter Android build files and `MainActivity.kt`. Machine-specific `android/local.properties` is intentionally not included; Flutter/Android Studio generates it locally.

No iOS scaffold is included in this package. Treat it as Android-focused until iOS platform files are generated and audited separately.
