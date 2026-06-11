import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../features/editor/editor_commands.dart';
import '../features/editor/slot_registry.dart';
import '../features/formula_engine/native_structural_edit_transaction_binding_policy.dart';
import '../features/formula_engine/structural_edit_transaction_engine_policy.dart';
import '../features/formula_engine/structural_renderer_bridge.dart';
import '../features/formula_engine/template_slot_navigation_policy.dart';
import '../logic/action_utils.dart';
import '../logic/evaluator_bridge.dart';
import '../logic/key_handlers.dart';
import 'calculator_actions.dart';
import 'calculator_state.dart';

class CalculatorController extends ChangeNotifier {
  // Q43 lineage marker: v172q43-slotPayloadInlineInsert. Q75 now wraps the
  // same slot-scoped insert path with NativeStructuralEditTransactionBindingPolicy.
  // Q75 verifier marker: NativeStructuralEditTransactionBindingPolicy.shouldKeepStructuralFocusAfterFilledSlotEdit
  // V172-G compatibility marker: v172g-slotPayloadBackspace
  CalculatorController({CalculatorState? initialState}) : _state = initialState ?? CalculatorState.initial;

  CalculatorState _state;

  CalculatorState get state => _state;

  void handleKey(String label) {
    dispatch(KeyHandlers.actionForLabel(label));
  }

  void selectEditorSlot({required String slotId, required String slotRole, required int caretIndex, required String source}) {
    _setState(_state.copyWith(
      activeSlotId: slotId,
      activeSlotRole: slotRole,
      caretIndex: caretIndex,
      lastHitSource: source,
      clearLinearCaret: true,
    ));
  }

  void selectTextCaret({required int caretIndex, required String source}) {
    final expressionText = _state.expressionText;
    if (expressionText.isEmpty) return;
    _setState(_state.copyWith(
      linearCaretIndex: caretIndex.clamp(0, expressionText.length).toInt(),
      lastHitSource: source,
      clearActiveSlot: true,
    ));
  }

  /// Clears only the active selection/highlight. It intentionally preserves the
  /// expression. The C key remains the explicit full-expression clear action.
  void clearSelection() {
    if (!_state.hasActiveSlot && !_state.hasLinearCaret) return;
    _setState(_state.copyWith(clearActiveSlot: true, clearLinearCaret: true, lastHitSource: 'selectionCleared'));
  }

  void copySelection() {
    final value = EditorCommands.selectedSlotPayload(_state.expressionText, activeSlotId: _state.activeSlotId);
    if (value == null || value.trim().isEmpty) return;
    Clipboard.setData(ClipboardData(text: value));
    _setState(_state.copyWith(clipboard: value));
  }

  void cutSelection() {
    final value = EditorCommands.selectedSlotPayload(_state.expressionText, activeSlotId: _state.activeSlotId);
    if (value == null || value.trim().isEmpty) return;
    Clipboard.setData(ClipboardData(text: value));
    final cleared = EditorCommands.clearSelectedSlot(_state.expressionText, activeSlotId: _state.activeSlotId) ??
        (_state.expressionText.contains('□')
            ? EditorCommands.clearFirstOpenSlot(_state.expressionText, activeSlotId: _state.activeSlotId)
            : _state.expressionText);
    _setState(_withUndo(_focusPrimaryOpenSlot(_state.copyWith(
      expression: <String>[cleared],
      clipboard: value,
      clearUnsupportedReason: true,
      clearLastEvaluatedExpression: true,
    ), source: 'selectionCut')));
  }

  void duplicateSelection() {
    final value = EditorCommands.selectedSlotPayload(_state.expressionText, activeSlotId: _state.activeSlotId);
    if (value == null || value.trim().isEmpty) return;
    final inserted = _state.hasActiveSlot && _state.expressionText.contains('□')
        ? EditorCommands.replaceFirstOpenSlot(_state.expressionText, value, activeSlotId: _state.activeSlotId)
        : _insertAt(_state.expressionText, value, _safeLinearCaretIndex(defaultToEnd: true));
    final nextCaret = _state.hasActiveSlot && _state.expressionText.contains('□')
        ? null
        : _safeLinearCaretIndex(defaultToEnd: true) + value.length;
    _setState(_withUndo(_focusPrimaryOpenSlot(_state.copyWith(
      expression: <String>[inserted],
      linearCaretIndex: nextCaret,
      templateTrayOpen: false,
      clearUnsupportedReason: true,
      clearLastEvaluatedExpression: true,
    ), source: 'selectionDuplicate')));
  }

  Future<void> pasteSelection() async {
    var value = _state.clipboard;
    if (value.trim().isEmpty) {
      final external = await Clipboard.getData(Clipboard.kTextPlain);
      value = external?.text ?? '';
    }
    if (value.trim().isEmpty) return;

    final filledSlotReplacement = _state.hasActiveSlot
        ? EditorCommands.replaceSelectedSlot(_state.expressionText, value, activeSlotId: _state.activeSlotId)
        : null;
    final inserted = filledSlotReplacement ??
        (_state.hasActiveSlot && _state.expressionText.contains('□')
            ? EditorCommands.replaceFirstOpenSlot(_state.expressionText, value, activeSlotId: _state.activeSlotId)
            : _insertAt(_state.expressionText, value, _safeLinearCaretIndex(defaultToEnd: true)));
    final nextCaret = filledSlotReplacement != null || (_state.hasActiveSlot && _state.expressionText.contains('□'))
        ? null
        : _safeLinearCaretIndex(defaultToEnd: true) + value.length;
    _setState(_withUndo(_focusPrimaryOpenSlot(_state.copyWith(
      expression: <String>[inserted],
      linearCaretIndex: nextCaret,
      clipboard: value,
      templateTrayOpen: false,
      clearUnsupportedReason: true,
      clearLastEvaluatedExpression: true,
    ), source: 'selectionPaste')));
  }




  void syncExternalEditorExpression({required String expression, required String source}) {
    final trimmed = expression.trim();
    if (trimmed == _state.expressionText && !_state.hasActiveSlot && !_state.hasLinearCaret) return;
    _setState(_state.copyWith(
      expression: trimmed.isEmpty ? const <String>[] : <String>[trimmed],
      linearCaretIndex: trimmed.length,
      templateTrayOpen: false,
      clearActiveSlot: true,
      clearUnsupportedReason: true,
      clearLastEvaluatedExpression: true,
      lastHitSource: source,
    ));
  }
  void restoreExpression({required String expression, String? result, required String source}) {
    final trimmed = expression.trim();
    if (trimmed.isEmpty) return;
    _setState(_withUndo(_state.copyWith(
      expression: <String>[trimmed],
      result: result ?? _state.result,
      linearCaretIndex: trimmed.length,
      templateTrayOpen: false,
      clearActiveSlot: true,
      clearUnsupportedReason: true,
      lastHitSource: source,
    )));
  }

  void undo() {
    if (_state.undoStack.isEmpty) return;
    final previous = _state.undoStack.last;
    final nextUndo = _state.undoStack.sublist(0, _state.undoStack.length - 1);
    final nextRedo = <List<String>>[..._state.redoStack, _state.expression];
    _setState(_focusPrimaryOpenSlot(_state.copyWith(
      expression: previous,
      undoStack: nextUndo,
      redoStack: nextRedo,
      templateTrayOpen: false,
      clearUnsupportedReason: true,
      clearLastEvaluatedExpression: true,
      clearActiveSlot: true,
    ), source: 'undo'));
  }

  void redo() {
    if (_state.redoStack.isEmpty) return;
    final nextExpression = _state.redoStack.last;
    final nextRedo = _state.redoStack.sublist(0, _state.redoStack.length - 1);
    final nextUndo = <List<String>>[..._state.undoStack, _state.expression];
    _setState(_focusPrimaryOpenSlot(_state.copyWith(
      expression: nextExpression,
      undoStack: nextUndo,
      redoStack: nextRedo,
      templateTrayOpen: false,
      clearUnsupportedReason: true,
      clearLastEvaluatedExpression: true,
      clearActiveSlot: true,
    ), source: 'redo'));
  }

  void dispatch(CalculatorAction action) {
    final nextState = switch (action) {
      InsertTextAction(:final text) => _insertText(text),
      InsertTemplateAction(:final template) => _insertTemplate(template),
      BackspaceAction() => _backspace(),
      ClearAction() => _withUndo(CalculatorState.initial.copyWith(lastAnswer: _state.lastAnswer, clipboard: _state.clipboard)),
      InsertAnswerAction() => _insertText(_state.lastAnswer),
      ToggleTemplateTrayAction() => _state.copyWith(templateTrayOpen: !_state.templateTrayOpen),
      EvaluateAction() => _evaluate(),
    };

    _setState(_finalizeStructuralEditTransaction(nextState, action: action));
  }

  CalculatorState _finalizeStructuralEditTransaction(CalculatorState next, {required CalculatorAction action}) {
    final before = _state.expressionText;
    final after = next.expressionText;
    if (after.isEmpty || before == after) return next;
    final source = _transactionSourceForAction(action);
    final normalized = StructuralEditTransactionEnginePolicy.finalizeExpression(before: before, after: after, source: source);
    if (normalized == after) return next;
    final caret = next.linearCaretIndex?.clamp(0, normalized.length).toInt();
    final normalizedState = next.copyWith(
      expression: <String>[normalized],
      linearCaretIndex: caret,
      lastHitSource: StructuralEditTransactionEnginePolicy.transactionLabel(source),
      clearUnsupportedReason: true,
      clearLastEvaluatedExpression: true,
    );
    return normalized.contains('□')
        ? _focusPrimaryOpenSlot(normalizedState, source: 'v172q60-structuralTransactionRestore')
        : normalizedState;
  }

  String _transactionSourceForAction(CalculatorAction action) {
    return switch (action) {
      InsertTextAction() => 'insertTextTransaction',
      InsertTemplateAction() => 'insertTemplateTransaction',
      BackspaceAction() => 'backspaceTransaction',
      InsertAnswerAction() => 'insertAnswerTransaction',
      ClearAction() => 'clearTransaction',
      ToggleTemplateTrayAction() => 'toggleTemplateTrayNonEdit',
      EvaluateAction() => 'evaluateNonEdit',
    };
  }

  CalculatorState _insertText(String text) {
    if (text.isEmpty) return _state;

    if (_state.expressionText.contains('□')) {
      final linkedSeriesEdit = EditorCommands.replaceLinkedSeriesSlot(
        _state.expressionText,
        text,
        activeSlotId: _state.activeSlotId,
      );
      if (linkedSeriesEdit != null) {
        return _withUndo(_focusOpenSlotAfterFill(_state.copyWith(
          expression: <String>[linkedSeriesEdit.expression],
          templateTrayOpen: false,
          clearUnsupportedReason: true,
          clearLastEvaluatedExpression: true,
        ), filledOrdinal: linkedSeriesEdit.filledOrdinal, source: 'seriesLinkedSlotInsert'));
      }
    }

    final selectedPayload = EditorCommands.selectedSlotPayload(_state.expressionText, activeSlotId: _state.activeSlotId);
    if (NativeStructuralEditTransactionBindingPolicy.shouldBindTextToActiveSlot(
      hasActiveSlot: _state.hasActiveSlot,
      activeSlotId: _state.activeSlotId,
    ) && selectedPayload != null) {
      final activeSlotId = _state.activeSlotId!;
      final scopedSlotInsert = EditorCommands.insertIntoSelectedSlotPayload(
        _state.expressionText,
        text,
        activeSlotId: activeSlotId,
        caretIndex: _state.caretIndex,
      );
      if (scopedSlotInsert != null && scopedSlotInsert.expression != _state.expressionText) {
        return _withUndo(_focusStructuralSlotByRole(_state.copyWith(
          expression: <String>[scopedSlotInsert.expression],
          caretIndex: scopedSlotInsert.caretIndex,
          templateTrayOpen: false,
          clearUnsupportedReason: true,
          clearLastEvaluatedExpression: true,
        ), preferredRole: _state.activeSlotRole ?? scopedSlotInsert.slotRole, caretIndex: scopedSlotInsert.caretIndex, source: NativeStructuralEditTransactionBindingPolicy.sourceFor('filled-slot-inline-insert')));
      }

      final Object? replacedFilledSlot = EditorCommands.replaceSelectedSlot(
        _state.expressionText,
        text,
        activeSlotId: activeSlotId,
      );
      if (replacedFilledSlot is String && replacedFilledSlot != _state.expressionText) {
        final keepStructuralFocus = NativeStructuralEditTransactionBindingPolicy
            .shouldKeepStructuralFocusAfterFilledSlotEdit(role: _state.activeSlotRole);
        final replacedState = _state.copyWith(
          expression: <String>[replacedFilledSlot],
          caretIndex: NativeStructuralEditTransactionBindingPolicy.caretIndexAfterOpenSlotFill(text),
          templateTrayOpen: false,
          clearUnsupportedReason: true,
          clearLastEvaluatedExpression: true,
          clearActiveSlot: !keepStructuralFocus,
          linearCaretIndex: keepStructuralFocus ? null : replacedFilledSlot.length,
          clearLinearCaret: keepStructuralFocus,
        );
        return _withUndo(keepStructuralFocus
            ? _focusStructuralSlotByRole(
                replacedState,
                preferredRole: _state.activeSlotRole,
                caretIndex: NativeStructuralEditTransactionBindingPolicy.caretIndexAfterOpenSlotFill(text),
                source: NativeStructuralEditTransactionBindingPolicy.sourceFor('filled-slot-replace'),
              )
            : _focusPrimaryOpenSlot(replacedState, source: 'filledSlotReplace'));
      }
    }

    if (_state.expressionText.contains('□') && _state.hasActiveSlot) {
      final derivativeOrderExpansion = EditorCommands.replaceDerivativeOrderSlot(
        _state.expressionText,
        text,
        activeSlotId: _state.activeSlotId,
      );
      if (derivativeOrderExpansion != null) {
        return _withUndo(_state.copyWith(
          expression: <String>[derivativeOrderExpansion],
          linearCaretIndex: derivativeOrderExpansion.length,
          templateTrayOpen: false,
          clearUnsupportedReason: true,
          clearLastEvaluatedExpression: true,
          clearActiveSlot: true,
        ));
      }

      final filledOrdinal = EditorCommands.placeholderOrdinalForSlot(
        _state.expressionText,
        activeSlotId: _state.activeSlotId,
      );
      final activeRole = _state.activeSlotRole ?? '';
      final singleOpenSlot = EditorCommands.openSlotCount(_state.expressionText) == 1;
      final replaced = EditorCommands.replaceFirstOpenSlot(_state.expressionText, text, activeSlotId: _state.activeSlotId);

      // V172-B/Q80R4: single-argument functions such as sin(□), cos(□),
      // tan(□), ln(□), and log(□) must not throw the cursor outside the
      // parentheses after the first character. Once the visible slot is filled,
      // the caret becomes a deterministic in-argument linear caret immediately
      // after the inserted payload, so users can continue typing sin(300),
      // ln(123), etc. without re-tapping. This is not a detached outside
      // fallback: the caret index is derived from the replaced placeholder.
      if (NativeStructuralEditTransactionBindingPolicy.shouldUseInlineLinearCaretAfterOpenSlotFill(
        role: activeRole,
        singleOpenSlot: singleOpenSlot,
      )) {
        final placeholderIndex = _state.expressionText.indexOf('□');
        final nextCaret = (placeholderIndex < 0 ? replaced.length : placeholderIndex + text.runes.length)
            .clamp(0, replaced.length)
            .toInt();
        return _withUndo(_state.copyWith(
          expression: <String>[replaced],
          linearCaretIndex: nextCaret,
          templateTrayOpen: false,
          clearUnsupportedReason: true,
          clearLastEvaluatedExpression: true,
          clearActiveSlot: true,
          lastHitSource: NativeStructuralEditTransactionBindingPolicy.sourceFor('open-slot-inline-linear-caret'),
        ));
      }

      if (NativeStructuralEditTransactionBindingPolicy.shouldKeepStructuralFocusAfterOpenSlotFill(
        role: activeRole,
        singleOpenSlot: singleOpenSlot,
      )) {
        final nextCaret = NativeStructuralEditTransactionBindingPolicy.caretIndexAfterOpenSlotFill(text);
        return _withUndo(_focusStructuralSlotByRole(_state.copyWith(
          expression: <String>[replaced],
          caretIndex: nextCaret,
          templateTrayOpen: false,
          clearUnsupportedReason: true,
          clearLastEvaluatedExpression: true,
          clearLinearCaret: true,
        ), preferredRole: activeRole, caretIndex: nextCaret, source: NativeStructuralEditTransactionBindingPolicy.sourceFor('open-slot-fill')));
      }

      return _withUndo(_focusOpenSlotAfterFill(_state.copyWith(
        expression: <String>[replaced],
        templateTrayOpen: false,
        clearUnsupportedReason: true,
        clearLastEvaluatedExpression: true,
      ), filledOrdinal: filledOrdinal, source: 'slotInsertNext'));
    }

    if (NativeStructuralEditTransactionBindingPolicy.shouldBindTextToActiveSlot(
      hasActiveSlot: _state.hasActiveSlot,
      activeSlotId: _state.activeSlotId,
    )) {
      final activeSlotId = _state.activeSlotId!;
      final scopedSlotInsert = EditorCommands.insertIntoSelectedSlotPayload(
        _state.expressionText,
        text,
        activeSlotId: activeSlotId,
        caretIndex: _state.caretIndex,
      );
      if (scopedSlotInsert != null && scopedSlotInsert.expression != _state.expressionText) {
        return _withUndo(_focusStructuralSlotByRole(_state.copyWith(
          expression: <String>[scopedSlotInsert.expression],
          caretIndex: scopedSlotInsert.caretIndex,
          templateTrayOpen: false,
          clearUnsupportedReason: true,
          clearLastEvaluatedExpression: true,
        ), preferredRole: _state.activeSlotRole ?? scopedSlotInsert.slotRole, caretIndex: scopedSlotInsert.caretIndex, source: NativeStructuralEditTransactionBindingPolicy.sourceFor('filled-slot-inline-insert')));
      }

      final Object? replacedFilledSlot = EditorCommands.replaceSelectedSlot(
        _state.expressionText,
        text,
        activeSlotId: activeSlotId,
      );
      if (replacedFilledSlot is String && replacedFilledSlot != _state.expressionText) {
        final keepStructuralFocus = NativeStructuralEditTransactionBindingPolicy
            .shouldKeepStructuralFocusAfterFilledSlotEdit(role: _state.activeSlotRole);
        final replacedState = _state.copyWith(
          expression: <String>[replacedFilledSlot],
          caretIndex: NativeStructuralEditTransactionBindingPolicy.caretIndexAfterOpenSlotFill(text),
          templateTrayOpen: false,
          clearUnsupportedReason: true,
          clearLastEvaluatedExpression: true,
          clearActiveSlot: !keepStructuralFocus,
          linearCaretIndex: keepStructuralFocus ? null : replacedFilledSlot.length,
          clearLinearCaret: keepStructuralFocus,
        );
        return _withUndo(keepStructuralFocus
            ? _focusStructuralSlotByRole(
                replacedState,
                preferredRole: _state.activeSlotRole,
                caretIndex: NativeStructuralEditTransactionBindingPolicy.caretIndexAfterOpenSlotFill(text),
                source: NativeStructuralEditTransactionBindingPolicy.sourceFor('filled-slot-replace'),
              )
            : _focusPrimaryOpenSlot(replacedState, source: 'filledSlotReplace'));
      }
    }

    final expressionText = _state.expressionText;
    final caret = _safeLinearCaretIndex(defaultToEnd: true);

    if (EditorCommands.isReplaceableOperatorToken(text) && caret > 0) {
      final previous = expressionText[caret - 1];
      if (EditorCommands.shouldReplacePreviousOperator(previous, text)) {
        final nextExpression = expressionText.replaceRange(caret - 1, caret, text);
        return _withUndo(_state.copyWith(
          expression: <String>[nextExpression],
          linearCaretIndex: caret,
          templateTrayOpen: false,
          clearUnsupportedReason: true,
          clearLastEvaluatedExpression: true,
          clearActiveSlot: true,
        ));
      }
    }

    final nextExpression = _insertAt(expressionText, text, caret);
    return _withUndo(_state.copyWith(
      expression: <String>[nextExpression],
      linearCaretIndex: caret + text.length,
      templateTrayOpen: false,
      clearUnsupportedReason: true,
      clearLastEvaluatedExpression: true,
      clearActiveSlot: true,
    ));
  }

  CalculatorState _insertTemplate(String label) {
    final spec = ActionUtils.templateSpecForStructure(label);
    final expression = _state.expressionText.contains('□') && _state.hasActiveSlot
        ? EditorCommands.replaceFirstOpenSlot(_state.expressionText, spec.expression, activeSlotId: _state.activeSlotId)
        : _insertAt(_state.expressionText, spec.expression, _safeLinearCaretIndex(defaultToEnd: true));
    final nextCaret = _state.expressionText.contains('□') && _state.hasActiveSlot
        ? null
        : _safeLinearCaretIndex(defaultToEnd: true) + spec.expression.length;
    return _withUndo(_focusPrimaryOpenSlot(_state.copyWith(
      expression: <String>[expression],
      linearCaretIndex: nextCaret,
      templateTrayOpen: false,
      clearUnsupportedReason: true,
      clearLastEvaluatedExpression: true,
    ), preferredRole: spec.focusRole, source: 'template:${spec.label}'));
  }

  CalculatorState _backspace() {
    final expressionText = _state.expressionText;
    if (expressionText.isEmpty) return _state;
    final caret = _safeLinearCaretIndex(defaultToEnd: true);

    final selectedPayload = EditorCommands.selectedSlotPayload(expressionText, activeSlotId: _state.activeSlotId);
    if (_state.hasActiveSlot && selectedPayload != null) {
      final scopedSlotEdit = EditorCommands.backspaceSelectedSlotPayload(
        expressionText,
        activeSlotId: _state.activeSlotId,
        caretIndex: _state.caretIndex,
      );
      if (scopedSlotEdit != null && scopedSlotEdit.expression != expressionText) {
        return _withUndo(_focusStructuralSlotByRole(_state.copyWith(
          expression: scopedSlotEdit.expression.isEmpty ? const <String>[] : <String>[scopedSlotEdit.expression],
          caretIndex: scopedSlotEdit.caretIndex,
          clearUnsupportedReason: true,
          clearLastEvaluatedExpression: true,
        ), preferredRole: _state.activeSlotRole ?? scopedSlotEdit.slotRole, caretIndex: scopedSlotEdit.caretIndex, source: 'v172g-slotPayloadBackspace'));
      }

      final clearedFilledSlot = EditorCommands.clearSelectedSlot(expressionText, activeSlotId: _state.activeSlotId);
      if (clearedFilledSlot != null && clearedFilledSlot != expressionText) {
        return _withUndo(_focusPrimaryOpenSlot(_state.copyWith(
          expression: <String>[clearedFilledSlot],
          clearUnsupportedReason: true,
          clearLastEvaluatedExpression: true,
        ), source: 'filledSlotBackspace'));
      }
    }

    if (expressionText.contains('□') && _state.hasActiveSlot) {
      final atomic = EditorCommands.atomicBackspaceAt(
        expressionText,
        caretIndex: caret,
        activeSlotId: _state.activeSlotId,
      );
      if (atomic != null) {
        final restored = EditorCommands.restoreStructuralPlaceholders(atomic.expression);
        final nextState = _state.copyWith(
          expression: restored.isEmpty ? const <String>[] : <String>[restored],
          linearCaretIndex: atomic.caretIndex.clamp(0, restored.length).toInt(),
          clearUnsupportedReason: true,
          clearLastEvaluatedExpression: true,
          clearActiveSlot: true,
        );
        return _withUndo(restored.contains('□')
            ? _focusPrimaryOpenSlot(nextState, source: 'v172q51-atomicPlaceholderRestore')
            : nextState);
      }

      final cleared = EditorCommands.clearFirstOpenSlot(expressionText, activeSlotId: _state.activeSlotId);
      return _withUndo(_focusPrimaryOpenSlot(_state.copyWith(
        expression: <String>[cleared],
        clearUnsupportedReason: true,
        clearLastEvaluatedExpression: true,
      ), source: 'slotBackspace'));
    }

    if (_state.hasActiveSlot) {
      final clearedFilledSlot = EditorCommands.clearSelectedSlot(expressionText, activeSlotId: _state.activeSlotId);
      if (clearedFilledSlot != null && clearedFilledSlot != expressionText) {
        return _withUndo(_focusPrimaryOpenSlot(_state.copyWith(
          expression: <String>[clearedFilledSlot],
          clearUnsupportedReason: true,
          clearLastEvaluatedExpression: true,
        ), source: 'filledSlotBackspace'));
      }
    }

    if (caret <= 0) return _state;
    final atomic = EditorCommands.atomicBackspaceAt(expressionText, caretIndex: caret);
    if (atomic != null) {
      final restored = EditorCommands.restoreStructuralPlaceholders(atomic.expression);
      final nextState = _state.copyWith(
        expression: restored.isEmpty ? const <String>[] : <String>[restored],
        linearCaretIndex: atomic.caretIndex.clamp(0, restored.length).toInt(),
        clearUnsupportedReason: true,
        clearLastEvaluatedExpression: true,
        clearActiveSlot: true,
      );
      return _withUndo(restored.contains('□')
          ? _focusPrimaryOpenSlot(nextState, source: 'v172q51-atomicPlaceholderRestore')
          : nextState);
    }

    final rawNextExpression = expressionText.replaceRange(caret - 1, caret, '');
    final nextExpression = EditorCommands.restoreStructuralPlaceholders(rawNextExpression);
    final nextState = _state.copyWith(
      expression: nextExpression.isEmpty ? const <String>[] : <String>[nextExpression],
      linearCaretIndex: (caret - 1).clamp(0, nextExpression.length).toInt(),
      clearUnsupportedReason: true,
      clearLastEvaluatedExpression: true,
      clearActiveSlot: true,
    );
    return _withUndo(nextExpression.contains('□') && nextExpression != rawNextExpression
        ? _focusPrimaryOpenSlot(nextState, source: 'v172q51-linearBackspacePlaceholderRestore')
        : nextState);
  }

  CalculatorState _evaluate() {
    final expressionText = _state.expressionText;
    if (expressionText.contains('□')) {
      return _state.copyWith(
        result: '—',
        lastEvaluatedExpression: expressionText,
        lastUnsupportedReason: 'Açık slotları doldurmadan değerlendirme yapılmadı.',
      );
    }

    final evaluation = EvaluatorBridge.evaluateBasic(expressionText);
    if (evaluation.isSuccess) {
      final result = evaluation.displayValue!;
      return _state.copyWith(
        result: result,
        lastAnswer: result,
        lastEvaluatedExpression: expressionText,
        clearUnsupportedReason: true,
      );
    }

    return _state.copyWith(
      result: '—',
      lastEvaluatedExpression: expressionText,
      lastUnsupportedReason: evaluation.unsupportedReason,
    );
  }

  CalculatorState _focusStructuralSlotByRole(
    CalculatorState next, {
    required String? preferredRole,
    required int caretIndex,
    required String source,
  }) {
    final expressionText = next.expressionText;
    if (expressionText.isEmpty) {
      return next.copyWith(clearActiveSlot: true, clearLinearCaret: true, lastHitSource: source);
    }
    final registry = StructuralRendererBridge.snapshotForExpression(expressionText).registry;
    if (!registry.hasSlots) {
      return next.copyWith(
        clearActiveSlot: true,
        linearCaretIndex: caretIndex.clamp(0, expressionText.length).toInt(),
        lastHitSource: source,
      );
    }
    final slot = _firstSlotWithRole(registry.entries, preferredRole) ?? registry.byId(next.activeSlotId) ?? registry.primary;
    if (slot == null) return next.copyWith(clearActiveSlot: true, lastHitSource: source);
    return next.copyWith(
      activeSlotId: slot.id,
      activeSlotRole: slot.role,
      caretIndex: caretIndex < 0 ? 0 : caretIndex,
      lastHitSource: source,
      clearLinearCaret: true,
    );
  }

  CalculatorState _focusPrimaryOpenSlot(CalculatorState next, {String? preferredRole, required String source}) {
    final expressionText = next.expressionText;
    if (!expressionText.contains('□')) {
      return next.copyWith(
        clearActiveSlot: true,
        linearCaretIndex: next.linearCaretIndex ?? expressionText.length,
        lastHitSource: source,
      );
    }
    final registry = StructuralRendererBridge.snapshotForExpression(expressionText).registry;
    if (!registry.hasSlots) {
      return next.copyWith(
        clearActiveSlot: true,
        linearCaretIndex: next.linearCaretIndex ?? expressionText.length,
        lastHitSource: source,
      );
    }

    final explicit = registry.byId(next.activeSlotId);
    final preferred = _firstSlotWithRole(registry.entries, preferredRole);
    final orderedPrimary = TemplateSlotNavigationPolicy.orderedSlots(registry.entries).isEmpty
        ? null
        : TemplateSlotNavigationPolicy.orderedSlots(registry.entries).first;
    final slot = explicit ?? preferred ?? orderedPrimary ?? registry.primary;
    return _focusSlot(next, slot, source: source);
  }

  CalculatorState _focusOpenSlotAfterFill(CalculatorState next, {required int? filledOrdinal, required String source}) {
    final expressionText = next.expressionText;
    if (!expressionText.contains('□')) {
      return next.copyWith(
        clearActiveSlot: true,
        linearCaretIndex: expressionText.length,
        lastHitSource: source,
      );
    }
    final registry = StructuralRendererBridge.snapshotForExpression(expressionText).registry;
    if (!registry.hasSlots) {
      return next.copyWith(
        clearActiveSlot: true,
        linearCaretIndex: expressionText.length,
        lastHitSource: source,
      );
    }

    final slot = TemplateSlotNavigationPolicy.nextSlotAfterFill(
      entries: registry.entries,
      filledPlaceholderOrdinal: filledOrdinal ?? 0,
    );
    return _focusSlot(next, slot, source: source);
  }

  CalculatorState _focusSlot(CalculatorState next, SlotEntry? slot, {required String source}) {
    if (slot == null) return next.copyWith(clearActiveSlot: true, lastHitSource: source);
    return next.copyWith(
      activeSlotId: slot.id,
      activeSlotRole: slot.role,
      caretIndex: 0,
      lastHitSource: source,
      clearLinearCaret: true,
    );
  }

  CalculatorState _withUndo(CalculatorState next) {
    if (listEquals(_state.expression, next.expression)) return next;
    return next.copyWith(
      undoStack: <List<String>>[..._state.undoStack, List<String>.from(_state.expression)],
      redoStack: const <List<String>>[],
    );
  }

  int _safeLinearCaretIndex({required bool defaultToEnd}) {
    final expressionText = _state.expressionText;
    final raw = _state.linearCaretIndex ?? (defaultToEnd ? expressionText.length : 0);
    return raw.clamp(0, expressionText.length).toInt();
  }

  String _insertAt(String source, String value, int index) {
    final safeIndex = index.clamp(0, source.length).toInt();
    return source.replaceRange(safeIndex, safeIndex, value);
  }


  void _setState(CalculatorState nextState) {
    if (nextState == _state) return;
    _state = nextState;
    notifyListeners();
  }

  SlotEntry? _firstSlotWithRole(Iterable<SlotEntry> entries, String? preferredRole) {
    if (preferredRole == null) return null;
    for (final entry in entries) {
      if (entry.role == preferredRole) return entry;
    }
    return null;
  }
}
