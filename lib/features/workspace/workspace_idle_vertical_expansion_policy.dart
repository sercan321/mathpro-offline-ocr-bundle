/// V172-Q229 — Workspace Idle Vertical Expansion / Dead Gap Reclaim.
///
/// Guard-only policy notes for the normal/idle workspace layout pass.
/// This phase is not a keyboard, MathLive, Graph, MORE, History, Solution,
/// solver, startup, or Android phase.  It only lets the normal workspace card
/// reclaim the vertical slot that was previously left as dead space above the
/// keyboard while preserving shrink behavior when Graph, MORE/template tray, or
/// Solution Steps is visible.
class WorkspaceIdleVerticalExpansionPolicy {
  const WorkspaceIdleVerticalExpansionPolicy._();

  static const String phase = 'V172-Q229-WORKSPACE-IDLE-VERTICAL-EXPANSION';
  static const String successorPhase = 'V172-Q229R4-WORKSPACE-CARD-SLOT-FILL-PHANTOM-GAP-FIX';
  static const String idleFlag = 'idleExpansion';
  static const bool keyboardLayoutMayChange = false;
  static const bool mathLiveProductionEditorMayChange = false;
  static const bool graphRuntimeMayBeRedesigned = false;
  static const bool solutionRuntimeMayChange = false;
  static const bool appShellPanelCoordinationMayChange = false;
  static const bool onlyIdleWorkspaceMayReclaimDeadGap = true;
  static const double targetKeyboardGapMin = 8;
  static const double targetKeyboardGapMax = 14;
  static const double q229r2IdleBottomGapTargetMin = 8;
  static const double q229r2IdleBottomGapTargetMax = 12;
  static const String protectedIntent =
      'Idle screen grows the workspace card; graph/MORE/solution context panels keep their existing shrink behavior.';
}
