/// V172-Q385R4 — camera OCR download session recovery state-machine repair.
///
/// This policy is intentionally limited to the deferred camera/OCR model
/// download state machine. It does not enable OCR inference, re-add ONNX
/// Runtime, bundle model bytes, or mutate keyboard/MathLive/Graph/History/
/// Solution/Solver surfaces.
class GaussCameraOcrDownloadSessionRecoveryStateMachineQ385R4Policy {
  const GaussCameraOcrDownloadSessionRecoveryStateMachineQ385R4Policy._();

  static const String phase = 'V172-Q385R4-DOWNLOAD-SESSION-RECOVERY-TEST-AND-STATE-MACHINE-REPAIR';
  static const String sourcePhase = 'V172-Q385R3-CAMERA-OCR-DOWNLOAD-SESSION-RECOVERY-RETRY-UX-HARDENING';

  static const bool standaloneQueuedStateSurvivesLoad = true;
  static const bool installSessionQueuedStateCanRecover = true;
  static const bool interruptedDownloadingVerifyingRecoverImmediately = true;
  static const bool installSessionIdPersisted = true;
  static const bool q239dQueuedLoadTestRepaired = true;
  static const bool reviewAsyncCallbackSignatureRepaired = true;
  static const bool reviewDownloadSemanticsMirrorsVisibleCopy = true;
  static const bool sidecarShaLockStillNotClaimed = true;
  static const bool modelBinaryBundledInBaseApp = false;
  static const bool onnxRuntimeReintroducedInBaseApk = false;
  static const bool productionInferenceClaimedByQ385R4 = false;
  static const bool keyboardQ382Touched = false;
  static const bool graphHistorySolutionSolverTouched = false;

  static const String installSessionIdPrefix = 'q385r4-install-session-';
  static const String interruptedInstallSessionCopy =
      'Önceki model indirme oturumu tamamlanamadı; yarıda kaldı. Kilit temizlendi; tekrar indirmeyi deneyebilirsin.';
}
