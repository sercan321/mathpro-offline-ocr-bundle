/// V172-Q218 — GAUSS splash startup black-screen repair.
///
/// Records the narrow repair for the user's real-device report that Q217 still
/// showed only a black startup screen. Q218 removes all Flutter first-frame
/// deferral from app boot, keeps Android 12+ native splash in a safe premium
/// dark background-only mode, and shows the supplied GAUSS artwork only as a
/// normal bounded Flutter overlay that cannot block startup.
abstract final class GaussSplashStartupBlackScreenRepairPolicy {
  static const String phase = 'V172-Q218';
  static const String fullPhase = 'V172-Q218-GAUSS-SPLASH-STARTUP-BLACK-SCREEN-REPAIR';

  static const bool triggeredByRealDeviceBlackScreenReport = true;
  static const bool firstFrameDeferralRemoved = true;
  static const bool startupIndependentFromImageDecode = true;
  static const bool nativeSplashUsesFullscreenBitmapInIconSlot = false;
  static const bool flutterOverlayIsBoundedByTimer = true;
  static const bool supersededByQ219BootVisibilityDirectShell = true;
  static const bool q235SafeFitSplashSuccessorActive = true;
  static const int overlayVisibleMilliseconds = 1050;
  static const int overlayFadeMilliseconds = 240;
  static const bool suppliedSplashArtworkPreserved = true;
  static const bool launcherIconMutationAllowed = false;
  static const bool splashArtworkRedrawAllowed = false;
  static const bool keyboardMutationAllowed = false;
  static const bool graphRuntimeBehaviorMutationAllowed = false;
  static const bool historyMutationAllowed = false;
  static const bool solutionMutationAllowed = false;
  static const bool mathLiveProductionRuntimeMutationAllowed = false;
  static const bool businessLogicMutationAllowed = false;
  static const bool flutterAnalyzePassClaimedByAssistant = false;
  static const bool flutterTestPassClaimedByAssistant = false;
  static const bool androidRealDevicePassClaimedByAssistant = false;
}
