/// V172-Q159 — MathLive Real Device Input Visibility Repair.
///
/// Q159 targets the real-device blocker where MathPro keyboard keys visibly
/// press but no expression appears in the MathLive main editor. The repair keeps
/// the frozen MathPro keyboard and MathLive template mappings intact while
/// making the WebView command path resilient to early key presses, delayed page
/// load, delayed math-field mount, and bridge-state gaps.
class MathLiveRealDeviceInputVisibilityPolicy {
  const MathLiveRealDeviceInputVisibilityPolicy._();

  static const String phase = 'V172-Q159';
  static const bool flushQueuedCommandsAfterWebViewLoad = true;
  static const bool webViewFallbackMayStayVisibleWithoutMountedMathfield = true;
  static const bool domFallbackWritesMathLiveHostWhenBridgeMissing = true;
  static const bool controllerFallbackMayMirrorVisibleLatex = true;
  static const int maxQueuedKeyboardCommands = 24;

  static const bool keyboardLayoutMutationAllowed = false;
  static const bool longPressOrderMutationAllowed = false;
  static const bool moreInventoryMutationAllowed = false;
  static const bool graphHistorySolutionUiMutationAllowed = false;
  static const bool photomathLevelClaimed = false;
  static const bool realDevicePassClaimed = false;
}
