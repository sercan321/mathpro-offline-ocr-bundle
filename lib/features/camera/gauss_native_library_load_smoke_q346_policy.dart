class GaussNativeLibraryLoadSmokeQ346Policy {
  const GaussNativeLibraryLoadSmokeQ346Policy._();

  static const String phase = 'V172-Q346-NATIVE-LIBRARY-LOAD-SMOKE';
  static const String sourcePhase = 'V172-Q345-GRADLE-ABI-PACKAGING-BUILD-TRIAL';
  static const String status = 'NATIVE_LIBRARY_LOAD_SMOKE_GUARDED_DEFAULT_OFF_PENDING_USER_REAL_DEVICE_INVOCATION';

  static const List<String> requiredBundledBinaryInputs = <String>[
    'android/app/libs/PaddlePredictor.jar',
    'android/app/src/main/jniLibs/arm64-v8a/libpaddle_lite_jni.so',
    'android/app/src/main/jniLibs/armeabi-v7a/libpaddle_lite_jni.so',
  ];

  static const List<String> loadSmokeBridgeSignals = <String>[
    'mathpro/ocr_runtime_bridge::nativeLibraryLoadSmoke',
    'guarded native library load bridge is present in MainActivity',
    'feature flag remains default-off',
    'no automatic app startup native load',
    'no Paddle Lite Predictor instantiate',
    'no model loader or inference',
  ];

  static const List<String> hardNonGoals = <String>[
    'no-automatic-startup-native-load-in-q346',
    'no-paddle-lite-predictor-instantiate-in-q346',
    'no-model-loader-or-model-load-in-q346',
    'no-runtime-startup-or-dummy-call-in-q346',
    'no-image-to-latex-inference-in-q346',
    'no-ocr-review-ui-or-workspace-import-in-q346',
    'no-gradle-pubspec-androidmanifest-mutation-in-q346',
    'no-workspace-keyboard-more-longpress-mathlive-graph-solution-history-splash-icon-change',
    'no-android-real-device-pass-claim-without-user-run-log',
  ];
}
