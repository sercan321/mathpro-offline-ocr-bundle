# V172-Q354 ONNX Runtime Android Dependency / ABI Build Trial Audit

## Phase

`V172-Q354-ONNX-RUNTIME-ANDROID-DEPENDENCY-ABI-BUILD-TRIAL`

## Source

Q354 starts from Q353 and uses Q352 ONNX conversion evidence plus Q352R1 verifier hygiene as its chain source.

## Scope

Q354 adds the selected Android dependency coordinate to `android/app/build.gradle` for a user-side ABI/build trial:

`implementation 'com.microsoft.onnxruntime:onnxruntime-android:1.26.0'`

This is a build-trial dependency gate only. It does not add an ONNX model, does not call ONNX Runtime from Kotlin/Java, does not load a model, and does not perform inference or OCR.

## Protected Surface Report

Intentional protected file change:

- `android/app/build.gradle`

Reason:

- Q354 is explicitly the ONNX Runtime Android dependency / ABI build trial phase. A Gradle dependency mutation is the minimum required change for this phase.

Runtime effect:

- Dependency resolution/build surface changes only after the user runs `flutter pub get` / Android build. No runtime method calls were added.

Risk:

- Android dependency resolution, APK/AAB size, native ABI packaging, and device compatibility must be proven by user-side Flutter/Android logs. Assistant environment cannot claim these PASS results.

Verification:

- Q354 verifier requires the dependency coordinate in Gradle and blocks MainActivity/AndroidManifest/pubspec/model/OCR changes.

## Explicit Non-Changes

- No ONNX model bundle.
- No copy to private app storage.
- No model-load attempt.
- No runtime startup call.
- No dummy input call.
- No image-to-LaTeX inference.
- No editable MathLive OCR review.
- No workspace import.
- No Solve/Graph/Solution/History trigger.
- No OCR PASS claim.
- No Flutter/Android PASS claim by package.

## External Artifact Still Outside ZIP

- `pp_formulanet_s.onnx`
- Size: `308743097` bytes
- SHA256: `6d24333f86478d765fe6fa6fc3bd8061c52044433aafda18399f49cde3fe4d6a`

The 308 MB model remains outside the Flutter project ZIP.
