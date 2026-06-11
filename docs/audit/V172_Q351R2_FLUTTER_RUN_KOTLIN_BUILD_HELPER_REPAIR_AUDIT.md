# V172 Q351R2 Flutter Run Kotlin Build Helper Repair Audit

Phase: `V172-Q351R2-FLUTTER-RUN-KOTLIN_BUILD_HELPER_REPAIR`

Q351R2 repairs a user-side `flutter run` / `compileDebugKotlin` failure where later OCR bridge envelopes referenced `q318PrivateModelStorageRoot()` and `q318PrivateModelArtifactFile()` although the helper functions were missing from `MainActivity.kt`.

## Scope

- Adds only the missing Q318 app-private storage helper functions to `MainActivity.kt`.
- Keeps Q344 bundled binaries unchanged.
- Keeps Q345 Gradle jar dependency unchanged.
- Keeps Q346/Q347 bridge methods default-off.
- Keeps active OCR/product gate at Q351.

## Not implemented

- No model loader.
- No model load.
- No runtime startup.
- No dummy call.
- No image-to-LaTeX.
- No OCR review UI.
- No workspace import.
- No OCR PASS claim.
