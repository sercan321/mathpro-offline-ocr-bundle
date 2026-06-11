# V172-Q370 Camera/OCR Final Real-Device QA + Release Closure

Q370 is a final package-side closure gate for the camera/OCR/ONNX path. It does not claim OCR, Android, model-load, image-to-LaTeX, store-ready, or release-ready PASS.

## Scope

- Preserve Q363 as the active product/OCR release gate.
- Record final real-device QA evidence requirements for Q364 through Q369.
- Require `flutter analyze`, `flutter test`, and `flutter run -d 23106RN0DA` evidence.
- Require private-storage model artifact, model-load, dummy-call, image-to-LaTeX, editable review, and approved import evidence before any future OCR PASS claim.
- Keep direct OCR-to-workspace and direct OCR-to-Solve/Graph/Solution/History blocked.

## Red-line preservation

Q370 does not modify MainActivity, Gradle, pubspec, AndroidManifest, keyboard, MORE/template tray, long-press, MathLive production, workspace UI, Graph, Solution, History, splash/icon, or solver/evaluator surfaces.

## No-pass claims

Q370 claims no Flutter, Android, model private-storage, model-load, dummy runtime call, image-to-LaTeX, OCR review, workspace import, OCR, store-ready, or release-ready PASS. Those require the final user-side test and real-device evidence.
