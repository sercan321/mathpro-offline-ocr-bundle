class GaussRuntimeStartupSmokeOnDeviceQ320Policy {
  const GaussRuntimeStartupSmokeOnDeviceQ320Policy._();

  static const String phase = 'V172-Q320-RUNTIME-STARTUP-SMOKE-ON-DEVICE';
  static const String sourcePhase = 'V172-Q319-VERIFIED-ARTIFACT-LOAD-SMOKE-ON-DEVICE';
  static const String selectedEngineLabel = 'PP-FormulaNet-S';
  static const String implementationScope =
      'runtime-startup-smoke-preflight-envelope-only-default-off-no-runtime-dependency';
  static const String nativeChannelName = 'mathpro/ocr_runtime_bridge';
  static const String runtimeStartupSmokeMethod = 'runtimeStartupSmoke';
  static const String runtimeStartupSmokeStatus =
      'RUNTIME_STARTUP_SMOKE_BLOCKED_NO_RUNTIME_DEPENDENCY_DEFAULT_OFF';
  static const String featureFlagName = 'gauss.ppFormulaNetS.runtimeStartupSmoke.defaultOff';
  static const String modelDirectoryName = 'ocr_models/PP-FormulaNet-S';
  static const String artifactFileName = 'inference.pdiparams';
  static const String expectedInferencePdiparamsSha256 =
      'b6392296d16e2a9f414c0a751d7ccbd1bd9d8272b68aab72df1d3875f35a7489';
  static const int expectedInferencePdiparamsSizeBytes = 231675001;
  static const String q315EvidenceCapturedAt = '2026-06-06T21:09:02.327Z';
  static const String mainActivityChangeReason =
      'add default-off runtime startup smoke preflight method only; no runtime dependency or model loader';
  static const String nextRequiredPhase =
      'Q321_DUMMY_INPUT_RUNTIME_CALL_REQUIRES_REAL_RUNTIME_DEPENDENCY_SELECTION';

  static const List<String> runtimeStartupSmokeEnvelopeFields = <String>[
    'phase',
    'sourcePhase',
    'method',
    'channel',
    'status',
    'engine',
    'featureFlagDefaultEnabled',
    'privateStorageRoot',
    'artifactPath',
    'artifactExists',
    'artifactSizeBytes',
    'expectedArtifactSha256',
    'actualArtifactSha256',
    'sha256MatchesExpected',
    'verifiedArtifactLoadSmokePassed',
    'runtimeStartupBlockedReason',
    'runtimeDependencyAdded',
    'runtimeStartupAttempted',
    'runtimeStartupExecuted',
    'runtimeStartupSmokePassed',
    'modelLoaderAvailable',
    'modelLoaded',
    'dummyRuntimeCallExecuted',
    'imageToLatexInferenceExecuted',
    'editableMathLiveReviewOpened',
    'workspaceImportExecuted',
    'ocrPassClaimed',
    'androidRealDevicePassClaimed',
  ];

  static const List<String> q320HardBlocks = <String>[
    'no-pubspec-gradle-or-androidmanifest-mutation-in-q320',
    'no-paddle-onnx-tflite-runtime-dependency-in-q320',
    'no-jni-native-model-loader-in-q320',
    'no-runtime-startup-attempt-without-selected-runtime-dependency-in-q320',
    'no-dummy-runtime-call-or-image-to-latex-in-q320',
    'no-mathlive-review-or-workspace-import-in-q320',
    'no-ocr-pass-or-android-real-device-pass-without-real-run-log',
  ];

  static const List<String> q321EntryCriteria = <String>[
    'q320-flutter-analyze-clean',
    'q320-flutter-test-clean',
    'q320-flutter-run-device-log-shows-runtimeStartupSmoke-method-response',
    'q320-response-keeps-runtimeStartupExecuted-false-with-no-runtime-dependency',
    'runtime-dependency-selection-approved-before-dummy-runtime-call',
  ];

  static const bool q315HashEvidenceProvidedToAssistant = true;
  static const bool q315Sha256MatchesExpected = true;
  static const bool q315ArtifactStoredOutsideProjectRoot = true;
  static const bool q315RuntimeAccepted = false;
  static const bool q319VerifiedArtifactLoadSmokeAdded = true;
  static const bool runtimeStartupSmokeMethodAdded = true;
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
  static const bool dummyRuntimeCallExecuted = false;
  static const bool realImageToLatexInferenceExecuted = false;
  static const bool editableMathLiveReviewOpened = false;
  static const bool workspaceImportExecuted = false;
  static const bool ocrPassClaimed = false;
  static const bool cameraOcrRuntimePassClaimed = false;
  static const bool androidRealDevicePassClaimed = false;
}
