# V172-Q308 Runtime Startup Real Device Smoke Gate Audit

## Scope

Q308 defines the package-side gate for a future PP-FormulaNet-S runtime startup smoke on a real Android device.

This is a **contract/static guard phase**. It does **not** start a native runtime, call MethodChannel, bind JNI, load a real model artifact, warm up a model, run image-to-LaTeX inference, open MathLive review, import workspace content, or claim OCR/runtime/store/release PASS.

## Required Evidence Before Any Future Runtime Startup

- Q307 private artifact load smoke evidence.
- Q306 verified private artifact path.
- Q306 expected/actual SHA256 match.
- Q306 atomic move evidence.
- Q307 model-format probe evidence.
- Native runtime package selection.
- Android ABI matrix review.
- Real Android device startup log.
- Startup timeout / memory-pressure policy.
- Rollback and cleanup plan.
- Editable MathLive review and explicit user approval remain mandatory before any OCR workspace import.

## Protected Surfaces

Keyboard layout, MORE/template tray, long-press lists, MathLive production route/bridge/surface, Camera shell, Workspace, Graph, Solution, History, AppShell, AndroidManifest, MainActivity, splash/icon, solver/evaluator, `pubspec.yaml`, camera dependencies, and Android toolchain remain unchanged.

## Honest Boundary

Runtime startup is blocked until real device evidence exists. No OCR PASS, Camera/OCR runtime PASS, store-ready PASS, or release PASS is claimed in Q308.
