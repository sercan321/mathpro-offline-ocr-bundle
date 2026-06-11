/// V172-Q190R3 — Production Command Bus Court.
///
/// This is not a feature phase and it is not a final Android PASS claim. The
/// phase hardens the active Q184-Q190R2 production route with an auditable
/// command-bus court so real-device freezes can be attributed to a precise
/// stage: Flutter key tap, Dart dispatch, WebView bridge call, MathLive insert
/// commit, notifyFlutterState, queue release, focus/caret refresh, or clear.
class MathLiveProductionCommandBusCourtPolicy {
  const MathLiveProductionCommandBusCourtPolicy._();

  static const String phase = 'V172-Q190R3';
  static const String baseline = 'V172-Q190R2_PRODUCTION_ACTIVE_PATH_HARDENING';
  static const String repairScope = 'production-command-bus-court-and-state-trace';

  static const bool newFeatureAllowed = false;
  static const bool finalReleaseClaimAllowed = false;
  static const bool androidRealDevicePassClaimed = false;
  static const bool flutterAnalyzePassClaimedByAssistant = false;
  static const bool flutterTestPassClaimedByAssistant = false;
  static const bool flutterRunPassClaimedByAssistant = false;

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
  static const bool productionBridgeMustEmitCommandTraceStatus = true;
  static const bool productionBridgeMustCountReceivedCompletedAndFailedCalls = true;
  static const bool productionBridgeMustTraceInsertCommitOutcome = true;
  static const bool productionBridgeMustTraceQueueFlush = true;
  static const bool productionBridgeMustTraceNotifyFlutterState = true;
  static const bool dartSurfaceMustTraceDispatchStartSentFailedAndTimeout = true;
  static const bool traceStateIntoSelectionDescription = true;
  static const bool productionPublicApiExpansionAllowed = false;
  static const bool visualDebugOverlayAllowed = false;

  static const bool legacySurfacePhysicalCleanupCompleted = false;
  static const bool mathLiveFontsBundledAndVerified = false;
  static const bool premiumSymbolVisualPassClaimed = false;
  static const bool caretRealDevicePassClaimed = false;
}
