# V172-Q324 — Approved Runtime Dependency Trial Behind Default-Off Flag Audit

## Phase

`V172-Q324-APPROVED-RUNTIME-DEPENDENCY-TRIAL-BEHIND-DEFAULT-OFF-FLAG`

## Source phase

`V172-Q323-RUNTIME-DEPENDENCY-MODEL-LOADER-DECISION-IMPLEMENTATION`

## Scope

Q324 adds a default-off approved runtime dependency trial envelope after the Q323 model-loader decision gate. It deliberately keeps the actual runtime dependency unselected because the package still lacks user-side Q323 Flutter logs and approved Android-compatible dependency coordinates.

## Added bridge method

- Channel: `mathpro/ocr_runtime_bridge`
- Method: `approvedRuntimeDependencyTrial`
- Status: `APPROVED_RUNTIME_DEPENDENCY_TRIAL_BLOCKED_PENDING_USER_Q323_FLUTTER_LOG_AND_RUNTIME_COORDINATE_EVIDENCE_DEFAULT_OFF`

## Evidence carried forward

- Q315 artifact SHA evidence provided: `true`
- Expected SHA: `b6392296d16e2a9f414c0a751d7ccbd1bd9d8272b68aab72df1d3875f35a7489`
- Expected size: `231675001`
- Runtime accepted: `false`

## Intentional protected file change

`android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt` was intentionally changed only to add the default-off `approvedRuntimeDependencyTrial` bridge envelope method.

## Explicit non-goals

- No `pubspec.yaml` mutation.
- No Gradle mutation.
- No AndroidManifest mutation.
- No Paddle/PaddleOCR dependency.
- No Paddle Lite dependency.
- No ONNX Runtime dependency.
- No TFLite dependency.
- No JNI/native model loader.
- No model load.
- No runtime startup.
- No dummy runtime call execution.
- No image-to-LaTeX execution.
- No editable MathLive review.
- No workspace import.
- No OCR/runtime/Android real-device PASS claim.

## Next required evidence

Before a future phase may mutate pubspec/Gradle or add an actual runtime dependency, it must have:

- Q324 user-side `flutter analyze` PASS log.
- Q324 user-side `flutter test` PASS log.
- Q324 user-side real-device `flutter run` log, or an explicit decision to proceed without device runtime PASS.
- Approved dependency coordinates and version.
- License and transitive dependency audit.
- Android Gradle and ABI impact review.
- APK/AAB size impact review.
- Rollback plan.
- Default-off feature flag before runtime instantiation.
