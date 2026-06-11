/// V172-Q382R28 — JS-side command queue.
///
/// Moves the hot insert/delete ordering responsibility into the production
/// MathLive bridge so Dart does not serialize every key through a Future tail.
/// This is deliberately not an optimistic echo expansion and does not touch
/// keyboard layout, MORE, long-press, template inventory, Graph, Solution,
/// History, OCR, Android, or native MathLive caret ownership.
class MathLiveJsSideCommandQueueQ382R28Policy {
  const MathLiveJsSideCommandQueueQ382R28Policy._();

  static const String phase = 'V172-Q382R28';
  static const String contract = 'q382r28-js-side-command-queue-active';

  static const bool enabled = true;
  static const bool useJsSideQueueForInsertLatex = true;
  static const bool useJsSideQueueForDeleteBackward = true;
  static const bool useJsSideQueueForClear = false;
  static const bool dartProductionCommandTailPreservedForPriorityPaths = true;
  static const bool mathLiveNativeCaretAuthorityPreserved = true;
  static const bool optimisticEchoScopeExpanded = false;
  static const bool keyboardLayoutOrderLabelsUntouched = true;
  static const bool moreTemplateTrayUntouched = true;
  static const bool longPressListsUntouched = true;
  static const bool graphSolutionHistoryOcrAndroidUntouched = true;
  static const bool panDragScrollReintroduced = false;

  static bool shouldUseJsSideQueueForAction(String action) {
    if (!enabled) return false;
    return switch (action) {
      'insertLatex' => useJsSideQueueForInsertLatex,
      'deleteBackward' => useJsSideQueueForDeleteBackward,
      'clear' => useJsSideQueueForClear,
      _ => false,
    };
  }

  static const bool flutterAnalyzePassClaimedByAssistant = false;
  static const bool flutterTestPassClaimedByAssistant = false;
  static const bool realDeviceLatencyPassClaimed = false;
}
