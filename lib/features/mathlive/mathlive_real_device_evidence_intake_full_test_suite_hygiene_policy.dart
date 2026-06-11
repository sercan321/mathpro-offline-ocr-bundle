import 'mathlive_real_device_evidence_intake_analyze_test_hygiene_policy.dart';

/// V172-Q204R2 — Real Device Evidence Intake Full Test-Suite Hygiene.
///
/// Q204R2 migrates stale MathLive tests to the Q197/Q203 architecture:
/// [mathlive_main_editor_surface.dart] is only a compatibility shim, while
/// [mathlive_production_editor_surface.dart], [mathlive_prod_bridge.js], and
/// [main_editor_prod.html] own active production behavior. It does not revive
/// retired diagnostic/fallback implementation markers.
abstract final class MathLiveRealDeviceEvidenceIntakeFullTestSuiteHygienePolicy {
  static const String phase = 'V172-Q204R2';
  static const String fullPhase =
      'V172-Q204R2-REAL-DEVICE-EVIDENCE-INTAKE-FULL-TEST-SUITE-HYGIENE';
  static const String baseline =
      MathLiveRealDeviceEvidenceIntakeAnalyzeTestHygienePolicy.fullPhase;

  static const bool q204EvidenceGatePreserved = true;
  static const bool q204r1AnalyzeTestHygienePreserved = true;
  static const bool fullMathLiveTestSuiteMigratedToQ197Q203Architecture = true;
  static const bool shimTestsOnlyAssertCompatibilityForwarding = true;
  static const bool productionImplementationTestsReadProductionSurface = true;
  static const bool bridgeTestsReadProductionBridge = true;
  static const bool htmlTestsReadProductionHtml = true;
  static const bool retiredDiagnosticMarkersRevived = false;
  static const bool returningResultApiRevived = false;
  static const bool visibleFallbackOverlayRevived = false;
  static const bool staleTestScannerCoversFullSuite = true;
  static const bool protectedKeyboardGraphHistorySolutionMutationAllowed = false;
  static const bool flutterAnalyzePassClaimedByAssistant = false;
  static const bool flutterTestPassClaimedByAssistant = false;
  static const bool androidRealDevicePassClaimed = false;
  static const bool finalReleasePassClaimed = false;

  static const List<String> forbiddenStaleTestMarkers = <String>[
    'runJavaScriptReturningResult',
    'mathpro-q163-diagnostic-overlay',
    '_refreshRealDeviceDiagnostic',
    'appShellVisibleFallbackPhase',
    'Q165 KEY:',
    'Q169 KEY:',
    'PAINT:',
    '_visibleFallbackExpression',
    'visibleFallbackMayRenderStructuralTemplates',
    'class _MathLiveMainEditorSurfaceState',
    'class _MathLiveAppShellVisibleFallbackOverlay',
    'class _MathLiveDiagnosticOverlay',
    'MathLiveMainEditorSurface.singleFileRuntimeBootRepairPhase',
    'MathLiveMainEditorSurface.mfTrueBridgeDispatchRepairPhase',
    "phase = 'V172-Q135-Q139'",
    'premiumSurfaceRepairPhase',
    'pointerCaretFluidityPhase',
    'viewportFitPhase',
  ];
}
