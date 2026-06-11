# V172-Q385R2 — Camera OCR Download Compile and Legacy Verifier Recovery Repair

## Scope

This is a surgical repair on top of Q385R1. It only touches the deferred camera/OCR model download guard and the stale verifier/audit hygiene around that guard.

It does **not** enable OCR inference, re-add ONNX Runtime, bundle any model artifact, load Paddle inference for real OCR, mutate keyboard/Q382 ordering, alter MORE or long-press inventory, change MathLive editor/caret authority, or touch Graph, History, Solution, Solver, splash/icon, or startup flow.

## Repairs

1. **AccumulatorSink compile-risk repair**
   - Removed the risky `crypto.AccumulatorSink<crypto.Digest>()` usage.
   - Added a local `_GaussQ385R2DigestCaptureSink implements Sink<crypto.Digest>` so the SHA256 chunked conversion no longer depends on a symbol that may not exist under the `crypto` namespace.

2. **Download timeout guard**
   - Added a bounded HTTP request timeout.
   - Added a bounded stream idle timeout for long model downloads.
   - Timeout failures are mapped to a user-retryable message and do not mark partial files as ready.

3. **Stale active-state recovery**
   - Persisted `stateUpdatedAtIso` in the model snapshot.
   - `load()` now recovers stale `queued` / `downloading` / `verifying` states into a retryable `failed` state after the Q385R2 grace period.
   - This prevents the “Modeli indir” button from staying disabled forever after an app kill, dropped network, or interrupted Future.

4. **Honest verification copy**
   - User-facing text no longer says all model files were SHA256-verified.
   - The copy now says the primary `inference.pdiparams` file is SHA256-verified and sidecar files are checked by presence/size.
   - Q385R2 still does not claim sidecar SHA locks.

5. **Legacy verifier recovery**
   - Q239D and Q239E verifiers are now successor-aware: they still protect the original no-runtime/no-direct-solve/no-model-bundle contract, but no longer hard-fail just because Q384R1 intentionally introduced real user-approved HTTP download.
   - Q244R1 verifier now accepts the successor download-recovery marker instead of requiring old prose.

6. **Audit numbering and documentation hygiene**
   - Q385R1 audit numbering was normalized.
   - Q385R2 documents that Flutter analyze/test/build/device PASS is still not claimed without user-side logs.

## Still not claimed

- No `flutter analyze` PASS.
- No `flutter test` PASS.
- No release APK/AAB size PASS.
- No real-device PASS.
- No OCR inference/image-to-LaTeX PASS.
- No Q382 ordering real-device PASS.

All of those require user-side Flutter/Android/device logs.
