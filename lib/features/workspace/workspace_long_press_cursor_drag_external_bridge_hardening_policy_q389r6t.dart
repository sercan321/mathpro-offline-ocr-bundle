/// Q389R6T keeps the real-device cursor drag path deterministic without
/// reviving the old document-level pan/drag listeners forbidden by the Q382
/// latency courts.
class WorkspaceLongPressCursorDragExternalBridgeHardeningPolicyQ389R6T {
  const WorkspaceLongPressCursorDragExternalBridgeHardeningPolicyQ389R6T._();

  static const String phase = 'Q389R6T';
  static const bool flutterExternalCursorDragBridgeIsPrimary = true;
  static const bool parentListenerUsesOpaqueHitTesting = true;
  static const bool documentLevelTouchMoveFallbackRemoved = true;
  static const bool mathLiveNativeCaretRemainsAuthoritative = true;
  static const bool keyboardLayoutChanged = false;
  static const bool keyboardDispatchQueueChanged = false;
  static const bool graphRuntimeChanged = false;
  static const bool ocrRuntimeChanged = false;
  static const bool androidNativeChanged = false;
  static const bool legacyFlutterCursorOverlayRevived = false;
}
