# V172-Q387 — Paddle Lite `.nb` Model Format Decision Gate

## Scope

Q387 is a camera/OCR runtime compatibility decision phase. It does not change keyboard, MORE/template tray, long-press inventory, MathLive caret authority, Graph, History, Solution/Solver semantics, splash/icon, or startup flow.

## Why this phase exists

Q386 opened the first real Paddle Lite inference bridge, but the currently downloaded PP-FormulaNet-S artifact is a Paddle inference directory:

- `config.json`
- `inference.json`
- `inference.yml`
- `inference.pdiparams`

The Android package contains `PaddlePredictor.jar`. Inspection of `com.baidu.paddle.lite.MobileConfig` shows the current API line exposes:

- `setModelFromFile(String)`
- `setModelFromBuffer(String)`
- `setThreads(int)`
- `setPowerMode(PowerMode)`

The current JAR does **not** expose a `setModelDir(...)` API. Therefore Q387 forbids blindly passing `inference.pdiparams` to `MobileConfig.setModelFromFile(...)` as if it were an Android-ready Paddle Lite model.

## Q387 decision

Android real OCR must use a download-only Paddle Lite optimized `.nb` artifact unless a future runtime/JAR with verified directory loading support is deliberately introduced and proven.

Current decision:

```text
current artifact: paddle-inference-directory
required Android runtime artifact: paddle-lite-optimized-nb
future load method: MobileConfig.setModelFromFile(.nb)
```

## Runtime evidence added

Q387 adds native evidence fields to the Q386 bridge envelope:

- `q387Phase`
- `q387Status`
- `q387CurrentDownloadedArtifactFormat`
- `q387RequiredAndroidArtifactFormat`
- `q387RequiredModelFileExtension`
- `q387CandidateNbModelPath`
- `q387PaddleLiteNbModelReady`
- `q387MobileConfigApiEvidence`
- `q387SelectedModelLoadStrategy`
- `q387ModelLoadBlockedBeforeAttempt`
- `q387ModelLoadBlockedReason`
- `q387ProductionInferencePassClaimed`

Expected blocked reason for the existing package state:

```text
q387-paddle-lite-nb-model-required
```

## Safety guarantees

Q387 preserves:

- no fake LaTeX candidate
- no direct camera-to-workspace import
- review-first flow
- explicit user approval before workspace import
- no auto-solve
- no auto-graph
- no auto-solution/history
- no ONNX Runtime reintroduction
- no model binary inside base APK/AAB
- Q382 keyboard ordering untouched

## Memory hygiene repair included

The Q380 tensor preprocessing helper now recycles the resized bitmap created by:

```kotlin
Bitmap.createScaledBitmap(...)
```

The decoded source bitmap was already recycled by Q386; Q387 closes the resized-bitmap leak risk as well.

## What Q387 does not claim

Q387 does not claim:

- Flutter analyze PASS
- Flutter test PASS
- Android build PASS
- real-device camera PASS
- Paddle inference PASS
- OCR PASS
- APK/AAB size PASS
- workspace import device PASS

Those require user-side logs and later phases.

## Next phase

Q387R1 should produce or select a real Paddle Lite optimized `.nb` PP-FormulaNet-S artifact, keep it download-only, calculate its SHA256, and update the model manifest/install path to target that `.nb` file.

Static status phrase for legacy verifier compatibility:

```text
No OCR/image-to-LaTeX/Android real-device PASS is claimed by Q387.
```
