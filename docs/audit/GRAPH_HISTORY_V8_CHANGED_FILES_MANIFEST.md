# Graph / Premium History V8 Changed Files Manifest

Changed files compared with V7 baseline:

- `README.md`
  - Updated release scope from V7 item system to V8 interaction hardening.
  - Added V8 history interaction notes and honest verification status.

- `lib/app/app_shell.dart`
  - Removed duplicate `tabName` argument.
  - History entry/result restore now closes history and clears stale graph preview state.

- `lib/features/history/history_controller.dart`
  - Added `entryById`.
  - Changed `delete` to return the removed entry.
  - Added `clearAndReturn`, `restoreDeleted`, and `restoreBatch` for undo-safe interactions.

- `lib/features/history/history_item_card.dart`
  - Rebuilt cleanly to remove V7 brace drift.
  - Split primary tap from explicit edit action.
  - Kept contextual inline and long-press actions: edit, result use, graph open, copy, pin/unpin, delete.

- `lib/features/history/history_panel.dart`
  - Rebuilt cleanly to remove V7 brace drift.
  - Added graph-primary tap routing.
  - Added delete undo, pin feedback, clear confirmation, and clear undo.
  - Preserved search, empty state, upward close gesture, and premium panel chrome.

- `test/graph_history_regression_test.dart`
  - Removed duplicate old-handle assertion.
  - Added regression coverage for graph primary tap, delete undo, clear confirmation/undo, and controller restore helpers.

- `docs/audit/GRAPH_HISTORY_V8_REPORT.md`
  - This audit report.

- `docs/audit/GRAPH_HISTORY_V8_CHANGED_FILES_MANIFEST.md`
  - This changed-files manifest.

- `docs/audit/GRAPH_HISTORY_V8_RELEASE_HYGIENE_REPORT.md`
  - Release hygiene report.

- `docs/audit/GRAPH_HISTORY_V8_STATIC_CHECK.txt`
  - Static check summary.

- `docs/audit/GRAPH_HISTORY_V8_CONTENTS.txt`
  - Package file listing.
