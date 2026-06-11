/// V172-Q182 — Production MathLive Simplification.
///
/// The Q169 court/evidence pipeline was necessary while proving Android
/// WebView, MathLive runtime, channel, insert, value, and native paint. It is
/// too heavy for the normal main editor path. Q182 keeps all diagnostic APIs
/// available for explicit debug/evidence runs, but the production main editor
/// must behave like a simple product surface: MathPro keyboard command in,
/// MathLive native value/render out.
class MathLiveProductionSimplificationPolicy {
  const MathLiveProductionSimplificationPolicy._();

  static const String phase = 'V172-Q182';
  static const bool productionBridgeLean = true;
  static const bool heavyDiagnosticCourtsDefaultDisabled = true;
  static const bool initialRealDeviceDiagnosticDisabled = true;
  static const bool finalSelfTestCourtDisabledByDefault = true;
  static const bool singleSourceCourtPushDebugOnly = true;
  static const bool privateGlyphClassStylingAllowed = false;
  static const bool mathProKeyboardLayoutMutationAllowed = false;
  static const bool appShellMutationAllowed = false;
  static const bool graphHistorySolutionMutationAllowed = false;
  static const bool realDevicePremiumPassClaimed = false;

  static bool shouldRunHeavyDiagnosticCourt({required bool debugCourtEnabled}) {
    return debugCourtEnabled;
  }

  static bool shouldShowUserFacingDiagnostic({required bool debugCourtEnabled}) {
    return debugCourtEnabled;
  }
}
