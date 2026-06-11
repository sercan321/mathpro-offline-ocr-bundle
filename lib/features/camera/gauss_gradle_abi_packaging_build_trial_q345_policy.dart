class GaussGradleAbiPackagingBuildTrialQ345Policy {
  const GaussGradleAbiPackagingBuildTrialQ345Policy._();

  static const String phase = 'V172-Q345-GRADLE-ABI-PACKAGING-BUILD-TRIAL';
  static const String sourcePhase = 'V172-Q344-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR';
  static const String status = 'GRADLE_ABI_PACKAGING_CONFIGURED_BUILD_TRIAL_PENDING_USER_FLUTTER_RUN_DEFAULT_OFF';

  static const List<String> packagedBinaryInputs = <String>[
    'android/app/libs/PaddlePredictor.jar',
    'android/app/src/main/jniLibs/arm64-v8a/libpaddle_lite_jni.so',
    'android/app/src/main/jniLibs/armeabi-v7a/libpaddle_lite_jni.so',
  ];

  static const List<String> gradlePackagingSignals = <String>[
    "implementation files('libs/PaddlePredictor.jar')",
    'android/app/src/main/jniLibs is the Android Gradle Plugin default native library source set',
    'arm64-v8a bundled from Q344 approved hash evidence',
    'armeabi-v7a bundled from Q344 approved hash evidence',
  ];

  static const List<String> hardNonGoals = <String>[
    'no-system-load-library-in-q345',
    'no-paddle-lite-predictor-instantiate-in-q345',
    'no-model-loader-or-model-load-in-q345',
    'no-runtime-startup-or-dummy-call-in-q345',
    'no-image-to-latex-inference-in-q345',
    'no-ocr-review-ui-or-workspace-import-in-q345',
    'no-mainactivity-androidmanifest-pubspec-mutation-in-q345',
    'no-workspace-keyboard-more-longpress-mathlive-graph-solution-history-splash-icon-change',
    'no-android-real-device-pass-claim-without-user-run-log',
  ];
}
