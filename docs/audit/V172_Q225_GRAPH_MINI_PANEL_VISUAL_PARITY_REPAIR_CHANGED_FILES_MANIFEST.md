# V172-Q225 Changed Files Manifest

## Modified production files

- `lib/features/workspace/workspace_panel.dart`
  - Raises graph mini panel requested height responsively to improve canvas dominance without changing keyboard or expression card logic.
- `lib/features/graph/graph_card.dart`
  - Thins card chrome, reduces header/info row height, keeps canvas-first layout, and passes compact/tight fit state into the 3D mini surface.
- `lib/features/graph/graph_models.dart`
  - Makes new/restored graph previews trace-clean by default when trace metadata is absent.
- `lib/features/graph/graph_surface_3d.dart`
  - Suppresses compact 3D text clutter and uses tighter compact plot padding.

## Modified test/verifier/support files

- `test/graph_history_regression_test.dart`
  - Updates fullscreen trace default expectation after Q225 default trace-off policy.
- `tool/verify_graph_mini_panel_final_regression_freeze_v172_q224.mjs`
  - Accepts Q225 as a verified successor of Q224.
- `assets/mathlive/manifest.json`
  - Adds Q225 envelope and advances graph mini panel latest phase.
- `README.md`
  - Adds Q225 summary.

## Added files

- `lib/features/graph/graph_mini_panel_visual_parity_repair_policy.dart`
- `test/v172_q225_graph_mini_panel_visual_parity_repair_test.dart`
- `tool/verify_graph_mini_panel_visual_parity_repair_v172_q225.mjs`
- `docs/audit/V172_Q225_GRAPH_MINI_PANEL_VISUAL_PARITY_REPAIR_AUDIT_REPORT.md`
- `docs/audit/V172_Q225_GRAPH_MINI_PANEL_VISUAL_PARITY_REPAIR_CHANGED_FILES_MANIFEST.md`

## Protected files intentionally not modified

- `lib/features/keyboard/key_config.dart`
- `lib/features/keyboard/math_keyboard.dart`
- `lib/features/keyboard/bottom_dock.dart`
- `lib/features/keyboard/premium_key.dart`
- `lib/features/keyboard/long_press_popup.dart`
- `lib/features/workspace/template_tray.dart`
- `lib/features/history/history_controller.dart`
- `lib/features/history/history_panel.dart`
- `lib/features/solution/solution_steps_panel.dart`
- `assets/mathlive/main_editor_prod.html`
- `assets/mathlive/mathlive_prod_bridge.js`
- `lib/features/mathlive/mathlive_production_editor_surface.dart`
- `lib/app/app_shell.dart`
- `lib/main.dart`
- `android/app/src/main/AndroidManifest.xml`
- `android/app/src/main/res/values/styles.xml`
- `android/app/src/main/res/values-v31/styles.xml`
