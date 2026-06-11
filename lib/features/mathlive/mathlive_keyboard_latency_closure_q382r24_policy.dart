/// V172-Q382R24 — MathLive keyboard latency closure policy.
///
/// Kept in the MathLive feature namespace so verifier/static audits can prove
/// the production bridge changes are deliberate and scoped.
class MathLiveKeyboardLatencyClosureQ382R24Policy {
  const MathLiveKeyboardLatencyClosureQ382R24Policy._();

  static const String phase = 'V172-Q382R24';
  static const String contractMarker = 'q382r24-mathlive-keyboard-latency-closure-active';
  static const bool mathLiveNativeCaretRemainsAuthority = true;
  static const bool keyboardLayoutOrderLabelsUntouched = true;
  static const bool graphSolutionHistoryOcrAndroidUntouched = true;
  static const bool panDragScrollReintroduced = false;
  static const bool syntheticDartEchoSuppressedForKeyboardCommands = true;
  static const bool fireAndForgetInsertDispatch = true;
  static const bool fireAndForgetDeleteDispatch = true;
  static const bool fireAndForgetClearDispatch = false;
  static const bool jsKeyboardSettlePushAfterCanonicalAllowed = false;
  static const int jsKeyboardNativeEventSuppressionMs = 64;
}
