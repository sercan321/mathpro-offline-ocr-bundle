class GaussNativeLibraryPackageFileHashIntakeNoBundleEvidenceGateQ328Policy {
  const GaussNativeLibraryPackageFileHashIntakeNoBundleEvidenceGateQ328Policy._();

  static const String phase = 'V172-Q328-NATIVE-LIBRARY-PACKAGE-FILE-HASH-INTAKE-NO-BUNDLE-EVIDENCE-GATE';
  static const String sourcePhase = 'V172-Q327-NATIVE-LIBRARY-SOURCE-PACKAGE-APPROVAL-ABI-MATRIX-LOCK';
  static const String selectedEngineLabel = 'PP-FormulaNet-S';
  static const String implementationScope =
      'native-library-package-file-hash-intake-and-no-bundle-evidence-gate-with-no-so-aar-jar-jnilibs-gradle-or-pubspec-mutation';
  static const String nativeChannelName = 'mathpro/ocr_runtime_bridge';
  static const String nativeLibraryPackageFileHashIntakeMethod = 'nativeLibraryPackageFileHashIntake';
  static const String nativeLibraryPackageFileHashIntakeStatus =
      'NATIVE_LIBRARY_PACKAGE_FILE_HASH_INTAKE_BLOCKED_NO_NATIVE_PACKAGE_HASH_EVIDENCE_DEFAULT_OFF';
  static const String featureFlagName = 'gauss.ppFormulaNetS.nativeLibraryPackageFileHashIntake.defaultOff';
  static const String selectedRuntimeDependencyCandidate =
      'PADDLE_LITE_ANDROID_NATIVE_LIBRARY_MANUAL_TRIAL_PENDING';
  static const String selectedModelLoaderCandidate =
      'PADDLE_LITE_OPTIMIZED_PADDLE_INFERENCE_MODEL_LOADER_PENDING_CONVERSION_EVIDENCE';
  static const String approvedNativeLibrarySourcePackage =
      'PADDLE_LITE_ANDROID_PREDICTION_LIBRARY_RELEASE_OR_SELF_COMPILED_PACKAGE_PENDING_USER_APPROVAL';
  static const String externalNativePackageEvidencePolicy = '../MathProOcrNativePackages/Paddle_Lite_Android';
  static const String nativePackageEvidenceFileName = 'q328_native_library_package_hash_evidence.json';
  static const String requiredPrimaryAbi = 'arm64-v8a';
  static const String optionalLegacyAbi = 'armeabi-v7a';
  static const String emulatorAbi = 'x86_64';
  static const String jarCandidatePath = 'android/app/libs/PaddlePredictor.jar';
  static const String modernSharedLibraryCandidate = 'libpaddle_lite_api_shared.so';
  static const String expectedInferencePdiparamsSha256 =
      'b6392296d16e2a9f414c0a751d7ccbd1bd9d8272b68aab72df1d3875f35a7489';
  static const int expectedInferencePdiparamsSizeBytes = 231675001;
  static const String q315EvidenceCapturedAt = '2026-06-06T21:09:02.327Z';
  static const String mainActivityChangeReason =
      'add default-off native library package file hash intake envelope method only; no .so, .aar, jar, jniLibs, Gradle, pubspec, AndroidManifest, model loader, runtime startup, dummy execution, or inference';
  static const String nextRequiredPhase =
      'Q329_REQUIRES_USER_Q328_FLUTTER_LOGS_AND_NATIVE_PACKAGE_HASH_EVIDENCE_BEFORE_ANY_BINARY_BUNDLE';

  static const List<String> requiredNativePackageFiles = <String>[
    'PaddlePredictor.jar',
    'arm64-v8a/libpaddle_lite_jni.so',
    'armeabi-v7a/libpaddle_lite_jni.so',
  ];

  static const List<String> optionalNativePackageFiles = <String>[
    'x86_64/libpaddle_lite_jni.so',
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

  static const List<String> nativePackageHashEvidenceRequirements = <String>[
    'place-paddle-lite-native-package-files-outside-project-root',
    'capture-sha256-for-PaddlePredictor-jar-and-each-required-so',
    'write-q328-native-library-package-hash-evidence-json-outside-project-root',
    'do-not-commit-so-aar-jar-or-jnilibs-before-user-approval',
    'do-not-mutate-gradle-pubspec-or-androidmanifest-before-binary-bundle-approval',
    'fresh-flutter-analyze-test-run-log-required-after-any-future-binary-bundle',
  ];

  static const List<String> q328HardBlocks = <String>[
    'no-so-aar-jar-bundled-in-q328',
    'no-jnilibs-or-android-app-libs-directory-created-in-q328',
    'no-pubspec-gradle-androidmanifest-mutation-in-q328',
    'no-system-loadlibrary-or-paddle-lite-instantiation-in-q328',
    'no-model-conversion-model-loader-runtime-startup-or-dummy-execution-in-q328',
    'no-image-to-latex-execution-in-q328',
    'no-mathlive-review-or-workspace-import-in-q328',
    'no-ocr-runtime-pass-claim-in-q328',
  ];

  static const List<String> q329EntryCriteria = <String>[
    'q328-flutter-analyze-and-test-user-log-clean',
    'q328-flutter-run-real-device-log-reviewed',
    'native-package-hash-evidence-json-provided-and-reviewed',
    'per-file-sha256-captured-for-jar-and-required-so-files',
    'explicit-binary-bundle-approval-before-jniLibs-or-libs-directory-created',
    'rollback-plan-approved-before-gradle-or-native-loader-mutation',
  ];
}
