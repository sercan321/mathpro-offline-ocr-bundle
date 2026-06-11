# V172-Q333 Native Package Hash Evidence Intake / Real Bundle Permission Review Audit

Phase: `V172-Q333-NATIVE-PACKAGE-HASH-EVIDENCE-INTAKE-REAL-BUNDLE-PERMISSION-REVIEW`

## Scope
Q333 adds a default-off native bridge envelope for reviewing the native package hash evidence before any real Paddle Lite binary bundle can be approved.

## What changed
- Added Q333 Dart policy/result files.
- Added Q333 Flutter self-test.
- Added Q333 Node verifier.
- Extended `MainActivity.kt` with `nativePackageHashEvidenceIntakeReview`.
- Updated manifest latest camera/product phase to Q333.

## What did not change
- No `.so`, `.jar`, or `.aar` files were added.
- No `jniLibs` or `android/app/libs` directories were created.
- No Gradle, pubspec, or AndroidManifest mutation.
- No `System.loadLibrary` call.
- No Paddle Lite instantiate/model load/runtime startup/inference.
- No OCR PASS, Android PASS, store/release PASS claim.

## Required before Q334
- User-side Q333 `flutter analyze` and `flutter test` evidence.
- Q328 native package hash evidence JSON.
- Explicit user approval to bundle required native files.
