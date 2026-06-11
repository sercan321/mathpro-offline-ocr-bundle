/// V172-Q190R6 — No-Freeze Runtime Invariant.
///
/// This phase converts the real-device freeze repair from a best-effort bridge
/// patch into a code-level invariant: MathPro key taps must never wait for an
/// Android WebView JavaScript result before releasing Flutter-side command / key
/// flow. WebView commands still execute, timeout, trace, and push state, but the
/// Flutter UI receives immediate acceptance once a command is scheduled.
class MathLiveNoFreezeRuntimeInvariantPolicy {
  const MathLiveNoFreezeRuntimeInvariantPolicy._();

  static const String phase = 'V172-Q190R6';
  static const String baseline = 'V172-Q190R5_TEMPLATE_PAYLOAD_SURGICAL_REPAIR';
  static const String repairScope = 'production-no-freeze-runtime-invariant';

  static const bool newFeatureAllowed = false;
  static const bool finalReleaseClaimAllowed = false;
  static const bool keyboardLayoutMutationAllowed = false;
  static const bool moreInventoryMutationAllowed = false;
  static const bool longPressOrderMutationAllowed = false;
  static const bool graphUiMutationAllowed = false;
  static const bool graphControllerMutationAllowed = false;
  static const bool historyControllerMutationAllowed = false;
  static const bool historyPanelMutationAllowed = false;
  static const bool solutionStepsPanelMutationAllowed = false;

  static const bool flutterKeyPressMayAwaitWebViewJavascript = false;
  static const bool productionSendKeyReturnsAfterScheduling = true;
  static const bool productionBridgeResultDeliveredByStatePush = true;
  static const bool webViewJavascriptStillTimeoutBounded = true;
  static const bool priorityClearAlwaysReleasesDartQueue = true;
  static const bool javascriptPendingQueueHasDeterministicBounds = true;
  static const bool productionTailErrorsMustBeCaught = true;
  static const bool visualDebugOverlayAllowed = false;
  static const bool productionPublicApiExpansionAllowed = false;

  static const Duration statePushCommandTimeout = Duration(milliseconds: 450);

  static const bool androidRealDevicePassClaimed = false;
  static const bool flutterAnalyzePassClaimedByAssistant = false;
  static const bool flutterTestPassClaimedByAssistant = false;
  static const bool flutterRunPassClaimedByAssistant = false;
  static const bool premiumSymbolVisualPassClaimed = false;
  static const bool caretRealDevicePassClaimed = false;
  static const bool legacySurfacePhysicalCleanupCompleted = false;
}
