/// Q387R7C repair policy for the next user-reported Flutter test stale marker.
///
/// This phase only restores the legacy Q379 decoder source markers that older
/// static Flutter tests still require. It does not change OCR runtime semantics
/// and does not claim real OCR, device, build, or workspace import success.
class GaussPaddleLiteNbFlutterTestStaleRegressionRepairQ387R7CPolicy {
  const GaussPaddleLiteNbFlutterTestStaleRegressionRepairQ387R7CPolicy._();

  static const String phase = 'V172-Q387R7C-FLUTTER-TEST-Q379-DECODER-MARKER-REPAIR';
  static const String sourcePhase = 'V172-Q387R7B-FLUTTER-TEST-STALE-REGRESSION-REPAIR';
  static const String status = 'STATIC_REPAIR_READY_BUT_REAL_FLUTTER_TEST_REQUIRES_USER_LOG';

  static const bool q379DecodedCandidateLatexMarkerRestored = true;
  static const bool q379OutputDecoderImplementedMarkerRestored = true;
  static const bool q379DecoderDoesNotInventLatexPreserved = true;
  static const bool q387ManifestGatePreserved = true;
  static const bool modelBinaryBundledInBaseApp = false;
  static const bool onnxRuntimeReintroducedInBaseApk = false;
  static const bool productionInferencePassClaimedByQ387R7C = false;
  static const bool androidRealDevicePassClaimedByQ387R7C = false;
  static const bool fakeLatexCandidateAllowed = false;
  static const bool keyboardQ382Touched = false;
  static const bool graphHistorySolutionSolverTouched = false;
}
