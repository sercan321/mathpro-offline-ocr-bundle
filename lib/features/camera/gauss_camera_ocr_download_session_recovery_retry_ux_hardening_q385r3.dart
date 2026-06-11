/// V172-Q385R3 — camera OCR download session recovery and retry UX hardening.
///
/// This policy is intentionally limited to the deferred camera/OCR model
/// download session lifecycle. It does not enable OCR inference, re-add ONNX
/// Runtime, bundle model bytes, or mutate keyboard/MathLive/Graph/History/
/// Solution/Solver surfaces.
class GaussCameraOcrDownloadSessionRecoveryRetryUxHardeningQ385R3Policy {
  const GaussCameraOcrDownloadSessionRecoveryRetryUxHardeningQ385R3Policy._();

  static const String phase = 'V172-Q385R3-CAMERA-OCR-DOWNLOAD-SESSION-RECOVERY-RETRY-UX-HARDENING';
  static const String sourcePhase = 'V172-Q385R2-CAMERA-OCR-DOWNLOAD-COMPILE-LEGACY-VERIFIER-RECOVERY-REPAIR';

  static const bool processLocalActiveInstallGuardImplemented = true;
  static const bool activeSnapshotWithoutRunningProcessRecoversImmediately = true;
  static const bool activeProgressPersistenceImplemented = true;
  static const bool retryButtonCopyImplemented = true;
  static const bool generatedToolReportsDeclaredInAudit = true;
  static const bool sidecarShaLockStillNotClaimed = true;
  static const bool modelBinaryBundledInBaseApp = false;
  static const bool onnxRuntimeReintroducedInBaseApk = false;
  static const bool productionInferenceClaimedByQ385R3 = false;
  static const bool keyboardQ382Touched = false;
  static const bool graphHistorySolutionSolverTouched = false;

  static const Duration activeProgressPersistCadence = Duration(seconds: 2);

  static const String retryAfterInterruptedSessionCopy =
      'Önceki model indirme oturumu tamamlanamadı; yarıda kaldı. Kilit temizlendi; tekrar indirmeyi deneyebilirsin.';
  static const String retryButtonCopy = 'Tekrar indir';
  static const String defaultDownloadButtonCopy = 'Modeli indir';
  static const String activeDownloadButtonCopy = 'İndiriliyor';
}
