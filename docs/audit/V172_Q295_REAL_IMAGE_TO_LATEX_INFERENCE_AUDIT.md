# V172-Q295 — First Real Image-to-LaTeX Inference Audit

## Scope

Q295 adds the guarded First Real Image-to-LaTeX Inference contract after Q294. The package now defines the future image request envelope, candidate result envelope, crop/preprocess/SHA/ABI evidence requirements, runtime candidate fields, timeout/cancellation/memory policy, review-first boundary, and direct workspace/solve/Graph/Solution/History blocks.

## Runtime Boundary

This phase intentionally does not run real image-to-LaTeX inference. It does not invoke MethodChannel, JNI, native runtime, Paddle, or PaddleOCR. It does not send a camera image to any runtime, does not parse a real LaTeX candidate, does not import to workspace, and does not trigger Solve, Graph, Solution, or History.

## Evidence Required Before Future Real Inference

- Q294 real dummy-input runtime call evidence.
- Q293 runtime startup evidence.
- Verified private artifact path.
- Expected/actual SHA256 match.
- Model format probe evidence.
- MethodChannel and native handler evidence.
- Cropped image path and SHA256.
- Crop bounds, rotation, orientation, lighting, focus, and preprocess metadata.
- Latency, peak-memory, timeout, and cancellation evidence.
- Editable MathLive review and explicit user approval before workspace import.

## Protected Areas

Keyboard, MORE/template tray, long-press lists, MathLive production route/bridge/surface, Graph, Solution, History, AppShell, workspace runtime, camera shell runtime, AndroidManifest, MainActivity, splash/icon, solver/evaluator, camera dependencies, Android toolchain, and pubspec dependencies are not changed in Q295.

## Honest Claim Boundary

No OCR PASS, image-to-LaTeX PASS, Camera/OCR runtime PASS, store-ready PASS, release PASS, Flutter PASS, Android PASS, or premium final PASS is claimed by this package. Flutter/Dart/Android verification must be performed on the user's machine.
