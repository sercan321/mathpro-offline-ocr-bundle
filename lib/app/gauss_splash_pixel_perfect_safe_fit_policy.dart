/// V172-Q235 — GAUSS splash pixel-perfect safe-fit integration.
///
/// Q235 is splash-only. It re-enables the bounded Flutter splash overlay after
/// Q219's boot-visibility proof, uses only the user-provided splash artwork,
/// and forces contain/center safe-fit so the artwork is never cropped or
/// stretched. Native Android remains a dark compile-safe background because
/// Android 12 icon slots crop full-screen artwork.
abstract final class GaussSplashPixelPerfectSafeFitPolicy {
  static const String phase = 'V172-Q235';
  static const String fullPhase = 'V172-Q235-GAUSS-SPLASH-PIXEL-PERFECT-SAFE-FIT';

  static const bool splashOnlyPhase = true;
  static const bool userProvidedSplashReferenceUsed = true;
  static const bool newSplashImageGenerationUsed = false;
  static const bool flutterOverlayReenabled = false;
  static const bool appShellBuiltImmediately = true;
  static const bool firstFrameDeferralAllowed = false;
  static const bool androidIconSlotFullscreenBitmapAllowed = false;
  static const bool flutterSplashUsesBoxFitContain = true;
  static const bool flutterSplashCropsArtwork = false;
  static const bool flutterSplashStretchesArtwork = false;
  static const bool nativeSplashRemainsDarkBackgroundOnly = true;
  static const bool nativeSplashCannotCropFullArtwork = true;
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
  static const bool androidStartupThemeMutationAllowed = false;
  static const bool flutterAnalyzePassClaimedByAssistant = false;
  static const bool flutterTestPassClaimedByAssistant = false;
  static const bool androidRealDeviceSplashPassClaimedByAssistant = false;
  static const bool q235R3NativeSplashHardBindingActive = true;
  static const bool q235R2BootAndIconVisualRepairActive = true;
  static const bool q235R4NativeFlutterContinuityRepairActive = true;
  static const bool q235R5NativeOverlayUntilAppShellReadyActive = true;
}
