import 'package:flutter/foundation.dart';

@immutable
class CalculatorState {
  const CalculatorState({
    this.expression = const <String>[],
    this.result = '0',
    this.lastAnswer = '0',
    this.templateTrayOpen = false,
    this.lastEvaluatedExpression,
    this.lastUnsupportedReason,
    this.activeSlotId,
    this.activeSlotRole,
    this.caretIndex = 0,
    this.lastHitSource = 'none',
    this.linearCaretIndex,
    this.clipboard = '',
    this.undoStack = const <List<String>>[],
    this.redoStack = const <List<String>>[],
  });

  final List<String> expression;
  final String result;
  final String lastAnswer;
  final bool templateTrayOpen;
  final String? lastEvaluatedExpression;
  final String? lastUnsupportedReason;
  final String? activeSlotId;
  final String? activeSlotRole;
  final int caretIndex;
  final String lastHitSource;
  final int? linearCaretIndex;
  final String clipboard;
  final List<List<String>> undoStack;
  final List<List<String>> redoStack;

  String get expressionText => expression.join();
  bool get hasExpression => expression.isNotEmpty;
  bool get hasActiveSlot => activeSlotId != null;
  bool get hasLinearCaret => linearCaretIndex != null;
  bool get hasClipboard => clipboard.trim().isNotEmpty;
  bool get hasUndo => undoStack.isNotEmpty;
  bool get hasRedo => redoStack.isNotEmpty;
  String? get resultStatusMessage => lastUnsupportedReason;
  bool get hasResultStatusMessage => (resultStatusMessage ?? '').trim().isNotEmpty;

  CalculatorState copyWith({
    List<String>? expression,
    String? result,
    String? lastAnswer,
    bool? templateTrayOpen,
    String? lastEvaluatedExpression,
    String? lastUnsupportedReason,
    String? activeSlotId,
    String? activeSlotRole,
    int? caretIndex,
    String? lastHitSource,
    int? linearCaretIndex,
    String? clipboard,
    List<List<String>>? undoStack,
    List<List<String>>? redoStack,
    bool clearLastEvaluatedExpression = false,
    bool clearUnsupportedReason = false,
    bool clearActiveSlot = false,
    bool clearLinearCaret = false,
  }) {
    return CalculatorState(
      expression: expression ?? this.expression,
      result: result ?? this.result,
      lastAnswer: lastAnswer ?? this.lastAnswer,
      templateTrayOpen: templateTrayOpen ?? this.templateTrayOpen,
      lastEvaluatedExpression: clearLastEvaluatedExpression ? null : lastEvaluatedExpression ?? this.lastEvaluatedExpression,
      lastUnsupportedReason: clearUnsupportedReason ? null : lastUnsupportedReason ?? this.lastUnsupportedReason,
      activeSlotId: clearActiveSlot ? null : activeSlotId ?? this.activeSlotId,
      activeSlotRole: clearActiveSlot ? null : activeSlotRole ?? this.activeSlotRole,
      caretIndex: caretIndex ?? this.caretIndex,
      lastHitSource: lastHitSource ?? this.lastHitSource,
      linearCaretIndex: clearLinearCaret ? null : linearCaretIndex ?? this.linearCaretIndex,
      clipboard: clipboard ?? this.clipboard,
      undoStack: undoStack ?? this.undoStack,
      redoStack: redoStack ?? this.redoStack,
    );
  }

  static const CalculatorState initial = CalculatorState();
}
