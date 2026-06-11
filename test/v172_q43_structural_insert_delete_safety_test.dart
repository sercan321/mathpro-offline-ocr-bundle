import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/editor/editor_commands.dart';
import 'package:mathpro_flutter_phase17/features/editor/node_factory.dart';
import 'package:mathpro_flutter_phase17/features/editor/slot_registry.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/structural_insert_delete_safety_policy.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';

void main() {
  group('V172-Q43 structural insert/delete safety', () {
    test('Q43 lineage remains protected after later Q48 repairs without final +95 PASS claim', () {
      expect(MathProPackageContract.cursorLineageVersions, contains(MathProPackageContract.version));
      expect(MathProPackageContract.cursorLineageTitles, contains('V172-Q43 Structural Insert/Delete Safety'));
      expect(MathProPackageContract.pubspecDescription, contains('V172-Q80'));
      expect(MathProPackageContract.nextPhase, contains('Q81'));
    });

    test('policy locks slot-scoped insert/delete without UI mutation', () {
      expect(StructuralInsertDeleteSafetyPolicy.structuralInsertDeleteSafetyAvailable, isTrue);
      expect(StructuralInsertDeleteSafetyPolicy.filledSlotInlineInsertEnabled, isTrue);
      expect(StructuralInsertDeleteSafetyPolicy.halfTokenLeakAllowed, isFalse);
      expect(StructuralInsertDeleteSafetyPolicy.atomicFunctionTailLeakAllowed, isFalse);
      expect(StructuralInsertDeleteSafetyPolicy.keyboardSurfaceMutationAllowed, isFalse);
      expect(StructuralInsertDeleteSafetyPolicy.p6VisualBaselineLocked, isTrue);
      expect(StructuralInsertDeleteSafetyPolicy.requiredCorrectStructuralEditsPerTwenty, 19);
    });

    test('filled function argument inserts inside payload instead of replacing it', () {
      final registry = SlotRegistry.build(NodeFactory.rootFromExpression('sin(300)'));
      final arg = registry.entries.firstWhere((slot) => slot.role == 'functionArgument');
      final edit = EditorCommands.insertIntoSelectedSlotPayload(
        'sin(300)',
        '5',
        activeSlotId: arg.id,
        caretIndex: 1,
      );
      expect(edit, isNotNull);
      expect(edit!.expression, 'sin(3500)');
      expect(edit.caretIndex, 2);
    });

    test('filled fraction denominator inserts inside payload instead of replacing it', () {
      final registry = SlotRegistry.build(NodeFactory.rootFromExpression('12⁄345'));
      final denominator = registry.entries.firstWhere((slot) => slot.role == 'fractionDenominator');
      final edit = EditorCommands.insertIntoSelectedSlotPayload(
        '12⁄345',
        '9',
        activeSlotId: denominator.id,
        caretIndex: 1,
      );
      expect(edit, isNotNull);
      expect(edit!.expression, '12⁄3945');
      expect(edit.caretIndex, 2);
    });

    test('filled power exponent and log argument remain scoped', () {
      final powerRegistry = SlotRegistry.build(NodeFactory.rootFromExpression('x^(12)'));
      final exponent = powerRegistry.entries.firstWhere((slot) => slot.role == 'powerExponent');
      final powerEdit = EditorCommands.insertIntoSelectedSlotPayload(
        'x^(12)',
        '3',
        activeSlotId: exponent.id,
        caretIndex: 1,
      );
      expect(powerEdit, isNotNull);
      expect(powerEdit!.expression, 'x^(132)');

      final logRegistry = SlotRegistry.build(NodeFactory.rootFromExpression('log₍2₎(500)'));
      final argument = logRegistry.entries.firstWhere((slot) => slot.role == 'functionArgument');
      final logEdit = EditorCommands.insertIntoSelectedSlotPayload(
        'log₍2₎(500)',
        '9',
        activeSlotId: argument.id,
        caretIndex: 1,
      );
      expect(logEdit, isNotNull);
      expect(logEdit!.expression, 'log₍2₎(5900)');
    });

    test('backspace still clears to real placeholder when payload becomes empty', () {
      final registry = SlotRegistry.build(NodeFactory.rootFromExpression('x^(1)'));
      final exponent = registry.entries.firstWhere((slot) => slot.role == 'powerExponent');
      final edit = EditorCommands.backspaceSelectedSlotPayload(
        'x^(1)',
        activeSlotId: exponent.id,
        caretIndex: 1,
      );
      expect(edit, isNotNull);
      expect(edit!.expression, 'x^(□)');
      expect(edit.slotRole, 'powerExponent');
    });
  });
}
