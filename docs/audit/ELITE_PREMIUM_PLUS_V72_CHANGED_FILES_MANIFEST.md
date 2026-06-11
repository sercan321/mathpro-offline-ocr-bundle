# MathPro V72 — Changed Files Manifest

## Production files

1. `lib/features/keyboard/key_config.dart`
   - Removed fraction long-press entry for `□/□`.
   - Removed absolute-value long-press entry for `|□|`.
   - Reduced factorial long-press options to `□C□`, `□P□`.
   - Removed duplicate `log(□)` from `log` long-press options.

2. `pubspec.yaml`
   - Version bumped from `0.71.0+71` to `0.72.0+72`.

## Test files

3. `test/v72_long_press_cleanup_test.dart`
   - Locks V72 cleanup behavior with direct KeyConfig assertions.

## Audit files

4. `docs/audit/ELITE_PREMIUM_PLUS_V72_LONGPRESS_MORE_CLEANUP_AUDIT_REPORT.md`
5. `docs/audit/ELITE_PREMIUM_PLUS_V72_CHANGED_FILES_MANIFEST.md`
6. `docs/audit/ELITE_PREMIUM_PLUS_V72_HASH_REPORT.md`
7. `docs/audit/ELITE_PREMIUM_PLUS_V72_RELEASE_HYGIENE_REPORT.md`
8. `docs/audit/ELITE_PREMIUM_PLUS_V72_MANUAL_TEST_PROTOCOL.md`
