# V172-Q382 Changed Files Manifest

Intentional additions:
- lib/features/workspace/workspace_expression_context_menu.dart
- lib/features/workspace/workspace_editor_actions.dart
- lib/features/workspace/workspace_math_action.dart
- lib/features/workspace/workspace_math_action_classifier.dart
- lib/features/workspace/workspace_math_action_resolver.dart
- lib/features/workspace/workspace_math_action_state.dart
- lib/features/workspace/workspace_expression_context_menu_q382_policy.dart
- test/v172_q382_workspace_expression_context_menu_test.dart
- tool/verify_workspace_expression_context_menu_v172_q382.mjs
- docs/audit/V172_Q382_WORKSPACE_EXPRESSION_CONTEXT_MENU_AUDIT_REPORT.md
- docs/audit/V172_Q382_WORKSPACE_EXPRESSION_CONTEXT_MENU_CHANGED_FILES_MANIFEST.md

Intentional modifications:
- lib/features/workspace/workspace_panel.dart
- lib/app/app_shell.dart
- lib/features/solution/solution_step_models.dart
- lib/features/mathlive/mathlive_main_editor_surface.dart
- assets/mathlive/manifest.json
- README.md
- tool/verify_mathpro_contract_report.json
- tool/verify_mathpro_contract_report.md

Protected surfaces intentionally not modified:
- keyboard layout/key config/math keyboard/bottom dock/premium key
- MORE/template tray source
- long-press popup/list/order
- MathLive production HTML/JS bridge assets
- Q381R1 native OCR bridge/runtime files
- Graph renderer/settings/fullscreen models
- History panel/controller/models
- Splash/icon resources
- pubspec.yaml, AndroidManifest.xml, Gradle build files
