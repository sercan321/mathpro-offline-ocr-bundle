# V172-Q271 PP-FormulaNet-S Private Artifact Load Prototype Audit

Phase: `V172-Q271-PP-FORMULANET-S-PRIVATE-ARTIFACT-LOAD-PROTOTYPE`
Source phase: `V172-Q270-PP-FORMULANET-S-NATIVE-RUNTIME-BRIDGE-SKELETON`

## Scope

Q271 is a private-artifact-load prototype gate. It does not load a real PP-FormulaNet-S artifact, does not probe a real model, does not add Paddle/PaddleOCR/JNI/MethodChannel runtime binding, and does not run image-to-LaTeX inference.

## Guarded chain

- Q270 native/runtime bridge skeleton must be present.
- Future artifact path must be inside private app storage.
- Future artifact SHA256 must be present, exactly 64 hex characters, and accepted by the previous court before any load smoke.
- Artifact must not be bundled in base APK or loaded from assets.
- Model-format probe and load dry-run are documented before runtime or inference.
- Feature flag remains default-off and runtime remains disabled by default.
- MathLive editable review and explicit user approval remain mandatory before workspace import.
- Direct solve, Graph, Solution, and History from camera remain blocked.

## Explicit non-goals

- No Paddle runtime.
- No PaddleOCR dependency.
- No JNI/native bridge implementation.
- No MethodChannel runtime binding.
- No model binary.
- No production model URL.
- No real network download worker.
- No image-to-LaTeX inference.
- No artifact-load PASS, runtime PASS, OCR PASS, Flutter PASS, Android PASS, or release PASS claim.

## Protected runtime surfaces

Keyboard, MORE/template tray, long-press, MathLive production editor, Graph, Solution, History, AppShell, main.dart, AndroidManifest, MainActivity, splash, workspace panel, pubspec, Android toolchain files, camera shell, and Q260-Q270 guard files remain protected.
