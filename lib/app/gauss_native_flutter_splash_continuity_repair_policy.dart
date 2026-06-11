/// V172-Q235R4 — GAUSS native-to-Flutter splash continuity repair.
///
/// Q235R3 proved the native splash artwork appears, but Android removes native
/// splash quickly and Flutter/AppShell can still show a dark frame. Q235R4 keeps
/// native hard-binding and restores a Flutter-held splash poster long enough to
/// bridge startup. AppShell is mounted only after the poster duration, so
/// platform views cannot cover the splash while it is visible.
abstract final class GaussNativeFlutterSplashContinuityRepairPolicy {
  static const String phase = 'V172-Q235R4';
  static const String fullPhase = 'V172-Q235R4-GAUSS-NATIVE-FLUTTER-SPLASH-CONTINUITY-REPAIR';

  static const bool triggeredByNativeSplashTooShortThenDarkFrameReport = true;
  static const bool nativeSplashHardBindingPreserved = true;
  static const bool userProvidedSplashReferenceUsed = true;
  static const bool newSplashImageGenerationUsed = false;

  static const bool flutterSplashPosterRestored = true;
  static const bool appShellMountedOnlyAfterPosterDuration = true;
  static const bool appShellStackedBehindSplash = false;
  static const bool platformViewCanCoverSplashWhileVisible = false;
  static const bool posterUsesBoxFitContain = true;
  static const bool posterUsesBoxFitCover = false;
  static const int posterVisibleDurationMs = 2400;
  static const int posterFadeOutDurationMs = 180;
  static const bool visibleFallbackEnabled = true;
  static const bool firstFrameDeferralAllowed = false;

  static const bool productionHomeUsesGaussStartupSplash = true;
  static const bool productionHomeDirectAppShellOnly = false;

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
  static const bool q235R5NativeOverlayUntilAppShellReadyActive = true;
}
