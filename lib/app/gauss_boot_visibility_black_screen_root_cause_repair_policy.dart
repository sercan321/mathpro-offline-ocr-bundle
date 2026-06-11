/// V172-Q219 — GAUSS boot visibility / black-screen root-cause repair.
///
/// Q219 is intentionally not a visual splash polish phase. It disables the
/// Flutter GAUSS splash overlay from the production boot route so the real
/// device court can prove whether MathProAppShell itself becomes visible. This
/// prevents splash code from masking AppShell, MathLive/WebView, or runtime
/// failures behind a permanent black screen.
abstract final class GaussBootVisibilityBlackScreenRootCauseRepairPolicy {
  static const String phase = 'V172-Q219';
  static const String fullPhase = 'V172-Q219-GAUSS-BOOT-VISIBILITY-BLACK-SCREEN-ROOT-CAUSE-REPAIR';

  static const bool triggeredByRealDeviceBlackScreenAfterQ218 = true;
  static const bool splashOverlayDisabledForBootProof = true;
  static const bool appBootsDirectlyIntoMathProAppShell = true;
  static const bool nativeSplashIsDarkBackgroundOnly = true;
  static const bool android12IconSlotUsesFullscreenBitmap = false;
  static const bool startupDependsOnSplashAssetDecode = false;
  static const bool startupDependsOnPrecacheImage = false;
  static const bool firstFrameDeferralAllowed = false;
  static const bool suppliedSplashArtworkPreservedButInactive = true;
  static const bool q235SafeFitSplashSuccessorActive = true;
  static const bool q235ReenabledBoundedFlutterOverlay = true;
  static const bool launcherIconMutationAllowed = false;
  static const bool splashArtworkRedrawAllowed = false;
  static const bool keyboardMutationAllowed = false;
  static const bool graphRuntimeBehaviorMutationAllowed = false;
  static const bool historyMutationAllowed = false;
  static const bool solutionMutationAllowed = false;
  static const bool mathLiveCommandBridgeMutationAllowed = false;
  static const bool solverMutationAllowed = false;
  static const bool flutterAnalyzePassClaimedByAssistant = false;
  static const bool flutterTestPassClaimedByAssistant = false;
  static const bool flutterRunPassClaimedByAssistant = false;
  static const bool androidRealDevicePassClaimedByAssistant = false;
  static const bool q235R3NativeSplashHardBindingActive = true;
  static const bool q235R4NativeFlutterContinuityRepairActive = true;
}
