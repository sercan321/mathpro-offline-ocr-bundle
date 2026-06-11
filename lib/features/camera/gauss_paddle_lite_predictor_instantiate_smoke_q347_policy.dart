class GaussPaddleLitePredictorInstantiateSmokeQ347Policy {
  const GaussPaddleLitePredictorInstantiateSmokeQ347Policy._();

  static const String phase = 'V172-Q347-PADDLE-LITE-PREDICTOR-INSTANTIATE-SMOKE';
  static const String sourcePhase = 'V172-Q346-NATIVE-LIBRARY-LOAD-SMOKE';
  static const String status = 'PADDLE_LITE_PREDICTOR_INSTANTIATE_SMOKE_GUARDED_DEFAULT_OFF_PENDING_USER_REAL_DEVICE_INVOCATION';

  static const List<String> requiredPriorPhases = <String>[
    'V172-Q344-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR',
    'V172-Q345-GRADLE-ABI-PACKAGING-BUILD-TRIAL',
    'V172-Q346-NATIVE-LIBRARY-LOAD-SMOKE',
  ];

  static const List<String> predictorInstantiateBridgeSignals = <String>[
    'mathpro/ocr_runtime_bridge::paddleLitePredictorInstantiateSmoke',
    'guarded Paddle Lite classpath and predictor instantiate smoke bridge is present in MainActivity',
    'feature flag remains default-off',
    'no automatic app startup predictor instantiate',
    'no model loader or model load',
    'no runtime inference or image-to-LaTeX',
  ];

  static const List<String> hardNonGoals = <String>[
    'no-automatic-startup-predictor-instantiate-in-q347',
    'no-model-loader-or-model-load-in-q347',
    'no-runtime-startup-or-dummy-call-in-q347',
    'no-image-to-latex-inference-in-q347',
    'no-ocr-review-ui-or-workspace-import-in-q347',
    'no-gradle-pubspec-androidmanifest-mutation-in-q347',
    'no-workspace-keyboard-more-longpress-mathlive-graph-solution-history-splash-icon-change',
    'no-android-real-device-pass-claim-without-user-run-log',
  ];
}
