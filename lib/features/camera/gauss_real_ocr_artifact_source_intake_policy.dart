class GaussRealOcrArtifactSourceIntakePolicy {
  const GaussRealOcrArtifactSourceIntakePolicy._();

  static const String phase = 'V172-Q288-REAL-OCR-ARTIFACT-SOURCE-INTAKE';
  static const String sourcePhase = 'V172-Q287R2-STORE-READINESS-CAMERA-OCR-RELEASE-AUDIT-TEST-DOC-SECTION-REPAIR';
  static const String selectedEngineLabel = 'PP-FormulaNet-S';
  static const String intakeMode = 'official-source-candidate-intake-only-sha-pending-no-runtime-no-ocr-pass';

  static const String primaryOfficialSourceLabel = 'Hugging Face PaddlePaddle/PP-FormulaNet-S';
  static const String primaryOfficialSourceLocator = 'HF_MODEL_REPO:PaddlePaddle/PP-FormulaNet-S';
  static const String primaryOfficialRepositoryPath = 'PaddlePaddle/PP-FormulaNet-S';
  static const String officialMirrorSourceLabel = 'PaddleOCR/PaddleX BOS official inference model tar candidate';
  static const String officialMirrorInferenceArtifactLocator = 'BOS_OFFICIAL_INFERENCE_TAR:PP-FormulaNet-S_infer.tar';
  static const String recordedLicense = 'apache-2.0';
  static const String expectedSha256 = 'PENDING_DOWNLOAD_AND_HASH_VERIFICATION';
  static const String modelFormatFamily = 'Paddle inference artifact candidate';
  static const String runtimePathDecision = 'deferred-to-default-off-runtime-dependency-trial';
  static const String storageStrategy = 'download-to-private-app-storage-after-checksum-verification';

  static const int huggingFaceRepositorySizeMb = 238;
  static const int paddleDocsModelStorageSizeMb = 224;
  static const double paddleDocsGpuInferenceTimeMs = 182.25;
  static const double paddleDocsCpuInferenceTimeMs = 254.39;
  static const int expectedInputImageSize = 224;

  static const bool sourceCandidateRecorded = true;
  static const bool licenseEvidenceRecorded = true;
  static const bool modelSizeEvidenceRecorded = true;
  static const bool modelFormatEvidenceRecorded = true;
  static const bool androidAbiEvidencePending = true;
  static const bool latencyBudgetEvidencePending = true;
  static const bool peakMemoryBudgetEvidencePending = true;
  static const bool artifactSha256Verified = false;
  static const bool artifactAcceptedForRuntime = false;
  static const bool officialDownloadEnabled = false;

  static const bool changesRuntimeBehavior = false;
  static const bool keyboardLayoutChanged = false;
  static const bool moreTemplateTrayChanged = false;
  static const bool longPressListsChanged = false;
  static const bool graphSolutionHistoryChanged = false;
  static const bool mathLiveProductionRouteChanged = false;
  static const bool cameraShellRuntimeChanged = false;
  static const bool workspaceRuntimeChanged = false;
  static const bool solverEvaluatorChanged = false;
  static const bool androidToolchainChanged = false;
  static const bool cameraDependencyChanged = false;

  static const bool realOcrRuntimeAdded = false;
  static const bool paddleRuntimeAdded = false;
  static const bool paddleOcrDependencyAdded = false;
  static const bool nativeHandlerImplementationAdded = false;
  static const bool methodChannelRuntimeBindingAdded = false;
  static const bool modelBinaryBundledInBaseApp = false;
  static const bool productionModelUrlBound = false;
  static const bool productionDownloadEnabled = false;
  static const bool imageToLatexInferenceExecuted = false;
  static const bool directWorkspaceImportEnabled = false;
  static const bool directSolveGraphSolutionHistoryEnabled = false;
  static const bool ocrPassClaimed = false;
  static const bool cameraOcrRuntimePassClaimed = false;
  static const bool storeReadyPassClaimed = false;
  static const bool releasePassClaimed = false;

  static const List<String> sourceEvidenceReferences = [
    primaryOfficialSourceLabel,
    officialMirrorSourceLabel,
    'PaddleOCR formula recognition documentation lists PP-FormulaNet-S model storage/performance characteristics',
  ];

  static const List<String> artifactAcceptanceRequirements = [
    'download-candidate-artifact-in-an-isolated-non-production-step',
    'compute-and-record-real-sha256-before-ready-state',
    'verify-apache-2.0-license-compatibility-for-app-distribution',
    'confirm-android-runtime-path-and-abi-support-before-dependency-addition',
    'confirm-peak-memory-and-latency-budget-on-real-device-before-runtime-activation',
    'keep-model-out-of-base-apk-and-use-private-app-storage',
    'use-checksum-before-ready-and-atomic-move-after-checksum',
    'keep-editable-mathlive-review-and-explicit-user-approval-mandatory',
    'keep-direct-solve-graph-solution-history-blocked-for-camera-output',
  ];

  static const List<String> requiresUserSideRetest = [
    'flutter clean',
    'flutter pub get',
    'flutter analyze',
    'flutter test',
    'flutter run -d 23106RN0DA',
  ];
}
