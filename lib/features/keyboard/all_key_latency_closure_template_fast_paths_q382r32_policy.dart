import 'package:flutter/foundation.dart';

/// V172-Q382R32 — All-key latency closure and template fast paths.
///
/// This phase does not expand optimistic echo beyond the Q382R27 linear-safe
/// set.  It closes the non-linear families through safer mechanisms:
///
/// * structural/function/MORE/long-press templates use cached payload
///   classification and the existing Q382R28 JS-side queue;
/// * template/long-press/MORE downstream sync debounce is shortened but still
///   not made immediate;
/// * delete repeat stays on its own faster cadence;
/// * clear remains priority/direct and never goes through the optimistic or
///   queued template path.
@immutable
class AllKeyLatencyClosureTemplateFastPathsQ382R32Policy {
  const AllKeyLatencyClosureTemplateFastPathsQ382R32Policy._();

  static const String phase = 'V172-Q382R32';
  static const String marker = 'q382r32-all-key-latency-closure-template-fast-paths-active';

  static const bool coversMainKeyboard = true;
  static const bool coversMoreTemplates = true;
  static const bool coversLongPressChildren = true;
  static const bool coversStructureTemplates = true;
  static const bool coversFunctionTemplates = true;
  static const bool coversDeleteCadence = true;
  static const bool preservesClearPriorityPath = true;
  static const bool optimisticEchoScopeExpanded = false;
  static const bool templateOptimisticEchoAllowed = false;
  static const bool moreLongPressOptimisticEchoAllowed = false;
  static const bool keyboardLayoutOrderLabelsUntouched = true;
  static const bool longPressListsUntouched = true;
  static const bool moreTemplateTrayInventoryUntouched = true;
  static const bool mathLiveNativeCaretAuthorityPreserved = true;
  static const bool graphSolutionHistoryOcrAndroidUntouched = true;
  static const bool panDragScrollReintroduced = false;

  static const Duration templateDownstreamSyncDebounce = Duration(milliseconds: 88);
  static const Duration longPressDownstreamSyncDebounce = Duration(milliseconds: 92);
  static const Duration moreTemplateDownstreamSyncDebounce = Duration(milliseconds: 92);
  static const Duration deleteDownstreamSyncDebounce = Duration(milliseconds: 48);
  static const int templatePayloadCacheLimit = 96;
  static const int templateQueueDrainPerTick = 8;

  static const Set<String> protectedNoOptimisticTemplateLabels = <String>{
    '□/□', '□⁄□', '√□', '∛□', '□√□', '□^□', '|□|', '‖□‖',
    'sin', 'cos', 'tan', 'cot', 'sec', 'csc', 'ln', 'log', 'lim', 'Σ', 'Π', '∫□dx', 'd/dx',
    'Taylor', 'Maclaurin', '[□ □]', '[□]', 'det(□)', '□·□', '□×□',
  };

  static bool isProtectedTemplateLabel(String label) => protectedNoOptimisticTemplateLabels.contains(label.trim());

  static bool templateFamilyUsesQueuedFastPath(String label) => isProtectedTemplateLabel(label) ||
      label.contains('□') ||
      label.contains('(□)') ||
      label.contains('log_□') ||
      label.contains('serisi');

  static const bool flutterAnalyzePassClaimedByAssistant = false;
  static const bool flutterTestPassClaimedByAssistant = false;
  static const bool realDeviceLatencyPassClaimed = false;
}
