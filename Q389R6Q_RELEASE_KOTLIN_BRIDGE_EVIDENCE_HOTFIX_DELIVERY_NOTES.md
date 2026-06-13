# Q389R6Q — Release Kotlin bridge-evidence compile hotfix

## Trigger
User-side release build failed in `android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt` at line 4528:

- `Unresolved reference 'bridgeEvidence'`
- `Operator '==' cannot be applied to 'kotlin.text.MatchGroup?' and 'kotlin.Boolean'`

`flutter analyze` and `flutter test` were already clean in Q389R6P. This phase is a Kotlin release-build hotfix only.

## Surgical fix
`q384R2DeferredPaddleModelRuntimeBindingPreflight()` incorrectly referenced `bridgeEvidence`, which is scoped only inside the later real Paddle OCR bridge function.

Q389R6Q now computes local NB artifact readiness inside the q384R2 preflight function:

- `q387CandidateNbModelFile`
- `q387R1NbManifestEvidence`
- `q387PaddleLiteNbModelReady`
- `modelArtifactReady = paddleInferenceDirectoryReady || q387PaddleLiteNbModelReady`

The return map now exposes scoped q387 readiness evidence and no longer references out-of-scope `bridgeEvidence`.

## Protected surfaces
This phase does not modify:

- Flutter keyboard layout
- Dart keyboard dispatch
- MathLive bridge / cursor drag runtime
- Graph runtime UI
- OCR Dart review surface
- Android permissions / Gradle dependencies
- Solver / CAS

## Evidence available in this environment
Static verifier only:

```bash
node tool/verify_release_kotlin_bridge_evidence_hotfix_q389r6q.mjs
```

Flutter/Android release PASS is not claimed by this package. It requires user-side `flutter build apk --release --target-platform android-arm64` evidence.
