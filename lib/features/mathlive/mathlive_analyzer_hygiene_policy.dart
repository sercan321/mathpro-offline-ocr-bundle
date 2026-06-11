/// V172-Q158R1 — MathLive Analyzer Hygiene Micro Repair.
///
/// Q157R1 restored the real runtime command binding after the earlier Q157
/// package-integrity miss. User-side Flutter tests passed, but `flutter analyze`
/// reported that `_lastRuntimeCommandAck` was written and never read. This policy
/// records the surgical hygiene repair: keep the ack telemetry, make it
/// observable, and do not alter keyboard layout, template mappings, Graph,
/// History, Solution, MORE, or long-press behavior.
class MathLiveAnalyzerHygienePolicy {
  const MathLiveAnalyzerHygienePolicy._();

  static const String phase = 'V172-Q158R1';
  static const bool fixesUnusedRuntimeCommandAckWarning = true;
  static const bool preservesRuntimeCommandAckTelemetry = true;
  static const bool preservesRunJavaScriptReturningResultBinding = true;
  static const bool preservesVisibleFallback = true;
  static const bool keyboardLayoutMutationAllowed = false;
  static const bool longPressOrderMutationAllowed = false;
  static const bool moreInventoryMutationAllowed = false;
  static const bool graphHistorySolutionUiMutationAllowed = false;
  static const bool cursorPassClaimed = false;
  static const bool photomathLevelClaimed = false;
}
