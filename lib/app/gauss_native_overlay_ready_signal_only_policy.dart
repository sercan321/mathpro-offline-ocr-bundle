/// V172-Q235R6 — GAUSS native overlay ready-signal-only release.
///
/// Q235R6 removes the hard maximum timeout from the native splash overlay.
/// The overlay is not hidden because 14 seconds passed. It is hidden only when
/// Flutter reports that AppShell has mounted, a child frame has drawn, and the
/// explicit `releaseNativeSplash` signal is sent over `mathpro/native_splash`.
abstract final class GaussNativeOverlayReadySignalOnlyPolicy {
  static const String phase = 'V172-Q235R6';
  static const String fullPhase = 'V172-Q235R6-GAUSS-NATIVE-OVERLAY-READY-SIGNAL-ONLY';

  static const bool triggeredByNoFixedSplashDurationRequest = true;
  static const bool userProvidedSplashReferenceUsed = true;
  static const bool newSplashImageGenerationUsed = false;
  static const bool nativeOverlayAboveFlutterViewEnabled = true;
  static const bool nativeOverlayUsesFullSplashArtwork = true;
  static const bool nativeOverlayUsesFitCenter = true;
  static const bool hardMaxNativeSplashTimeoutRemoved = true;
  static const bool hardMinNativeSplashTimeoutRemoved = true;
  static const bool releaseOnlyOnFlutterReadySignal = true;
  static const bool releaseSignalSentAfterAppShellChildFrame = true;
  static const bool appShellMountedOnlyAfterFlutterPoster = true;
  static const bool splashCanRemainAsLongAsStartupNeeds = true;
  static const bool nativeOverlayHasNoTimeCap = true;
  static const bool flutterPosterUsesBoxFitContain = true;
  static const bool flutterPosterUsesBoxFitCover = false;
  static const bool appShellStackedBehindSplash = false;
  static const bool firstFrameDeferralAllowed = false;
  static const bool visibleFallbackEnabled = true;

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
