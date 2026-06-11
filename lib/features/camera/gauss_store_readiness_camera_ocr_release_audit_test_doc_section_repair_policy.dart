class GaussStoreReadinessCameraOcrReleaseAuditTestDocSectionRepairPolicy {
  const GaussStoreReadinessCameraOcrReleaseAuditTestDocSectionRepairPolicy._();

  static const String phase = 'V172-Q287R2-STORE-READINESS-CAMERA-OCR-RELEASE-AUDIT-TEST-DOC-SECTION-REPAIR';
  static const String sourcePhase = 'V172-Q287R1-STORE-READINESS-CAMERA-OCR-RELEASE-AUDIT-FLUTTER-LOG-REPAIR';
  static const String selectedEngineLabel = 'PP-FormulaNet-S';
  static const String repairMode = 'flutter-test-doc-section-repair-only-no-runtime-no-release-pass';

  static const int repairedIssueCount = 2;
  static const bool repairsQ277R3ChangedFilesSectionAssertion = true;
  static const bool repairsQ287R1ChangedFilesSectionAssertion = true;
  static const bool keepsAnalyzeCleanResult = true;
  static const bool changesRuntimeBehavior = false;

  static const bool keyboardLayoutChanged = false;
  static const bool moreTemplateTrayChanged = false;
  static const bool longPressListsChanged = false;
  static const bool graphSolutionHistoryChanged = false;
  static const bool mathLiveProductionRouteChanged = false;
  static const bool cameraShellRuntimeChanged = false;
  static const bool solverEvaluatorChanged = false;
  static const bool androidToolchainChanged = false;
  static const bool cameraDependencyChanged = false;

  static const bool realOcrRuntimeAdded = false;
  static const bool paddleRuntimeAdded = false;
  static const bool paddleOcrDependencyAdded = false;
  static const bool nativeHandlerImplementationAdded = false;
  static const bool methodChannelRuntimeBindingAdded = false;
  static const bool modelBinaryBundledInBaseApp = false;
  static const bool productionModelUrlBound = false;
  static const bool productionDownloadEnabled = false;
  static const bool imageToLatexInferenceExecuted = false;
  static const bool ocrPassClaimed = false;
  static const bool cameraOcrRuntimePassClaimed = false;
  static const bool storeReadyPassClaimed = false;
  static const bool releasePassClaimed = false;

  static const List<String> repairedLogIssues = [
    'q277r3-test-treated-explicitly-not-modified-doc-lines-as-modified-lines',
    'q287r1-test-treated-not-changed-doc-lines-as-modified-lines',
  ];

  static const List<String> requiresUserSideRetest = [
    'flutter clean',
    'flutter pub get',
    'flutter analyze',
    'flutter test',
    'flutter run -d 23106RN0DA',
  ];
}
