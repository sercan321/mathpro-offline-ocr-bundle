/// V172-Q169R3 — Q158 static analyzer hygiene contract repair.
///
/// Narrow package repair after Q169R2 user-side Flutter tests showed the
/// legacy Q158R1 static test still expects the exact
/// `source: 'q157-returning-result-command-ack $_lastRuntimeCommandAck'` marker
/// in the MathLive surface. The active Q169 bridge ack / native paint commit
/// behavior is unchanged; this policy records that only the static compatibility
/// marker was restored.
class MathLiveQ158StaticContractRepairPolicy {
  const MathLiveQ158StaticContractRepairPolicy._();

  static const String phase = 'V172-Q169R3';
  static const bool q158RuntimeAckCompatibilityMarkerPreserved = true;
  static const bool runtimeBridgeAckSemanticsChanged = false;
  static const bool q169NativePaintCommitSemanticsChanged = false;
  static const bool keyboardLayoutMutationAllowed = false;
  static const bool moreInventoryMutationAllowed = false;
  static const bool longPressOrderMutationAllowed = false;
  static const bool graphHistorySolutionUiMutationAllowed = false;
  static const bool appShellMutationAllowed = false;
  static const bool realDevicePassClaimed = false;
  static const bool photomathLevelClaimed = false;
}
