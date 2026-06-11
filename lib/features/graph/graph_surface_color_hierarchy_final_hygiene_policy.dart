class GraphSurfaceColorHierarchyFinalHygienePolicy {
  const GraphSurfaceColorHierarchyFinalHygienePolicy._();

  static const String phase = 'V172-Q234R1';
  static const String fullPhase = 'V172-Q234R1-GRAPH-SURFACE-COLOR-HIERARCHY-FINAL-HYGIENE';

  static const bool q234SurfaceRendererPreserved = true;
  static const bool q225VerifierAcceptsQ234SurfaceSuccessor = true;
  static const bool fullscreenGraphSettingsRenderModeBindingRepaired = true;
  static const bool fullscreenGraphSettingsColorApplyPreserved = true;
  static const bool duplicateApplyKeyAnalyzerHygieneRepaired = true;

  // Q234 deliberately persists graph color at GraphExpression/history JSON level.
  // Q234R1 makes that contract explicit instead of adding a broad app-level async
  // preference bootstrap that would require protected AppShell/main startup changes.
  static const String graphColorPersistenceScope = 'expression-level';
  static const bool graphColorStoredInGraphExpression = true;
  static const bool graphColorKeyStoredInGraphJson = true;
  static const bool globalGraphColorDefaultPreferenceAdded = false;
  static const String globalPreferenceDecision = 'Not added in Q234R1; expression-level persistence is the explicit, low-risk contract.';

  static const bool graphPainterMutationAllowed = false;
  static const bool graphSurface3DMutationAllowed = false;
  static const bool graphEvaluatorMutationAllowed = false;
  static const bool keyboardMutationAllowed = false;
  static const bool moreMutationAllowed = false;
  static const bool longPressMutationAllowed = false;
  static const bool mathLiveProductionMutationAllowed = false;
  static const bool workspaceLayoutMutationAllowed = false;
  static const bool solutionPanelMutationAllowed = false;
  static const bool historyMutationAllowed = false;
  static const bool appShellMutationAllowed = false;

  static const bool flutterAnalyzePassClaimedByAssistant = false;
  static const bool flutterTestPassClaimedByAssistant = false;
  static const bool androidGraphVisualPassClaimedByAssistant = false;
  static const bool realDeviceScreenshotPassClaimedByAssistant = false;
}
