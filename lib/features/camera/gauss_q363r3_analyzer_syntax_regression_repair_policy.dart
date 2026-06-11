class GaussQ363R3AnalyzerSyntaxRegressionRepairPolicy {
  static const String phase = 'V172-Q363R3-ANALYZER-SYNTAX-REGRESSION-REPAIR';
  static const String sourcePhase = 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE';
  static const String status = 'analyzer-syntax-regression-repair-only';

  static const bool preservesQ363AsActiveProductPhase = true;
  static const bool repairsMalformedQ363R2DartInsertions = true;
  static const bool repairsLeadingCommaSyntaxErrors = true;
  static const bool repairsMalformedManifestIndexing = true;
  static const bool repairsLegacySuccessorAwarenessWithoutRuntimeChanges = true;
  static const bool q363R2SupersededAsBrokenArtifact = true;
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
