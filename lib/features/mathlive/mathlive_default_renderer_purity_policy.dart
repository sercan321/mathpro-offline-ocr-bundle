/// V172-Q175 — MathLive Default Renderer Purity.
///
/// This phase moves the visible math surface toward the official MathLive
/// default renderer instead of imitating MathLive internals with private CSS
/// selectors. MathPro keeps only the dark container, public CSS variables,
/// chrome suppression, and clean template intent. Fraction/radical/base glyph
/// layout must be owned by MathLive.
class MathLiveDefaultRendererPurityPolicy {
  const MathLiveDefaultRendererPurityPolicy._();

  static const String phase = 'V172-Q175';
  static const String previousNativeRendererPurityPhase = 'V172-Q174';
  static const double targetDefaultRendererSimilarity = 0.95;
  static const bool mathLiveDefaultGlyphLayoutIsOwner = true;
  static const bool privateMathLiveGlyphClassStylingAllowed = false;
  static const bool cssVariablesAllowedForAccentAndChrome = true;
  static const bool internalFractionLineStylingAllowed = false;
  static const bool internalSqrtLineStylingAllowed = false;
  static const bool internalPlaceholderClassStylingAllowed = false;
  static const bool internalBaseFontClassStylingAllowed = false;
  static const bool userFacingDiagnosticOverlayAllowed = false;
  static const bool keyboardLayoutMutationAllowed = false;
  static const bool longPressOrderMutationAllowed = false;
  static const bool moreInventoryMutationAllowed = false;
  static const bool appShellMutationAllowed = false;
  static const bool graphHistorySolutionUiMutationAllowed = false;
  static const bool flutterAnalyzePassClaimedByAssistant = false;
  static const bool flutterTestPassClaimedByAssistant = false;
  static const bool flutterRunPassClaimedByAssistant = false;
  static const bool realDevicePremiumPassClaimed = false;
}
