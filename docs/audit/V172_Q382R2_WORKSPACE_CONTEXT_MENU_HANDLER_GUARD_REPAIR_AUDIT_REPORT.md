# V172-Q382R2 — Workspace Context Menu Handler Guard Repair Audit

## Scope
Q382R2 is a surgical repair over Q382R1. It does not add a new solver, graph engine, OCR runtime, keyboard layout, MORE behavior, long-press list, or MathLive production asset change.

## Repair intent
Q382 installed the workspace expression context menu and Q382R1 hardened overlay safe-area behavior. Q382R2 hardens the semantic-action contract so a selected math intent carries whether it requires a solver handler and whether the current engine has proven support.

## Implemented safeguards
- `WorkspaceSelectedMathAction` now stores `requiresSolverHandler` and `supportedByCurrentEngine`.
- AppShell routes those support flags into `SolutionStepsComposer`.
- Opening Solution with an unsupported selected handler shows a short premium status and does not claim execution.
- Solution metadata step states that the handler is not proven and the existing result was not changed as handler output.
- No fake factor/root/trig/calculus/complex solution output is generated.

## Protected surfaces
Unchanged by intent:
- keyboard layout/key_config/math_keyboard/premium_key/bottom_dock
- MORE/template tray
- long-press popup/list/order
- MathLive production HTML/JS bridge assets
- Q381R1 OCR native bridge/runtime and review-first import rule
- Graph
- History
- splash/icon
- solver/evaluator engine
- pubspec.yaml / Gradle / AndroidManifest

## Evidence status
Static/verifier/package checks only. No Flutter analyze/test/run or real-device PASS is claimed by this package.
