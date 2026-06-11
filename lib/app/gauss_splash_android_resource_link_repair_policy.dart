/// V172-Q214 — GAUSS splash Android resource-link repair.
///
/// This policy records a narrow Android build repair created from the user's
/// real `flutter run` log. It removes the unavailable framework-scoped
/// `android:postSplashScreenTheme` style attribute from the Android 12+ splash
/// style while preserving the Q212 GAUSS splash artwork, Q211 launcher icon,
/// MathLive production editor route, keyboard, Graph, History, Solution, and
/// business logic.
abstract final class GaussSplashAndroidResourceLinkRepairPolicy {
  static const String phase = 'V172-Q214';
  static const String fullPhase =
      'V172-Q214-GAUSS-SPLASH-ANDROID-RESOURCE-LINK-REPAIR';

  static const bool triggeredByUserSideFlutterRunLog = true;
  static const String failingTask = ':app:processDebugResources';
  static const String removedUnavailableFrameworkAttribute =
      'android:postSplashScreenTheme';
  static const bool androidValuesV31CompileSafe = true;
  static const bool q212SplashArtworkPreserved = true;
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
