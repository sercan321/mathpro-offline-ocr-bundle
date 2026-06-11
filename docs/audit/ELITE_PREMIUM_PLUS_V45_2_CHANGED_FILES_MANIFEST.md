# MathPro V45.2 — Changed Files Manifest

## Runtime files

- `lib/features/keyboard/bottom_dock.dart`
  - Added a 3dp internal layout rounding guard to stop the real 1.8px BottomDock Column overflow.

- `lib/features/keyboard/long_press_popup.dart`
  - Restored bounded integral long-press chip width to 108dp to satisfy the locked `>=104` regression contract.

## Metadata/docs

- `pubspec.yaml`
  - Version bumped to `0.45.2+452`.

- `README.md`
  - Updated package status and required user-side test instructions.

- `docs/audit/ELITE_PREMIUM_PLUS_V45_2_REAL_LOG_REPAIR_AUDIT_REPORT.md`
  - Added this repair audit.

- `docs/audit/ELITE_PREMIUM_PLUS_V45_2_CHANGED_FILES_MANIFEST.md`
  - Added changed-file manifest.

- `docs/audit/ELITE_PREMIUM_PLUS_V45_2_RELEASE_HYGIENE_REPORT.md`
  - Added release hygiene report.
