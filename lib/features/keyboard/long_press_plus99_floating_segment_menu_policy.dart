/// V172-Q231 — Long-press popup +99 floating segment menu policy.
///
/// Visual/geometry-only phase. It must not mutate keyboard layout, key order,
/// long-press option inventory/order, MORE, MathLive, Workspace, Graph,
/// History, Solution, or evaluator behavior.
class LongPressPlus99FloatingSegmentMenuPolicy {
  const LongPressPlus99FloatingSegmentMenuPolicy._();

  static const String phase = 'V172-Q231';
  static const bool visualRedesignOnly = true;
  static const bool keyboardLayoutMutationAllowed = false;
  static const bool longPressOptionMutationAllowed = false;
  static const bool longPressOrderMutationAllowed = false;
  static const bool moreMutationAllowed = false;
  static const bool mathLiveMutationAllowed = false;
  static const bool workspaceMutationAllowed = false;
  static const bool graphHistorySolutionMutationAllowed = false;
  static const bool realDevicePassClaimed = false;
  static const bool plus99ClaimedWithoutScreenshot = false;

  static const bool singleCapsuleSurface = true;
  static const bool segmentedOptions = true;
  static const bool edgeSafePlacement = true;
  static const bool pointerAnchoredToSourceKey = true;
  static const bool compactEliteEnvelope = true;
  static const bool legacyLargeCardEnvelopeRetired = true;
}
