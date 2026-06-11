/// V172-Q145 — MathLive Premium Template Layout Policy.
///
/// Q145 is a real behavior repair for MathLive main-editor visual quality. It
/// keeps the protected MathPro keyboard/MORE/long-press layout locked while the
/// bridge normalizes large structural templates into compact, mobile-safe
/// MathLive payloads and hardens the mathfield layout against line breaks,
/// clipping, and oversized placeholder blocks.
class MathLivePremiumTemplateLayoutPolicy {
  const MathLivePremiumTemplateLayoutPolicy._();

  static const String phase = 'V172-Q145';
  static const bool protectedKeyboardMutationAllowed = false;
  static const bool protectedLongPressMutationAllowed = false;
  static const bool graphHistorySolutionUiMutationAllowed = false;
  static const bool mathLiveDebugBadgeVisible = false;
  static const bool mathLiveVirtualKeyboardVisible = false;
  static const bool namedTemplatesRenderAsMathematics = true;
  static const bool compactLargeOperatorLayoutRequired = true;
  static const bool rootFractionIntegralClippingAllowed = false;
  static const bool realDevicePassClaimed = false;
  static const bool photomathLevelClaimed = false;

  static bool isLargeOperatorTemplateLabel(String label) {
    final trimmed = label.trim();
    return trimmed == 'Σ' ||
        trimmed == 'Π' ||
        trimmed == 'lim' ||
        trimmed == 'lim x→□' ||
        trimmed == 'lim x→∞' ||
        trimmed == 'lim x→0⁺' ||
        trimmed == 'lim x→0⁻' ||
        trimmed == '∫' ||
        trimmed == '∫dx' ||
        trimmed == '∫□dx' ||
        trimmed == '∫ₐᵇ' ||
        trimmed == '∬' ||
        trimmed == '∭' ||
        trimmed == '∮' ||
        trimmed == 'Taylor' ||
        trimmed == 'Maclaurin';
  }

  static bool mustStaySemanticTemplate(String label) {
    final trimmed = label.trim();
    return trimmed == 'Taylor' ||
        trimmed == 'Maclaurin' ||
        trimmed == 'Geometrik' ||
        trimmed == 'Binom' ||
        trimmed == '{3 denklem' ||
        trimmed == '{n denklem' ||
        trimmed == '3 Denklem' ||
        trimmed == 'n Denklem';
  }
}
