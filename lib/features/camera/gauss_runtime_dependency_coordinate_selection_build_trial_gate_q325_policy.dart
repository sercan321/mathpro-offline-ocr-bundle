class GaussRuntimeDependencyCoordinateSelectionBuildTrialGateQ325Policy {
  const GaussRuntimeDependencyCoordinateSelectionBuildTrialGateQ325Policy._();

  static const String phase = 'V172-Q325-EXPLICIT-RUNTIME-DEPENDENCY-COORDINATE-SELECTION-BUILD-TRIAL-GATE';
  static const String sourcePhase = 'V172-Q324-APPROVED-RUNTIME-DEPENDENCY-TRIAL-BEHIND-DEFAULT-OFF-FLAG';
  static const String selectedEngineLabel = 'PP-FormulaNet-S';
  static const String implementationScope =
      'explicit-runtime-dependency-coordinate-selection-and-build-trial-gate-with-no-dependency-mutation';
  static const String nativeChannelName = 'mathpro/ocr_runtime_bridge';
  static const String runtimeDependencyCoordinateSelectionMethod = 'runtimeDependencyCoordinateSelection';
  static const String runtimeDependencyCoordinateSelectionStatus =
      'RUNTIME_DEPENDENCY_COORDINATE_SELECTION_RECORDED_BUILD_TRIAL_BLOCKED_NO_GRADLE_MUTATION_DEFAULT_OFF';
  static const String featureFlagName = 'gauss.ppFormulaNetS.runtimeDependencyCoordinateSelection.defaultOff';
  static const String selectedRuntimeDependencyCandidate =
      'PADDLE_LITE_ANDROID_NATIVE_LIBRARY_MANUAL_TRIAL_PENDING';
  static const String selectedModelLoaderCandidate =
      'PADDLE_LITE_OPTIMIZED_PADDLE_INFERENCE_MODEL_LOADER_PENDING_CONVERSION_EVIDENCE';
  static const String selectedRuntimeDependencyCoordinate =
      'NO_MAVEN_COORDINATE_SELECTED_MANUAL_NATIVE_LIBRARY_TRIAL_REQUIRED';
  static const String coordinateSelectionReason =
      'official-on-device-path-points-to-paddle-lite-native-library-workflow-rather-than-simple-flutter-pub-dependency';
  static const String modelDirectoryName = 'ocr_models/PP-FormulaNet-S';
  static const String artifactFileName = 'inference.pdiparams';
  static const String expectedInferencePdiparamsSha256 =
      'b6392296d16e2a9f414c0a751d7ccbd1bd9d8272b68aab72df1d3875f35a7489';
  static const int expectedInferencePdiparamsSizeBytes = 231675001;
  static const String q315EvidenceCapturedAt = '2026-06-06T21:09:02.327Z';
  static const String mainActivityChangeReason =
      'add default-off runtime dependency coordinate selection envelope method only; no pubspec, Gradle, AndroidManifest, dependency, native loader, runtime startup, dummy execution, or inference';
  static const String nextRequiredPhase =
      'Q326_REQUIRES_USER_Q325_FLUTTER_LOGS_AND_EXPLICIT_NATIVE_LIBRARY_BUILD_TRIAL_APPROVAL';

  static const List<String> candidateRuntimePaths = <String>[
    'paddle-lite-native-android-library-manual-integration-candidate',
    'onnx-runtime-mobile-conversion-candidate-blocked-pending-export-evidence',
    'tflite-conversion-candidate-blocked-pending-model-conversion-evidence',
    'server-side-or-cloud-ocr-candidate-rejected-for-offline-first-camera-ocr-track',
  ];

  static const List<String> buildTrialEnvelopeFields = <String>[
    'phase',
    'sourcePhase',
    'method',
    'channel',
    'status',
    'engine',
    'featureFlagDefaultEnabled',
    'selectedRuntimeDependencyCandidate',
    'selectedModelLoaderCandidate',
    'selectedRuntimeDependencyCoordinate',
    'coordinateSelectionReason',
    'buildTrialBlockedReason',
    'q315HashEvidenceSha256Matches',
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
    'runtimeDependencyCoordinateSelected',
    'buildTrialExecuted',
    'nativeLibraryBundled',
    'nativeModelLoaderAdded',
    'modelLoaderAvailable',
    'runtimeStartupAttempted',
    'dummyRuntimeCallExecuted',
    'realImageToLatexInferenceExecuted',
    'ocrPassClaimed',
    'androidRealDevicePassClaimed',
  ];

  static const List<String> q325HardBlocks = <String>[
    'no-pubspec-gradle-androidmanifest-mutation-in-q325',
    'no-native-library-or-aar-bundling-in-q325',
    'no-runtime-startup-or-model-loader-binding-in-q325',
    'no-dummy-runtime-execution-in-q325',
    'no-image-to-latex-execution-in-q325',
    'no-mathlive-review-or-workspace-import-in-q325',
    'no-ocr-runtime-pass-claim-in-q325',
  ];

  static const List<String> q326EntryCriteria = <String>[
    'q325-flutter-analyze-and-test-user-log-clean',
    'q325-flutter-run-real-device-log-reviewed',
    'explicit-native-library-build-trial-approved-by-user',
    'paddle-lite-android-abi-library-source-identified',
    'model-conversion-or-compatibility-plan-approved',
    'rollback-plan-before-gradle-or-native-library-mutation',
    'feature-flag-default-off-before-runtime-instantiation',
  ];
}
