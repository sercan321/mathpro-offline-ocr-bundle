# MathPro Graph/History V2 Changed Files Manifest

## Modified runtime files

- `pubspec.yaml`
  - Added `shared_preferences` for conscious, lightweight history persistence.
- `lib/app/app_shell.dart`
  - Connected graph preview actions to real viewport state changes: trace toggle, reset, zoom in/out, settings apply, fullscreen state return.
- `lib/features/workspace/workspace_panel.dart`
  - Passed graph action callbacks into the graph card without touching keyboard layout or key contracts.
- `lib/features/graph/graph_models.dart`
  - Added graph display flags, viewport reset, copyWith expansion, and JSON serialization for history persistence.
- `lib/features/graph/graph_eligibility.dart`
  - Hardened classification for explicit `x`, `y = f(x)`, numeric constants, and implicit `x/y` equations.
- `lib/features/graph/graph_painter.dart`
  - Added grid/axis toggles, safer range handling, tan/discontinuity break protection, and log10/log2 support.
- `lib/features/graph/graph_card.dart`
  - Replaced future-only action chips with real trace/reset/zoom/settings callbacks.
- `lib/features/graph/graph_fullscreen_page.dart`
  - Converted to stateful fullscreen graph with real trace, zoom, pan-by-drag, reset, settings, and state return.
- `lib/features/graph/graph_settings_sheet.dart`
  - Replaced static settings display with validated editable ranges, grid/axis/trace toggles, curve color choices, reset, and apply.
- `lib/features/history/history_controller.dart`
  - Added persistence restore/save, search filtering, and stable sectioning.
- `lib/features/history/history_models.dart`
  - Added JSON serialization for calculation and graph history entries.
- `lib/features/history/history_panel.dart`
  - Replaced disabled search icon with real premium search field and filtered sections.
- `lib/features/history/history_storage.dart`
  - Implemented shared_preferences-backed storage with safe fallback.
- `lib/features/history/history_item_card.dart`
  - Added copy action to long-press sheet while preserving edit/pin/delete/graph actions.

## Added tests

- `test/graph_history_regression_test.dart`
  - Locks graph eligibility, graph evaluator primitives, in-memory history sections/pinning/search, and graph history serialization.

## Not modified

Keyboard contract files were intentionally not edited:

- `lib/features/keyboard/key_config.dart`
- `lib/features/keyboard/math_keyboard.dart`
- `lib/features/keyboard/bottom_dock.dart`
- `lib/features/keyboard/long_press_popup.dart`
