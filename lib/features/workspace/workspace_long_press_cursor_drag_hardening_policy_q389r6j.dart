/// Q389R6J — Workspace long-press cursor drag audit hardening policy.
///
/// This is a narrow hardening pass over Q389R6I. It keeps MathLive as the
/// native caret authority and does not touch keyboard, graph, OCR, Android
/// native, solver, or workspace Dart layout. The hardening closes two mobile
/// interaction risks found during post-audit:
///
/// 1. Edge autoscroll in Q389R6I was move-event driven only, so holding the
///    finger still at the edge could stop after a single scroll step.
/// 2. Pointer-capture cleanup needed to be explicit so interrupted gestures do
///    not leave the field in a dragging/touch-action state.
class WorkspaceLongPressCursorDragHardeningPolicyQ389R6J {
  const WorkspaceLongPressCursorDragHardeningPolicyQ389R6J._();

  static const String phase = 'Q389R6J';
  static const String fullPhase = 'Q389R6J-WORKSPACE-LONG-PRESS-CURSOR-DRAG-AUDIT-HARDENING';

  static const String productionHtmlPath = 'assets/mathlive/main_editor_prod.html';
  static const String productionBridgePath = 'assets/mathlive/mathlive_prod_bridge.js';

  static const bool buildsOnQ389R6I = true;
  static const bool continuousEdgeAutoscrollLoopImplemented = true;
  static const int continuousEdgeAutoscrollTickMs = 72;
  static const bool edgeAutoscrollNoLongerRequiresPointerMove = true;
  static const bool pointerCaptureCleanupHardened = true;
  static const bool touchCalloutSuppressedForMathField = true;

  static const bool q389R6IPhaseMarkersPreserved = true;
  static const bool nativeMathLiveCaretAuthorityPreserved = true;
  static const bool legacyFlutterCursorAllowed = false;
  static const bool earlyPointerDownPreventDefaultForbidden = true;
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
