# V172-Q343 Native Package Hash Evidence Final Acceptance / Real Bundle Unlock Gate Audit

Phase: `V172-Q343-NATIVE-PACKAGE-HASH-EVIDENCE-FINAL-ACCEPTANCE-REAL-BUNDLE-UNLOCK-GATE`

Source phase: `V172-Q342-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-PENDING-EVIDENCE-BLOCKED`

## Scope

Q343 is a final acceptance/unlock gate before any real Paddle Lite binary bundle phase. It keeps the actual bundle blocked because this assistant session does not have all required user-side evidence:

- Q328 native package hash evidence JSON accepted: `false`
- Explicit user binary bundle approval: `false`
- Q342-or-newer clean user-side Flutter analyze/test/run log: `false`

## What Q343 adds

- A default-off Dart policy/result contract for the Q343 gate.
- A default-off Android OCR bridge envelope method: `nativePackageHashEvidenceFinalAcceptanceRealBundleUnlockGate`.
- A Q343 verifier and Flutter test contract.
- Manifest/README/audit metadata for the next real bundle decision point.

## What Q343 intentionally does not add

- No `.so`, `.jar`, or `.aar` files.
- No `android/app/src/main/jniLibs` directory.
- No `android/app/libs` directory.
- No Gradle, `pubspec.yaml`, or `AndroidManifest.xml` mutation.
- No `System.loadLibrary` call.
- No Paddle Lite predictor instantiation.
- No model loader.
- No runtime startup.
- No dummy runtime call.
- No image-to-LaTeX inference.
- No OCR candidate review UI.
- No workspace import.
- No OCR/runtime/Android real-device PASS claim.

## Red-line UI preservation

Q343 is intentionally non-UI. Workspace, keyboard, MORE/template tray, long-press, MathLive production bridge/surface, Graph, Solution, History, splash, and icon surfaces remain untouched.

## Next gate

Q344 can copy real `jniLibs` + `PaddlePredictor.jar` only after Q328/Q336 native package hash evidence exists, the user explicitly approves binary bundling, and Q342/Q343 user-side Flutter logs are clean.
