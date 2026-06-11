/// V172-Q185 — Production MathLive HTML/bridge finalization.
///
/// Locks the post-Q184 production WebView assets into a small product path: one
/// local MathLive runtime, one native <math-field>, one minimal bridge, and no
/// diagnostic/court/evidence UI in the active editor. This is not a keyboard
/// layout phase and does not mutate Graph/History/Solution surfaces.
class MathLiveProductionHtmlFinalizationPolicy {
  const MathLiveProductionHtmlFinalizationPolicy._();

  static const String phase = 'V172-Q185';
  static const bool usesProductionHtml = true;
  static const bool usesProductionBridge = true;
  static const bool diagnosticCourtInProduction = false;
  static const bool mathLivePrivateGlyphCssAllowed = false;
  static const bool keyboardLayoutMutationAllowed = false;
  static const bool graphHistorySolutionMutationAllowed = false;
  static const bool flutterAnalyzePassClaimedByAssistant = false;
  static const bool flutterTestPassClaimedByAssistant = false;
  static const bool flutterRunPassClaimedByAssistant = false;
  static const bool realDevicePremiumPassClaimed = false;
}
