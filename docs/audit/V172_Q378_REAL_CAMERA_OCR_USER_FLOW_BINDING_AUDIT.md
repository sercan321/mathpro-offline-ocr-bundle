# V172-Q378 Real Camera OCR User Flow Binding Audit

Q378 binds the real camera/crop user flow to the existing OCR evidence and decoder pipeline. It is no longer a contract-only statement: accepting the crop frame invokes the OCR decoder harness, opens the review sheet with a decoded candidate when available, and imports only the reviewed and explicitly approved LaTeX into the workspace.

Safety invariants:
- No direct OCR-to-workspace before review.
- No automatic Solve/Graph/Solution/History.
- No ONNX model bundled in the ZIP.
- MainActivity native bridge code is reused, not expanded.
- Keyboard, MORE, long-press, Graph, Solution, History, splash/icon, Gradle, pubspec, and AndroidManifest are preserved.

Runtime caveat: Q378 still does not claim OCR PASS from static/package-side verification. Real model availability, model-load, image-to-LaTeX output, and user-flow behavior must be proven on device.
