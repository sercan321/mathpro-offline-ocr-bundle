class GraphSettingsBottomSheetControlMigrationPolicy {
  const GraphSettingsBottomSheetControlMigrationPolicy._();

  static const String phase = 'V172-Q222';
  static const bool graphSettingsBottomSheetActivated = true;
  static const bool modeControlMigratedToSheet = true;
  static const bool viewportWindowFieldsMigratedToSheet = true;
  static const bool traceControlMigratedToSheet = true;
  static const bool resetViewMigratedToSheet = true;
  static const bool miniPanelRemainsCanvasFirst = true;
  static const bool graphCanvasCropPreventionPreserved = true;
  static const bool appShellMutationLimitedToSettingsBinding = true;
  static const bool keyboardMutationAllowed = false;
  static const bool moreMutationAllowed = false;
  static const bool longPressMutationAllowed = false;
  static const bool mathLiveProductionMutationAllowed = false;
  static const bool historyMutationAllowed = false;
  static const bool solutionMutationAllowed = false;
  static const bool graphRuntimeEvaluatorMutationAllowed = false;
  static const bool splashStartupMutationAllowed = false;
  static const bool launcherIconMutationAllowed = false;
  static const bool flutterAnalyzePassClaimedByAssistant = false;
  static const bool flutterTestPassClaimedByAssistant = false;
  static const bool androidRealDevicePassClaimedByAssistant = false;
}
