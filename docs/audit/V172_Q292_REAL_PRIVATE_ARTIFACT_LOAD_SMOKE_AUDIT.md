# V172-Q292 Real Private Artifact Load Smoke Audit

## Phase

`V172-Q292-REAL-PRIVATE-ARTIFACT-LOAD-SMOKE`

## Source Phase

`V172-Q291-PRIVATE-MODEL-DOWNLOAD-SHA-VERIFICATION-RUNTIME`

## Purpose

Q292 adds the guarded real-private-artifact-load smoke contract for the selected PP-FormulaNet-S OCR path. It does **not** load a real model file in this package, because Q291 still has no verified private artifact, no expected/actual SHA256 match evidence, and no user-side real-device artifact-load smoke evidence.

## Runtime Boundary

Q292 remains default-off and blocked until the following evidence exists:

- verified private artifact path in application-private storage
- expected SHA256
- actual SHA256
- expected/actual SHA match
- checksum-before-load proof
- atomic move completed evidence
- model-format probe plan
- dummy-input-only smoke boundary
- timeout/cancellation and memory-pressure policy
- editable MathLive review boundary
- explicit user approval before workspace import

## No Real Runtime or OCR Claim

This phase intentionally adds no Paddle runtime, no PaddleOCR dependency, no JNI binding, no MethodChannel runtime binding, no native handler implementation, no model binary, no production download worker, and no image-to-LaTeX inference.

Q292 does not claim private artifact load PASS, runtime smoke PASS, OCR PASS, Camera/OCR runtime PASS, Store-ready PASS, or Release PASS.

## Protected Surfaces

The keyboard, MORE/template tray, long-press lists, MathLive production route, Graph, Solution, History, AppShell, workspace runtime, camera shell runtime, AndroidManifest, MainActivity, splash/icon, solver/evaluator, pubspec dependencies, camera dependencies, and Android toolchain are not changed.

## User-Side Evidence Required

The user must still run `flutter analyze`, `flutter test`, and `flutter run -d 23106RN0DA` on a real environment/device. The assistant environment cannot claim Flutter or Android PASS.
