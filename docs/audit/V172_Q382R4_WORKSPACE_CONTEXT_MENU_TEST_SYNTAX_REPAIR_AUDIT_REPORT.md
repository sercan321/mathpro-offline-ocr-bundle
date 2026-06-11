# V172-Q382R4 Workspace Context Menu Test Syntax Repair Audit

## Phase
V172-Q382R4-WORKSPACE-CONTEXT-MENU-TEST-SYNTAX-REPAIR

## Baseline
V172-Q382R3-WORKSPACE-CONTEXT-MENU-SOLUTION-INTENT-INJECTION-REPAIR

## Scope
Q382R4 is a surgical test/package correctness repair. It does not add new runtime features, does not change the workspace context menu runtime behavior, and does not alter keyboard, MORE, long-press, MathLive production assets, OCR, Graph, History, solver/evaluator, Gradle, pubspec, AndroidManifest, or splash/icon surfaces.

## Problem Found
The final Q382 context-menu test case introduced for Q382R3 ended with `}` instead of `});`. Because Flutter/Dart execution is not available in the assistant environment, this was caught by direct source inspection and verifier hardening. The issue could block `flutter test` even though the runtime feature files were otherwise present.

## Repair
- Closed the final `test(...)` invocation in `test/v172_q382_workspace_expression_context_menu_test.dart` with `});`.
- Added Q382R4 policy and manifest markers.
- Added `tool/verify_workspace_expression_context_menu_test_syntax_v172_q382r4.mjs` to enforce balanced test invocation closures and preserve Q382R3 exact-once solution intent injection markers.

## Runtime Behavior
Unchanged. The context menu, selected action chip, solution metadata routing, fake-solver block, and Q381R1 OCR safety remain as in Q382R3.

## No-Fake-Solver Contract
Preserved. Unsupported math actions still do not fabricate factor/root/trig/calculus/complex results.

## Protected Surfaces
No intentional changes to:
- Keyboard layout/key_config/math_keyboard/premium_key/bottom_dock
- MORE/template tray
- Long-press popup/list/order
- MathLive production HTML/JS bridge assets
- Q381R1 OCR native bridge/runtime/camera flow
- Graph
- History
- Solver/evaluator engine
- pubspec.yaml
- AndroidManifest.xml
- Gradle files
- splash/icon

## Verification
Expected static checks:
- `node tool/verify_workspace_expression_context_menu_test_syntax_v172_q382r4.mjs`
- `node tool/verify_workspace_expression_context_menu_solution_intent_injection_v172_q382r3.mjs`
- `node tool/verify_workspace_expression_context_menu_handler_guard_v172_q382r2.mjs`
- `node tool/verify_workspace_expression_context_menu_risk_repair_v172_q382r1.mjs`
- `node tool/verify_workspace_expression_context_menu_v172_q382.mjs`
- `node tool/verify_camera_ocr_runtime_risk_repair_v172_q381r1.mjs`
- `python3 tool/verify_mathpro_contract.py`

Flutter/Dart/Android SDK is not available in the assistant environment, so no assistant-side `flutter analyze`, `flutter test`, `flutter run`, real-device context-menu, or OCR PASS is claimed.
