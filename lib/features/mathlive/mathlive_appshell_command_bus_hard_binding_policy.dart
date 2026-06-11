/// V172-Q167 — AppShell -> MathLive Command Bus Hard Binding.
///
/// V172-Q190R7 — production active path isolation.
///
/// The historical Q167 fallback feed is now disabled for the production
/// MathLive route. MathLive state must come from the WebView bridge/state push,
/// not from an AppShell/CalculatorController mirror.
///
/// Real-device evidence showed the MathPro keyboard tap reached Flutter
/// (`Q165 KEY:<label> SEND:Flutter`) while the MathLive/WebView editor stayed
/// visually blank. Q167 hard-binds AppShell key handling to the MathLive surface
/// by handing the same sanitized fallback expression to the surface before the
/// async WebView bridge has proven a visible value. The real MathLive snapshot
/// remains authoritative when it arrives.
class MathLiveAppShellCommandBusHardBindingPolicy {
  const MathLiveAppShellCommandBusHardBindingPolicy._();

  static const String phase = 'V172-Q167';
  static const bool visibleFallbackFeedsSurface = false;
  static const bool rawInsertTokensAllowedInVisibleFallback = false;
  static const bool keyboardLayoutMutationAllowed = false;
  static const bool longPressOrderMutationAllowed = false;
  static const bool graphHistorySolutionUiMutationAllowed = false;
  static const bool realDevicePassClaimed = false;
  static const bool photomathLevelClaimed = false;
}
