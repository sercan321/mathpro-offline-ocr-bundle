class GaussFlutterTestSuccessorAwareHygieneRepairQ313R3Policy {
  const GaussFlutterTestSuccessorAwareHygieneRepairQ313R3Policy._();

  static const String phase = 'V172-Q313R3-FLUTTER-TEST-SUCCESSOR-AWARE-HYGIENE-REPAIR';
  static const String sourcePhase = 'V172-Q313R2-FLUTTER-ANALYZE-INFO-HYGIENE';
  static const String repairScope = 'flutter-test-successor-aware-hygiene-only';

  static const bool q313r1TestMadeQ313R3SuccessorAware = true;
  static const bool q313r2ChangedFilesProtectedSectionCheckRepaired = true;
  static const bool runtimeBehaviorChanged = false;
  static const bool cameraOcrRuntimeAdded = false;
  static const bool paddleRuntimeAdded = false;
  static const bool paddleOcrDependencyAdded = false;
  static const bool jniNativeHandlerAdded = false;
  static const bool methodChannelBindingAdded = false;
  static const bool modelBinaryBundledInBaseApp = false;
  static const bool productionDownloadEnabled = false;
  static const bool realImageToLatexInferenceExecuted = false;
  static const bool editableMathLiveReviewOpened = false;
  static const bool workspaceImportExecuted = false;
  static const bool ocrPassClaimed = false;
  static const bool cameraOcrRuntimePassClaimed = false;
  static const bool storeReadyPassClaimed = false;
  static const bool releasePassClaimed = false;

  static const List<String> repairedTestFindings = <String>[
    'q313r1-test-accepted-only-q313r1-active-phase-instead-of-q313r2-or-q313r3-successor',
    'q313r2-test-searched-protected-not-modified-section-for-pubspec-instead-of-modified-added-sections-only',
  ];

  static const List<String> repairedFiles = <String>[
    'test/v172_q313r1_flutter_log_repair_q295_path_escape_q152_successor_aware_test.dart',
    'test/v172_q313r2_flutter_analyze_info_hygiene_test.dart',
  ];
}
