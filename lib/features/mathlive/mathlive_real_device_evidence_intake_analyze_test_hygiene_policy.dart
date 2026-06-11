import 'mathlive_real_device_evidence_intake_policy.dart';

/// V172-Q204R1 — Real Device Evidence Intake Analyze/Test Hygiene.
///
/// Q204R1 is a compile/analyze/test hygiene repair over Q204. It updates stale
/// historical tests to the Q197/Q203 production-surface architecture without
/// reviving retired diagnostic/fallback markers on [MathLiveMainEditorSurface].
abstract final class MathLiveRealDeviceEvidenceIntakeAnalyzeTestHygienePolicy {
  static const String phase = 'V172-Q204R1';
  static const String fullPhase =
      'V172-Q204R1-REAL-DEVICE-EVIDENCE-INTAKE-ANALYZE-TEST-HYGIENE';
  static const String baseline = MathLiveRealDeviceEvidenceIntakePolicy.fullPhase;

  static const bool q204EvidenceGatePreserved = true;
  static const bool staleQ169SurfaceStaticExpectationsRemovedFromTests = true;
  static const bool retiredMainEditorSurfaceStaticsRevived = false;
  static const bool testsReadProductionSurfaceFileAfterQ197 = true;
  static const bool testsReadProductionBridgeAfterQ197 = true;
  static const bool testsReadProductionHtmlAfterQ197 = true;
  static const bool unusedDecodeJavascriptStringResultRemoved = true;
  static const bool q204VerifierIncludesStaleTestScanner = true;
  static const bool protectedKeyboardGraphHistorySolutionMutationAllowed = false;
  static const bool flutterAnalyzePassClaimedByAssistant = false;
  static const bool flutterTestPassClaimedByAssistant = false;
  static const bool androidRealDevicePassClaimed = false;
  static const bool finalReleasePassClaimed = false;

  static const List<String> forbiddenStaleTestReferences = <String>[
    'MathLiveMainEditorSurface.singleFileRuntimeBootRepairPhase',
    'MathLiveMainEditorSurface.mfTrueBridgeDispatchRepairPhase',
    'class _MathLiveMainEditorSurfaceState',
    'class _MathLiveAppShellVisibleFallbackOverlay',
    'class _MathLiveDiagnosticOverlay',
  ];
}
