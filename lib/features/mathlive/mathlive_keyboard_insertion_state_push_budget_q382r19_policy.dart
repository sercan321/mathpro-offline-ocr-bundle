/// V172-Q382R19 — MathLive Keyboard Insertion Mode + State Push Budget.
///
/// This phase is a surgical latency repair on top of Q382R18. It does not
/// change keyboard layout/order/labels, long-press lists, MORE/template tray,
/// Graph, Solution logic, OCR/Camera, Android/Kotlin, Gradle, solver semantics,
/// splash/icon, or the MathLive production route.
///
/// The narrow goal is to keep normal MathPro keyboard insertion from flooding
/// Flutter with redundant JS -> Dart state messages. The serial WebView command
/// queue and Android command timeout remain unchanged.
class MathLiveKeyboardInsertionStatePushBudgetQ382R19Policy {
  const MathLiveKeyboardInsertionStatePushBudgetQ382R19Policy._();

  static const String phase = 'V172-Q382R19';
  static const String repairScope = 'mathlive-keyboard-insertion-state-push-budget';

  static const bool keyboardLayoutChanged = false;
  static const bool moreTemplateTrayChanged = false;
  static const bool longPressListsChanged = false;
  static const bool graphChanged = false;
  static const bool solutionLogicChanged = false;
  static const bool ocrCameraChanged = false;
  static const bool androidManifestChanged = false;
  static const bool mainActivityChanged = false;
  static const bool gradleChanged = false;
  static const bool solverChanged = false;
  static const bool splashIconChanged = false;
  static const bool legacyFlutterCursorReintroduced = false;

  static const bool serialProductionCommandQueuePreserved = true;
  static const bool androidBridgeCommandTimeoutPreserved = true;
  static const bool mathLiveNativeCaretAuthorityPreserved = true;
  static const bool keyboardInsertionModeAddedInProductionBridge = true;
  static const bool normalKeyboardInsertionUsesStatePushBudget = true;
  static const bool keyboardInsertionSuppressesNativeInputSelectionFlood = true;
  static const bool keyboardInsertionRemovesEightyMsCommandCaretPush = true;
  static const bool pointerTapSelectionCaretPathPreserved = true;
  static const bool flutterAnalyzePassClaimedByAssistant = false;
  static const bool flutterTestPassClaimedByAssistant = false;
  static const bool realDeviceLatencyPassClaimed = false;

  static const int keyboardInsertionNativeEventSuppressionMs = 24;
  static const int keyboardInsertionCanonicalStatePushBudget = 1;
  static const int keyboardInsertionSettleStatePushBudget = 1;
}
