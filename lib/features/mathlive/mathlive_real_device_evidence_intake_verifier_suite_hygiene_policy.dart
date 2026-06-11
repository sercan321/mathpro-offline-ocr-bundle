/// V172-Q204R3 Real Device Evidence Intake Verifier Suite Hygiene.
///
/// This policy separates the current active production verifier suite from
/// historical diagnostic/court/fallback verifiers that targeted the pre-Q197
/// monolithic MathLiveMainEditorSurface implementation.
class MathLiveRealDeviceEvidenceIntakeVerifierSuiteHygienePolicy {
  static const String phase = 'V172-Q204R3';
  static const String fullPhase =
      'V172-Q204R3-REAL-DEVICE-EVIDENCE-INTAKE-VERIFIER-SUITE-HYGIENE';

  static const bool activeVerifierSuiteDeclared = true;
  static const bool retiredVerifierSuiteDeclared = true;
  static const bool obsoleteVerifiersMayProduceFakeFailures = false;
  static const bool preservedProductionContractsAcceptQ204R3Successor = true;

  static const bool productionRuntimeFilesMutated = false;
  static const bool legacyDiagnosticMarkersRestored = false;
  static const bool returningResultApiRestored = false;
  static const bool retiredVisibleFallbackOverlayRestored = false;
  static const bool retiredDiagnosticOverlayRestored = false;
  static const bool retiredLegacyMainEditorStateRestored = false;

  static const bool keyboardLayoutMutationAllowed = false;
  static const bool moreInventoryMutationAllowed = false;
  static const bool longPressMutationAllowed = false;
  static const bool graphUiMutationAllowed = false;
  static const bool historyPanelMutationAllowed = false;
  static const bool solutionStepsPanelMutationAllowed = false;

  static const bool flutterAnalyzePassClaimedByAssistant = false;
  static const bool flutterTestPassClaimedByAssistant = false;
  static const bool flutterRunPassClaimedByAssistant = false;
  static const bool androidRealDevicePassClaimed = false;
  static const bool finalReleasePassClaimed = false;
}
