/// V172-Q176 — Static Marker Contract Repair.
///
/// Restores Q149/Q170 static compatibility markers after Q175 default renderer
/// purity without changing production MathLive rendering behavior.
class MathLiveStaticMarkerContractRepairPolicy {
  static const String phase = 'V172-Q176';
  static const bool restoresQ149VisualChromeMarker = true;
  static const bool restoresQ170PremiumVisualMarker = true;
  static const bool userFacingDiagnosticOverlayAllowed = false;
  static const bool privateMathLiveGlyphStylingRestored = false;
  static const bool keyboardLayoutMutationAllowed = false;
  static const bool realDevicePremiumPassClaimed = false;
}
