# GRAPH/HISTORY V10 Changed Files Manifest

## Modified runtime files

- `lib/app/app_shell.dart`
  - Added active graph history entry linkage.
  - Graph open now stores the linked history item ID.
  - Graph opened from history now links back to the same item.
  - Trace/reset/zoom/settings/fullscreen-return updates now synchronize active graph metadata back into the linked history item.

- `lib/features/graph/graph_models.dart`
  - Added `GraphExpression.historyIdentityKey` for graph-history dedupe identity.

- `lib/features/history/history_controller.dart`
  - `addGraph` now returns the graph history entry.
  - Reopening the same graph upserts the existing graph entry instead of duplicating it.
  - Added `updateGraphEntry` for in-place graph metadata synchronization.
  - Added a shared mutation commit helper for trim/persist/notify consistency.

- `lib/features/history/history_models.dart`
  - Added graph storage key metadata.
  - Expanded `HistoryEntry.copyWith` to support graph metadata updates while preserving pinned state.

## Modified test/documentation files

- `test/graph_history_regression_test.dart`
  - Added V10 graph-history linkage regression coverage.

- `README.md`
  - Updated package status from V9 to V10.

## Added audit files

- `docs/audit/GRAPH_HISTORY_V10_REPORT.md`
- `docs/audit/GRAPH_HISTORY_V10_CHANGED_FILES_MANIFEST.md`
- `docs/audit/GRAPH_HISTORY_V10_RELEASE_HYGIENE_REPORT.md`
- `docs/audit/GRAPH_HISTORY_V10_STATIC_CHECK.txt`
- `docs/audit/GRAPH_HISTORY_V10_CONTENTS.txt`

## Keyboard files intentionally unchanged

- `lib/features/keyboard/key_config.dart`
- `lib/features/keyboard/math_keyboard.dart`
- `lib/features/keyboard/bottom_dock.dart`
- `lib/features/keyboard/long_press_popup.dart`
