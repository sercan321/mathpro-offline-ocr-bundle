class GaussNativePackageHashEvidenceReviewBinaryBundleApprovalGateQ329Policy {
  const GaussNativePackageHashEvidenceReviewBinaryBundleApprovalGateQ329Policy._();

  static const String phase = 'V172-Q329-NATIVE-PACKAGE-HASH-EVIDENCE-REVIEW-BINARY-BUNDLE-APPROVAL-GATE';
  static const String sourcePhase = 'V172-Q328-NATIVE-LIBRARY-PACKAGE-FILE-HASH-INTAKE-NO-BUNDLE-EVIDENCE-GATE';
  static const String selectedEngineLabel = 'PP-FormulaNet-S';
  static const String implementationScope =
      'native-package-hash-evidence-review-and-binary-bundle-approval-gate-with-no-so-aar-jar-jnilibs-gradle-or-pubspec-mutation';
  static const String nativeChannelName = 'mathpro/ocr_runtime_bridge';
  static const String nativePackageHashEvidenceReviewMethod = 'nativePackageHashEvidenceReview';
  static const String nativePackageHashEvidenceReviewStatus =
      'NATIVE_PACKAGE_HASH_EVIDENCE_REVIEW_BLOCKED_PENDING_USER_NATIVE_PACKAGE_HASH_EVIDENCE_DEFAULT_OFF';
  static const String featureFlagName = 'gauss.ppFormulaNetS.nativePackageHashEvidenceReview.defaultOff';
  static const String selectedRuntimeDependencyCandidate =
      'PADDLE_LITE_ANDROID_NATIVE_LIBRARY_MANUAL_TRIAL_PENDING';
  static const String selectedModelLoaderCandidate =
      'PADDLE_LITE_OPTIMIZED_PADDLE_INFERENCE_MODEL_LOADER_PENDING_CONVERSION_EVIDENCE';
  static const String externalNativePackageEvidencePolicy = '../MathProOcrNativePackages/Paddle_Lite_Android';
  static const String nativePackageEvidenceFileName = 'q328_native_library_package_hash_evidence.json';
  static const String requiredPrimaryAbi = 'arm64-v8a';
  static const String optionalLegacyAbi = 'armeabi-v7a';
  static const String emulatorAbi = 'x86_64';
  static const String binaryBundleApprovalStatus =
      'BLOCKED_UNTIL_PER_FILE_SHA256_EVIDENCE_IS_PROVIDED_AND_USER_APPROVES_BINARY_BUNDLE';
  static const String mainActivityChangeReason =
      'add default-off native package hash evidence review and binary bundle approval gate envelope method only; no so, aar, jar, jniLibs, Gradle, pubspec, AndroidManifest, system-loadlibrary, model loader, runtime startup, dummy execution, or inference';
  static const String nextRequiredPhase =
      'Q330_REQUIRES_Q329_FLUTTER_LOGS_AND_NATIVE_PACKAGE_HASH_EVIDENCE_BEFORE_BINARY_BUNDLE_TRIAL';

  static const List<String> requiredNativePackageFiles = <String>[
    'PaddlePredictor.jar',
    'arm64-v8a/libpaddle_lite_jni.so',
    'armeabi-v7a/libpaddle_lite_jni.so',
  ];

  static const List<String> optionalNativePackageFiles = <String>[
    'x86_64/libpaddle_lite_jni.so',
  ];

  static const List<String> evidenceReviewRequirements = <String>[
    'run-q328-native-package-hash-capture-script-outside-project-root',
    'provide-q328-native-library-package-hash-evidence-json',
    'verify-required-jar-and-arm64-so-sha256-values-before-bundling',
    'confirm-native-package-license-before-bundling',
    'obtain-explicit-user-binary-bundle-approval-before-creating-jnilibs-or-android-app-libs',
    'run-fresh-flutter-analyze-test-run-after-any-future-binary-bundle',
  ];

  static const List<String> q329HardBlocks = <String>[
    'no-so-aar-jar-bundled-in-q329',
    'no-jnilibs-or-android-app-libs-directory-created-in-q329',
    'no-pubspec-gradle-androidmanifest-mutation-in-q329',
    'no-native-library-load-call-in-q329',
    'no-paddle-lite-instantiation-in-q329',
    'no-model-loader-runtime-startup-dummy-execution-or-inference-in-q329',
    'no-mathlive-review-or-workspace-import-in-q329',
    'no-ocr-android-real-device-store-or-release-pass-claims-in-q329',
  ];

  static const List<String> q330EntryCriteria = <String>[
    'q329-flutter-analyze-and-test-clean-on-user-machine',
    'q328-native-package-hash-evidence-json-provided',
    'per-file-sha256-evidence-reviewed-for-required-native-package-files',
    'explicit-user-approval-for-binary-bundle-trial',
    'rollback-plan-before-jnilibs-or-android-app-libs-mutation',
  ];
}
