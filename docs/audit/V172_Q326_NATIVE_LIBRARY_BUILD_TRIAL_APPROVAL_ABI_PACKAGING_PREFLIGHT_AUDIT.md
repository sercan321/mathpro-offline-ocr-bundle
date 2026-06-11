# V172 Q326 — Native Library Build Trial Approval / ABI Packaging Preflight Audit

## Phase

V172-Q326-NATIVE-LIBRARY-BUILD-TRIAL-APPROVAL-ABI-PACKAGING-PREFLIGHT

## Source Phase

V172-Q325-EXPLICIT-RUNTIME-DEPENDENCY-COORDINATE-SELECTION-BUILD-TRIAL-GATE

## Purpose

Q326 records the native-library build-trial and ABI packaging preflight for the PP-FormulaNet-S OCR track without mutating dependency surfaces or bundling native binaries.

The selected candidate remains `PADDLE_LITE_ANDROID_NATIVE_LIBRARY_MANUAL_TRIAL_PENDING`. This is intentionally a preflight package phase only.

## Runtime Scope

Added a default-off Android bridge envelope method:

- Channel: `mathpro/ocr_runtime_bridge`
- Method: `nativeLibraryBuildTrialPreflight`
- Status: `NATIVE_LIBRARY_BUILD_TRIAL_PREFLIGHT_BLOCKED_NO_NATIVE_LIBRARY_BUNDLE_DEFAULT_OFF`

## Explicit Blocks

Q326 intentionally does not:

- change `pubspec.yaml`
- change Gradle files
- change `AndroidManifest.xml`
- create `android/app/src/main/jniLibs`
- bundle `.so` files
- bundle `.aar` files
- add Paddle/PaddleOCR/Paddle Lite dependencies
- instantiate Paddle Lite
- convert the Paddle inference model to a Paddle Lite optimized model
- add a native/JNI model loader
- start a runtime
- execute a dummy runtime call
- run image-to-LaTeX inference
- open MathLive review
- import into workspace
- claim OCR/runtime/Android real-device PASS

## Protected Runtime File Intentionally Modified

- `android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt`

Reason: add only the default-off `nativeLibraryBuildTrialPreflight` bridge envelope method and constants. No runtime dependency, binary library, loader, inference, or import path was added.

## Evidence Carried Forward

- Q315 local artifact SHA evidence was provided by the user.
- `actualSha256` matched the expected SHA256.
- Artifact was stored outside the project root.
- Runtime acceptance remains false.

## Next Required Phase

Q327 must not bundle a native library or mutate Gradle until:

- Q326 user-side `flutter analyze` and `flutter test` are clean.
- Real-device `flutter run` is reviewed if available.
- A specific Paddle Lite native library source package is approved.
- ABI matrix is approved.
- Rollback plan is explicit.
- Feature flag remains default-off.
