# V172-Q325 — Runtime Dependency Coordinate Selection / Build Trial Gate Audit

Phase: `V172-Q325-EXPLICIT-RUNTIME-DEPENDENCY-COORDINATE-SELECTION-BUILD-TRIAL-GATE`
Source phase: `V172-Q324-APPROVED-RUNTIME-DEPENDENCY-TRIAL-BEHIND-DEFAULT-OFF-FLAG`

Q325 records the first explicit runtime dependency candidate for the PP-FormulaNet-S Android OCR track. The selected candidate is `PADDLE_LITE_ANDROID_NATIVE_LIBRARY_MANUAL_TRIAL_PENDING`, with model-loader candidate `PADDLE_LITE_OPTIMIZED_PADDLE_INFERENCE_MODEL_LOADER_PENDING_CONVERSION_EVIDENCE`.

This is a coordinate-selection and build-trial gate only. It does **not** mutate `pubspec.yaml`, Gradle, `AndroidManifest.xml`, or bundle any native `.so`/AAR. It does **not** add Paddle, PaddleOCR, ONNX Runtime, TFLite, JNI/native model loading, runtime startup, dummy runtime execution, image-to-LaTeX inference, MathLive review, workspace import, OCR PASS, or Android real-device PASS.

Protected runtime file intentionally modified: `android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt`, limited to `runtimeDependencyCoordinateSelection` envelope method on `mathpro/ocr_runtime_bridge`.

Q315 artifact evidence retained:

- SHA256: `b6392296d16e2a9f414c0a751d7ccbd1bd9d8272b68aab72df1d3875f35a7489`
- Size: `231675001`
- Runtime accepted: `false`

Q326 remains blocked until user-side Q325 Flutter logs are clean and the user explicitly approves a native-library build trial / ABI packaging mutation.
