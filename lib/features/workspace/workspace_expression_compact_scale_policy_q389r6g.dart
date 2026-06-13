/// Q389R6G — Workspace compact expression scale policy.
///
/// This phase changes only the production MathLive editor's visual CSS scale
/// in assets/mathlive/main_editor_prod.html. It intentionally does not mutate
/// the MathLive bridge, keyboard dispatch, graph, OCR, Android native, solver,
/// or long-press cursor drag behavior.
class WorkspaceExpressionCompactScalePolicyQ389R6G {
  const WorkspaceExpressionCompactScalePolicyQ389R6G._();

  static const String phase = 'Q389R6G';
  static const String fullPhase = 'Q389R6G-WORKSPACE-COMPACT-EXPRESSION-SCALE';

  static const String productionHtmlPath = 'assets/mathlive/main_editor_prod.html';
  static const String productionBridgePath = 'assets/mathlive/mathlive_prod_bridge.js';

  /// Baseline found and frozen by Q389R6F.
  static const String previousFontClamp = 'clamp(28px, 7.8vw, 38px)';
  static const String compactFontClamp = 'clamp(23px, 6.35vw, 31px)';

  static const int previousHostMinHeightPx = 92;
  static const int compactHostMinHeightPx = 84;
  static const int previousMathFieldMinHeightPx = 72;
  static const int compactMathFieldMinHeightPx = 62;
  static const int compactEditablePartMinHeightPx = 54;

  static const double previousLineHeight = 1.24;
  static const double compactLineHeight = 1.20;

  static const bool runtimeInputSemanticsChanged = false;
  static const bool mathLiveBridgeChanged = false;
  static const bool keyboardLayoutChanged = false;
  static const bool cursorDragChanged = false;
  static const bool longExpressionScrollChanged = false;
  static const bool graphChanged = false;
  static const bool ocrChanged = false;
  static const bool androidNativeChanged = false;
  static const bool solverChanged = false;
  static const bool legacyFlutterCursorAllowed = false;

  static const bool compactScaleApplied = true;
  static const bool minimumReadableScalePreservedForQ389R6H = true;
  static const bool nativeMathLiveCaretAuthorityPreserved = true;

  static const bool flutterAnalyzePassClaimedByAssistant = false;
  static const bool flutterTestPassClaimedByAssistant = false;
  static const bool flutterRunPassClaimedByAssistant = false;
  static const bool androidRealDevicePassClaimed = false;
}
