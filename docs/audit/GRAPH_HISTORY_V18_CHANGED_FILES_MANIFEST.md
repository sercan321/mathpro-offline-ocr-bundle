# GRAPH HISTORY V18 — CHANGED FILES MANIFEST

Runtime source changes:

- `lib/features/graph/graph_card.dart`
  - Replaced rigid graph action `Row` with a wrapping premium action rail to prevent horizontal overflow.

- `lib/features/history/history_controller.dart`
  - Added monotonic suffix to `_newId()` to prevent rapid test/runtime ID collisions.

- `lib/app/app_shell.dart`
  - Removed outgoing keyboard dock retention while history panel is open.

Test contract changes:

- `test/graph_history_regression_test.dart`
  - Scrolls result/graph inline actions into view before tapping them.

- `test/widget_test.dart`
  - Corrects graph keyboard-preservation assertion for the frozen Cebir expanded keyboard: `MORE`, `=`, `↵`.

Documentation/audit changes:

- `README.md`
- `docs/audit/GRAPH_HISTORY_V18_REAL_FLUTTER_TEST_REPAIR_REPORT.md`
- `docs/audit/GRAPH_HISTORY_V18_CHANGED_FILES_MANIFEST.md`
- `docs/audit/GRAPH_HISTORY_V18_RELEASE_HYGIENE_REPORT.md`
- `docs/audit/GRAPH_HISTORY_V18_STATIC_CHECK.txt`
- `docs/audit/GRAPH_HISTORY_V18_CONTENTS.txt`
