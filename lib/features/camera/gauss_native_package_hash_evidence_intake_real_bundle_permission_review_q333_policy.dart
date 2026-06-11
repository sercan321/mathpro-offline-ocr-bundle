class GaussNativePackageHashEvidenceIntakeRealBundlePermissionReviewQ333Policy {
  const GaussNativePackageHashEvidenceIntakeRealBundlePermissionReviewQ333Policy._();

  static const String phase = 'V172-Q333-NATIVE-PACKAGE-HASH-EVIDENCE-INTAKE-REAL-BUNDLE-PERMISSION-REVIEW';
  static const String sourcePhase = 'V172-Q332-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-BLOCKED-GATE';
  static const String nativeChannelName = 'mathpro/ocr_runtime_bridge';
  static const String methodName = 'nativePackageHashEvidenceIntakeReview';
  static const String status = 'NATIVE_PACKAGE_HASH_EVIDENCE_INTAKE_REVIEW_BLOCKED_PENDING_Q328_EVIDENCE_JSON_AND_EXPLICIT_USER_BUNDLE_APPROVAL_DEFAULT_OFF';
  static const String selectedEngineLabel = 'PP-FormulaNet-S';
  static const String selectedRuntimeDependencyCandidate = 'PADDLE_LITE_ANDROID_NATIVE_LIBRARY_MANUAL_TRIAL_PENDING';
  static const String selectedModelLoaderCandidate = 'PADDLE_LITE_OPTIMIZED_PADDLE_INFERENCE_MODEL_LOADER_PENDING_CONVERSION_EVIDENCE';
  static const String externalNativePackageEvidencePolicy = '../MathProOcrNativePackages/Paddle_Lite_Android';
  static const String nativePackageEvidenceFileName = 'q328_native_library_package_hash_evidence.json';
  static const String bundlePermissionStatus = 'BLOCKED_UNTIL_Q328_NATIVE_PACKAGE_HASH_EVIDENCE_JSON_AND_EXPLICIT_USER_BINARY_BUNDLE_APPROVAL_ARE_REVIEWED';

  static const List<String> requiredNativePackageFiles = <String>[
    'PaddlePredictor.jar',
    'arm64-v8a/libpaddle_lite_jni.so',
    'armeabi-v7a/libpaddle_lite_jni.so',
  ];

  static const List<String> optionalNativePackageFiles = <String>[
    'x86_64/libpaddle_lite_jni.so',
  ];

  static const List<String> plannedBundleTargets = <String>[
    'android/app/libs/PaddlePredictor.jar',
    'android/app/src/main/jniLibs/arm64-v8a/libpaddle_lite_jni.so',
    'android/app/src/main/jniLibs/armeabi-v7a/libpaddle_lite_jni.so',
  ];

  static const List<String> evidenceReviewRequirements = <String>[
    'q328-native-package-hash-evidence-json-provided-from-outside-project-root',
    'per-file-sha256-for-required-native-files-present',
    'artifact-paths-remain-outside-project-before-bundle',
    'explicit-user-binary-bundle-approval-required',
    'no-binary-bundle-before-review',
  ];

  static const List<String> q333HardBlocks = <String>[
    'no-so-aar-jar-bundled-in-q333',
    'no-jniLibs-directory-created-in-q333',
    'no-android-app-libs-directory-created-in-q333',
    'no-gradle-or-pubspec-mutation-in-q333',
    'no-system-load-library-in-q333',
    'no-paddle-lite-instantiation-in-q333',
    'no-runtime-or-ocr-pass-claim-in-q333',
  ];

  static const List<String> q334EntryCriteria = <String>[
    'q333-flutter-analyze-pass-user-side',
    'q333-flutter-test-pass-user-side',
    'q328-native-package-hash-evidence-reviewed',
    'explicit-user-approval-to-bundle-required-native-files',
  ];
}
