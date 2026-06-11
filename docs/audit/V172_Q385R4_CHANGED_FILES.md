# V172-Q385R4 — Changed Files

## Modified

- `lib/features/camera/gauss_deferred_math_ocr_model_manager.dart`
  - Added optional `installSessionId` to persisted snapshots.
  - Repaired queued/downloading/verifying recovery state-machine.
  - Standalone queued state now survives `load()`.
  - Install-session queued/downloading/verifying states recover to retryable failed when the process-local worker is gone.

- `lib/features/camera/gauss_mathlive_ocr_review_surface.dart`
  - Changed `_DeferredModelStatusCard.onQueueModel` from `VoidCallback` to `Future<void> Function()`.
  - Made button `semanticsLabel` mirror `snapshot.downloadActionLabel`.

- `assets/mathlive/manifest.json`
  - Added Q385R4 audit envelope.

- `README.md`
  - Added Q385R4 summary.

## Added

- `lib/features/camera/gauss_camera_ocr_download_session_recovery_state_machine_q385r4.dart`
- `test/v172_q385r4_camera_ocr_download_session_recovery_state_machine_test.dart`
- `tool/verify_camera_ocr_download_session_recovery_state_machine_v172_q385r4.mjs`
- `docs/audit/V172_Q385R4_DOWNLOAD_SESSION_RECOVERY_TEST_AND_STATE_MACHINE_REPAIR.md`
- `docs/audit/V172_Q385R4_CHANGED_FILES.md`

## Explicitly not changed

- Q382 keyboard ordering/runtime behavior
- Keyboard layout/order/labels
- MORE/template tray
- Long-press inventory
- MathLive editor/caret authority
- Graph
- History
- Solution/Solver semantics
- OCR inference/runtime execution
- ONNX Runtime dependency
- Bundled model files
- Gradle/ABI policy
- AndroidManifest permissions
- Splash/icon/startup flow
