/// Q389R6D — Graph open-state expression refresh contract.
///
/// Enter/evaluate should refresh only an already-visible graph preview from the
/// latest MathLive production state.  It must not convert graphing into a hot
/// per-keystroke listener and must not mutate keyboard, OCR, MathLive bridge,
/// solver, or workspace layout behavior.
class GraphExpressionRefreshPolicy {
  const GraphExpressionRefreshPolicy._();

  static const String phase = 'Q389R6E';
  static const String fullPhase = 'Q389R6E-GRAPH-ENTER-REFRESH-AUDIT-HARDENING';

  static const bool evaluateEnterRefreshesVisibleGraph = true;
  static const bool refreshOnlyWhenGraphPreviewAlreadyVisible = true;
  static const bool preserveRenderModeOnRefresh = true;
  static const bool preserveGraphDisplayTogglesOnRefresh = true;
  static const bool resetViewportForNewExpression = true;
  static const bool preserveViewportWhenExpressionUnchanged = true;
  static const bool closeStaleGraphWhenNewExpressionIsNotGraphable = true;

  static const bool perKeystrokeGraphRefreshAllowed = false;
  static const bool keyboardLayoutMutationAllowed = false;
  static const bool mathLiveBridgeMutationAllowed = false;
  static const bool ocrMutationAllowed = false;
  static const bool androidNativeMutationAllowed = false;
  static const bool solverMutationAllowed = false;
  static const bool workspaceLayoutMutationAllowed = false;

  static const bool flutterAnalyzePassClaimedByAssistant = false;
  static const bool flutterTestPassClaimedByAssistant = false;
  static const bool flutterRunPassClaimedByAssistant = false;
  static const bool androidRealDevicePassClaimed = false;
}
