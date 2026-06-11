# Graph + Premium History V12 Changed Files Manifest

## Modified

- `README.md`
  - Updated title and status from V11 motion hardening to V12 regression-lock / final quality-gate hardening.
  - Added V12 regression-lock scope.

## Added

- `test/graph_history_v12_regression_lock_test.dart`
  - Locks frozen keyboard topology and critical long-press contracts.
  - Locks graph eligibility and sampling contracts.
  - Locks graph viewport validation.
  - Locks history schema/persistence/metadata/pinned/error contracts.
  - Locks runtime source drift scans for stale/dead UI surfaces.

- `docs/audit/GRAPH_HISTORY_V12_FINAL_AUDIT_REPORT.md`
- `docs/audit/GRAPH_HISTORY_V12_CHANGED_FILES_MANIFEST.md`
- `docs/audit/GRAPH_HISTORY_V12_RELEASE_HYGIENE_REPORT.md`
- `docs/audit/GRAPH_HISTORY_V12_STATIC_CHECK.txt`
- `docs/audit/GRAPH_HISTORY_V12_KNOWN_LIMITATIONS.md`
- `docs/audit/GRAPH_HISTORY_V12_MANUAL_DEVICE_CHECKLIST.md`
- `docs/audit/GRAPH_HISTORY_V12_CONTENTS.txt`

## Not modified

- `lib/features/keyboard/key_config.dart`
- `lib/features/keyboard/math_keyboard.dart`
- `lib/features/keyboard/bottom_dock.dart`
- `lib/features/keyboard/long_press_popup.dart`
