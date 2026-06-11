class GaussActualBinaryBundleJniLibsPaddlePredictorNoEvidenceBlockedGateQ338Policy {
  const GaussActualBinaryBundleJniLibsPaddlePredictorNoEvidenceBlockedGateQ338Policy._();

  static const String phase = 'V172-Q338-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-NO-EVIDENCE-BLOCKED-GATE';
  static const String sourcePhase = 'V172-Q337-NATIVE-PACKAGE-HASH-EVIDENCE-ACCEPTANCE-EXPLICIT-BUNDLE-APPROVAL-GATE';
  static const String nativeChannelName = 'mathpro/ocr_runtime_bridge';
  static const String methodName = 'actualBinaryBundleNoEvidenceBlockedGate';
  static const String status = 'ACTUAL_BINARY_BUNDLE_BLOCKED_NO_Q328_NATIVE_HASH_EVIDENCE_NO_USER_APPROVAL_UI_PROTECTED_DEFAULT_OFF';
  static const String selectedEngineLabel = 'PP-FormulaNet-S';
  static const String selectedRuntimeDependencyCandidate = 'PADDLE_LITE_ANDROID_NATIVE_LIBRARY_MANUAL_TRIAL_PENDING';
  static const String selectedModelLoaderCandidate = 'PADDLE_LITE_OPTIMIZED_PADDLE_INFERENCE_MODEL_LOADER_PENDING_CONVERSION_EVIDENCE';
  static const String externalNativePackageEvidencePolicy = '../MathProOcrNativePackages/Paddle_Lite_Android';
  static const String nativePackageEvidenceFileName = 'q328_native_library_package_hash_evidence.json';
  static const String bundlePermissionStatus = 'BLOCKED_UNTIL_Q328_NATIVE_PACKAGE_HASH_EVIDENCE_AND_EXPLICIT_USER_BINARY_BUNDLE_APPROVAL_ARE_PROVIDED';
  static const String uiProtectionStatus = 'UI_PROTECTED_NO_WORKSPACE_KEYBOARD_MATHLIVE_GRAPH_SOLUTION_HISTORY_SPLASH_CHANGE';

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

  static const List<String> q338HardBlocks = <String>[
    'no-so-aar-jar-bundled-in-q338',
    'no-jniLibs-directory-created-in-q338',
    'no-android-app-libs-directory-created-in-q338',
    'no-gradle-or-pubspec-mutation-in-q338',
    'no-android-manifest-mutation-in-q338',
    'no-ui-workspace-keyboard-mathlive-graph-solution-history-splash-mutation-in-q338',
    'no-system-load-library-in-q338',
    'no-paddle-lite-instantiation-in-q338',
    'no-runtime-or-ocr-pass-claim-in-q338',
  ];
}
