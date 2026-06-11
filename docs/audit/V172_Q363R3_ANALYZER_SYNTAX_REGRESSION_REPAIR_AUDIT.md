# V172-Q363R3 Analyzer Syntax Regression Repair Audit

## Scope

Q363R3 is a hygiene-only repair created after Q363R2 introduced malformed Dart syntax while attempting to update legacy successor-awareness tests.

## Preserved Active Product Phase

- `cameraOcrLatestPhase`: `V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE`
- `activeProductDevelopmentLatestPhase`: `V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE`

Q363R3 does not advance OCR/runtime/product behavior.

## Repairs

- Removes/avoids malformed leading-comma Q363 insertions in legacy Dart tests.
- Avoids malformed manifest map indexing such as `manifest['cameraOcrLatestPhase', ...]`.
- Restores syntax-safe Q363 successor acceptance for legacy tests.
- Keeps Q363 active-phase acceptance without runtime, UI, Gradle, pubspec, AndroidManifest, or MainActivity changes.

## Explicit Non-Goals

- No model bundle.
- No model copy to private storage.
- No model load.
- No dummy runtime call execution.
- No image-to-LaTeX execution.
- No OCR execution.
- No editable review UI open.
- No workspace import.
- No Android/OCR/store/release PASS claim.

## Protected Red Lines

Q363R3 must not modify:

- `android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt`
- `android/app/build.gradle`
- `pubspec.yaml`
- `android/app/src/main/AndroidManifest.xml`
- keyboard / MORE / long-press files
- MathLive production files
- workspace UI
- Graph / Solution / History
- splash / icon
- solver / evaluator
