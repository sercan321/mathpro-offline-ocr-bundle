# GRAPH_HISTORY_V13 — Changed Files Manifest

## Runtime source changes

- `lib/features/history/history_panel.dart`
  - Added the missing `final HistoryController controller;` field required by the existing constructor and existing `widget.controller` usage.
  - No behavior, layout, animation, graph, storage, keyboard, or long-press logic was changed.

## Documentation / audit changes

- `README.md`
  - Updated package status from V12 to V13.
  - Added the V13 final closure/static blocker repair section.

- `docs/audit/GRAPH_HISTORY_V13_FINAL_CLOSURE_REPORT.md`
- `docs/audit/GRAPH_HISTORY_V13_CHANGED_FILES_MANIFEST.md`
- `docs/audit/GRAPH_HISTORY_V13_RELEASE_HYGIENE_REPORT.md`
- `docs/audit/GRAPH_HISTORY_V13_STATIC_CHECK.txt`
- `docs/audit/GRAPH_HISTORY_V13_KNOWN_LIMITATIONS.md`
- `docs/audit/GRAPH_HISTORY_V13_MANUAL_DEVICE_CHECKLIST.md`
- `docs/audit/GRAPH_HISTORY_V13_AUTHORITATIVE_INDEX.md`
- `docs/audit/GRAPH_HISTORY_V13_CONTENTS.txt`

## Explicitly untouched keyboard files

- `lib/features/keyboard/key_config.dart`
- `lib/features/keyboard/math_keyboard.dart`
- `lib/features/keyboard/bottom_dock.dart`
- `lib/features/keyboard/long_press_popup.dart`
