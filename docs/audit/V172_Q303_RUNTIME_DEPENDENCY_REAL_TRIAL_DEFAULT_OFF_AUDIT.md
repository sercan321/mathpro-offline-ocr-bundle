# V172-Q303 — Runtime Dependency Real Trial Behind Default-Off Flag Audit

## Purpose

Q303 returns the active product-development path to the real OCR runtime dependency question after Q302 locked the official PP-FormulaNet-S source locators while keeping SHA pending.

This phase defines the **Runtime Dependency Real Trial** gate, but keeps it **default-off** and blocked because Q302 has not yet produced a controlled download SHA256, runtime library candidate evidence, Android ABI matrix, APK-size budget, RAM/latency budget, or real-device build evidence.

## What Q303 Does

- Adds a default-off real dependency trial contract for PP-FormulaNet-S.
- Requires Q302 controlled-download SHA evidence before any runtime dependency is added.
- Requires runtime-library candidate name/version/source before any pubspec mutation.
- Requires license, ABI, APK-size, RAM/latency, rollback, and real-device build evidence.
- Keeps editable MathLive review and explicit user approval mandatory.
- Keeps direct workspace import, Solve, Graph, Solution, and History blocked.

## What Q303 Does Not Do

Q303 does **not** add Paddle, PaddleOCR, Paddle Lite, ONNX Runtime, TFLite, JNI binding, MethodChannel binding, native handler implementation, model binary, production download worker, private artifact load, runtime startup, image-to-LaTeX inference, real MathLive review, or workspace import.

It does **not** claim runtime dependency PASS, OCR PASS, Camera/OCR runtime PASS, Store-ready PASS, Release PASS, Flutter PASS, or Android real-device PASS.

## Red-Line Preservation

The following areas remain untouched:

- Keyboard layout/source
- MORE/template tray
- Long-press lists
- MathLive production route and bridge
- Graph/Solution/History
- AppShell/workspace runtime
- Camera shell runtime
- AndroidManifest/MainActivity
- Splash/icon
- Solver/evaluator
- pubspec.yaml
- Camera dependency line
- Android toolchain

## Honest Blocker

The real dependency trial is deliberately blocked until Q302's pending SHA gap is closed by a controlled download and verified hash. Adding a runtime dependency before that would be guesswork and could destabilize Gradle, ABI support, APK size, RAM, startup latency, and device behavior.
