# Graph / Premium History V4 — Changed Files Manifest

## Modified runtime files

- `lib/features/graph/graph_fullscreen_page.dart`
  - Rebuilt fullscreen graph mode as a premium stateful surface.
  - Added state-preserving route exit for app back and Android/system back attempts.
  - Added graph-surface-size-based pan math.
  - Added pinch zoom, double-tap reset, trace toggle, viewport chip, gesture hint and premium fullscreen controls.

## Modified test files

- `test/graph_history_regression_test.dart`
  - Added a widget regression test that verifies fullscreen graph controls are present and interactive.
  - Kept previous graph eligibility, evaluator, curve sampling and history serialization tests.

## Modified documentation/audit files

- `README.md`
- `docs/audit/GRAPH_HISTORY_V4_CHANGED_FILES_MANIFEST.md`
- `docs/audit/GRAPH_HISTORY_V4_FINAL_AUDIT_REPORT.md`
- `docs/audit/GRAPH_HISTORY_V4_KNOWN_LIMITATIONS.md`
- `docs/audit/GRAPH_HISTORY_V4_RELEASE_HYGIENE_REPORT.md`
- `docs/audit/GRAPH_HISTORY_V4_STATIC_CHECK.md`
- `docs/audit/GRAPH_HISTORY_V4_CONTENTS.txt`

## Explicitly untouched keyboard-critical files

- `lib/features/keyboard/key_config.dart`
- `lib/features/keyboard/math_keyboard.dart`
- `lib/features/keyboard/bottom_dock.dart`
- `lib/features/keyboard/long_press_popup.dart`

These files were hash-checked after the V4 work and remained unchanged.
