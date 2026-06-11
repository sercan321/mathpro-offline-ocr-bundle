class GaussNativeLibraryBuildTrialApprovalAbiPackagingPreflightQ326Policy {
  const GaussNativeLibraryBuildTrialApprovalAbiPackagingPreflightQ326Policy._();

  static const String phase = 'V172-Q326-NATIVE-LIBRARY-BUILD-TRIAL-APPROVAL-ABI-PACKAGING-PREFLIGHT';
  static const String sourcePhase = 'V172-Q325-EXPLICIT-RUNTIME-DEPENDENCY-COORDINATE-SELECTION-BUILD-TRIAL-GATE';
  static const String selectedEngineLabel = 'PP-FormulaNet-S';
  static const String implementationScope =
      'native-library-build-trial-approval-and-abi-packaging-preflight-with-no-native-binary-or-gradle-mutation';
  static const String nativeChannelName = 'mathpro/ocr_runtime_bridge';
  static const String nativeLibraryBuildTrialPreflightMethod = 'nativeLibraryBuildTrialPreflight';
  static const String nativeLibraryBuildTrialPreflightStatus =
      'NATIVE_LIBRARY_BUILD_TRIAL_PREFLIGHT_BLOCKED_NO_NATIVE_LIBRARY_BUNDLE_DEFAULT_OFF';
  static const String featureFlagName = 'gauss.ppFormulaNetS.nativeLibraryBuildTrialPreflight.defaultOff';
  static const String selectedRuntimeDependencyCandidate =
      'PADDLE_LITE_ANDROID_NATIVE_LIBRARY_MANUAL_TRIAL_PENDING';
  static const String selectedModelLoaderCandidate =
      'PADDLE_LITE_OPTIMIZED_PADDLE_INFERENCE_MODEL_LOADER_PENDING_CONVERSION_EVIDENCE';
  static const String nativeLibrarySourceCandidate =
      'PADDLE_LITE_ANDROID_INFERENCE_LIBRARY_DOWNLOAD_OR_BUILD_REQUIRED_NOT_BUNDLED';
  static const String modelConversionCandidate =
      'PADDLE_LITE_OPT_TOOL_CONVERSION_REQUIRED_BEFORE_MODEL_LOAD_NOT_EXECUTED';
  static const String selectedRuntimeDependencyCoordinate =
      'NO_MAVEN_COORDINATE_SELECTED_MANUAL_NATIVE_LIBRARY_TRIAL_REQUIRED';
  static const String modelDirectoryName = 'ocr_models/PP-FormulaNet-S';
  static const String artifactFileName = 'inference.pdiparams';
  static const String expectedInferencePdiparamsSha256 =
      'b6392296d16e2a9f414c0a751d7ccbd1bd9d8272b68aab72df1d3875f35a7489';
  static const int expectedInferencePdiparamsSizeBytes = 231675001;
  static const String q315EvidenceCapturedAt = '2026-06-06T21:09:02.327Z';
  static const String mainActivityChangeReason =
      'add default-off native library build-trial ABI packaging preflight envelope method only; no pubspec, Gradle, AndroidManifest, native library, AAR, JNI loader, runtime startup, dummy execution, or inference';
  static const String nextRequiredPhase =
      'Q327_REQUIRES_USER_Q326_FLUTTER_LOGS_AND_EXPLICIT_NATIVE_LIBRARY_SOURCE_PACKAGE_APPROVAL';

  static const List<String> abiPackagingCandidates = <String>[
    'arm64-v8a-required-candidate',
    'armeabi-v7a-optional-legacy-candidate',
    'x86_64-emulator-only-candidate',
  ];

  static const List<String> nativeLibraryCandidatePaths = <String>[
    'android/app/src/main/jniLibs/arm64-v8a/libpaddle_lite_jni.so',
    'android/app/src/main/jniLibs/armeabi-v7a/libpaddle_lite_jni.so',
    'android/app/src/main/jniLibs/x86_64/libpaddle_lite_jni.so',
  ];

  static const List<String> preflightEnvelopeFields = <String>[
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
    'nativeLibrarySourceCandidate',
    'modelConversionCandidate',
    'abiPackagingCandidates',
    'nativeLibraryCandidatePaths',
    'nativeLibraryBuildTrialBlockedReason',
    'q315HashEvidenceSha256Matches',
    'privateStorageRoot',
    'artifactPath',
    'artifactExists',
    'artifactSizeBytes',
    'expectedArtifactSha256',
    'actualArtifactSha256',
    'sha256MatchesExpected',
    'pubspecChanged',
    'gradleChanged',
    'androidManifestChanged',
    'nativeLibraryBundled',
    'aarBundled',
    'jniLibsDirectoryCreated',
    'abiPackagingTrialExecuted',
    'runtimeDependencyAdded',
    'runtimeStartupExecuted',
    'modelLoadAttempted',
    'dummyRuntimeCallExecuted',
    'realImageToLatexInferenceExecuted',
    'ocrPassClaimed',
    'androidRealDevicePassClaimed',
  ];

  static const List<String> q326HardBlocks = <String>[
    'no-pubspec-gradle-androidmanifest-mutation-in-q326',
    'no-native-library-so-aar-or-jnilibs-directory-added-in-q326',
    'no-paddle-lite-runtime-instantiation-in-q326',
    'no-paddle-lite-opt-model-conversion-in-q326',
    'no-model-loader-runtime-startup-or-dummy-execution-in-q326',
    'no-image-to-latex-execution-in-q326',
    'no-mathlive-review-or-workspace-import-in-q326',
    'no-ocr-runtime-pass-claim-in-q326',
  ];

  static const List<String> q327EntryCriteria = <String>[
    'q326-flutter-analyze-and-test-user-log-clean',
    'q326-flutter-run-real-device-log-reviewed',
    'explicit-native-library-source-package-approved',
    'abi-matrix-approved-before-jnilibs-mutation',
    'paddle-lite-opt-model-conversion-plan-approved',
    'rollback-plan-before-gradle-or-native-library-mutation',
    'feature-flag-default-off-before-native-loader-binding',
  ];
}
