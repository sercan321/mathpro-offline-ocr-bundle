class GaussFullRealCameraOcrRegressionPolicy {
  const GaussFullRealCameraOcrRegressionPolicy._();

  static const String phase = 'V172-Q298-FULL-REAL-CAMERA-OCR-REGRESSION';
  static const String sourcePhase = 'V172-Q297-APPROVED-OCR-WORKSPACE-IMPORT-REAL-RUNTIME';
  static const String selectedEngineLabel = 'PP-FormulaNet-S';
  static const String fallbackEngineLabel = 'PP-FormulaNet_plus-L only';
  static const String regressionMode = 'full-real-camera-ocr-regression-contract-only-runtime-blocked';
  static const String regressionFeatureFlag = 'gauss.ppFormulaNetS.fullRealCameraOcrRegression.defaultOff';
  static const String regressionReadinessState = 'BLOCKED_PENDING_REAL_Q291_TO_Q297_DEVICE_EVIDENCE_CHAIN';
  static const String regressionDecision = 'blocked-until-real-model-runtime-inference-review-approval-import-and-device-evidence';
  static const String regressionPolicy = 'review-first-approved-import-only-no-auto-solve-graph-solution-history';
  static const String rollbackMode = 'delete-q298-contract-files-without-runtime-binding-model-download-workspace-mutation-or-history-solution-write';

  static const int minimumRegressionGateCount = 28;
  static const int minimumEvidenceArtifactCount = 12;
  static const int maxRegressionEvidenceLatencyBudgetMs = 2200;

  static const bool q297ApprovedOcrWorkspaceImportRequired = true;
  static const bool q296EditableMathLiveReviewRequired = true;
  static const bool q295ImageToLatexInferenceEvidenceRequired = true;
  static const bool q294DummyInputRuntimeCallEvidenceRequired = true;
  static const bool q293RuntimeStartupEvidenceRequired = true;
  static const bool q292PrivateArtifactLoadEvidenceRequired = true;
  static const bool q291PrivateModelDownloadShaEvidenceRequired = true;
  static const bool q290NativeHandlerBindingEvidenceRequired = true;
  static const bool q289RuntimeDependencyTrialDefaultOffRequired = true;
  static const bool q288ArtifactSourceIntakeRequired = true;
  static const bool editableMathLiveReviewStillRequired = true;
  static const bool explicitUserApprovalStillRequired = true;
  static const bool workspaceImportOnlyAfterApproval = true;
  static const bool manualSolveGraphAfterImportOnly = true;

  static const bool changesRuntimeBehavior = false;
  static const bool keyboardLayoutChanged = false;
  static const bool moreTemplateTrayChanged = false;
  static const bool longPressListsChanged = false;
  static const bool graphSolutionHistoryChanged = false;
  static const bool mathLiveProductionRouteChanged = false;
  static const bool mathLiveBridgeChanged = false;
  static const bool cameraShellRuntimeChanged = false;
  static const bool workspaceRuntimeChanged = false;
  static const bool solverEvaluatorChanged = false;
  static const bool androidToolchainChanged = false;
  static const bool cameraDependencyChanged = false;
  static const bool androidManifestChanged = false;
  static const bool mainActivityChanged = false;
  static const bool splashIconChanged = false;

  static const bool fullRealCameraOcrRegressionExecuted = false;
  static const bool realWorkspaceImportRuntimeExecuted = false;
  static const bool realEditableMathLiveReviewOpened = false;
  static const bool realUserApprovalCaptured = false;
  static const bool realImageToLatexInferenceExecuted = false;
  static const bool realDummyInputRuntimeCallExecuted = false;
  static const bool nativeRuntimeStartupExecuted = false;
  static const bool realPrivateArtifactFileLoaded = false;
  static const bool realModelDownloadedAndShaVerified = false;
  static const bool nativeRuntimeHandlerImplemented = false;
  static const bool methodChannelRuntimeBindingAdded = false;
  static const bool jniBindingAdded = false;
  static const bool paddleRuntimeAdded = false;
  static const bool paddleOcrDependencyAdded = false;
  static const bool runtimeDependencyAddedToPubspec = false;
  static const bool gradleNativeRuntimeDependencyAdded = false;
  static const bool cameraImageSentToNativeRuntime = false;
  static const bool latexCandidateReturnedByRuntime = false;
  static const bool modelBinaryBundledInBaseApp = false;
  static const bool productionDownloadEnabled = false;
  static const bool directWorkspaceImportEnabled = false;
  static const bool autoEvaluateEnabled = false;
  static const bool autoSolveGraphSolutionHistoryEnabled = false;
  static const bool solutionHistoryWriteEnabled = false;
  static const bool fullRegressionPassClaimed = false;
  static const bool workspaceImportPassClaimed = false;
  static const bool reviewBindingPassClaimed = false;
  static const bool imageToLatexPassClaimed = false;
  static const bool runtimeSmokePassClaimed = false;
  static const bool modelDownloadPassClaimed = false;
  static const bool ocrPassClaimed = false;
  static const bool cameraOcrRuntimePassClaimed = false;
  static const bool premiumFinalPassClaimed = false;
  static const bool storeReadyPassClaimed = false;
  static const bool releasePassClaimed = false;

  static const List<String> requiredRegressionGates = [
    'q297-approved-ocr-workspace-import-contract-present',
    'q296-editable-mathlive-review-contract-present',
    'q295-image-to-latex-inference-contract-present',
    'q294-dummy-input-runtime-call-contract-present',
    'q293-runtime-startup-smoke-contract-present',
    'q292-private-artifact-load-smoke-contract-present',
    'q291-private-model-download-sha-verification-contract-present',
    'q290-native-handler-android-binding-contract-present',
    'q289-runtime-dependency-trial-default-off-contract-present',
    'q288-real-ocr-artifact-source-intake-contract-present',
    'keyboard-layout-preserved',
    'more-template-tray-preserved',
    'long-press-lists-preserved',
    'mathlive-production-route-preserved',
    'mathlive-bridge-preserved',
    'camera-shell-runtime-preserved',
    'workspace-runtime-preserved',
    'graph-surface-preserved',
    'solution-surface-preserved',
    'history-surface-preserved',
    'app-shell-main-preserved',
    'android-manifest-mainactivity-preserved',
    'camera-dependencies-preserved',
    'android-toolchain-preserved',
    'editable-mathlive-review-required',
    'explicit-user-approval-required',
    'workspace-import-only-after-approval',
    'no-auto-evaluate-solve-graph-solution-history',
  ];

  static const List<String> regressionCourtCases = [
    'camera-entry-button-still-reachable',
    'camera-permission-shell-contract-still-safe',
    'crop-scan-frame-metadata-preserved',
    'artifact-source-intake-evidence-gate',
    'private-model-download-sha-gate',
    'private-artifact-load-gate',
    'runtime-startup-smoke-gate',
    'dummy-input-runtime-call-gate',
    'image-to-latex-candidate-gate',
    'editable-mathlive-review-gate',
    'approved-workspace-import-gate',
    'keyboard-more-longpress-regression-guard',
    'graph-solution-history-no-auto-write-guard',
    'fake-pass-claim-guard',
  ];

  static const List<String> blockedUntilRealEvidence = [
    'real-official-artifact-url-and-expected-sha256',
    'real-private-download-actual-sha256-log',
    'real-private-artifact-load-device-log',
    'real-model-format-probe-device-log',
    'real-native-runtime-startup-device-log',
    'real-dummy-input-runtime-call-device-log',
    'real-image-to-latex-inference-device-log',
    'real-editable-mathlive-review-opened-evidence',
    'real-explicit-user-approval-evidence',
    'real-approved-workspace-import-evidence',
    'real-flutter-analyze-log',
    'real-flutter-test-log',
    'real-flutter-run-device-log',
  ];

  static const List<String> forbiddenActions = [
    'runFullCameraOcrRegressionInQ298',
    'claimFullRegressionPassWithoutRealEvidence',
    'invokeNativeRuntimeInQ298',
    'sendCameraImageToNativeRuntimeInQ298',
    'returnLatexCandidateFromRuntimeInQ298',
    'mutateWorkspaceFromCameraWithoutApproval',
    'autoEvaluateCameraOutput',
    'autoSolveCameraOutput',
    'autoGraphCameraOutput',
    'autoWriteSolutionOrHistoryFromCameraOutput',
    'addPaddleRuntimeDependencyInQ298',
    'addPaddleOcrDependencyInQ298',
    'addNativeHandlerImplementationInQ298',
    'addJniBindingInQ298',
    'bindRuntimeMethodChannelInQ298',
    'bundlePPFormulaNetSModelInBaseApkInQ298',
    'enableProductionDownloadInQ298',
    'claimOcrPassWithoutRealInferenceEvidence',
    'claimPremiumFinalPassWithoutDeviceEvidence',
    'claimReleasePassWithoutStoreAuditEvidence',
  ];

  static const List<String> blockedDependencyFamilies = [
    'paddleocr',
    'paddle_ocr',
    'paddle_flutter',
    'paddle_lite',
    'onnxruntime',
    'tesseract',
    'pix2text',
    'flutter_downloader',
    'background_downloader',
    'dio',
  ];

  static const List<String> requiresUserSideRetest = [
    'flutter clean',
    'flutter pub get',
    'flutter analyze',
    'flutter test',
    'flutter run -d 23106RN0DA',
  ];
}
