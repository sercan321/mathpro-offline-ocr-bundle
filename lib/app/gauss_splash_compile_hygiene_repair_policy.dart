/// V172-Q216: GAUSS splash compile hygiene repair.
///
/// This policy records the narrow repair for user-side Flutter analyze/test
/// blockers introduced by the no-black startup first-frame gate. Q218 supersedes
/// the gate with a non-blocking overlay, and Q219 disables the overlay for
/// boot visibility/root-cause proof. It does not
/// change the supplied splash artwork, launcher icon, keyboard, Graph, History,
/// Solution, MathLive production editor, routing, or business logic.
class GaussSplashCompileHygieneRepairPolicy {
  const GaussSplashCompileHygieneRepairPolicy._();

  static const String phase = 'V172-Q216';
  static const bool triggeredByUserSideAnalyzeAndTestLog = true;
  static const bool futureAnyConstructorRemoved = true;
  static const bool runAppMaterialImportRestored = true;
  static const bool firstFrameGatePreserved = false;
  static const bool supersededByQ219BootVisibilityDirectShell = true;
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
