# V172-Q336 — Native Package Hash Evidence Capture / Q328 JSON Intake

## Phase

`V172-Q336-NATIVE-PACKAGE-HASH-EVIDENCE-CAPTURE-Q328-JSON-INTAKE`

## Source phase

`V172-Q335-NATIVE-PACKAGE-HASH-EVIDENCE-COLLECTION-USER-SIDE-NATIVE-PACKAGE-INTAKE`

## Scope

Q336 adds a no-bundle, default-off intake gate for the Q328 native package hash evidence JSON.
It prepares the project to review native package hashes from `../MathProOcrNativePackages/Paddle_Lite_Android/q328_native_library_package_hash_evidence.json` before any future `.so` or `.jar` file is copied into the Flutter/Android project.

## Added

- `lib/features/camera/gauss_native_package_hash_evidence_capture_q328_json_intake_q336_policy.dart`
- `lib/features/camera/gauss_native_package_hash_evidence_capture_q328_json_intake_q336.dart`
- `test/v172_q336_native_package_hash_evidence_capture_q328_json_intake_test.dart`
- `tool/intake_q328_native_package_hash_evidence_v172_q336.mjs`
- `tool/verify_native_package_hash_evidence_capture_q328_json_intake_v172_q336.mjs`
- `docs/audit/V172_Q336_NATIVE_PACKAGE_HASH_EVIDENCE_CAPTURE_Q328_JSON_INTAKE_AUDIT.md`
- `docs/audit/V172_Q336_CHANGED_FILES.md`

## Modified

- `assets/mathlive/manifest.json`
- `README.md`
- `android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt`
- selected Q313R1-Q335 successor-aware tests/verifiers

## Explicit non-goals

- No `.so` bundle.
- No `.jar` bundle.
- No `.aar` bundle.
- No `jniLibs` directory.
- No `android/app/libs` directory.
- No Gradle mutation.
- No `pubspec.yaml` mutation.
- No AndroidManifest mutation.
- No `System.loadLibrary`.
- No Paddle Lite instantiation.
- No runtime startup.
- No model load.
- No image-to-LaTeX inference.
- No OCR PASS claim.

## Required next external evidence

Run Q335 intake preparation, place native package files outside the project root, then run Q328 hash capture and Q336 evidence intake scripts. Only after the evidence JSON is reviewed and explicit user approval is given should a future binary bundle phase be opened.
