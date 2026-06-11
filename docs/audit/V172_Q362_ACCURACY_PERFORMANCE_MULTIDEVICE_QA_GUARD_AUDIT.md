# V172-Q362 — Accuracy / Performance / Multi-device QA Guard Audit

Phase: `V172-Q362-ACCURACY-PERFORMANCE-MULTIDEVICE-QA-GUARD`
Source: `V172-Q361-CAMERA-OCR-RUNTIME-EXECUTION-BRIDGE`

Q362 consolidates the remaining QA-oriented OCR guard work into one simplified phase:

- OCR accuracy and candidate-ranking guard.
- Latency, memory, and thermal profiling guard.
- Multi-device Android QA guard.

## Guarded behavior

- Accuracy cannot be claimed from static verification.
- Candidate ranking requires reviewed candidate-envelope evidence.
- Performance PASS requires real latency, memory, and thermal evidence.
- Multi-device PASS requires real device-class evidence.
- Editable MathLive review and explicit user approval remain mandatory before any workspace import.
- No camera/startup/workspace/Solve/Graph/Solution/History path auto-runs OCR, model-load, dummy-call, image-to-LaTeX, review, or import.

## Deliberately not done

- No ONNX model is bundled or copied.
- No model-load, dummy call, image-to-LaTeX inference, review UI, workspace import, or OCR is executed by the package.
- No Flutter, Android, ONNX Runtime, model-load, dummy-call, image-to-LaTeX, review, import, accuracy, performance, multi-device, or OCR PASS is claimed.

## Protected surface statement

Q362 does not change `MainActivity.kt`, Gradle, pubspec, AndroidManifest, keyboard, MORE/template tray, long-press, MathLive production, workspace UI, Graph, Solution, History, splash/icon, or solver/evaluator surfaces.
