# V172 Q341 — Native Package Hash Evidence Capture / Bundle Evidence Acceptance Audit

Phase: `V172-Q341-NATIVE-PACKAGE-HASH-EVIDENCE-CAPTURE-BUNDLE-EVIDENCE-ACCEPTANCE`
Source phase: `V172-Q340-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-EVIDENCE-BLOCKED-GATE`

## Scope
Q341 keeps binary bundle acceptance blocked because Q328 native package hash evidence JSON, explicit user bundle approval, and clean user-side Flutter logs are not present. No `.so`, `.jar`, `.aar`, `jniLibs`, `android/app/libs`, Gradle, pubspec, AndroidManifest, or UI runtime files are changed.

## MainActivity
`MainActivity.kt` is intentionally modified only to add the default-off `nativePackageHashEvidenceCaptureBundleEvidenceAcceptance` envelope method on `mathpro/ocr_runtime_bridge`.

## Hard blocks
- No native binary bundle.
- No `System.loadLibrary`.
- No Paddle Lite instantiation.
- No model loader/runtime startup/inference.
- No OCR PASS claim.
- No workspace/keyboard/MORE/long-press/MathLive/Graph/Solution/History/splash/icon changes.
