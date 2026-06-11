class GaussNativeLibrarySourcePackageApprovalAbiMatrixLockQ327Policy {
  const GaussNativeLibrarySourcePackageApprovalAbiMatrixLockQ327Policy._();

  static const String phase = 'V172-Q327-NATIVE-LIBRARY-SOURCE-PACKAGE-APPROVAL-ABI-MATRIX-LOCK';
  static const String sourcePhase = 'V172-Q326-NATIVE-LIBRARY-BUILD-TRIAL-APPROVAL-ABI-PACKAGING-PREFLIGHT';
  static const String selectedEngineLabel = 'PP-FormulaNet-S';
  static const String implementationScope =
      'native-library-source-package-and-abi-matrix-lock-with-no-so-aar-jar-jnilibs-gradle-or-pubspec-mutation';
  static const String nativeChannelName = 'mathpro/ocr_runtime_bridge';
  static const String nativeLibrarySourcePackageApprovalMethod = 'nativeLibrarySourcePackageApproval';
  static const String nativeLibrarySourcePackageApprovalStatus =
      'NATIVE_LIBRARY_SOURCE_PACKAGE_APPROVAL_ABI_MATRIX_LOCKED_NO_BINARY_BUNDLE_DEFAULT_OFF';
  static const String featureFlagName = 'gauss.ppFormulaNetS.nativeLibrarySourcePackageApproval.defaultOff';
  static const String selectedRuntimeDependencyCandidate =
      'PADDLE_LITE_ANDROID_NATIVE_LIBRARY_MANUAL_TRIAL_PENDING';
  static const String selectedModelLoaderCandidate =
      'PADDLE_LITE_OPTIMIZED_PADDLE_INFERENCE_MODEL_LOADER_PENDING_CONVERSION_EVIDENCE';
  static const String approvedNativeLibrarySourcePackage =
      'PADDLE_LITE_ANDROID_PREDICTION_LIBRARY_RELEASE_OR_SELF_COMPILED_PACKAGE_PENDING_USER_APPROVAL';
  static const String requiredPrimaryAbi = 'arm64-v8a';
  static const String optionalLegacyAbi = 'armeabi-v7a';
  static const String emulatorAbi = 'x86_64';
  static const String jarCandidatePath = 'android/app/libs/PaddlePredictor.jar';
  static const String modernSharedLibraryCandidate = 'libpaddle_lite_api_shared.so';
  static const String modelDirectoryName = 'ocr_models/PP-FormulaNet-S';
  static const String artifactFileName = 'inference.pdiparams';
  static const String expectedInferencePdiparamsSha256 =
      'b6392296d16e2a9f414c0a751d7ccbd1bd9d8272b68aab72df1d3875f35a7489';
  static const int expectedInferencePdiparamsSizeBytes = 231675001;
  static const String q315EvidenceCapturedAt = '2026-06-06T21:09:02.327Z';
  static const String mainActivityChangeReason =
      'add default-off native library source package approval and ABI matrix lock envelope method only; no .so, .aar, jar, jniLibs, Gradle, pubspec, AndroidManifest, model loader, runtime startup, dummy execution, or inference';
  static const String nextRequiredPhase =
      'Q328_REQUIRES_USER_Q327_FLUTTER_LOGS_AND_EXPLICIT_NATIVE_LIBRARY_PACKAGE_FILES_BEFORE_ANY_BINARY_BUNDLE';

  static const List<String> requiredNativeLibraryFiles = <String>[
    'PaddlePredictor.jar',
    'arm64-v8a/libpaddle_lite_jni.so',
    'armeabi-v7a/libpaddle_lite_jni.so',
  ];

  static const List<String> abiMatrix = <String>[
    'arm64-v8a-required',
    'armeabi-v7a-optional-legacy',
    'x86_64-emulator-only',
  ];

  static const List<String> nativeLibraryCandidatePaths = <String>[
    'android/app/src/main/jniLibs/arm64-v8a/libpaddle_lite_jni.so',
    'android/app/src/main/jniLibs/armeabi-v7a/libpaddle_lite_jni.so',
    'android/app/src/main/jniLibs/x86_64/libpaddle_lite_jni.so',
  ];

  static const List<String> sourcePackageEvidenceRequirements = <String>[
    'official-paddle-lite-or-paddleocr-on-device-download-or-build-source-url',
    'license-marker-apache-2-compatible-before-bundling',
    'per-file-sha256-for-jar-and-each-so-before-commit',
    'abi-matrix-approved-before-jnilibs-mutation',
    'rollback-plan-before-binary-or-gradle-mutation',
    'flutter-build-log-after-any-binary-bundle',
  ];

  static const List<String> q327HardBlocks = <String>[
    'no-so-aar-jar-bundled-in-q327',
    'no-jnilibs-or-android-app-libs-directory-created-in-q327',
    'no-pubspec-gradle-androidmanifest-mutation-in-q327',
    'no-system-loadlibrary-or-paddle-lite-instantiation-in-q327',
    'no-model-conversion-model-loader-runtime-startup-or-dummy-execution-in-q327',
    'no-image-to-latex-execution-in-q327',
    'no-mathlive-review-or-workspace-import-in-q327',
    'no-ocr-runtime-pass-claim-in-q327',
  ];

  static const List<String> q328EntryCriteria = <String>[
    'q327-flutter-analyze-and-test-user-log-clean',
    'q327-flutter-run-real-device-log-reviewed',
    'explicit-native-library-source-package-files-provided-or-downloadable',
    'per-file-sha256-captured-for-jar-and-so-files',
    'binary-bundle-plan-approved-before-jniLibs-or-libs-directory-created',
    'feature-flag-default-off-before-any-native-loader-binding',
  ];
}
