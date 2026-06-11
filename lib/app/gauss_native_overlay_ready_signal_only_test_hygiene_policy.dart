/// V172-Q235R6R1 — GAUSS native overlay ready-signal-only test hygiene.
///
/// Q235R6 removed native splash time caps from runtime. Q235R6R1 updates the
/// stale Q235R5 regression test so it no longer expects the removed
/// `minNativeSplashVisibleMs` / `maxNativeSplashVisibleMs` runtime constants.
/// This phase is test/verifier hygiene only; runtime startup behavior is not
/// changed.
abstract final class GaussNativeOverlayReadySignalOnlyTestHygienePolicy {
  static const String phase = 'V172-Q235R6R1';
  static const String fullPhase = 'V172-Q235R6R1-GAUSS-NATIVE-OVERLAY-READY-SIGNAL-ONLY-TEST-HYGIENE';

  static const bool triggeredByUserSideFlutterTestFailure = true;
  static const bool staleQ235R5TestExpectationRepaired = true;
  static const bool q235R6ReadySignalOnlyRuntimePreserved = true;
  static const bool hardMaxNativeSplashTimeoutStillRemoved = true;
  static const bool hardMinNativeSplashTimeoutStillRemoved = true;
  static const bool releaseOnlyOnFlutterReadySignalStillRequired = true;
  static const bool runtimeMainActivityChanged = false;
  static const bool splashArtworkChanged = false;
  static const bool launcherIconMutationAllowed = false;
  static const bool keyboardMutationAllowed = false;
  static const bool longPressMutationAllowed = false;
  static const bool moreMutationAllowed = false;
  static const bool mathLiveMutationAllowed = false;
  static const bool graphRuntimeMutationAllowed = false;
  static const bool workspaceMutationAllowed = false;
  static const bool resultPanelMutationAllowed = false;
  static const bool solutionMutationAllowed = false;
  static const bool historyMutationAllowed = false;
  static const bool solverMutationAllowed = false;
  static const bool androidManifestMutationAllowed = false;

  static const bool flutterAnalyzePassClaimedByAssistant = false;
  static const bool flutterTestPassClaimedByAssistant = false;
  static const bool flutterRunPassClaimedByAssistant = false;
  static const bool androidRealDeviceSplashPassClaimedByAssistant = false;
}
