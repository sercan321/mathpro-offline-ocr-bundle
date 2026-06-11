class MathLiveShadowObserverFeedbackLoopRepairPolicy {
  const MathLiveShadowObserverFeedbackLoopRepairPolicy._();

  static const String phase = 'V172-Q169R36';
  static const bool shadowRootObserverMayWatchAttributes = false;
  static const bool shadowRootObserverIsDebounced = true;
  static const bool shadowRootObserverIsInstalledOncePerField = true;
  static const bool chromeSuppressionMayMutateInsideObserverSynchronously = false;
  static const bool mathLiveRuntimeBootMustRemainSingleFile = true;
  static const bool fallbackRenderingMayNotClaimPaintPass = true;
  static const bool touchesKeyboardLayout = false;
  static const bool touchesAppShell = false;
  static const bool touchesGraphHistorySolution = false;
  static const bool claimsRealDevicePaintPass = false;
}
