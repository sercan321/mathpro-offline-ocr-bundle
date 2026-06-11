/// V172-Q235R1 — Android adaptive icon resource-link repair.
///
/// Q235R1 fixes the user-side AAPT build failure caused by an invalid adaptive
/// icon foreground reference. Android resource XML must reference the
/// `drawable-nodpi/ic_launcher_foreground.png` asset as `@drawable/ic_launcher_foreground`;
/// the folder qualifier is not part of the resource name.
abstract final class GaussSplashAndroidAdaptiveIconResourceLinkRepairPolicy {
  static const String phase = 'V172-Q235R1';
  static const String fullPhase = 'V172-Q235R1-ANDROID-ADAPTIVE-ICON-RESOURCE-LINK-REPAIR';

  static const bool triggeredByUserSideAaptFailure = true;
  static const bool invalidDrawableNodpiReferenceRemoved = true;
  static const bool adaptiveForegroundReferenceUsesDrawableType = true;
  static const String fixedForegroundReference = '@drawable/ic_launcher_foreground';
  static const String rejectedForegroundReference = '@drawable-nodpi/ic_launcher_foreground';

  static const bool splashFitBehaviorChanged = false;
  static const bool userProvidedSplashReferenceStillUsed = true;
  static const bool boxFitContainPreserved = true;
  static const bool launcherIconArtworkChanged = false;
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

  static const bool flutterAnalyzePassClaimedByAssistant = false;
  static const bool flutterTestPassClaimedByAssistant = false;
  static const bool flutterRunPassClaimedByAssistant = false;
  static const bool androidRealDeviceSplashPassClaimedByAssistant = false;
  static const bool q235R2AdaptiveIconXmlRouteRemoved = true;
  static const bool q235R2ExactPngLauncherRouteActive = true;
}
