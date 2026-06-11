class GaussActualBinaryBundleJniLibsPaddlePredictorPendingEvidenceBlockedGateQ334Policy {
  const GaussActualBinaryBundleJniLibsPaddlePredictorPendingEvidenceBlockedGateQ334Policy._();

  static const String phase = 'V172-Q334-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-PENDING-EVIDENCE-BLOCKED-GATE';
  static const String sourcePhase = 'V172-Q333-NATIVE-PACKAGE-HASH-EVIDENCE-INTAKE-REAL-BUNDLE-PERMISSION-REVIEW';
  static const String nativeChannelName = 'mathpro/ocr_runtime_bridge';
  static const String methodName = 'actualBinaryBundlePlacementGate';
  static const String status = 'ACTUAL_BINARY_BUNDLE_PLACEMENT_BLOCKED_PENDING_Q328_NATIVE_PACKAGE_HASH_EVIDENCE_AND_EXPLICIT_USER_APPROVAL_DEFAULT_OFF';
  static const String selectedEngineLabel = 'PP-FormulaNet-S';
  static const String externalNativePackageEvidencePolicy = '../MathProOcrNativePackages/Paddle_Lite_Android';
  static const String nativePackageEvidenceFileName = 'q328_native_library_package_hash_evidence.json';
  static const String bundlePermissionStatus = 'BLOCKED_UNTIL_Q328_NATIVE_PACKAGE_HASH_EVIDENCE_JSON_AND_EXPLICIT_USER_BINARY_BUNDLE_APPROVAL_ARE_PROVIDED';

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

  static const List<String> placementRequirements = <String>[
    'q328-native-package-hash-evidence-json-provided',
    'per-file-sha256-for-required-native-files-reviewed-and-accepted',
    'explicit-user-approval-to-copy-binary-files-into-project',
    'q333-flutter-analyze-and-test-clean-user-side',
    'no-binary-file-copy-before-requirements-are-met',
  ];

  static const List<String> q334HardBlocks = <String>[
    'no-so-aar-jar-bundled-in-q334',
    'no-jniLibs-directory-created-in-q334',
    'no-android-app-libs-directory-created-in-q334',
    'no-gradle-or-pubspec-mutation-in-q334',
    'no-system-load-library-in-q334',
    'no-paddle-lite-instantiation-in-q334',
    'no-runtime-or-ocr-pass-claim-in-q334',
  ];

  static const List<String> q335EntryCriteria = <String>[
    'q334-flutter-analyze-pass-user-side',
    'q334-flutter-test-pass-user-side',
    'q328-native-package-hash-evidence-reviewed-and-accepted',
    'explicit-user-approval-to-bundle-required-native-files',
  ];
}
