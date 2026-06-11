class GaussRuntimeDependencyModelLoaderDecisionQ323Policy {
  const GaussRuntimeDependencyModelLoaderDecisionQ323Policy._();

  static const String phase = 'V172-Q323-RUNTIME-DEPENDENCY-MODEL-LOADER-DECISION-IMPLEMENTATION';
  static const String sourcePhase = 'V172-Q322-FIRST-IMAGE-TO-LATEX-INFERENCE-ENVELOPE';
  static const String selectedEngineLabel = 'PP-FormulaNet-S';
  static const String implementationScope =
      'runtime-dependency-model-loader-decision-only-default-off-no-dependency-added';
  static const String nativeChannelName = 'mathpro/ocr_runtime_bridge';
  static const String runtimeDependencyModelLoaderDecisionMethod = 'runtimeDependencyModelLoaderDecision';
  static const String runtimeDependencyModelLoaderDecisionStatus =
      'RUNTIME_DEPENDENCY_MODEL_LOADER_DECISION_BLOCKED_PENDING_APPROVED_RUNTIME_EVIDENCE_DEFAULT_OFF';
  static const String featureFlagName = 'gauss.ppFormulaNetS.runtimeDependencyModelLoaderDecision.defaultOff';
  static const String selectedRuntimeDependency = 'UNSELECTED_PENDING_APPROVED_ANDROID_COMPATIBLE_RUNTIME_EVIDENCE';
  static const String selectedModelLoader = 'NONE_PENDING_APPROVED_RUNTIME_DEPENDENCY';
  static const String modelDirectoryName = 'ocr_models/PP-FormulaNet-S';
  static const String artifactFileName = 'inference.pdiparams';
  static const String expectedInferencePdiparamsSha256 =
      'b6392296d16e2a9f414c0a751d7ccbd1bd9d8272b68aab72df1d3875f35a7489';
  static const int expectedInferencePdiparamsSizeBytes = 231675001;
  static const String q315EvidenceCapturedAt = '2026-06-06T21:09:02.327Z';
  static const String mainActivityChangeReason =
      'add default-off runtime dependency/model loader decision envelope method only; no pubspec, Gradle, runtime dependency, model loader, startup, dummy call, or inference';
  static const String nextRequiredPhase =
      'Q324_REQUIRES_APPROVED_RUNTIME_DEPENDENCY_TRIAL_WITH_BUILD_LOG_AND_ROLLBACK_PLAN';

  static const List<String> decisionEnvelopeFields = <String>[
    'phase',
    'sourcePhase',
    'method',
    'channel',
    'status',
    'engine',
    'featureFlagDefaultEnabled',
    'selectedRuntimeDependency',
    'selectedModelLoader',
    'dependencyDecisionBlockedReason',
    'privateStorageRoot',
    'artifactPath',
    'artifactExists',
    'artifactSizeBytes',
    'expectedArtifactSha256',
    'actualArtifactSha256',
    'sha256MatchesExpected',
    'verifiedArtifactLoadSmokePassed',
    'pubspecChanged',
    'gradleChanged',
    'androidManifestChanged',
    'runtimeDependencyAdded',
    'approvedRuntimeDependencySelected',
    'modelLoaderAvailable',
    'modelLoadAttempted',
    'modelLoaded',
    'runtimeStartupAttempted',
    'runtimeStartupExecuted',
    'dummyRuntimeCallExecuted',
    'realImageToLatexInferenceExecuted',
    'ocrPassClaimed',
    'androidRealDevicePassClaimed',
  ];

  static const List<String> q323HardBlocks = <String>[
    'no-pubspec-gradle-androidmanifest-mutation-in-q323',
    'no-paddle-onnx-tflite-runtime-dependency-in-q323',
    'no-model-loader-binding-in-q323',
    'no-runtime-startup-or-dummy-call-execution-in-q323',
    'no-image-to-latex-execution-in-q323',
    'no-mathlive-review-or-workspace-import-in-q323',
    'no-ocr-pass-or-android-real-device-pass-without-real-runtime-log',
  ];

  static const List<String> q324EntryCriteria = <String>[
    'q323-flutter-analyze-clean',
    'q323-flutter-test-clean',
    'q323-flutter-run-device-log-shows-runtimeDependencyModelLoaderDecision-method-response',
    'q323-response-keeps-runtimeDependencyAdded-false-and-selectedRuntimeDependency-unselected',
    'approved-android-compatible-runtime-dependency-before-pubspec-or-gradle-mutation',
    'rollback-plan-required-before-runtime-dependency-trial',
  ];

  static const bool q315HashEvidenceProvidedToAssistant = true;
  static const bool q315Sha256MatchesExpected = true;
  static const bool q315ArtifactStoredOutsideProjectRoot = true;
  static const bool q315RuntimeAccepted = false;
  static const bool q319VerifiedArtifactLoadSmokeAdded = true;
  static const bool q320RuntimeStartupSmokeAdded = true;
  static const bool q321DummyRuntimeCallMethodAdded = true;
  static const bool q322FirstImageToLatexInferenceMethodAdded = true;
  static const bool runtimeDependencyModelLoaderDecisionMethodAdded = true;
  static const bool featureFlagDefaultEnabled = false;
  static const bool mainActivityChanged = true;
  static const bool protectedMainActivityChangeDeclared = true;
  static const bool pubspecChanged = false;
  static const bool gradleChanged = false;
  static const bool androidManifestChanged = false;
  static const bool runtimeDependencyAdded = false;
  static const bool approvedRuntimeDependencySelected = false;
  static const bool paddleRuntimeDependencyAdded = false;
  static const bool paddleOcrDependencyAdded = false;
  static const bool onnxRuntimeDependencyAdded = false;
  static const bool tfliteRuntimeDependencyAdded = false;
  static const bool downloadDependencyAdded = false;
  static const bool methodChannelBindingExtended = true;
  static const bool jniNativeHandlerAdded = false;
  static const bool nativeModelLoaderAdded = false;
  static const bool modelBinaryBundledInBaseApp = false;
  static const bool projectZipContainsModelArtifact = false;
  static const bool modelArtifactAcceptedForRuntime = false;
  static const bool modelLoaderAvailable = false;
  static const bool modelLoadAttempted = false;
  static const bool modelLoaded = false;
  static const bool runtimeStartupAttempted = false;
  static const bool runtimeStartupExecuted = false;
  static const bool runtimeStartupSmokePassed = false;
  static const bool dummyRuntimeCallAttempted = false;
  static const bool dummyRuntimeCallExecuted = false;
  static const bool dummyRuntimeCallPassed = false;
  static const bool imageInputAccepted = false;
  static const bool realImageToLatexInferenceAttempted = false;
  static const bool realImageToLatexInferenceExecuted = false;
  static const bool realImageToLatexInferencePassed = false;
  static const bool editableMathLiveReviewOpened = false;
  static const bool workspaceImportExecuted = false;
  static const bool ocrPassClaimed = false;
  static const bool cameraOcrRuntimePassClaimed = false;
  static const bool androidRealDevicePassClaimed = false;
}
