/// V172-Q165 — AppShell Visible Fallback / Diagnostic Tap Bus.
///
/// Real-device Q164R1 evidence showed that the MathLive surface could remain at
/// a static `Q163 bekleniyor` label even after keyboard taps. Q165 does not
/// mutate keyboard layout, MORE, long-press order, Graph, History, or Solution
/// UI. It adds an AppShell-level visible fallback so key taps are reflected in a
/// sanitized expression overlay when Android WebView/MathLive remains visually
/// blank.
class MathLiveAppShellVisibleFallbackPolicy {
  const MathLiveAppShellVisibleFallbackPolicy._();

  static const String phase = 'V172-Q165';
  static const bool keyboardLayoutMutationAllowed = false;
  static const bool longPressOrderMutationAllowed = false;
  static const bool moreInventoryMutationAllowed = false;
  static const bool graphHistorySolutionUiMutationAllowed = false;
  static const bool rawInsertTokensMayBeUserVisible = false;
  static const bool sanitizedFlutterFallbackAllowedWhenMathLiveBlank = true;
  static const bool realDevicePassClaimed = false;
  static const bool cursorPassClaimed = false;
  static const bool photomathLevelClaimed = false;
}
