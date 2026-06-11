/// V172-Q164 — MathLive Diagnostic Contract Cleanup / Analyzer Hygiene.
///
/// This is a narrow package-side repair after Q163 real-device diagnostics:
/// it restores legacy static test markers that Q161/Q163 drifted away from,
/// fixes analyzer string interpolation hygiene, and preserves the Q163 on-device
/// diagnostic bridge without touching protected keyboard or app surfaces.
class MathLiveDiagnosticContractCleanupPolicy {
  static const String phase = 'V172-Q164';
  static const bool analyzerInterpolationHygieneApplied = true;
  static const bool q140InsertIntoMathfieldCompatibilityRestored = true;
  static const bool q161VisibleFallbackContractMarkerRestored = true;
  static const bool q163DiagnosticBridgePreserved = true;
  static const bool keyboardLayoutMutationAllowed = false;
  static const bool longPressOrderMutationAllowed = false;
  static const bool moreInventoryMutationAllowed = false;
  static const bool graphHistorySolutionUiMutationAllowed = false;
  static const bool realDevicePassClaimed = false;
  static const bool photomathLevelClaimed = false;
}
