class GaussStoreReadinessCameraOcrReleaseAuditLogRepairPolicy {
  const GaussStoreReadinessCameraOcrReleaseAuditLogRepairPolicy._();

  static const String phase = 'V172-Q287R1-STORE-READINESS-CAMERA-OCR-RELEASE-AUDIT-FLUTTER-LOG-REPAIR';
  static const String sourcePhase = 'V172-Q287-STORE-READINESS-CAMERA-OCR-RELEASE-AUDIT';
  static const String selectedEngineLabel = 'PP-FormulaNet-S';
  static const String repairMode = 'flutter-analyze-test-log-repair-only-no-runtime-no-release-pass';

  static const int repairedIssueCount = 2;
  static const bool repairsQ277R3MalformedTestString = true;
  static const bool repairsMathLiveKeepCaretVisibleAnalyzerWarning = true;
  static const bool keepsQ277R3TapLatencyCadenceIntent = true;
  static const bool keepsCaretVisibilityHelperOnFirstRuntimeMountOnly = true;

  static const bool keyboardLayoutChanged = false;
  static const bool moreTemplateTrayChanged = false;
  static const bool longPressListsChanged = false;
  static const bool graphSolutionHistoryChanged = false;
  static const bool cameraShellRuntimeChanged = false;
  static const bool solverEvaluatorChanged = false;
  static const bool androidToolchainChanged = false;
  static const bool cameraDependencyChanged = false;

  static const bool mathLiveProductionSurfaceTouchedForAnalyzerHygiene = true;
  static const bool q277R3TestFileTouchedForSyntaxRepair = true;

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
    'q277r3-test-malformed-contains-string-extra-paren',
    'mathlive-production-keep-caret-visible-unused-element',
  ];

  static const List<String> requiresUserSideRetest = [
    'flutter clean',
    'flutter pub get',
    'flutter analyze',
    'flutter test',
    'flutter run -d 23106RN0DA',
  ];
}
