import 'mathlive_state_adapter.dart';

/// V172-Q382R27 — Safe Optimistic Linear Echo.
///
/// This phase allows only the smallest append-only Flutter mirror for linear
/// keys after Q382R26 proves the native MathLive caret is collapsed at the
/// document end.  It does not touch template, MORE, long-press, delete, clear,
/// solve, graph, or MathLive native caret authority.
class MathLiveSafeOptimisticLinearEchoQ382R27Policy {
  const MathLiveSafeOptimisticLinearEchoQ382R27Policy._();

  static const String phase = 'V172-Q382R27';
  static const String contract = 'q382r27-safe-optimistic-linear-echo-active';
  static const String optimisticSource = 'q382r27-safe-optimistic-linear-echo';

  static const bool optimisticEchoEnabled = true;
  static const bool requiresCaretContextBridge = true;
  static const bool requiresTrustedCaretContext = true;
  static const bool appendOnly = true;
  static const bool mathLiveAuthoritativeStateWins = true;
  static const bool nativeMathLiveCaretAuthorityPreserved = true;
  static const bool templateOptimisticEchoAllowed = false;
  static const bool moreLongPressOptimisticEchoAllowed = false;
  static const bool deleteClearSolveGraphOptimisticEchoAllowed = false;
  static const bool panDragScrollReintroduced = false;
  static const bool keyboardLayoutOrderLabelsUntouched = true;

  static const Set<String> optimisticLinearLabels = <String>{
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '+',
    '−',
    '-',
    '.',
    'x',
    'y',
  };

  static bool isOptimisticLinearLabel(String label) => optimisticLinearLabels.contains(label.trim());

  static bool canApply({
    required String label,
    required MathLiveCaretContextSnapshot caretContext,
    required bool continuingOptimisticChain,
    required bool workspaceSelectionActive,
  }) {
    if (!optimisticEchoEnabled) return false;
    if (workspaceSelectionActive) return false;
    if (!isOptimisticLinearLabel(label)) return false;
    if (continuingOptimisticChain) return true;
    return caretContext.mayAllowOptimisticLinearAppend;
  }

  static String appendLabel({required String expression, required String label}) {
    final token = switch (label.trim()) {
      '−' => '-',
      '-' => '-',
      '+' => '+',
      '.' => '.',
      'x' => 'x',
      'y' => 'y',
      '0' => '0',
      '1' => '1',
      '2' => '2',
      '3' => '3',
      '4' => '4',
      '5' => '5',
      '6' => '6',
      '7' => '7',
      '8' => '8',
      '9' => '9',
      _ => '',
    };
    if (token.isEmpty) return expression;
    return '${expression.trim()}$token';
  }

  static const bool flutterAnalyzePassClaimedByAssistant = false;
  static const bool flutterTestPassClaimedByAssistant = false;
  static const bool realDeviceLatencyPassClaimed = false;
}
