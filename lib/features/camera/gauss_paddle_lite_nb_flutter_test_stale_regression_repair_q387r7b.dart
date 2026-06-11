/// Q387R7B repair policy for user-reported Flutter analyze/test regressions.
///
/// This phase does not claim camera/OCR/device success. It only keeps the
/// Q387 .nb evidence chain test-compatible after the stronger Q387R1/Q387R7
/// gates and restores legacy successor markers that older tests still verify.
class GaussPaddleLiteNbFlutterTestStaleRegressionRepairQ387R7BPolicy {
  const GaussPaddleLiteNbFlutterTestStaleRegressionRepairQ387R7BPolicy._();

  static const String phase = 'V172-Q387R7B-FLUTTER-TEST-STALE-REGRESSION-REPAIR';
  static const String sourcePhase = 'V172-Q387R7A-FLUTTER-ANALYZE-TEST-REPAIR';
  static const String status = 'STATIC_REPAIR_READY_BUT_REAL_FLUTTER_TEST_REQUIRES_USER_LOG';

  static const bool q387R4ConstConstructorInfoRepaired = true;
  static const bool q380PrivateStorageEvidenceCompatibilityAliasRestored = true;
  static const bool q385R4QueuedCopyLegacySubstringRestored = true;
  static const bool q387ManifestGatePreserved = true;
  static const bool modelBinaryBundledInBaseApp = false;
  static const bool onnxRuntimeReintroducedInBaseApk = false;
  static const bool productionInferencePassClaimedByQ387R7B = false;
  static const bool androidRealDevicePassClaimedByQ387R7B = false;
  static const bool fakeLatexCandidateAllowed = false;
  static const bool keyboardQ382Touched = false;
  static const bool graphHistorySolutionSolverTouched = false;
}
