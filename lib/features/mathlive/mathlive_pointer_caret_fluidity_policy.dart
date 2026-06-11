/// V172-Q143 — MathLive Pointer/Caret Fluidity policy.
///
/// This phase targets the real-device complaint that MathLive can accept one
/// caret placement and then stop responding to later taps. It keeps the
/// official MathLive math-field as the only caret owner, primes Android WebView
/// focus before touch/click handling, eagerly routes Flutter gestures into the
/// WebView, and synchronizes selection state after MathLive settles. It does
/// not mutate the protected MathPro keyboard, MORE, long-press, Graph, History,
/// or Solution contracts and it does not claim a real-device cursor PASS.
class MathLivePointerCaretFluidityPolicy {
  const MathLivePointerCaretFluidityPolicy._();

  static const String phase = 'V172-Q143';
  static const bool realBehaviorRepair = true;
  static const bool webViewUsesEagerGestureRecognizer = true;
  static const bool pointerDownPrimesMathfieldFocus = true;
  static const bool pointerSelectionStillOwnedByMathLive = true;
  static const bool selectionStateSyncAfterTapSettles = true;
  static const bool blurRecoveryIsScoped = true;
  static const bool keyboardCommandPrimesPointerSurface = true;
  static const bool mathfieldTabIndexAndDefaultModeSet = true;
  static const bool mathfieldTouchActionIsAuto = true;
  static const bool keyboardLayoutMutationAllowed = false;
  static const bool longPressMutationAllowed = false;
  static const bool moreMutationAllowed = false;
  static const bool graphHistorySolutionUiMutationAllowed = false;
  static const bool cursorPassClaimed = false;
  static const bool photomathLevelClaimed = false;
  static const bool flutterAnalyzePassClaimedByAssistant = false;
  static const bool flutterTestPassClaimedByAssistant = false;
  static const bool flutterRunPassClaimedByAssistant = false;
}
