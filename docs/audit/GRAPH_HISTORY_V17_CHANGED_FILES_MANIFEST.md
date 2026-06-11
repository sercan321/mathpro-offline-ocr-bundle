# GRAPH_HISTORY_V17 — Changed Files Manifest

Runtime Dart changes:
- `lib/features/history/history_item_card.dart`
  - Fixed `_InlineActions` invalid `widget.*` access by using the widget's constructor fields.
- `lib/features/graph/graph_settings_sheet.dart`
  - Replaced deprecated `activeColor` with `activeThumbColor` and `activeTrackColor`.

Test changes:
- `test/graph_history_v17_analyze_repair_test.dart`
  - Locks the exact V17 analyzer/test-load repair.

Documentation / audit changes:
- `README.md`
- `docs/audit/GRAPH_HISTORY_V16_AUTHORITATIVE_INDEX.md`
- `docs/audit/GRAPH_HISTORY_V17_AUTHORITATIVE_INDEX.md`
- `docs/audit/GRAPH_HISTORY_V17_ANALYZE_TEST_REPAIR_REPORT.md`
- `docs/audit/GRAPH_HISTORY_V17_CHANGED_FILES_MANIFEST.md`
- `docs/audit/GRAPH_HISTORY_V17_RELEASE_HYGIENE_REPORT.md`
- `docs/audit/GRAPH_HISTORY_V17_STATIC_CHECK.txt`
- `docs/audit/GRAPH_HISTORY_V17_CONTENTS.txt`

Frozen keyboard files intentionally unchanged:
- `lib/features/keyboard/key_config.dart`
- `lib/features/keyboard/math_keyboard.dart`
- `lib/features/keyboard/bottom_dock.dart`
- `lib/features/keyboard/long_press_popup.dart`
