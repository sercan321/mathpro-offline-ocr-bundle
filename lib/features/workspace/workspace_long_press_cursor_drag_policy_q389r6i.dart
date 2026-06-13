/// Q389R6I — Workspace long-press cursor drag and edge autoscroll policy.
///
/// This phase builds on Q389R6G/Q389R6H. It adds Fotomath-style long-press
/// cursor dragging for long expressions while preserving MathLive as the only
/// caret authority. The implementation is intentionally narrow: production
/// MathLive bridge listeners use MathLive public `getOffsetFromPoint`,
/// `position`/`setPosition`, and the existing horizontal caret visibility
/// helpers. No legacy Flutter cursor layer is reintroduced.
class WorkspaceLongPressCursorDragPolicyQ389R6I {
  const WorkspaceLongPressCursorDragPolicyQ389R6I._();

  static const String phase = 'Q389R6I';
  static const String fullPhase = 'Q389R6I-WORKSPACE-LONG-PRESS-CURSOR-DRAG-EDGE-AUTOSCROLL';

  static const String productionHtmlPath = 'assets/mathlive/main_editor_prod.html';
  static const String productionBridgePath = 'assets/mathlive/mathlive_prod_bridge.js';

  static const int longPressDelayMs = 260;
  static const int moveCancelThresholdPx = 18;
  static const int edgeAutoscrollThresholdPx = 42;
  static const int edgeAutoscrollStepPx = 22;

  static const bool longPressCursorDragImplemented = true;
  static const bool dragStartsOnlyAfterLongPress = true;
  static const bool tapToPlacePreserved = true;
  static const bool earlyPointerDownPreventDefaultForbidden = true;
  static const bool mathLiveGetOffsetFromPointUsed = true;
  static const bool mathLiveNativePositionUsed = true;
  static const bool edgeAutoscrollEnabled = true;
  static const bool existingQ389R6HScrollPolicyPreserved = true;

  static const bool nativeMathLiveCaretAuthorityPreserved = true;
  static const bool legacyFlutterCursorAllowed = false;
  static const bool mathLiveBridgeRewritten = false;
  static const bool keyboardLayoutChanged = false;
  static const bool keyboardDispatchChanged = false;
  static const bool graphChanged = false;
  static const bool ocrChanged = false;
  static const bool androidNativeChanged = false;
  static const bool solverChanged = false;

  static const bool flutterAnalyzePassClaimedByAssistant = false;
  static const bool flutterTestPassClaimedByAssistant = false;
  static const bool flutterRunPassClaimedByAssistant = false;
  static const bool androidRealDevicePassClaimed = false;
}
