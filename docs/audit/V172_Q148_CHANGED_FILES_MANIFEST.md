# V172-Q148 Changed Files Manifest

## Modified

- `assets/mathlive/mathlive_bridge.js`
  - Adds Q148 viewport fit/caret-follow functions and state telemetry.
- `assets/mathlive/main_editor.html`
  - Adds Q148 adaptive fit CSS classes for long structural expressions.
- `lib/features/mathlive/mathlive_main_editor_surface.dart`
  - Calls MathLive caret visibility hardening after runtime mount, keyboard commands, and external sync.
- `assets/mathlive/manifest.json`
  - Adds Q148 manifest entry and asset references.
- `README.md`
  - Documents Q148 status and truth constraints.

## Added

- `lib/features/mathlive/mathlive_viewport_fit_policy.dart`
- `tool/verify_mathlive_viewport_fit_v172_q148.mjs`
- `test/v172_q148_mathlive_viewport_fit_test.dart`
- `docs/audit/V172_Q148_MATHLIVE_VIEWPORT_FIT_AUDIT_REPORT.md`
- `docs/audit/V172_Q148_CHANGED_FILES_MANIFEST.md`

## Protected files not intentionally modified

- `lib/features/keyboard/key_config.dart`
- `lib/features/keyboard/math_keyboard.dart`
- `lib/features/keyboard/bottom_dock.dart`
- `lib/features/keyboard/long_press_popup.dart`
- `lib/features/keyboard/premium_key.dart`
- `lib/features/workspace/math_label.dart`
- `lib/features/workspace/template_tray.dart`
- `lib/features/solution/solution_steps_panel.dart`
- `lib/features/graph/graph_card.dart`
- `lib/features/history/history_controller.dart`
- `lib/features/history/history_panel.dart`
