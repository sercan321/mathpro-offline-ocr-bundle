class GaussNativePackageHashEvidenceCaptureActualBundlePermissionFinalCheckQ339Policy {
  const GaussNativePackageHashEvidenceCaptureActualBundlePermissionFinalCheckQ339Policy._();

  static const String phase = 'V172-Q339-NATIVE-PACKAGE-HASH-EVIDENCE-CAPTURE-ACTUAL-BUNDLE-PERMISSION-FINAL-CHECK';
  static const String sourcePhase = 'V172-Q338-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-NO-EVIDENCE-BLOCKED-GATE';
  static const String nativeChannelName = 'mathpro/ocr_runtime_bridge';
  static const String methodName = 'nativePackageHashEvidenceCaptureActualBundlePermissionFinalCheck';
  static const String status = 'NATIVE_PACKAGE_HASH_EVIDENCE_CAPTURE_ACTUAL_BUNDLE_PERMISSION_FINAL_CHECK_BLOCKED_PENDING_Q328_JSON_AND_EXPLICIT_USER_APPROVAL_DEFAULT_OFF';
  static const String selectedEngineLabel = 'PP-FormulaNet-S';
  static const String selectedRuntimeDependencyCandidate = 'PADDLE_LITE_ANDROID_NATIVE_LIBRARY_MANUAL_TRIAL_PENDING';
  static const String selectedModelLoaderCandidate = 'PADDLE_LITE_OPTIMIZED_PADDLE_INFERENCE_MODEL_LOADER_PENDING_CONVERSION_EVIDENCE';
  static const String externalNativePackageEvidencePolicy = '../MathProOcrNativePackages/Paddle_Lite_Android';
  static const String nativePackageEvidenceFileName = 'q328_native_library_package_hash_evidence.json';
  static const String finalBundlePermissionStatus = 'BLOCKED_UNTIL_Q328_NATIVE_PACKAGE_HASH_EVIDENCE_JSON_IS_ACCEPTED_AND_USER_EXPLICITLY_APPROVES_BINARY_BUNDLE';
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

  static const List<String> q339HardBlocks = <String>[
    'no-so-jar-aar-bundled-in-q339',
    'no-jniLibs-or-android-app-libs-created-in-q339',
    'no-gradle-pubspec-androidmanifest-mutation-in-q339',
    'no-workspace-keyboard-more-longpress-mathlive-graph-solution-history-splash-icon-mutation-in-q339',
    'no-system-load-library-or-paddle-lite-instantiation-in-q339',
    'no-model-loader-runtime-startup-inference-review-import-or-ocr-pass-in-q339',
  ];
}
