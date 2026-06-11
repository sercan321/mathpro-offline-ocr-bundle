/// V172-Q156 — Long-Press Integral Popup Envelope Final Rebalance.
///
/// This phase is deliberately narrow: it repairs the remaining Flutter test
/// failures from the bounded-integral long-press popup no-clip envelope after
/// Q150/Q153 compact popup fit work. It does not alter keyboard layout, key
/// order, MORE inventory, long-press ordering, MathLive template mappings,
/// Graph/History/Solution UI, or solver behavior.
class MathLivePopupEnvelopeFinalRebalancePolicy {
  const MathLivePopupEnvelopeFinalRebalancePolicy._();

  static const String phase = 'V172-Q156';
  static const String repairTarget = 'long-press-integral-popup-envelope';
  static const bool popupEnvelopeFinalRebalanced = true;
  static const bool boundedIntegralNoClipEnvelopeRestored = true;
  static const bool q150CompactFitPreserved = true;
  static const bool keyboardLayoutMutationAllowed = false;
  static const bool longPressOrderMutationAllowed = false;
  static const bool moreInventoryMutationAllowed = false;
  static const bool mathLiveTemplateMutationAllowed = false;
  static const bool graphHistorySolutionMutationAllowed = false;
  static const bool solverBehaviorMutationAllowed = false;
  static const bool flutterAnalyzePassClaimedByAssistant = false;
  static const bool flutterTestPassClaimedByAssistant = false;
  static const bool realDevicePassClaimed = false;
  static const bool photomathLevelClaimed = false;

  static const double requiredPanelMinHeightPx = 116.0;
  static const double requiredBoundedIntegralChipWidthPx = 104.0;
}
