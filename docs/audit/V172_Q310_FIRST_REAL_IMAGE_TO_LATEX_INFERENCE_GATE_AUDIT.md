# V172-Q310 — First Real Image-to-LaTeX Inference Gate Audit

## Purpose

Q310 continues the product-development OCR/runtime track after Q309 by defining the first real image-to-LaTeX inference gate for a future PP-FormulaNet-S integration.

This is a contract/static guard phase. It does **not** run image-to-LaTeX inference, does **not** send camera image bytes to native runtime, does **not** call MethodChannel, does **not** invoke native runtime, does **not** parse a LaTeX response, does **not** open editable MathLive review, and does **not** import anything into the workspace.

## Locked Flow

Future allowed flow remains:

```text
verified artifact + runtime startup + dummy call evidence
→ cropped image fixture + cropped-image SHA256 + crop/preprocess metadata
→ native PP-FormulaNet-S image-to-LaTeX candidate envelope
→ editable MathLive review
→ user correction
→ explicit user approval
→ future workspace import only after approval
```

## Required Evidence Before Real Inference

- Q309 dummy input runtime call gate is present.
- Real Q309 dummy runtime call evidence exists outside the static package.
- Dummy runtime call succeeded on a real Android device.
- Native MethodChannel binding exists.
- Native handler implementation exists.
- Verified private artifact path exists.
- Cropped image fixture is defined.
- Cropped image SHA256 is recorded.
- Crop/preprocess metadata is recorded.
- Real Android device inference log exists.
- Timeout, cancellation, memory-pressure, cleanup, and rollback boundaries are defined.
- Editable MathLive review is mandatory.
- Explicit user approval is mandatory before any workspace import.

## Forbidden In Q310

- Add Paddle/PaddleOCR/runtime dependency.
- Modify `MainActivity.kt`.
- Modify `AndroidManifest.xml`.
- Modify `pubspec.yaml`.
- Bind MethodChannel.
- Implement JNI/native handler.
- Send camera image to runtime.
- Run image-to-LaTeX inference.
- Parse a native LaTeX response.
- Open real editable MathLive review.
- Import to workspace.
- Auto-solve, auto-graph, or write Solution/History.
- Claim OCR, runtime, store-ready, or release PASS.

## Protected Surface Result

Keyboard layout, MORE/template tray, long-press lists, MathLive production route/bridge/surface, Camera shell, Workspace, Graph, Solution, History, AppShell, AndroidManifest, MainActivity, splash/icon, solver/evaluator, camera dependencies, and Android toolchain remain protected and unchanged.
