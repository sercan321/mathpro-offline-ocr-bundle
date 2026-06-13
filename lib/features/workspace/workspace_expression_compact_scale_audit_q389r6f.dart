/// Q389R6F — Workspace expression compact scale preflight audit.
///
/// This phase is intentionally non-mutating.  It freezes the exact files and
/// red lines that must be respected before Q389R6G/Q389R6H/Q389R6I touch the
/// MathLive expression scale, long-expression horizontal scroll, and Fotomath-
/// style long-press cursor drag behavior.
class WorkspaceExpressionCompactScaleAuditQ389R6F {
  const WorkspaceExpressionCompactScaleAuditQ389R6F._();

  static const String phase = 'Q389R6F';
  static const String fullPhase = 'Q389R6F-WORKSPACE-EXPRESSION-SCALE-PREFLIGHT-AUDIT';

  static const bool runtimeBehaviorChanged = false;
  static const bool visualScaleChanged = false;
  static const bool cursorDragChanged = false;
  static const bool longExpressionScrollChanged = false;

  static const bool q389r6gMayTouchMathliveProductionHtmlCssOnly = true;
  static const bool q389r6gMayTouchWorkspaceCardMetricsOnlyAfterAudit = true;
  static const bool q389r6hMustPreserveMinimumReadableScale = true;
  static const bool q389r6iMustPreserveNativeMathLiveCaretAuthority = true;

  static const String productionHtmlPath = 'assets/mathlive/main_editor_prod.html';
  static const String productionBridgePath = 'assets/mathlive/mathlive_prod_bridge.js';
  static const String workspacePanelPath = 'lib/features/workspace/workspace_panel.dart';
  static const String mathLiveMainSurfacePath = 'lib/features/mathlive/mathlive_main_editor_surface.dart';
  static const String productionSurfacePath = 'lib/features/mathlive/mathlive_production_editor_surface.dart';

  static const bool keyboardLayoutMutationAllowed = false;
  static const bool mathLiveBridgeMutationAllowedInQ389R6G = false;
  static const bool mathLiveBridgeMutationAllowedInQ389R6H = false;
  static const bool mathLiveBridgeMutationAllowedInQ389R6IOnlyAfterSeparateProof = true;
  static const bool ocrMutationAllowed = false;
  static const bool androidNativeMutationAllowed = false;
  static const bool graphMutationAllowed = false;
  static const bool solverMutationAllowed = false;
  static const bool legacyFlutterCursorAllowed = false;

  static const bool flutterAnalyzePassClaimedByAssistant = false;
  static const bool flutterTestPassClaimedByAssistant = false;
  static const bool flutterRunPassClaimedByAssistant = false;
  static const bool androidRealDevicePassClaimed = false;
}
