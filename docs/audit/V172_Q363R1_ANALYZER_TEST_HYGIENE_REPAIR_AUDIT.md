# V172-Q363R1 Analyzer/Test Hygiene Repair Audit

Q363R1 is a hygiene-only repair after user-side `flutter analyze` and `flutter test` exposed stale test successor-awareness and Dart syntax/scope defects in older Q353-Q358 test files.

## Scope

- Preserves Q363 as the active camera/OCR/product gate.
- Repairs undefined successor constants in Q353-Q355 tests.
- Repairs undefined `manifest` scope in Q354-Q356R2 tests.
- Repairs malformed Windows path escape in Q358 test.
- Repairs Q362 test successor-awareness so Q363 is accepted.
- Updates the Q344 binary successor helper so Q363 remains recognized as a valid post-Q344 bundle-preserving phase.

## Explicit non-goals

- No runtime bridge mutation.
- No `MainActivity.kt` mutation.
- No Gradle/pubspec/AndroidManifest mutation.
- No keyboard/MORE/long-press/MathLive/workspace/Graph/Solution/History/splash/icon/solver/evaluator mutation.
- No model bundle/copy/load.
- No dummy runtime call, image-to-LaTeX, OCR review, workspace import, OCR PASS, Android PASS, store-ready PASS, or release-ready PASS.
