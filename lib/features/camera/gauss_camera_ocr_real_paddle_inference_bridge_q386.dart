/// V172-Q386 — real Paddle OCR inference bridge.
///
/// This phase opens the native bridge that attempts Paddle Lite runtime loading,
/// image decode, tensor preprocessing, predictor execution, and safe output
/// decoding against the user-downloaded PP-FormulaNet-S artifact. It remains
/// review-first and never fabricates LaTeX or writes the workspace directly.
class GaussCameraOcrRealPaddleInferenceBridgeQ386Policy {
  const GaussCameraOcrRealPaddleInferenceBridgeQ386Policy._();

  static const String phase = 'V172-Q386-REAL-PADDLE-OCR-INFERENCE-BRIDGE';
  static const String sourcePhase = 'V172-Q385R4-DOWNLOAD-SESSION-RECOVERY-TEST-AND-STATE-MACHINE-REPAIR';
  static const String nativeBridgeMethod = 'realPaddleOcrInferenceBridgeQ386';
  static const String q380BridgeEntry = 'q380-q386-real-paddle-inference-bridge';

  static const bool nativePaddleRuntimeLoadAttemptEnabled = true;
  static const bool paddlePredictorModelLoadAttemptEnabled = true;
  static const bool cameraImageDecodeAttemptEnabled = true;
  static const bool adaptiveTensorPreprocessAttemptEnabled = true;
  static const bool paddlePredictorRunAttemptEnabled = true;
  static const bool outputDecoderReuseQ380 = true;
  static const bool reviewRequiredBeforeWorkspaceImport = true;
  static const bool explicitUserApprovalRequiredBeforeWorkspaceImport = true;
  static const bool directWorkspaceImportBlocked = true;
  static const bool directSolveGraphSolutionHistoryBlocked = true;
  static const bool fakeLatexCandidateAllowed = false;
  static const bool onnxRuntimeReintroducedInBaseApk = false;
  static const bool modelBinaryBundledInBaseApp = false;
  static const bool productionInferencePassClaimedByQ386 = false;
  static const bool androidRealDevicePassClaimedByQ386 = false;
  static const bool keyboardQ382Touched = false;
  static const bool graphHistorySolutionSolverTouched = false;

  static const String downloadedArtifactFormat = 'paddle-inference-directory';
  static const String expectedMobileConfigModelFileMode = 'paddle-lite-optimized-model-file-or-compatible-artifact';
  static const String incompatibleArtifactBlockedReason = 'q386-paddle-lite-model-load-failed-or-artifact-format-incompatible';
}
