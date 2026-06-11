# V172 Q363R2 — Flutter Test Legacy Successor-Awareness Closure Repair

## Reason

User-side Q363R1 evidence showed `flutter analyze` passed, but `flutter test` still failed because older Q322-Q351R2 tests rejected the active Q363 product/OCR phase. The failures were stale test successor-awareness issues, not runtime/OCR failures.

## Scope

Q363R2 updates legacy tests so the active product phase `V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE` is accepted where appropriate. It preserves Q363 as the active product/OCR phase and records Q363R2 only as hygiene metadata.

## Explicit non-goals

- No MainActivity change.
- No Gradle/pubspec/AndroidManifest change.
- No UI/keyboard/MORE/long-press/MathLive/workspace/Graph/Solution/History/splash/icon/solver/evaluator change.
- No ONNX model bundle/copy/load.
- No model-load, dummy-call, image-to-LaTeX, OCR, review, or workspace import execution.
- No Flutter/Android/OCR/store/release PASS claim from assistant environment.

## Expected user-side outcome

`flutter test` should no longer fail on stale Q322-Q351R2 successor lists missing Q363. User must rerun `flutter test` on Windows to confirm.
