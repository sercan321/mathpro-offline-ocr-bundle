# GRAPH / HISTORY V7 — Changed Files Manifest

## Scope
Faz 7: Premium History Item Sistemi geliştirme.

## Modified files

- `README.md`
  - Updated package label and documented V7 history item scope.

- `lib/app/app_shell.dart`
  - Wires `HistoryPanel.onResultSelected` to a safe `_useHistoryResult` handler.
  - Restores a valid previous calculation result into the editor without touching keyboard behavior.

- `lib/features/history/history_models.dart`
  - Adds `HistoryEntryKind` derived classification: calculation / graph / error.
  - Adds labels, result display helpers, graph range/trace metadata, copy payload, search index, result usability and typed dedupe signature.

- `lib/features/history/history_controller.dart`
  - Search now uses the consolidated `HistoryEntry.searchText` index.
  - Duplicate suppression now uses `HistoryEntry.dedupeSignature` so calculation, graph and error entries do not collapse into each other accidentally.

- `lib/features/history/history_panel.dart`
  - Adds `onResultSelected` callback propagation to item cards.

- `lib/features/history/history_item_card.dart`
  - Rebuilds item cards as typed premium cards with badges, expression block, result/error line, graph metadata chips, mini graph preview and contextual actions.
  - Adds long-press `Sonucu kullan` action when the result is valid.

- `test/graph_history_regression_test.dart`
  - Adds model tests for typed history entries.
  - Adds widget tests for calculation / graph / error item rendering and action wiring.

## Files intentionally not modified

- `lib/features/keyboard/key_config.dart`
- `lib/features/keyboard/math_keyboard.dart`
- `lib/features/keyboard/bottom_dock.dart`
- `lib/features/keyboard/long_press_popup.dart`
