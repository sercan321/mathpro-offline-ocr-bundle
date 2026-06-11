/// V172-Q157 — MathLive Runtime Command Binding Repair.
///
/// Q157 targets the real-device failure where MathPro keyboard keys visually
/// pressed but did not produce visible MathLive editor input. The fix requires
/// an acknowledged JS bridge command result, a visible fallback when the bridge
/// returns an empty payload, and a bounded runtime-mount retry window before the
/// command path is considered blocked.
class MathLiveRuntimeCommandBindingPolicy {
  const MathLiveRuntimeCommandBindingPolicy._();

  static const String phase = 'V172-Q157';
  static const String commandAckPhase = 'q157-returning-result-command-ack';
  static const String visibleFallbackPhase = 'q157-visible-fallback-after-empty-ack';

  static const bool usesReturningResultAck = true;
  static const bool visibleFallbackEnabled = true;
  static const bool runtimeMountRetryEnabled = true;
  static const int runtimeMountRetryCount = 12;
  static const Duration runtimeMountRetryDelay = Duration(milliseconds: 80);

  static const bool keyboardLayoutMutationAllowed = false;
  static const bool longPressOrderMutationAllowed = false;
  static const bool moreInventoryMutationAllowed = false;
  static const bool graphHistorySolutionUiMutationAllowed = false;
  static const bool realDevicePassClaimed = false;
  static const bool photomathLevelClaimed = false;
}
