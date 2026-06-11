# V172-Q385 — Paddle Runtime ABI Trim and Delivery Guard

## Scope

This phase follows Q384R2 and is limited to camera/OCR runtime delivery and base package size hygiene.
It does not change keyboard/Q382 behavior, MORE, long-press, Graph, History, Solution, Solver semantics,
MathLive editor behavior, splash/icon, or app startup flow.

## Decision

Q384R1 activated user-tapped PP-FormulaNet-S model download and private-storage install.
Q384R2 aligned the downloaded Paddle inference directory with the native bridge preflight.
Q385 keeps that architecture intact and narrows the base native runtime package to the single current
supported ABI path:

```text
base-apk-arm64-v8a-only-paddle-lite-runtime-model-download-only
```

The base app still does not bundle PP-FormulaNet-S model bytes. ONNX Runtime remains removed. Native runtime
code is not downloaded from arbitrary network URLs. A future Play Feature Delivery / dynamic feature module
may be evaluated separately, but Q385 does not claim such a module exists.

## Android packaging change

`android/app/build.gradle` now applies:

```gradle
ndk {
    abiFilters 'arm64-v8a'
}
```

This is intended to keep release native packaging focused on `arm64-v8a` while preserving the existing source
Paddle Lite files for audit/rollback. The app must still be measured with real release APK/AAB builds before
claiming any size PASS.

## Native bridge evidence method

`MainActivity.kt` adds an explicit evidence method:

```text
paddleRuntimeDeliveryDecisionQ385
```

It reports packaged runtime policy, device ABI support, installed native library directory evidence, and blocks
all production inference claims. It does not load a model, run OCR, produce LaTeX, or write Workspace.

## Hard blocks preserved

- No ONNX Runtime Android dependency is reintroduced.
- No `.onnx`, `.nb`, `.pdmodel`, `.pdiparams`, `.tflite`, or `.safetensors` model file is bundled in the project.
- No arbitrary native runtime download is enabled.
- No Play Feature Delivery runtime module is claimed.
- No OCR PASS, Android device PASS, or image-to-LaTeX PASS is claimed.
- Direct Workspace import, Graph, Solution, History, and Solver execution remain blocked without explicit review/approval.

## Required user-side evidence

Q385 still needs user-side evidence for:

```text
flutter clean
flutter pub get
flutter analyze
flutter test
flutter build apk --release --target-platform android-arm64 --analyze-size
flutter build appbundle --release --target-platform android-arm64 --analyze-size
```

Expected evidence to send back:

- analyzer/test result
- APK size
- AAB size
- analyze-size native `lib` breakdown
- camera review screen after model install
- Q382 ordering smoke test result remains unchanged


## Q385R1 auditor clarification

Q385R1 later clarifies that Android `INTERNET` permission came from Q384R1, not Q385. It also keeps the
legacy `armeabi-v7a` Paddle Lite source file as rollback/audit fallback while Q385 `abiFilters 'arm64-v8a'`
continues to define the intended release packaging contract. Physical removal of the fallback ABI is deferred
until real release APK/AAB evidence is available.
