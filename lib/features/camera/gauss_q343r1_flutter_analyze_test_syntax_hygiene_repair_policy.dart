class GaussQ343R1FlutterAnalyzeTestSyntaxHygieneRepairPolicy {
  const GaussQ343R1FlutterAnalyzeTestSyntaxHygieneRepairPolicy._();

  static const String phase = 'V172-Q343R2-FLUTTER-ANALYZE-TEST-SYNTAX-HYGIENE-REPAIR';
  static const String sourcePhase = 'V172-Q343R1-FLUTTER-ANALYZE-TEST-SUCCESSOR-AWARE-HYGIENE-REPAIR';
  static const String preservedCameraOcrPhase = 'V172-Q343-NATIVE-PACKAGE-HASH-EVIDENCE-FINAL-ACCEPTANCE-REAL-BUNDLE-UNLOCK-GATE';
  static const String status = 'Q343R1_DART_TEST_SYNTAX_REPAIR_ONLY_NO_RUNTIME_OR_UI_MUTATION';

  static const List<String> repairedSyntaxFiles = <String>[
    'test/v172_q315r1_controlled_model_artifact_download_hash_capture_flutter_test_repair_test.dart',
    'test/v172_q316_runtime_dependency_feasibility_trial_default_off_test.dart',
  ];

  static const List<String> syntaxRepairScope = <String>[
    'remove malformed leading-comma Q343 successor list entries',
    'add explicit q343SuccessorPhase constants to Q315R1 and Q316 tests',
    'preserve Q343 as active blocked OCR runtime gate',
  ];

  static const List<String> hardNonGoals = <String>[
    'no-camera-ocr-latest-phase-advance-beyond-q343-runtime-gate',
    'no-mainactivity-change-in-q343r2',
    'no-binary-bundle',
    'no-jniLibs-or-android-app-libs',
    'no-gradle-pubspec-androidmanifest-change',
    'no-workspace-keyboard-more-longpress-mathlive-graph-solution-history-splash-icon-change',
    'no-system-load-library',
    'no-paddle-lite-instantiation',
    'no-model-loader-runtime-startup-dummy-call-image-to-latex-review-import-or-ocr-pass',
  ];
}
