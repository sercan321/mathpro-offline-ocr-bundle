/// V172-Q215 — GAUSS splash no-black-startup repair.
///
/// Records the narrow repair for the user-side finding that launch showed a
/// black screen before the app opened. This phase keeps the supplied GAUSS
/// splash artwork and launcher icon intact, strengthens Android 12+ system
/// splash handoff, but that approach was superseded by Q218 because first-frame deferral can
/// block startup on real devices.
abstract final class GaussSplashNoBlackStartupRepairPolicy {
  static const String phase = 'V172-Q215';
  static const String fullPhase = 'V172-Q215-GAUSS-SPLASH-NO-BLACK-STARTUP-REPAIR';
  static const bool triggeredByUserSideBlackStartupReport = true;
  static const bool firstFlutterFrameDeferredUntilSplashImageReady = false;
  static const bool android12SystemSplashNoLongerTransparentOnly = false;
  static const bool suppliedSplashArtworkPreserved = true;
  static const bool supersededByQ218NonBlockingOverlay = true;
  static const bool supersededByQ219BootVisibilityDirectShell = true;
  static const bool launcherIconMutationAllowed = false;
  static const bool splashArtworkRedrawAllowed = false;
  static const bool keyboardMutationAllowed = false;
  static const bool graphRuntimeBehaviorMutationAllowed = false;
  static const bool historyMutationAllowed = false;
  static const bool solutionMutationAllowed = false;
  static const bool mathLiveProductionRuntimeMutationAllowed = false;
  static const bool businessLogicMutationAllowed = false;
  static const bool flutterRunPassClaimedByAssistant = false;
  static const bool androidRealDevicePassClaimedByAssistant = false;
}
