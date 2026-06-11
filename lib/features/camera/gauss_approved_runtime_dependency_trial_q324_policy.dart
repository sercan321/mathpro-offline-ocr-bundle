class GaussApprovedRuntimeDependencyTrialQ324Policy {
  const GaussApprovedRuntimeDependencyTrialQ324Policy._();

  static const String phase = 'V172-Q324-APPROVED-RUNTIME-DEPENDENCY-TRIAL-BEHIND-DEFAULT-OFF-FLAG';
  static const String sourcePhase = 'V172-Q323-RUNTIME-DEPENDENCY-MODEL-LOADER-DECISION-IMPLEMENTATION';
  static const String selectedEngineLabel = 'PP-FormulaNet-S';
  static const String implementationScope =
      'approved-runtime-dependency-trial-default-off-blocked-until-user-q323-flutter-logs-and-runtime-coordinate-evidence';
  static const String nativeChannelName = 'mathpro/ocr_runtime_bridge';
  static const String approvedRuntimeDependencyTrialMethod = 'approvedRuntimeDependencyTrial';
  static const String approvedRuntimeDependencyTrialStatus =
      'APPROVED_RUNTIME_DEPENDENCY_TRIAL_BLOCKED_PENDING_USER_Q323_FLUTTER_LOG_AND_RUNTIME_COORDINATE_EVIDENCE_DEFAULT_OFF';
  static const String featureFlagName = 'gauss.ppFormulaNetS.approvedRuntimeDependencyTrial.defaultOff';
  static const String selectedRuntimeDependency = 'UNSELECTED_PENDING_BUILD_COMPATIBLE_RUNTIME_COORDINATES';
  static const String selectedModelLoader = 'NONE_PENDING_APPROVED_RUNTIME_DEPENDENCY';
  static const String modelDirectoryName = 'ocr_models/PP-FormulaNet-S';
  static const String artifactFileName = 'inference.pdiparams';
  static const String expectedInferencePdiparamsSha256 =
      'b6392296d16e2a9f414c0a751d7ccbd1bd9d8272b68aab72df1d3875f35a7489';
  static const int expectedInferencePdiparamsSizeBytes = 231675001;
  static const String q315EvidenceCapturedAt = '2026-06-06T21:09:02.327Z';
  static const String mainActivityChangeReason =
      'add default-off approved runtime dependency trial envelope method only; no pubspec, Gradle, AndroidManifest, runtime dependency, model loader, startup, dummy call, or inference';
  static const String nextRequiredPhase =
      'Q325_REQUIRES_EXPLICIT_RUNTIME_DEPENDENCY_COORDINATES_AND_USER_SIDE_FLUTTER_RUN_EVIDENCE';

  static const List<String> trialEnvelopeFields = <String>[
    'phase',
    'sourcePhase',
    'method',
    'channel',
    'status',
    'engine',
    'featureFlagDefaultEnabled',
    'selectedRuntimeDependency',
    'selectedModelLoader',
    'dependencyTrialBlockedReason',
    'q315HashEvidenceSha256Matches',
    'q323UserFlutterAnalyzePassed',
    'q323UserFlutterTestPassed',
    'q323UserFlutterRunPassed',
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
    'approvedRuntimeDependencyTrialDefined',
    'approvedRuntimeDependencySelected',
    'nativeModelLoaderAdded',
    'modelLoaderAvailable',
    'runtimeStartupAttempted',
    'dummyRuntimeCallExecuted',
    'realImageToLatexInferenceExecuted',
    'ocrPassClaimed',
    'androidRealDevicePassClaimed',
  ];

  static const List<String> q324HardBlocks = <String>[
    'no-pubspec-gradle-androidmanifest-mutation-in-q324',
    'no-paddle-onnx-tflite-runtime-dependency-in-q324',
    'no-selected-runtime-coordinates-without-user-approval',
    'no-model-loader-binding-in-q324',
    'no-runtime-startup-or-dummy-call-execution-in-q324',
    'no-image-to-latex-execution-in-q324',
    'no-mathlive-review-or-workspace-import-in-q324',
    'no-ocr-runtime-pass-claim-in-q324',
  ];

  static const List<String> q325EntryCriteria = <String>[
    'q324-flutter-analyze-and-test-user-log-clean',
    'q324-flutter-run-real-device-log-reviewed',
    'approved-runtime-dependency-coordinates-selected',
    'dependency-license-and-transitive-audit-complete',
    'gradle-and-abi-impact-review-complete',
    'rollback-plan-before-dependency-mutation',
    'feature-flag-default-off-before-runtime-instantiation',
  ];
}
