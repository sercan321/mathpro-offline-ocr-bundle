/// V172-Q235R5 — GAUSS native overlay until AppShell ready.
///
/// Q235R5 addresses the user-reported sequence:
/// small native splash -> normal splash -> dark frame -> app.
/// The repair keeps a native Android overlay above FlutterView with the full
/// user-provided splash artwork. Flutter asks native Android to release that
/// overlay only after `MathProAppShell` has mounted and a child frame has
/// completed. Native Android also enforces a minimum visibility and a max guard.
abstract final class GaussNativeOverlayUntilAppShellReadyPolicy {
  static const String phase = 'V172-Q235R5';
  static const String fullPhase = 'V172-Q235R5-GAUSS-NATIVE-OVERLAY-UNTIL-APPSHELL-READY';

  static const bool triggeredBySmallNormalDarkThenAppReport = true;
  static const bool userProvidedSplashReferenceUsed = true;
  static const bool newSplashImageGenerationUsed = false;
  static const bool nativeOverlayAboveFlutterViewEnabled = true;
  static const bool nativeOverlayUsesFullSplashArtwork = true;
  static const bool nativeOverlayUsesFitCenter = true;
  static const int minNativeSplashVisibleMs = 6500;
  static const int maxNativeSplashVisibleMs = 14000;
  static const bool flutterReleaseSignalRequiredBeforeMinHide = true;
  static const bool releaseSignalSentAfterAppShellChildFrame = true;
  static const bool appShellMountedOnlyAfterFlutterPoster = true;
  static const int flutterPosterVisibleDurationMs = 2400;
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
  static const bool q235R6ReadySignalOnlyReleaseActive = true;
}
