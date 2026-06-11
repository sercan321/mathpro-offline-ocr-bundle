/// V172-Q385R2 — compile, stale download recovery, and legacy verifier repair.
///
/// This policy is intentionally limited to the deferred camera/OCR model download
/// guard. It does not enable OCR inference, re-add ONNX Runtime, bundle model
/// bytes, or mutate keyboard/MathLive/Graph/History/Solution/Solver surfaces.
class GaussCameraOcrDownloadCompileLegacyVerifierRecoveryQ385R2Policy {
  const GaussCameraOcrDownloadCompileLegacyVerifierRecoveryQ385R2Policy._();

  static const String phase = 'V172-Q385R2-CAMERA-OCR-DOWNLOAD-COMPILE-LEGACY-VERIFIER-RECOVERY-REPAIR';
  static const String sourcePhase = 'V172-Q385R1-PADDLE-RUNTIME-ABI-TRIM-TEST-AND-DOWNLOAD-GUARD-REPAIR';

  static const bool accumulatorSinkCompileRiskRepaired = true;
  static const bool legacyCameraVerifiersMadeSuccessorAware = true;
  static const bool staleQueuedDownloadRecoveryImplemented = true;
  static const bool downloadRequestTimeoutImplemented = true;
  static const bool downloadStreamIdleTimeoutImplemented = true;
  static const bool primaryShaCopySeparatedFromSidecarSizeCopy = true;
  static const bool sidecarShaLockStillNotClaimed = true;
  static const bool modelBinaryBundledInBaseApp = false;
  static const bool onnxRuntimeReintroducedInBaseApk = false;
  static const bool productionInferenceClaimedByQ385R2 = false;
  static const bool keyboardQ382Touched = false;
  static const bool graphHistorySolutionSolverTouched = false;

  static const Duration requestTimeout = Duration(seconds: 45);
  static const Duration streamIdleTimeout = Duration(seconds: 30);
  static const Duration staleActiveStateGracePeriod = Duration(minutes: 30);

  static const String networkPolicy = 'user-approved-internet-required-large-download';
  static const String sidecarVerificationCopy = 'primary-sha256-sidecars-size-and-presence-checked';
}
