# V172-Q204R1 — Real Device Evidence Intake Analyze/Test Hygiene Audit Report

Q204R1 repairs stale test/analyzer hygiene discovered after Q204.

## Scope

- Update historical Q169R35/Q169R4 tests so they no longer compile against removed `MathLiveMainEditorSurface` static members.
- Keep `MathLiveMainEditorSurface` as a compatibility shim only.
- Keep active implementation in `MathLiveProductionEditorSurface`.
- Keep active HTML in `assets/mathlive/main_editor_prod.html`.
- Keep active bridge in `assets/mathlive/mathlive_prod_bridge.js`.
- Remove unused `_decodeJavascriptStringResult` helper.
- Extend the Q204 verifier with stale test scanner coverage.
- Do not mutate protected keyboard/MORE/long-press/Graph/History/Solution files.

## PASS boundary

This is static/analyze-test hygiene readiness only. It does not claim Flutter analyze, Flutter test, Flutter run, Android real-device, caret, premium visual, or final release PASS from the assistant environment.
