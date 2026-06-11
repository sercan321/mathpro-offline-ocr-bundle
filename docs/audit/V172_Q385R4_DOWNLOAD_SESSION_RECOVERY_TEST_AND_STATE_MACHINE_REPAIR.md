# V172-Q385R4 — Download Session Recovery Test and State-Machine Repair

## Scope

Q385R4 is a surgical repair after Q385R3. It fixes the deferred camera/OCR model download state-machine so that a standalone `queued` snapshot created by the historical/successor queue API survives `load()`, while true interrupted install-session states can still recover immediately to a retryable failure.

This phase does **not** enable OCR inference, does **not** re-add ONNX Runtime, does **not** bundle PP-FormulaNet-S model bytes into the base app, and does **not** touch Q382 keyboard ordering, MORE/long-press, Graph, History, Solution, Solver, Gradle/ABI, AndroidManifest, splash, icon, or startup flow.

## Problem repaired

Q385R3 intentionally made interrupted active download states retryable when no process-local install worker was running. The direction was correct, but the predicate was too broad:

- `queued`
- `downloading`
- `verifying`

were all treated as active/interrupted states.

That meant a standalone queued state produced by `queueUserApprovedNetworkPreparation()` could be turned into `failed` by the next `load()`. This contradicted the Q239D successor test expectation and could make `flutter test` fail even though the real interrupted-download recovery idea was valid.

## Q385R4 contract

The repaired state-machine is:

- Standalone legacy/successor `queued` without an install session id survives `load()`.
- Install-session `queued` with an install session id can recover to retryable failed if the process-local worker is gone.
- `downloading` and `verifying` recover to retryable failed when no process-local worker is running.
- Retry UX remains intact: failed snapshots expose `Tekrar indir`.
- The visible button label and accessibility semantics are aligned.

## Implementation notes

- `GaussMathOcrModelSnapshot` now carries optional `installSessionId`.
- `installProductionModelQ384R1()` creates a Q385R4 install-session id and passes it into the queued/downloading state chain.
- `queueUserApprovedNetworkPreparation()` remains usable without an install session id for Q239D successor compatibility.
- `_recoverStaleActiveSnapshot()` explicitly keeps standalone queued states intact, while recovering install-session queued/downloading/verifying states.
- `_DeferredModelStatusCard.onQueueModel` was changed from `VoidCallback` to `Future<void> Function()`.
- `semanticsLabel` now mirrors `snapshot.downloadActionLabel`.

## Safety boundaries

Q385R4 preserves the previous hard boundaries:

- No OCR inference is claimed.
- No fake LaTeX is produced.
- No workspace auto-import is introduced.
- No ONNX Runtime dependency is reintroduced.
- No `.onnx`, `.nb`, `.pdmodel`, `.pdiparams`, `.tflite`, or `.safetensors` artifact is bundled.
- Sidecar SHA lock is still not claimed; sidecars remain presence/size checked.
- Q382 keyboard ordering remains verifier-only preserved and still requires real-device validation.

## Required validation after this package

Static verifiers are not enough for final PASS. The package still requires:

- `flutter analyze`
- `flutter test`
- real-device `flutter run`
- camera model download test
- interrupted download retry test
- release APK/AAB analyze-size
- Q382 ordering test: `C → 88888 → 7777 = 888887777`
