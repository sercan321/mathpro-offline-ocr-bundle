/// V172-Q190R4 — Production Bridge / Queue / Focus Repair.
///
/// This is a surgical production-path repair after Q190R3. It does not claim
/// Android PASS, final release, premium symbol PASS, caret PASS, or physical
/// legacy cleanup. Its scope is limited to deterministic production command
/// dispatch: no active production state readback through
/// runJavaScriptReturningResult, priority clear queue reset, strict template
/// commit failure handling, and post-command focus/state push.
class MathLiveProductionBridgeQueueFocusRepairPolicy {
  const MathLiveProductionBridgeQueueFocusRepairPolicy._();

  static const String phase = 'V172-Q190R4';
  static const String baseline = 'V172-Q190R3_PRODUCTION_COMMAND_BUS_COURT';
  static const String repairScope = 'production-bridge-queue-focus-commit-repair';

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

  static const bool activeProductionCurrentStateUsesPushNotReturningResult = true;
  static const bool clearCommandMustResetDartCommandTail = true;
  static const bool clearCommandMustResetBridgePendingQueue = true;
  static const bool templatePayloadDocumentFallbackBlocked = true;
  static const bool rawInsertTokenCommitRejected = true;
  static const bool postCommandFocusRefreshRequired = true;
  static const bool productionPublicApiExpansionAllowed = false;
  static const bool visualDebugOverlayAllowed = false;

  static const bool legacySurfacePhysicalCleanupCompleted = false;
  static const bool mathLiveFontsBundledAndVerified = false;
  static const bool premiumSymbolVisualPassClaimed = false;
  static const bool caretRealDevicePassClaimed = false;
}
