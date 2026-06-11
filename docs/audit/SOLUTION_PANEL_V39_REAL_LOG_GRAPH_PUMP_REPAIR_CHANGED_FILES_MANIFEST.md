# V39 Changed Files Manifest

## Runtime changed
- `lib/features/graph/graph_painter.dart`
  - Defensive paint guard for tiny graph surfaces.
  - Safe label clamp helper to prevent inverted clamp range exceptions.

## Tests changed
- `test/widget_test.dart`
  - Replaced two `pumpAndSettle(...)` calls with deterministic fixed pumps in the real-log failing tests.

## Metadata changed
- `pubspec.yaml`
  - Version bumped to `0.39.0+39`.
- `docs/audit/SOLUTION_PANEL_V39_REAL_LOG_GRAPH_PUMP_REPAIR_AUDIT_REPORT.md`
- `docs/audit/SOLUTION_PANEL_V39_REAL_LOG_GRAPH_PUMP_REPAIR_CHANGED_FILES_MANIFEST.md`
- `docs/audit/SOLUTION_PANEL_V39_REAL_LOG_GRAPH_PUMP_REPAIR_RELEASE_HYGIENE_REPORT.md`
- `docs/audit/SOLUTION_PANEL_V39_REAL_LOG_GRAPH_PUMP_REPAIR_STATIC_CHECK.txt`

## Explicitly unchanged protected areas
- `lib/features/keyboard/key_config.dart`
- `lib/features/keyboard/bottom_dock.dart`
- `lib/features/keyboard/math_keyboard.dart`
- `lib/features/keyboard/premium_key.dart`
- `lib/features/keyboard/long_press_popup.dart`
- `lib/features/keyboard/long_press_indicator.dart`
- `lib/features/keyboard/key_model.dart`
- `lib/features/graph/graph_card.dart`
- `lib/features/graph/graph_surface.dart`
- `lib/features/history/history_panel.dart`
- `lib/app/app_shell.dart`
- `lib/features/solution/solution_steps_panel.dart`
- `lib/features/solution/solution_step_models.dart`
