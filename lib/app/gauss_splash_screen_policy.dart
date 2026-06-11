/// V172-Q212 GAUSS splash integration contract.
///
/// This phase is restricted to splash / launch-screen presentation only.
/// It must not mutate the launcher icon, keyboard, Graph, History, Solution,
/// MathLive production editor, routing/business logic, or the theme system.
class GaussSplashScreenPolicy {
  const GaussSplashScreenPolicy._();

  static const String phase = 'V172-Q212';
  static const String masterAsset = 'assets/branding/gauss_splash_screen.png';
  static const String androidNativeDrawable = 'android/app/src/main/res/drawable-nodpi/gauss_splash_screen_native.png';
  static const String androidLaunchBackground = 'android/app/src/main/res/drawable/launch_background.xml';
  static const String androidValuesStyle = 'android/app/src/main/res/values/styles.xml';
  static const String androidValuesV31Style = 'android/app/src/main/res/values-v31/styles.xml';
  static const String suppliedImageSha256 = 'f3f35b0444cc882c32e8b48919a50101e26e402b69e08c20de84ac9c42723533';
  static const int masterWidth = 1440;
  static const int masterHeight = 2560;
  static const bool launcherIconMutationAllowed = false;
  static const bool keyboardMutationAllowed = false;
  static const bool graphMutationAllowed = false;
  static const bool historyMutationAllowed = false;
  static const bool solutionMutationAllowed = false;
  static const bool mathLiveMutationAllowed = false;
  static const bool businessLogicMutationAllowed = false;
  static const bool imageRedrawAllowed = false;
  static const bool extraDecorationAllowed = false;
  static const bool q235SafeFitSuccessorActive = true;
  static const bool q235UsesBoxFitContain = true;
  static const bool flutterAnalyzePassClaimAllowedWithoutUserEvidence = false;
  static const bool realDevicePassClaimAllowedWithoutUserEvidence = false;
  static const bool q235R3NativeSplashHardBindingActive = true;
}
