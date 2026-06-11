/// V172-Q163 — Real Device MathLive Diagnostic / Focus / Insert / Paint Probe.
///
/// Temporary device-court diagnostic layer. It does not change the frozen
/// MathPro keyboard layout, MORE inventory, long-press order, Graph, History,
/// Solution, or solver behavior. It only exposes whether the Android WebView
/// path reaches the official MathLive <math-field>, whether focus is accepted,
/// whether insert mutates mathfield value, and whether the DOM can paint it.
class MathLiveRealDeviceDiagnosticBridgePolicy {
  static const String premiumVisualPolishPhase = 'V172-Q170';
  const MathLiveRealDeviceDiagnosticBridgePolicy._();

  static const String phase = 'V172-Q163';
  static const bool diagnosticBridgeEnabled = true;
  static const bool visibleDiagnosticOverlayEnabled = false;
  static const bool directProbeMayMutateOnlyWhenExplicitlyCalled = true;
  static const bool finalProductMayKeepDiagnosticOverlay = false;
  static const bool keyboardLayoutMutationAllowed = false;
  static const bool longPressOrderMutationAllowed = false;
  static const bool graphHistorySolutionUiMutationAllowed = false;
  static const bool rawInsertTokensMayBeUserVisible = false;
}
