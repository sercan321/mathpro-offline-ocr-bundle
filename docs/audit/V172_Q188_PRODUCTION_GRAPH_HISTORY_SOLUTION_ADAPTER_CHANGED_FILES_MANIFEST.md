# V172-Q188 Changed Files Manifest

## Added

- `lib/features/mathlive/mathlive_production_graph_history_solution_adapter_policy.dart`
- `test/v172_q188_production_graph_history_solution_adapter_test.dart`
- `tool/verify_mathlive_production_graph_history_solution_adapter_v172_q188.mjs`
- `docs/audit/V172_Q188_PRODUCTION_GRAPH_HISTORY_SOLUTION_ADAPTER_AUDIT_REPORT.md`
- `docs/audit/V172_Q188_PRODUCTION_GRAPH_HISTORY_SOLUTION_ADAPTER_CHANGED_FILES_MANIFEST.md`

## Modified

- `lib/app/app_shell.dart`
- `assets/mathlive/manifest.json`
- `README.md`

## Protected files intentionally unchanged

- `lib/features/keyboard/key_config.dart`
- `lib/features/keyboard/math_keyboard.dart`
- `lib/features/keyboard/bottom_dock.dart`
- `lib/features/keyboard/premium_key.dart`
- `lib/features/keyboard/long_press_popup.dart`
- `lib/features/workspace/template_tray.dart`
- `lib/features/solution/solution_steps_panel.dart`
- `lib/features/graph/graph_card.dart`
- `lib/features/graph/graph_controller.dart`
- `lib/features/history/history_controller.dart`
- `lib/features/history/history_panel.dart`

## Intentional AppShell touch

`lib/app/app_shell.dart` now routes active production MathLive state through `MathLiveProductionGraphHistorySolutionAdapterPolicy` so the Q188 adapter boundary is explicit and auditable. This does not change keyboard layout, MORE, long-press, Graph UI, History UI, or Solution UI.
