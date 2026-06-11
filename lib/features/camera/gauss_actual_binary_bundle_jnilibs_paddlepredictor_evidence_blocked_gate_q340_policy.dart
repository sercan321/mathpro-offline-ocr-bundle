class GaussActualBinaryBundleJniLibsPaddlePredictorEvidenceBlockedGateQ340Policy {
  const GaussActualBinaryBundleJniLibsPaddlePredictorEvidenceBlockedGateQ340Policy._();

  static const String phase = 'V172-Q340-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-EVIDENCE-BLOCKED-GATE';
  static const String sourcePhase = 'V172-Q339-NATIVE-PACKAGE-HASH-EVIDENCE-CAPTURE-ACTUAL-BUNDLE-PERMISSION-FINAL-CHECK';
  static const String nativeChannelName = 'mathpro/ocr_runtime_bridge';
  static const String methodName = 'actualBinaryBundleEvidenceBlockedGate';
  static const String status = 'ACTUAL_BINARY_BUNDLE_JNILIBS_PADDLEPREDICTOR_BLOCKED_PENDING_Q328_NATIVE_PACKAGE_HASH_EVIDENCE_USER_APPROVAL_AND_FLUTTER_LOG_DEFAULT_OFF';
  static const String selectedEngineLabel = 'PP-FormulaNet-S';
  static const String selectedRuntimeDependencyCandidate = 'PADDLE_LITE_ANDROID_NATIVE_LIBRARY_MANUAL_TRIAL_PENDING';
  static const String selectedModelLoaderCandidate = 'PADDLE_LITE_OPTIMIZED_PADDLE_INFERENCE_MODEL_LOADER_PENDING_CONVERSION_EVIDENCE';
  static const String externalNativePackageEvidencePolicy = '../MathProOcrNativePackages/Paddle_Lite_Android';
  static const String nativePackageEvidenceFileName = 'q328_native_library_package_hash_evidence.json';
  static const String binaryBundleStatus = 'BLOCKED_UNTIL_Q328_NATIVE_PACKAGE_HASH_EVIDENCE_JSON_IS_ACCEPTED_USER_EXPLICITLY_APPROVES_BINARY_BUNDLE_AND_Q339_OR_NEWER_FLUTTER_LOG_IS_CLEAN';
  static const String uiProtectionStatus = 'UI_PROTECTED_NO_WORKSPACE_KEYBOARD_MORE_LONGPRESS_MATHLIVE_GRAPH_SOLUTION_HISTORY_SPLASH_ICON_CHANGE';

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

  static const List<String> q340HardBlocks = <String>[
    'no-so-jar-aar-bundled-in-q340',
    'no-jniLibs-or-android-app-libs-created-in-q340',
    'no-gradle-pubspec-androidmanifest-mutation-in-q340',
    'no-ui-redline-mutation-in-q340',
    'no-system-load-library-or-paddle-lite-instantiation-in-q340',
    'no-runtime-startup-model-loader-inference-review-import-or-ocr-pass-in-q340',
  ];
}
