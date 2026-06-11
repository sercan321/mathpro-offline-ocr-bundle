# V172-Q385R1 — Paddle Runtime ABI Trim Test and Download Guard Repair

## Scope

This is a surgical auditor-feedback repair on top of Q385. It does not activate OCR inference, does not re-add
ONNX Runtime, does not bundle PP-FormulaNet-S model files, and does not touch keyboard/Q382 behavior, MORE,
long-press, Graph, History, Solution, Solver, MathLive editor/caret authority, splash/icon, or app startup flow.

## Repairs

1. Repaired the stale Q384R1 Flutter test expectation:
   - `greaterThan(200 * 1024 * 1024)` became `greaterThanOrEqualTo(200 * 1024 * 1024)`.
   - This matches the production lower bound exactly instead of failing when the value is equal.

2. Removed the false Wi-Fi-only claim from the real network download path:
   - User-facing queued label is now `İndirme kuyruğunda`.
   - Manifest policy is now `user-approved-internet-required-large-download`.
   - Q385R1 does not claim a real Wi-Fi gate; it only requires explicit user approval and internet access.

3. Hardened Q384R1 sidecar download guards without over-rejecting valid files:
   - Sidecar minimum sizes are relaxed to avoid false `artifact-too-small` rejects.
   - Documented size labels are recorded for the pinned Hugging Face revision.
   - A `Content-Length` sanity check rejects obviously incomplete responses before writing the artifact.
   - Primary `inference.pdiparams` SHA256 lock is preserved.
   - Q385R1 does not falsely claim sidecar SHA locks where official SHA evidence is not embedded in this package.

4. Clarified AndroidManifest permission history:
   - `INTERNET` permission was introduced by Q384R1 for the real deferred model download.
   - Q385 did not add a new permission beyond Q384R1.


5. Repaired stale successor tests that still expected the old Q239D Wi-Fi queue copy after Q384R1 made the model download real and Q385R1 removed the false Wi-Fi-only claim.

6. Clarified legacy ABI source fallback:
   - `armeabi-v7a/libpaddle_lite_jni.so` intentionally remains in source as rollback/audit fallback.
   - Q385 `abiFilters 'arm64-v8a'` still prevents packaging it into the intended base release artifact.
   - Physical removal is deferred until real release APK/AAB evidence proves no compatibility or rollback need.

## Still not claimed

- No `flutter analyze` PASS.
- No `flutter test` PASS.
- No release APK/AAB size PASS.
- No real-device PASS.
- No OCR inference/image-to-LaTeX PASS.
- No Q382 ordering real-device PASS.

All of those require user-side Flutter/Android/device logs.
