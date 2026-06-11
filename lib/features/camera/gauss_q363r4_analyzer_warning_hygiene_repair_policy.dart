class GaussQ363R4AnalyzerWarningHygieneRepairPolicy {
  static const String phase = 'V172-Q363R4-ANALYZER-WARNING-HYGIENE-REPAIR';
  static const String sourcePhase = 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE';
  static const String status = 'analyzer-warning-hygiene-repair-only';

  static const bool preservesQ363AsActiveProductPhase = true;
  static const bool triggeredByUserSideFlutterAnalyzeWarnings = true;
  static const bool userSideFlutterTestPassedBeforeRepair = true;
  static const bool repairsDuplicateSetLiteralElements = true;
  static const bool removesDuplicateQ363LiteralWhereQ363ConstantAlreadyExists = true;
  static const bool repairsAnalyzerWarningsOnly = true;
  static const bool repairsRuntimeBehavior = false;
  static const bool modifiesRuntimeBridge = false;
  static const bool modifiesUiRedlines = false;
  static const bool modifiesGradle = false;
  static const bool modifiesPubspec = false;
  static const bool modifiesAndroidManifest = false;
  static const bool modifiesMainActivity = false;
  static const bool modelBundled = false;
  static const bool modelLoadAttempted = false;
  static const bool dummyRuntimeCallExecuted = false;
  static const bool imageToLatexInferenceExecuted = false;
  static const bool ocrPassClaimed = false;
  static const bool androidPassClaimed = false;
  static const bool storeReadyPassClaimed = false;
  static const bool releaseReadyPassClaimed = false;
}
