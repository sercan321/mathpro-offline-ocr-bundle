/// V172-Q172 — Popup legacy contract repair.
///
/// This phase restores the no-clip popup geometry thresholds required by
/// older regression tests after Q171 made the long-press popup too compact.
/// It is a visual envelope repair only: keyboard layout, key order, MORE
/// inventory/order, long-press option order, AppShell, Graph, History, and
/// Solution surfaces remain protected.
class PremiumPopupLegacyContractRepairPolicy {
  const PremiumPopupLegacyContractRepairPolicy._();

  static const String phase = 'V172-Q172';
  static const bool visualEnvelopeOnly = true;
  static const bool keyboardLayoutMutationAllowed = false;
  static const bool longPressOrderMutationAllowed = false;
  static const bool moreOrderMutationAllowed = false;
  static const bool appShellMutationAllowed = false;
  static const bool graphHistorySolutionMutationAllowed = false;
  static const bool realDevicePremiumPassClaimed = false;

  static const double restoredLongPressPanelMinHeight = 116.0;
  static const double restoredLongPressPanelMaxHeight = 120.0;
  static const double restoredLongPressChipHeight = 88.0;
}
