/// Q389R6S — Workspace long-press cursor drag external bridge policy.
///
/// The production implementation no longer relies only on DOM pointer/touch
/// listeners inside Android WebView. Flutter observes the parent pointer stream
/// around the production WebView and forwards deterministic drag coordinates to
/// the existing MathLive production bridge. Native MathLive still owns the real
/// caret/selection; Flutter does not draw a legacy cursor overlay.
abstract final class WorkspaceLongPressCursorDragExternalBridgePolicyQ389R6S {
  static const String phase = 'Q389R6S';
  static const bool flutterParentPointerStreamObserved = true;
  static const bool forwardsCoordinatesToMathLiveProductionBridge = true;
  static const bool nativeMathLiveCaretRemainsAuthoritative = true;
  static const bool legacyFlutterCursorOverlayRevived = false;
  static const bool keyboardLayoutTouched = false;
  static const bool keyboardDispatchTouched = false;
  static const bool graphRuntimeTouched = false;
  static const bool ocrRuntimeTouched = false;
  static const bool androidNativeTouched = false;
}
