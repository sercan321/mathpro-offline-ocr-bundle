# V172-Q355 — ONNX Model Private Storage / SHA Verification Audit

## Phase

`V172-Q355-ONNX-MODEL-PRIVATE-STORAGE-SHA-VERIFICATION`

## Scope

Q355 prepares a private-storage and SHA-verification gate for the external `pp_formulanet_s.onnx` artifact after Q354 introduced the ONNX Runtime Android dependency build-trial coordinate.

This is not a model copy, model load, runtime startup, dummy-call, image-to-LaTeX, OCR review, workspace import, Solve, Graph, Solution, or History phase.

## Evidence carried forward

- Q354 dependency trial coordinate: `com.microsoft.onnxruntime:onnxruntime-android:1.26.0`
- External ONNX artifact file name: `pp_formulanet_s.onnx`
- External artifact path policy: `../MathProOcrArtifacts/PP-FormulaNet-S-ONNX-Exact/pp_formulanet_s.onnx`
- Expected ONNX size: `308743097` bytes
- Expected ONNX SHA256: `6d24333f86478d765fe6fa6fc3bd8061c52044433aafda18399f49cde3fe4d6a`

## Guarded state

- Private-storage policy prepared: yes
- SHA verification policy prepared: yes
- Atomic copy policy prepared: yes
- User-side external artifact still required: yes
- User-side Flutter/Android build evidence still required after Q354 dependency: yes

## Explicit non-goals

- No `.onnx` model is bundled into the project ZIP.
- No `.nb`, `.pdmodel`, `.pdiparams`, `.tflite`, or model cache is bundled.
- No ONNX Runtime Java/Kotlin call is added.
- No `MainActivity.kt` model-load bridge is added.
- No model is copied into app-private storage in this package.
- No SHA verification is executed on device in this package.
- No model load, runtime startup, dummy call, inference, OCR, review UI, workspace import, Solve, Graph, Solution, or History operation is executed.

## Red-line protection

Q355 must not modify keyboard, MORE/template tray, long-press, MathLive production route, workspace, Graph, Solution, History, splash/icon, solver/evaluator, `pubspec.yaml`, `AndroidManifest.xml`, or `MainActivity.kt`. It must preserve the Q354 Gradle dependency trial state without adding further runtime behavior.

## Honest limitation

Assistant environment does not provide Flutter/Dart/Android SDK. Q355 only provides static/verifier/package integrity evidence. User-side `flutter clean`, `flutter pub get`, `flutter analyze`, `flutter test`, and `flutter run` remain required.
