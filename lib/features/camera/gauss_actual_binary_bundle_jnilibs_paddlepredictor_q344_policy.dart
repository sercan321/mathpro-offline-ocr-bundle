class GaussActualBinaryBundleJniLibsPaddlePredictorQ344Policy {
  const GaussActualBinaryBundleJniLibsPaddlePredictorQ344Policy._();

  static const String phase = 'V172-Q344-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR';
  static const String sourcePhase = 'V172-Q343-NATIVE-PACKAGE-HASH-EVIDENCE-FINAL-ACCEPTANCE-REAL-BUNDLE-UNLOCK-GATE';
  static const String status = 'ACTUAL_BINARY_BUNDLE_EXECUTED_NATIVE_FILES_COPIED_NO_RUNTIME_LOAD_DEFAULT_OFF';

  static const List<String> requiredSourceNativePackageFiles = <String>[
    'PaddlePredictor.jar',
    'arm64-v8a/libpaddle_lite_jni.so',
    'armeabi-v7a/libpaddle_lite_jni.so',
  ];

  static const List<String> bundledNativeTargets = <String>[
    'android/app/libs/PaddlePredictor.jar',
    'android/app/src/main/jniLibs/arm64-v8a/libpaddle_lite_jni.so',
    'android/app/src/main/jniLibs/armeabi-v7a/libpaddle_lite_jni.so',
  ];

  static const List<String> expectedSha256ByTarget = <String>[
    'android/app/libs/PaddlePredictor.jar=81c8f73729123fd4b65b1b0d01ad58f9a0f0fe61274d49179910696cc68959f2',
    'android/app/src/main/jniLibs/arm64-v8a/libpaddle_lite_jni.so=2eb3cd0f1d3d01c2199ee79d28f5bef7180a699f7bd9cbb183743f3031277fe2',
    'android/app/src/main/jniLibs/armeabi-v7a/libpaddle_lite_jni.so=261de17f07130118962226f451a9a75aae84ff15bfe4e4b6b2ed942b5a7b121f',
  ];

  static const List<String> hardNonGoals = <String>[
    'no-system-load-library-in-q344',
    'no-paddle-lite-predictor-instantiate-in-q344',
    'no-model-loader-or-model-load-in-q344',
    'no-runtime-startup-or-dummy-call-in-q344',
    'no-image-to-latex-inference-in-q344',
    'no-ocr-review-ui-or-workspace-import-in-q344',
    'no-ocr-pass-or-android-real-device-pass-claim-in-q344',
    'no-workspace-keyboard-more-longpress-mathlive-graph-solution-history-splash-icon-change',
  ];
}
