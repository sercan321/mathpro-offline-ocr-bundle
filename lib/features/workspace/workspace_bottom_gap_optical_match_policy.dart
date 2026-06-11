/// V172-Q229R2 — Workspace Bottom Gap Optical Match / MORE-open Reference.
///
/// This policy documents the final idle spacing polish after Q229.  It does
/// not authorize keyboard, MathLive, Graph, Solution, MORE/template tray,
/// History, solver, startup, or Android changes.  The only runtime target is
/// the normal/idle workspace card bottom rhythm above the frozen keyboard.
class WorkspaceBottomGapOpticalMatchPolicy {
  const WorkspaceBottomGapOpticalMatchPolicy._();

  static const String phase = 'V172-Q229R2-WORKSPACE-BOTTOM-GAP-OPTICAL-MATCH';
  static const String successorPhase = 'V172-Q229R4-WORKSPACE-CARD-SLOT-FILL-PHANTOM-GAP-FIX';
  static const String reference = 'MORE-open compact tray separator rhythm';
  static const bool keyboardLayoutMayChange = false;
  static const bool mathLiveProductionEditorMayChange = false;
  static const bool graphRuntimeMayChange = false;
  static const bool solutionRuntimeMayChange = false;
  static const bool moreTemplateTrayMayChange = false;
  static const bool historyRuntimeMayChange = false;
  static const bool onlyIdleBottomGapMayChange = false;
  static const double idleBottomGapTargetMin = 8;
  static const double idleBottomGapTargetMax = 12;
  static const String protectedIntent =
      'Normal idle bottom gap visually follows the MORE-open spacing family while Graph/MORE/Solution shrink behavior remains unchanged.';
}
