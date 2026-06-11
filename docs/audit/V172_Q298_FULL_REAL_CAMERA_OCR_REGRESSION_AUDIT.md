# V172-Q298 — Full Real Camera/OCR Regression Audit

## Scope

Q298 adds the **Full Real Camera/OCR Regression** contract after Q297. It is a regression court for the future PP-FormulaNet-S path, not a production OCR runtime implementation.

## Runtime Boundary

Q298 does **not**:

- add Paddle runtime
- add PaddleOCR dependency
- add JNI binding
- add MethodChannel runtime binding
- implement a native runtime handler
- bundle a PP-FormulaNet-S model binary
- enable production download
- load a private artifact
- start a native runtime
- call dummy input runtime
- run image-to-LaTeX inference
- open a real editable MathLive review
- mutate the workspace
- evaluate, solve, graph, or write Solution/History
- claim OCR PASS, Camera/OCR runtime PASS, premium PASS, store-ready PASS, or release PASS

## Regression Gates Preserved

The Q298 contract requires the full Q288 → Q297 chain to remain present:

- Q288 artifact source intake
- Q289 default-off dependency trial
- Q290 native handler / Android binding skeleton
- Q291 private model download + SHA verification contract
- Q292 private artifact load smoke contract
- Q293 runtime startup smoke contract
- Q294 dummy input runtime call contract
- Q295 image-to-LaTeX inference contract
- Q296 editable MathLive review contract
- Q297 approved workspace import contract

## Red-Line Protection

The phase is intentionally package-side only. Keyboard layout, MORE/template tray, long-press lists, MathLive production route, MathLive bridge, camera shell runtime, workspace runtime, Graph, Solution, History, AppShell, `main.dart`, AndroidManifest, MainActivity, splash/icon, solver/evaluator, camera dependencies, and Android toolchain are not changed.

## Honest Evidence State

Q298 is static/verifier/fresh-extract ready only. Real `flutter analyze`, `flutter test`, `flutter run`, Android device behavior, model download, SHA verification, runtime startup, image-to-LaTeX inference, editable MathLive review, user approval, and workspace import must be proven on the user's machine/device before any runtime PASS claim.
