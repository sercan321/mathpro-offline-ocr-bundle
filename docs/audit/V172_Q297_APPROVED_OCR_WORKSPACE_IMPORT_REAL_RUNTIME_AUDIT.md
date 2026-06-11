# V172-Q297 Approved OCR Workspace Import Real Runtime Audit

## Scope

Q297 adds a contract-only approved OCR workspace import gate after Q296 editable MathLive review. It does not mutate the workspace and does not run OCR. The phase exists to define what must be true before a user-approved OCR review draft can become a workspace expression candidate in a later real-runtime phase.

## Runtime Boundary

Q297 deliberately keeps the runtime boundary closed:

- no real workspace import is executed;
- no automatic evaluate is enabled;
- no automatic solve, Graph, Solution, or History write is enabled;
- no Paddle/PaddleOCR runtime dependency is added;
- no JNI/native handler implementation is added;
- no MethodChannel runtime binding is added;
- no model binary or production download path is added;
- no OCR, workspace-import, store-ready, or release PASS is claimed.

## Required Future Evidence

A future real import phase must provide user-side evidence for:

- Q296 editable MathLive review opening;
- editable draft correction before approval;
- explicit user approval for workspace import;
- approved LaTeX draft preservation;
- review, engine, crop, and image SHA metadata preservation;
- no direct evaluate/solve/Graph/Solution/History side effects;
- real Flutter analyze/test/run and Android device behavior.

## Red-Line Preservation

Keyboard, MORE/template tray, long-press lists, MathLive production route, Graph, Solution, History, AppShell, Workspace runtime, Camera shell runtime, AndroidManifest, MainActivity, splash/icon, solver/evaluator, pubspec dependencies, and Android toolchain are not changed by this phase.
