/// V172-Q205 — MathLive-Only Main Editor Physical Cleanup.
///
/// This policy documents the post-Q204R3 product decision: the expression
/// editor authority is the production MathLive `<math-field>` route only.
/// Historical Flutter cursor/render surfaces may remain in audit history, but
/// they cannot be reachable from the production AppShell/Workspace route.
class MathLiveOnlyMainEditorPhysicalCleanupPolicy {
  const MathLiveOnlyMainEditorPhysicalCleanupPolicy._();

  static const String phase = 'V172-Q205';
  static const String fullPhase = 'V172-Q205-MATHLIVE-ONLY-MAIN-EDITOR-PHYSICAL-CLEANUP';

  static const bool mathLiveProductionEditorIsSingleExpressionAuthority = true;
  static const bool workspaceEditorViewportBranchRemoved = true;
  static const bool appShellLegacySnapshotBuildRemoved = true;
  static const bool appShellLegacySlotCallbacksRemoved = true;
  static const bool legacyCursorDisabledPanelRemoved = true;
  static const bool editorViewportProductionRouteAllowed = false;
  static const bool flutterCaretOverlayProductionRouteAllowed = false;
  static const bool mathJaxEditorSurfaceProductionRouteAllowed = false;
  static const bool runJavaScriptReturningResultAllowedInProduction = false;
  static const bool visibleFallbackOverlayAllowedInProduction = false;
  static const bool diagnosticOverlayAllowedInProduction = false;
  static const bool graphHistorySolutionAdapterPreserved = true;
  static const bool astCoreBlindDeletionAllowed = false;
  static const bool keyboardLayoutMutationAllowed = false;
  static const bool moreInventoryMutationAllowed = false;
  static const bool longPressMutationAllowed = false;
  static const bool graphUiMutationAllowed = false;
  static const bool historyUiMutationAllowed = false;
  static const bool solutionUiMutationAllowed = false;
  static const bool flutterAnalyzePassClaimedByAssistant = false;
  static const bool flutterTestPassClaimedByAssistant = false;
  static const bool androidRealDevicePassClaimed = false;
}
