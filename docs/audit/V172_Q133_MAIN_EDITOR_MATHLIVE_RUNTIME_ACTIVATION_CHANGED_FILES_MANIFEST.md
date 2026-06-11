# V172-Q133 Changed Files Manifest

## Added

- `assets/mathlive/main_editor.html`
- `lib/features/mathlive/mathlive_main_editor_surface.dart`
- `lib/features/mathlive/mathlive_main_editor_runtime_activation_v172_q133_policy.dart`
- `docs/audit/V172_Q133_MAIN_EDITOR_MATHLIVE_RUNTIME_ACTIVATION_AUDIT_REPORT.md`
- `docs/audit/V172_Q133_MAIN_EDITOR_MATHLIVE_RUNTIME_ACTIVATION_CHANGED_FILES_MANIFEST.md`
- `tool/verify_main_editor_mathlive_runtime_activation_v172_q133.mjs`

## Modified

- `assets/mathlive/mathlive_bridge.js`
- `lib/app/app_shell.dart`
- `lib/features/workspace/workspace_panel.dart`
- `lib/state/calculator_controller.dart`

## Protected surface note

This phase intentionally touches `lib/app/app_shell.dart` only for main editor engine routing because the user confirmed the old cursor motor was still active and ineffective. Keyboard, MORE, long-press, Graph, History, Solution, MathLabel, TemplateTray, and legacy cursor files remain intact.
