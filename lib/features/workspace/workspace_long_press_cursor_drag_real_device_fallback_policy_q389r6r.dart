/// Q389R6R documents the real-device hardening applied after user-side
/// feedback showed that the original JS-only pointer listener path did not
/// feel like Photomath-style long-press cursor drag on Android WebView.
///
/// This file is a static contract marker only. Runtime behavior remains inside
/// assets/mathlive/main_editor_prod.html and assets/mathlive/mathlive_prod_bridge.js.
/// Q389R6T/Q389R6U supersede the document-level fallback because Q382 latency
/// court forbids document touchmove/pointermove revival.
class WorkspaceLongPressCursorDragRealDeviceFallbackPolicyQ389R6R {
  const WorkspaceLongPressCursorDragRealDeviceFallbackPolicyQ389R6R._();

  static const String phase = 'Q389R6R';
  static const bool realDeviceFeedbackDriven = true;
  static const bool capturePhasePointerListenersEnabled = true;
  static const bool touchEventFallbackEnabled = true;
  static const bool documentMoveEndFallbackEnabled = false;
  static const bool documentMoveEndFallbackSupersededByExternalBridge = true;
  static const bool horizontalPreActivationDragToleranceEnabled = true;
  static const bool continuousEdgeAutoscrollPreserved = true;
  static const bool nativeMathLiveCaretAuthorityPreserved = true;
  static const bool legacyFlutterCursorAllowed = false;
  static const bool keyboardLayoutChanged = false;
  static const bool keyboardDispatchChanged = false;
  static const bool graphChanged = false;
  static const bool ocrChanged = false;
  static const bool androidNativeChanged = false;
}
