/// V172-Q235R7 — Android 12 small splash icon elimination.
///
/// Android 12+ renders `windowSplashScreenAnimatedIcon` in a fixed icon slot.
/// Placing the GAUSS splash poster there makes startup appear as a small
/// picture that later grows into the full native overlay. Q235R7 removes that
/// visual scale jump by restoring the transparent Android 12+ icon slot and
/// leaving the full GAUSS artwork to the native overlay above FlutterView.
abstract final class GaussAndroid12SmallSplashIconEliminationPolicy {
  static const String phase = 'V172-Q235R7';
  static const String fullPhase = 'V172-Q235R7-ANDROID12-SMALL-SPLASH-ICON-ELIMINATION';

  static const bool triggeredBySmallThenLargeSplashReport = true;
  static const bool android12SystemIconSlotRendersSmallArtwork = true;
  static const bool android12BrandedIconSlotRemoved = true;
  static const bool android12TransparentIconRestored = true;
  static const bool fullSplashOwnedByNativeOverlay = true;
  static const bool nativeOverlayUsesFullSplashArtwork = true;
  static const bool nativeOverlayUsesFitCenter = true;
  static const bool readySignalOnlyReleasePreserved = true;
  static const bool noHardNativeSplashTimeoutPreserved = true;
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
