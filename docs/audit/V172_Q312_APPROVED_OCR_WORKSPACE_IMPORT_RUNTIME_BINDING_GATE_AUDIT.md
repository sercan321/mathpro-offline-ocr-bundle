# V172-Q312 — Approved OCR Workspace Import Runtime Binding Gate Audit

## Scope
Q312 adds a contract-only gate for the future path from an explicitly user-approved editable MathLive OCR review draft to a workspace import envelope.

## Runtime Boundary
This phase does **not** mutate the workspace, does **not** evaluate, does **not** solve, does **not** graph, does **not** write Solution/History, does **not** open a real review UI, does **not** call MethodChannel, does **not** invoke native runtime, does **not** add Paddle/PaddleOCR dependencies, does **not** bundle a model, and does **not** claim OCR/runtime/workspace-import PASS.

## Required Future Evidence
- Q311 editable MathLive review UI binding evidence.
- User-edited review draft evidence.
- Explicit user approval evidence before workspace import.
- Approved LaTeX draft and metadata preservation evidence.
- Real Android workspace import log evidence.
- Manual Solve/Graph after import only; no automatic solve/graph/Solution/History.

## Protected Surfaces
Keyboard layout, MORE/template tray, long-press lists, MathLive production route/bridge/surface, Graph, Solution, History, AppShell, Workspace runtime, Camera shell runtime, AndroidManifest, MainActivity, splash/icon, solver/evaluator, `pubspec.yaml`, camera dependencies, and Android toolchain remain unchanged.
