/// Q389R6V documents the real-device closure for very long expression edge reach.
///
/// Q389R6U fixed the primary long-press cursor drag path, but very long
/// expressions could still fail to reach the absolute beginning/end because
/// edge autoscroll depended on DOM scrollLeft and point hit-testing alone.
/// Q389R6V keeps MathLive as the native caret owner and adds directional
/// offset walking while the finger is held inside the left/right edge zone.
class WorkspaceLongPressCursorDragExternalEdgeReachPolicyQ389R6V {
  static const String phase = 'Q389R6V';

  static const bool mathLiveNativeCaretRemainsAuthoritative = true;
  static const bool flutterLegacyCursorOverlayForbidden = true;
  static const bool documentLevelTouchMovePointerMoveForbidden = true;
  static const bool keyboardLayoutDispatchAndJsQueueUntouched = true;

  static const bool externalBridgeRemainsPrimaryDragAuthority = true;
  static const bool edgeAutoscrollUsesDirectionalCaretOffsetWalk = true;
  static const bool veryLongExpressionCanReachAbsoluteStartAndEnd = true;
  static const bool dragEndDoesNotReHitTestAndJump = true;
}
