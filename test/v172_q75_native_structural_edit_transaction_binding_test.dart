import 'package:flutter_test/flutter_test.dart';

import 'package:mathpro_flutter_phase17/features/formula_engine/native_structural_edit_transaction_binding_policy.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/structural_renderer_bridge.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';
import 'package:mathpro_flutter_phase17/state/calculator_actions.dart';
import 'package:mathpro_flutter_phase17/state/calculator_controller.dart';
import 'package:mathpro_flutter_phase17/state/calculator_state.dart';

void main() {
  group('V172-Q75 Native Structural Edit Transaction Binding', () {
    test('package identity advances to Q75 without claiming real-device +95 PASS', () {
      expect(MathProPackageContract.version, '0.172.112+172');
      expect(MathProPackageContract.pubspecDescription, contains('V172-Q80'));
      expect(MathProPackageContract.auditTitle, contains('Q75'));
      expect(MathProPackageContract.nextPhase, contains('Q81'));
      expect(MathProPackageContract.q75NativeStructuralEditTransactionBindingRule, contains('active SlotBox id'));
      expect(NativeStructuralEditTransactionBindingPolicy.realDevicePlus95PassClaimed, isFalse);
      expect(NativeStructuralEditTransactionBindingPolicy.structuralEditMayExitToDetachedLinearCaret, isFalse);
      expect(NativeStructuralEditTransactionBindingPolicy.functionArgumentAutoExitAfterFirstDigitAllowed, isFalse);
    });

    test('single function argument keeps deterministic in-argument typing after first and second digit', () {
      final controller = CalculatorController(initialState: const CalculatorState(expression: <String>['sin(□)']));
      final arg = StructuralRendererBridge.snapshotForExpression('sin(□)')
          .registry
          .entries
          .firstWhere((slot) => slot.role == 'functionArgument');

      controller.selectEditorSlot(slotId: arg.id, slotRole: arg.role, caretIndex: 0, source: 'q75-test-tap');
      controller.dispatch(const InsertTextAction('3'));

      expect(controller.state.expressionText, 'sin(3)');
      expect(controller.state.activeSlotId, isNull);
      expect(controller.state.linearCaretIndex, 5);
      expect(controller.state.lastHitSource, contains('v172q75-native-slot-transaction'));

      controller.dispatch(const InsertTextAction('0'));
      expect(controller.state.expressionText, 'sin(30)');
      expect(controller.state.activeSlotId, isNull);
      expect(controller.state.linearCaretIndex, 6);
    });

    test('filled structural slot insert stays scoped instead of replacing or exiting', () {
      final controller = CalculatorController(initialState: const CalculatorState(expression: <String>['12⁄345']));
      final denominator = StructuralRendererBridge.snapshotForExpression('12⁄345')
          .registry
          .entries
          .firstWhere((slot) => slot.role == 'fractionDenominator');

      controller.selectEditorSlot(slotId: denominator.id, slotRole: denominator.role, caretIndex: 1, source: 'q75-test-tap');
      controller.dispatch(const InsertTextAction('9'));

      expect(controller.state.expressionText, '12⁄3945');
      expect(controller.state.activeSlotRole, 'fractionDenominator');
      expect(controller.state.hasLinearCaret, isFalse);
      expect(controller.state.caretIndex, 2);
    });

    test('protected UI mutation gates remain closed for Q75', () {
      expect(NativeStructuralEditTransactionBindingPolicy.cursorOnlyChange, isTrue);
      expect(NativeStructuralEditTransactionBindingPolicy.keyboardSurfaceMutationAllowed, isFalse);
      expect(NativeStructuralEditTransactionBindingPolicy.moreSurfaceMutationAllowed, isFalse);
      expect(NativeStructuralEditTransactionBindingPolicy.longPressSurfaceMutationAllowed, isFalse);
      expect(NativeStructuralEditTransactionBindingPolicy.appShellMutationAllowed, isFalse);
      expect(NativeStructuralEditTransactionBindingPolicy.graphHistorySolutionMutationAllowed, isFalse);
    });
  });
}
