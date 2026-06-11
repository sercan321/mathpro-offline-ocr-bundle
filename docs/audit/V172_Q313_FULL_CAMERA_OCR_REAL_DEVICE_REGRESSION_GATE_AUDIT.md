# V172-Q313 — Full Camera/OCR Real Device Regression Gate Audit

## Scope

Q313 consolidates the Q302→Q312 PP-FormulaNet-S product-development Camera/OCR runtime chain into a final real-device regression gate. It is a **contract/static guard phase** only.

## What Q313 Adds

- Full Camera/OCR regression feature flag: `gauss.ppFormulaNetS.fullCameraOcrRealDeviceRegression.defaultOff`.
- Required evidence list for Q302 through Q312.
- Regression envelope fields for future Android device evidence.
- Regression states and error taxonomy.
- Explicit review-first and approval-first OCR rules.
- Direct workspace import/evaluate/solve/Graph/Solution/History blocking.
- Protected-surface preservation markers.

## What Q313 Does Not Do

Q313 does **not** add Paddle/PaddleOCR dependencies, does **not** implement JNI/native handler, does **not** bind MethodChannel, does **not** download or bundle a model, does **not** verify a real model SHA, does **not** load a private artifact, does **not** start runtime, does **not** call dummy runtime, does **not** run image-to-LaTeX, does **not** open editable MathLive review, does **not** import workspace content, and does **not** claim OCR/runtime/store/release PASS.

## Protected Surfaces

Keyboard layout, MORE/template tray, long-press lists, MathLive production route/bridge/surface, Camera shell, Workspace, Graph, Solution, History, AppShell, AndroidManifest, MainActivity, splash/icon, solver/evaluator, `pubspec.yaml`, camera dependencies, and Android toolchain remain protected and unchanged.

## Honest Boundary

Q313 can only be reported as static/verifier/fresh-extract ready. Real Flutter analyze/test/run and Android runtime/OCR behavior must be proven on the user's machine/device.
