class GaussDummyInputRuntimeCallQ321Policy {
  const GaussDummyInputRuntimeCallQ321Policy._();

  static const String phase = 'V172-Q321-DUMMY-INPUT-RUNTIME-CALL';
  static const String sourcePhase = 'V172-Q320-RUNTIME-STARTUP-SMOKE-ON-DEVICE';
  static const String selectedEngineLabel = 'PP-FormulaNet-S';
  static const String implementationScope =
      'dummy-runtime-call-envelope-only-default-off-blocked-no-runtime-dependency';
  static const String nativeChannelName = 'mathpro/ocr_runtime_bridge';
  static const String dummyRuntimeCallMethod = 'dummyRuntimeCall';
  static const String dummyRuntimeCallStatus =
      'DUMMY_RUNTIME_CALL_BLOCKED_NO_RUNTIME_DEPENDENCY_DEFAULT_OFF';
  static const String featureFlagName = 'gauss.ppFormulaNetS.dummyRuntimeCall.defaultOff';
  static const String modelDirectoryName = 'ocr_models/PP-FormulaNet-S';
  static const String artifactFileName = 'inference.pdiparams';
  static const String expectedInferencePdiparamsSha256 =
      'b6392296d16e2a9f414c0a751d7ccbd1bd9d8272b68aab72df1d3875f35a7489';
  static const int expectedInferencePdiparamsSizeBytes = 231675001;
  static const String q315EvidenceCapturedAt = '2026-06-06T21:09:02.327Z';
  static const String dummyPayloadLabel = 'q321-deterministic-dummy-input-no-runtime';
  static const String mainActivityChangeReason =
      'add default-off dummy runtime call envelope method only; no runtime dependency, model loader, or inference';
  static const String nextRequiredPhase =
      'Q322_FIRST_REAL_IMAGE_TO_LATEX_REQUIRES_REAL_RUNTIME_DEPENDENCY_AND_DUMMY_CALL_EVIDENCE';

  static const List<String> dummyRuntimeCallEnvelopeFields = <String>[
    'phase',
    'sourcePhase',
    'method',
    'channel',
    'status',
    'engine',
    'featureFlagDefaultEnabled',
    'dummyPayloadLabel',
    'dummyPayloadSha256',
    'privateStorageRoot',
    'artifactPath',
    'artifactExists',
    'artifactSizeBytes',
    'expectedArtifactSha256',
    'actualArtifactSha256',
    'sha256MatchesExpected',
    'verifiedArtifactLoadSmokePassed',
    'dummyRuntimeCallBlockedReason',
    'runtimeDependencyAdded',
    'runtimeStartupAttempted',
    'runtimeStartupExecuted',
    'runtimeStartupSmokePassed',
    'modelLoaderAvailable',
    'modelLoaded',
    'dummyRuntimeCallAttempted',
    'dummyRuntimeCallExecuted',
    'dummyRuntimeCallPassed',
    'realImageToLatexInferenceExecuted',
    'editableMathLiveReviewOpened',
    'workspaceImportExecuted',
    'ocrPassClaimed',
    'androidRealDevicePassClaimed',
  ];

  static const List<String> q321HardBlocks = <String>[
    'no-pubspec-gradle-or-androidmanifest-mutation-in-q321',
    'no-paddle-onnx-tflite-runtime-dependency-in-q321',
    'no-jni-native-model-loader-in-q321',
    'no-dummy-runtime-call-execution-without-selected-runtime-dependency-in-q321',
    'no-image-to-latex-in-q321',
    'no-mathlive-review-or-workspace-import-in-q321',
    'no-ocr-pass-or-android-real-device-pass-without-real-run-log',
  ];

  static const List<String> q322EntryCriteria = <String>[
    'q321-flutter-analyze-clean',
    'q321-flutter-test-clean',
    'q321-flutter-run-device-log-shows-dummyRuntimeCall-method-response',
    'q321-response-keeps-dummyRuntimeCallExecuted-false-with-no-runtime-dependency',
    'runtime-dependency-selection-approved-before-first-image-to-latex',
  ];

  static const bool q315HashEvidenceProvidedToAssistant = true;
  static const bool q315Sha256MatchesExpected = true;
  static const bool q315ArtifactStoredOutsideProjectRoot = true;
  static const bool q315RuntimeAccepted = false;
  static const bool q319VerifiedArtifactLoadSmokeAdded = true;
  static const bool q320RuntimeStartupSmokeAdded = true;
  static const bool dummyRuntimeCallMethodAdded = true;
  static const bool featureFlagDefaultEnabled = false;
  static const bool mainActivityChanged = true;
  static const bool protectedMainActivityChangeDeclared = true;
  static const bool pubspecChanged = false;
  static const bool gradleChanged = false;
  static const bool androidManifestChanged = false;
  static const bool runtimeDependencyAdded = false;
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
  static const bool runtimeStartupAttempted = false;
  static const bool runtimeStartupExecuted = false;
  static const bool runtimeStartupSmokePassed = false;
  static const bool dummyRuntimeCallAttempted = false;
  static const bool dummyRuntimeCallExecuted = false;
  static const bool dummyRuntimeCallPassed = false;
  static const bool realImageToLatexInferenceExecuted = false;
  static const bool editableMathLiveReviewOpened = false;
  static const bool workspaceImportExecuted = false;
  static const bool ocrPassClaimed = false;
  static const bool cameraOcrRuntimePassClaimed = false;
  static const bool androidRealDevicePassClaimed = false;
}
