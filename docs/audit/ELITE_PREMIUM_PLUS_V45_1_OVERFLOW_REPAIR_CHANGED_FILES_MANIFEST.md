# MathPro Elite Premium Plus V45.1 — Changed Files Manifest

## Runtime

1. `lib/features/keyboard/bottom_dock.dart`
   - Added `chipHeight` propagation from `_KeyboardLayout` to `_ShellTabs` and `_TabChip`.
   - Replaced fixed 28dp tab chip height with compact-safe calculated height.
   - Added `tabChipHeight => min(28.0, tabHeaderHeight)` so short devices do not overflow while normal devices keep the V45 visual size.

## Version / Docs

2. `pubspec.yaml`
   - Version updated to `0.45.1+451`.

3. `README.md`
   - Added V45.1 repair note at top.

4. `docs/audit/ELITE_PREMIUM_PLUS_V45_1_OVERFLOW_REPAIR_AUDIT_REPORT.md`
   - Added root cause and repair report.

5. `docs/audit/ELITE_PREMIUM_PLUS_V45_1_OVERFLOW_REPAIR_CHANGED_FILES_MANIFEST.md`
   - This changed file manifest.

6. `docs/audit/ELITE_PREMIUM_PLUS_V45_1_OVERFLOW_REPAIR_RELEASE_HYGIENE_REPORT.md`
   - Release hygiene report.

## Deliberately Unchanged

- `lib/features/keyboard/key_config.dart`
- `lib/features/keyboard/math_keyboard.dart`
- `lib/features/keyboard/long_press_popup.dart`
- Long-press source of truth
- Key labels / key order / tab order
