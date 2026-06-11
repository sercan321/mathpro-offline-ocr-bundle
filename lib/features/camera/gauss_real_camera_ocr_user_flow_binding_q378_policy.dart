class GaussRealCameraOcrUserFlowBindingQ378Policy {
  const GaussRealCameraOcrUserFlowBindingQ378Policy._();

  static const String phase = 'V172-Q378-REAL-CAMERA-OCR-USER-FLOW-BINDING';
  static const String sourcePhase = 'V172-Q377-CAMERA-OCR-END-TO-END-FINAL-DEVICE-CLOSURE';
  static const String bridgeChannel = 'mathpro/ocr_runtime_bridge';
  static const String decoderBridgeMethod = 'ocrRuntimeReadinessAdaptiveInputDecoderCompletion';
  static const String bindingVersion = 'q378-real-camera-ocr-user-flow-binding-v4-q389r2-offline-device-only-formula-ocr';

  static const bool cameraCropAcceptInvokesOcrHarness = true;
  static const bool realCandidateOpensEditableReview = true;
  static const bool approvedReviewImportsToWorkspace = true;
  static const bool directOcrToWorkspaceImportBlocked = true;
  static const bool directOcrToSolveGraphSolutionHistoryBlocked = true;
  static const bool workspaceImportRequiresExplicitUserApproval = true;
  static const bool workspaceImportMustNotAutoEvaluate = true;
  static const bool workspaceImportMustNotAutoGraph = true;
  static const bool workspaceImportMustNotWriteSolutionOrHistory = true;
  static const bool onnxModelBundledInZip = false;
  static const bool ocrPassClaimedByPackage = false;
  static const bool q389R2FormulaOcrBackendFirst = false;
  static const bool q389R2DeviceOnlyFormulaOcrPrimary = true;
  static const bool backendFormulaOcrAllowed = false;
  static const bool plainTextOcrFallbackEnabled = false;
}
