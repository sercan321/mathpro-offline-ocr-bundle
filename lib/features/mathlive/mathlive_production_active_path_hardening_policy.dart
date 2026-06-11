/// V172-Q190R2 — Production Active Path Hardening.
///
/// Q190R1 fixed a compile-scope blocker. Q190R2 is a static, surgical hardening
/// pass for the active production path that was found by inspecting the real
/// zip contents, not by assuming runtime success.
class MathLiveProductionActivePathHardeningPolicy {
  const MathLiveProductionActivePathHardeningPolicy._();

  static const String phase = 'V172-Q190R2';
  static const String baseline = 'V172-Q190R1_REAL_DEVICE_DEFECT_REPAIR_COMPILE_FIX';
  static const String repairScope = 'production-active-path-css-and-raw-token-commit-hardening';

  static const bool newFeatureAllowed = false;
  static const bool keyboardLayoutMutationAllowed = false;
  static const bool moreInventoryMutationAllowed = false;
  static const bool longPressOrderMutationAllowed = false;
  static const bool graphUiMutationAllowed = false;
  static const bool graphControllerMutationAllowed = false;
  static const bool historyControllerMutationAllowed = false;
  static const bool historyPanelMutationAllowed = false;
  static const bool solutionStepsPanelMutationAllowed = false;
  static const bool solverMutationAllowed = false;

  static const bool activeWorkspaceRouteMustUseProductionSurface = true;
  static const bool productionSurfaceMustLoadProductionHtml = true;
  static const bool productionSurfaceMustLoadProductionBridge = true;
  static const bool productionSurfaceMustLoadBundledRuntime = true;
  static const bool productionSurfaceMustInlineMathLiveCss = true;
  static const bool productionBridgeMustRejectRawInsertTokenCommit = true;
  static const bool productionBridgeMustRollbackRawInsertTokenLeak = true;
  static const bool productionBridgeMustAppendSanitizedDocumentLatexFallback = true;
  static const bool legacySurfacePhysicalCleanupCompleted = false;
  static const bool mathLiveFontsBundledAndVerified = false;
  static const bool androidRealDevicePassClaimed = false;
  static const bool flutterAnalyzePassClaimedByAssistant = false;
  static const bool flutterTestPassClaimedByAssistant = false;
  static const bool flutterRunPassClaimedByAssistant = false;
}
