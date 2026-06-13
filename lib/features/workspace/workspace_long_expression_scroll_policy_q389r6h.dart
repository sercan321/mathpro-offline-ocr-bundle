/// Q389R6H — Workspace long-expression scroll and caret visibility policy.
///
/// This phase preserves Q389R6G's Fotomath-like compact expression scale, adds
/// a minimum readable long-expression fit class, and keeps overflow horizontal
/// instead of shrinking math into unreadable micro text.
///
/// The runtime implementation is deliberately narrow: production MathLive HTML
/// CSS plus the production bridge's existing native-caret visibility command.
/// It does not implement Fotomath-style long-press cursor drag yet; that remains
/// reserved for Q389R6I after the scroll/caret visibility base is proven.
class WorkspaceLongExpressionScrollPolicyQ389R6H {
  const WorkspaceLongExpressionScrollPolicyQ389R6H._();

  static const String phase = 'Q389R6H';
  static const String fullPhase = 'Q389R6H-WORKSPACE-LONG-EXPRESSION-SCROLL-CARET-VISIBILITY';

  static const String productionHtmlPath = 'assets/mathlive/main_editor_prod.html';
  static const String productionBridgePath = 'assets/mathlive/mathlive_prod_bridge.js';

  static const String baseCompactFontClamp = 'clamp(23px, 6.35vw, 31px)';
  static const String compactFitFontClamp = 'clamp(22px, 6.05vw, 30px)';
  static const String minimumReadableScrollFontClamp = 'clamp(21px, 5.75vw, 28px)';

  static const bool horizontalOverflowScrollAllowed = true;
  static const bool unreadableMicroScaleForbidden = true;
  static const bool scrollbarHiddenForPremiumSurface = true;
  static const bool scrollPaddingInlineApplied = true;
  static const int scrollPaddingInlinePx = 24;

  static const bool caretVisibilityUsesNativeMathLivePosition = true;
  static const bool caretVisibilityUsesRatioFallbackOnly = true;
  static const bool selectionChangeSchedulesVisibilityRefresh = true;
  static const bool longPressCursorDragImplemented = false;

  static const bool nativeMathLiveCaretAuthorityPreserved = true;
  static const bool legacyFlutterCursorAllowed = false;
  static const bool mathLiveBridgeRewritten = false;
  static const bool keyboardLayoutChanged = false;
  static const bool graphChanged = false;
  static const bool ocrChanged = false;
  static const bool androidNativeChanged = false;
  static const bool solverChanged = false;

  static const bool flutterAnalyzePassClaimedByAssistant = false;
  static const bool flutterTestPassClaimedByAssistant = false;
  static const bool flutterRunPassClaimedByAssistant = false;
  static const bool androidRealDevicePassClaimed = false;
}
