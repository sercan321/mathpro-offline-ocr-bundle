import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/editor/editor_commands.dart';
import 'package:mathpro_flutter_phase17/features/editor/selection_controller.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';

void main() {
  group('V153 token boundary editing hardening', () {
    test('active metadata remains current while V153 behavior stays locked', () {
      expect(MathProPackageContract.phase, startsWith('V'));
      expect(MathProPackageContract.version, isNotEmpty);
      expect(MathProPackageContract.pubspecDescription, contains('MathPro Flutter phase 17'));
    });

    test('typed primitive atoms backspace as one structural token instead of fragmented text', () {
      for (final token in <String>['x₁', 'y″', 'y‴', 'z̄', 'i²', '+∞', '−∞', '−i', 'dx', 'dθ']) {
        expect(EditorCommands.isAtomicTypedPrimitiveToken(token), isTrue, reason: token);
        final edit = EditorCommands.atomicBackspaceAt('7+$token', caretIndex: '7+$token'.length);
        expect(edit, isNotNull, reason: token);
        expect(edit!.expression, '7+', reason: token);
        expect(edit.caretIndex, 2, reason: token);
      }
    });

    test('operator replacement extends to typed comparison and percent operators', () {
      expect(EditorCommands.shouldReplacePreviousOperator('+', '−'), isTrue);
      expect(EditorCommands.shouldReplacePreviousOperator('×', '÷'), isTrue);
      expect(EditorCommands.shouldReplacePreviousOperator('=', '≤'), isTrue);
      expect(EditorCommands.shouldReplacePreviousOperator('≠', '≈'), isTrue);
      expect(EditorCommands.shouldReplacePreviousOperator('%', '+'), isTrue);
      expect(EditorCommands.shouldReplacePreviousOperator('x', '+'), isFalse);
      expect(EditorCommands.shouldReplacePreviousOperator('+', 'x'), isFalse);
    });

    test('number and typed atom boundaries expose stable caret anchors', () {
      const expression = '12.3+x₁+dx';
      const canvas = Size(390, 148);
      for (final caretIndex in <int>[0, 4, 5, 7, 8, expression.length]) {
        final x = MathProCaretController.linearCaretXForExpression(
          expression: expression,
          canvasSize: canvas,
          caretIndex: caretIndex,
        );
        final resolved = MathProCaretController.closestLinearCaretIndex(
          expression: expression,
          canvasSize: canvas,
          point: Offset(x + 0.5, MathProCaretController.inlineExpressionCenterY(canvas)),
        );
        expect(resolved, caretIndex, reason: 'caret boundary $caretIndex');
      }
    });
  });
}
