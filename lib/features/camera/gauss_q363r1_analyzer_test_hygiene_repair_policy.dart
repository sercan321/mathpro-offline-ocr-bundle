class GaussQ363R1AnalyzerTestHygieneRepairPolicy {
  static const String phase = 'V172-Q363R1-ANALYZER-TEST-HYGIENE-REPAIR';
  static const String sourcePhase = 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE';
  static const String status = 'analyzer-test-hygiene-repair-only';

  static const bool preservesQ363AsActiveProductPhase = true;
  static const bool repairsSuccessorAwarenessTests = true;
  static const bool repairsAnalyzerCompilationErrors = true;
  static const bool repairsMalformedWindowsPathEscape = true;
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
}
