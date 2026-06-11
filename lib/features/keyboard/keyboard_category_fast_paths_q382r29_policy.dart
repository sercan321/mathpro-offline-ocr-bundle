import 'key_config.dart';
import 'all_key_latency_closure_template_fast_paths_q382r32_policy.dart';

/// V172-Q382R29 — Key category fast paths.
///
/// Q382R23/Q382R25 made the latency problem measurable across the full key
/// inventory.  Q382R29 does not mutate keyboard layout/order/labels, MORE
/// inventory, or long-press lists.  It only centralizes the hot-path decision
/// matrix so every key family has an explicit speed path:
///
/// * linear/text keys may dispatch on tap-down when they have no long-press;
/// * structural templates, wrappers, postfixes, MORE and long-press children
///   stay release/selection driven and rely on the Q382R28 JS-side queue;
/// * clear/evaluate/MORE are never optimistic or tap-down dispatched;
/// * downstream controller sync debounce is category-aware instead of one
///   undifferentiated delay for every MathLive state push.
class KeyboardCategoryFastPathsQ382R29Policy {
  const KeyboardCategoryFastPathsQ382R29Policy._();

  static const String phase = 'V172-Q382R29';
  static const String contract = 'q382r29-key-category-fast-paths-active';

  static const bool keyboardLayoutOrderLabelsUntouched = true;
  static const bool longPressListsUntouched = true;
  static const bool moreTemplateTrayInventoryUntouched = true;
  static const bool graphSolutionHistoryOcrAndroidUntouched = true;
  static const bool optimisticEchoScopeExpanded = false;
  static const bool nativeMathLiveCaretAuthorityPreserved = true;
  static const bool panDragScrollReintroduced = false;
  static const bool q382r32AllKeyLatencyClosureActive = true;
  static const bool templateMoreLongPressFastPathsCovered = true;

  static const Duration linearDownstreamSyncDebounce = Duration(milliseconds: 72);
  static const Duration textDownstreamSyncDebounce = Duration(milliseconds: 88);
  static const Duration templateDownstreamSyncDebounce =
      AllKeyLatencyClosureTemplateFastPathsQ382R32Policy.templateDownstreamSyncDebounce;
  static const Duration longPressDownstreamSyncDebounce =
      AllKeyLatencyClosureTemplateFastPathsQ382R32Policy.longPressDownstreamSyncDebounce;
  static const Duration deleteDownstreamSyncDebounce =
      AllKeyLatencyClosureTemplateFastPathsQ382R32Policy.deleteDownstreamSyncDebounce;

  static const Set<String> optimisticLinearLabels = <String>{
    '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '+', '-', '−', '.', 'x', 'y',
  };

  static const Set<String> textTapDownLabels = <String>{
    '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
    '+', '-', '−', '.', 'x', 'y',
    'a', 'b', 'c', 'n', 'm', 'k', 'r', 'z', 'A', 'B', 'I',
    'π', 'e', 'i', 'θ', 'λ', 'μ', '(', ')', '[', ']', ',', ';',
    '×', '÷', '%', '=', '≠', '<', '>', '≤', '≥', '≈', '≡',
    '∞', '−∞', '+∞', 'dx', 'dy', 'dt', 'dθ',
  };

  static const Set<String> neverTapDownLabels = <String>{
    'MORE', '↵', 'C', '⌫', 'Ans',
    '□/□', '□⁄□', '√□', '∛□', '□√□', '□^□', '|□|', '‖□‖',
    'sin', 'cos', 'tan', 'ln', 'log', 'lim', 'Σ', 'Π', '∫□dx', 'd/dx',
    'Taylor', 'Maclaurin', '[□ □]', '[□]', 'det(□)', '□·□', '□×□',
  };

  static const Set<String> functionTemplateRoots = <String>{
    'sin', 'cos', 'tan', 'cot', 'sec', 'csc', 'ln', 'log', 'lim', 'Σ', 'Π', 'd/dx', '∫□dx',
  };

  static KeyCategoryFastPathQ382R29 categoryFor({
    required String label,
    String origin = 'mainKeyboard',
    bool hasLongPress = false,
  }) {
    final trimmed = label.trim();
    if (origin == 'moreCategory') return KeyCategoryFastPathQ382R29.moreCategory;
    if (origin == 'moreTemplate') return KeyCategoryFastPathQ382R29.moreTemplate;
    if (origin == 'longPressOption') return KeyCategoryFastPathQ382R29.longPressChild;
    if (trimmed == 'MORE') return KeyCategoryFastPathQ382R29.moreCategory;
    if (trimmed == 'C') return KeyCategoryFastPathQ382R29.clearPriority;
    if (trimmed == '⌫') return KeyCategoryFastPathQ382R29.deleteRepeat;
    if (trimmed == '↵') return KeyCategoryFastPathQ382R29.evaluateAction;
    if (trimmed == 'Ans') return KeyCategoryFastPathQ382R29.answerRecall;
    if (functionTemplateRoots.contains(trimmed) || _looksLikeFunctionTemplate(trimmed)) {
      return KeyCategoryFastPathQ382R29.functionTemplate;
    }
    if (hasLongPress || KeyConfig.longPressMap.containsKey(trimmed)) return KeyCategoryFastPathQ382R29.longPressParent;
    if (optimisticLinearLabels.contains(trimmed)) return KeyCategoryFastPathQ382R29.linearSafe;
    if (_operatorLabels.contains(trimmed)) return KeyCategoryFastPathQ382R29.operatorText;
    final behavior = KeyConfig.getKeyBehavior(trimmed);
    return switch (behavior) {
      KeyBehaviorType.structureInsert => KeyCategoryFastPathQ382R29.structureTemplate,
      KeyBehaviorType.wrapper => KeyCategoryFastPathQ382R29.wrapperTemplate,
      KeyBehaviorType.postfix => KeyCategoryFastPathQ382R29.postfixTemplate,
      KeyBehaviorType.command => KeyCategoryFastPathQ382R29.uiCommand,
      KeyBehaviorType.textInsert => KeyCategoryFastPathQ382R29.textSymbol,
    };
  }

  static bool dispatchOnTapDown({
    required String label,
    required String activeTab,
    required bool hasLongPress,
  }) {
    if (hasLongPress) return false;
    final trimmed = label.trim();
    if (neverTapDownLabels.contains(trimmed)) return false;
    final category = categoryFor(label: trimmed, hasLongPress: hasLongPress);
    return switch (category) {
      KeyCategoryFastPathQ382R29.linearSafe => true,
      KeyCategoryFastPathQ382R29.operatorText => textTapDownLabels.contains(trimmed),
      KeyCategoryFastPathQ382R29.textSymbol => textTapDownLabels.contains(trimmed),
      KeyCategoryFastPathQ382R29.structureTemplate => false,
      KeyCategoryFastPathQ382R29.wrapperTemplate => false,
      KeyCategoryFastPathQ382R29.postfixTemplate => false,
      KeyCategoryFastPathQ382R29.functionTemplate => false,
      KeyCategoryFastPathQ382R29.longPressParent => false,
      KeyCategoryFastPathQ382R29.longPressChild => false,
      KeyCategoryFastPathQ382R29.moreTemplate => false,
      KeyCategoryFastPathQ382R29.moreCategory => false,
      KeyCategoryFastPathQ382R29.deleteRepeat => false,
      KeyCategoryFastPathQ382R29.clearPriority => false,
      KeyCategoryFastPathQ382R29.evaluateAction => false,
      KeyCategoryFastPathQ382R29.answerRecall => false,
      KeyCategoryFastPathQ382R29.uiCommand => false,
    };
  }

  static bool deferDownstreamSyncForLabel(String label) {
    final trimmed = label.trim();
    if (trimmed.isEmpty) return false;
    final category = categoryFor(label: trimmed);
    return switch (category) {
      KeyCategoryFastPathQ382R29.linearSafe => true,
      KeyCategoryFastPathQ382R29.operatorText => true,
      KeyCategoryFastPathQ382R29.textSymbol => true,
      KeyCategoryFastPathQ382R29.structureTemplate => true,
      KeyCategoryFastPathQ382R29.wrapperTemplate => true,
      KeyCategoryFastPathQ382R29.postfixTemplate => true,
      KeyCategoryFastPathQ382R29.functionTemplate => true,
      KeyCategoryFastPathQ382R29.longPressChild => true,
      KeyCategoryFastPathQ382R29.moreTemplate => true,
      KeyCategoryFastPathQ382R29.deleteRepeat => true,
      KeyCategoryFastPathQ382R29.answerRecall => true,
      KeyCategoryFastPathQ382R29.longPressParent => false,
      KeyCategoryFastPathQ382R29.moreCategory => false,
      KeyCategoryFastPathQ382R29.clearPriority => false,
      KeyCategoryFastPathQ382R29.evaluateAction => false,
      KeyCategoryFastPathQ382R29.uiCommand => false,
    };
  }

  static Duration downstreamSyncDebounceForLabel(String label) {
    final category = categoryFor(label: label.trim());
    return switch (category) {
      KeyCategoryFastPathQ382R29.linearSafe => linearDownstreamSyncDebounce,
      KeyCategoryFastPathQ382R29.operatorText => linearDownstreamSyncDebounce,
      KeyCategoryFastPathQ382R29.textSymbol => textDownstreamSyncDebounce,
      KeyCategoryFastPathQ382R29.structureTemplate => templateDownstreamSyncDebounce,
      KeyCategoryFastPathQ382R29.wrapperTemplate => templateDownstreamSyncDebounce,
      KeyCategoryFastPathQ382R29.postfixTemplate => templateDownstreamSyncDebounce,
      KeyCategoryFastPathQ382R29.functionTemplate => templateDownstreamSyncDebounce,
      KeyCategoryFastPathQ382R29.longPressChild => longPressDownstreamSyncDebounce,
      KeyCategoryFastPathQ382R29.moreTemplate =>
          AllKeyLatencyClosureTemplateFastPathsQ382R32Policy.moreTemplateDownstreamSyncDebounce,
      KeyCategoryFastPathQ382R29.deleteRepeat => deleteDownstreamSyncDebounce,
      _ => Duration.zero,
    };
  }

  static bool usesJsSideQueue({required String label, required String action}) {
    if (action == 'clear') return false;
    if (action == 'insertLatex' || action == 'deleteBackward') return true;
    return false;
  }

  static bool mayUseOptimisticEcho(String label) =>
      optimisticLinearLabels.contains(label.trim()) &&
      !AllKeyLatencyClosureTemplateFastPathsQ382R32Policy.isProtectedTemplateLabel(label);

  static bool _looksLikeFunctionTemplate(String label) {
    return label.contains('(□)') || label.contains('log_□') || label.startsWith('lim ') || label.contains('serisi');
  }

  static const Set<String> _operatorLabels = <String>{
    '+', '-', '−', '×', '÷', '%', '=', '≠', '<', '>', '≤', '≥', '≈', '≡',
  };

  static const bool flutterAnalyzePassClaimedByAssistant = false;
  static const bool flutterTestPassClaimedByAssistant = false;
  static const bool realDeviceLatencyPassClaimed = false;
}

enum KeyCategoryFastPathQ382R29 {
  linearSafe,
  operatorText,
  textSymbol,
  structureTemplate,
  wrapperTemplate,
  postfixTemplate,
  functionTemplate,
  longPressParent,
  longPressChild,
  moreTemplate,
  moreCategory,
  deleteRepeat,
  clearPriority,
  evaluateAction,
  answerRecall,
  uiCommand,
}
