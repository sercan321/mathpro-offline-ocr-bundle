import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:mathpro_flutter_phase17/features/editor/editor_commands.dart';
import 'package:mathpro_flutter_phase17/features/editor/node_factory.dart';
import 'package:mathpro_flutter_phase17/features/editor/slot_registry.dart';
import 'package:mathpro_flutter_phase17/logic/action_utils.dart';
import 'package:mathpro_flutter_phase17/logic/math_key_visual_contract.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';

void main() {
  group('active structural edit and compact visual contract consolidation', () {
    test('package metadata is current and stale version markers are not active', () {
      final pubspec = File('pubspec.yaml').readAsStringSync();
      final readmeHead = File('README.md').readAsStringSync().split('\n').take(8).join('\n');

      expect(MathProPackageContract.phase, startsWith('V'));
      expect(MathProPackageContract.version, isNotEmpty);
      expect(pubspec, contains('version: ${MathProPackageContract.version}'));
      expect(pubspec, contains(MathProPackageContract.pubspecDescription));
      expect(readmeHead, contains(MathProPackageContract.readmeTitle));
      for (final stale in MathProPackageContract.staleVersionMarkers) {
        expect(pubspec, isNot(contains(stale)), reason: stale);
      }
    });

    test('role-aware slot clearing preserves postfix, limit, integral and function slot roles', () {
      var factorialExpression = ActionUtils.templateForStructure('□!');
      factorialExpression = _replaceRole(factorialExpression, 'postfixTarget', 'n');
      final factorialRoot = NodeFactory.rootFromExpression(factorialExpression);
      final factorialSlot = SlotRegistry.build(factorialRoot).entries.singleWhere((entry) => entry.role == 'postfixTarget');
      final clearedFactorial = EditorCommands.clearSelectedSlot(factorialExpression, activeSlotId: factorialSlot.id);
      expect(clearedFactorial, '□!');
      expect(SlotRegistry.build(NodeFactory.rootFromExpression(clearedFactorial!)).entries.map((entry) => entry.role), contains('postfixTarget'));

      var limitExpression = ActionUtils.templateForStructure('lim');
      limitExpression = _replaceRole(limitExpression, 'limitTarget', '6');
      final limitRoot = NodeFactory.rootFromExpression(limitExpression);
      final targetSlot = SlotRegistry.build(limitRoot).entries.singleWhere((entry) => entry.role == 'limitTarget');
      final clearedLimit = EditorCommands.clearSelectedSlot(limitExpression, activeSlotId: targetSlot.id);
      expect(clearedLimit, contains('lim₍x→□₎'));

      var integralExpression = ActionUtils.templateForStructure('∫ₐᵇ');
      integralExpression = _replaceRole(integralExpression, 'integralBody', 'x');
      final integralRoot = NodeFactory.rootFromExpression(integralExpression);
      final bodySlot = SlotRegistry.build(integralRoot).entries.singleWhere((entry) => entry.role == 'integralBody');
      final clearedIntegral = EditorCommands.clearSelectedSlot(integralExpression, activeSlotId: bodySlot.id);
      expect(clearedIntegral, contains('(□)')); 

      var functionExpression = ActionUtils.templateForStructure('f(□,□)');
      functionExpression = _replaceRole(functionExpression, 'functionArgument2', 'y');
      final functionRoot = NodeFactory.rootFromExpression(functionExpression);
      final arg2Slot = SlotRegistry.build(functionRoot).entries.singleWhere((entry) => entry.role == 'functionArgument2');
      final clearedFunction = EditorCommands.clearSelectedSlot(functionExpression, activeSlotId: arg2Slot.id);
      expect(clearedFunction, 'f(□,□)');
    });

    test('postfix templates are atomic for backspace and active-slot removal', () {
      for (final expression in <String>['n!', 'Aᵀ', 'B⁻¹', '□ᴴ']) {
        final edit = EditorCommands.atomicBackspaceAt(expression, caretIndex: expression.length);
        expect(edit, isNotNull, reason: expression);
        expect(edit!.expression, isEmpty, reason: expression);
      }

      final template = ActionUtils.templateForStructure('□!');
      final slot = SlotRegistry.build(NodeFactory.rootFromExpression(template)).entries.singleWhere((entry) => entry.role == 'postfixTarget');
      final activeSlotEdit = EditorCommands.atomicBackspaceAt(template, caretIndex: 0, activeSlotId: slot.id);
      expect(activeSlotEdit, isNotNull);
      expect(activeSlotEdit!.expression, isEmpty);
    });

    test('slot registry stable order explicitly knows postfix and derivative roles', () {
      final source = File('lib/features/editor/slot_registry.dart').readAsStringSync();
      expect(source, contains("'postfixTarget':"));
      expect(source, contains("'derivativeBody':"));
      expect(source, contains("'derivativeVariable':"));
      expect(source, contains("'functionArgument2':"));
      expect(source, isNot(contains("'limitTarget': 61")));
    });

    test('compact visual profiles keep heavy math glyphs out of public structural labels', () {
      for (final label in <String>['lim', '∫□dx', '∫ₐᵇ', 'Σ', 'Π', '□!', '□C□', '□P□', 'Taylor']) {
        expect(MathKeyVisualContract.profileFor(label).isHeavy, isFalse, reason: label);
      }
      final mathLabelSource = File('lib/features/workspace/math_label.dart').readAsStringSync();
      expect(mathLabelSource, isNot(contains('FontWeight.w700')));
      expect(mathLabelSource, contains('FontWeight.w500'));
    });
  });
}

String _replaceRole(String expression, String role, String value) {
  final root = NodeFactory.rootFromExpression(expression);
  final slot = SlotRegistry.build(root).entries.firstWhere((entry) => entry.role == role);
  final edited = EditorCommands.replaceSelectedSlot(expression, value, activeSlotId: slot.id);
  expect(edited, isNotNull, reason: '$expression role=$role value=$value');
  return edited!;
}
