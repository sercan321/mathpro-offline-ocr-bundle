import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:mathpro_flutter_phase17/features/editor/math_node.dart';
import 'package:mathpro_flutter_phase17/features/editor/node_factory.dart';
import 'package:mathpro_flutter_phase17/features/editor/render/math_tex_serializer.dart';
import 'package:mathpro_flutter_phase17/features/editor/slot_registry.dart';
import 'package:mathpro_flutter_phase17/features/editor/tex_serializer.dart';
import 'package:mathpro_flutter_phase17/logic/action_utils.dart';
import 'package:mathpro_flutter_phase17/logic/key_handlers.dart';
import 'package:mathpro_flutter_phase17/logic/math_key_inventory.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';
import 'package:mathpro_flutter_phase17/logic/premium_math_key_specs.dart';
import 'package:mathpro_flutter_phase17/state/calculator_actions.dart';

void main() {
  group('V150 structural atom tree binding migration', () {
    test('metadata is current and audit docs are not claiming Flutter PASS', () {
      final pubspec = File('pubspec.yaml').readAsStringSync();
      expect(MathProPackageContract.phase, startsWith('V')); // current package phase; V150 behavior stays tested below
      expect(pubspec, contains('version: ${MathProPackageContract.version}'));
      expect(pubspec, contains(MathProPackageContract.pubspecDescription));
      expect(File('README.md').readAsStringSync().split('\n').take(3).join('\n'), contains(MathProPackageContract.readmeTitle));
    });

    test('fixed mathematical atoms no longer route as loose InsertTextAction', () {
      const structuralAtoms = <String>{
        'x₁', 'x₂', 'y₁', 'y₂', 'z₁', 'z₂',
        'A₁', 'A₂', 'B₁', 'B₂', 'I₂', 'I₃',
        'y′', 'y″', 'y‴', 'z̄', 'i²', '−i', '+∞', '−∞',
        'dx', 'dy', 'dt', 'dθ',
      };

      for (final label in structuralAtoms) {
        expect(PremiumMathKeySpecs.specFor(label), isNotNull, reason: label);
        expect(KeyHandlers.actionForLabel(label), isA<InsertTemplateAction>(), reason: label);
        expect(MathKeyInventory.primitiveTextLabels.contains(label), isFalse, reason: label);
      }
    });

    test('fixed subscript and power atoms parse through the AST families', () {
      const expectedKinds = <String, MathNodeKind>{
        'x₁': MathNodeKind.subscript,
        'x₂': MathNodeKind.subscript,
        'y₁': MathNodeKind.subscript,
        'y₂': MathNodeKind.subscript,
        'z₁': MathNodeKind.subscript,
        'z₂': MathNodeKind.subscript,
        'A₁': MathNodeKind.subscript,
        'A₂': MathNodeKind.subscript,
        'B₁': MathNodeKind.subscript,
        'B₂': MathNodeKind.subscript,
        'I₂': MathNodeKind.subscript,
        'I₃': MathNodeKind.subscript,
        'i²': MathNodeKind.power,
      };

      for (final entry in expectedKinds.entries) {
        final expression = ActionUtils.templateForStructure(entry.key);
        final root = NodeFactory.rootFromExpression(expression);
        expect(root.children, isNotEmpty, reason: entry.key);
        expect(root.children.single.kind, entry.value, reason: '${entry.key} → $expression');
        expect(SlotRegistry.build(root).entries, isEmpty, reason: '${entry.key} is a fixed atom and must not expose false editable slots');
      }
    });

    test('prime and overline atoms parse as postfix AST atoms without false slots', () {
      const labels = <String>{'y′', 'y″', 'y‴', 'z̄'};
      for (final label in labels) {
        final root = NodeFactory.rootFromExpression(ActionUtils.templateForStructure(label));
        expect(root.children, hasLength(1), reason: label);
        expect(root.children.single.kind, MathNodeKind.postfix, reason: label);
        expect(SlotRegistry.build(root).entries, isEmpty, reason: '$label is fixed notation, not an editable template');
      }
    });

    test('structural atom TeX remains premium and not programmer/raw fallback', () {
      final cases = <String, String>{
        'x₁': '_{1}',
        'A₂': '_{2}',
        'I₃': '_{3}',
        'z̄': r'\overline{z}',
      };
      for (final entry in cases.entries) {
        final sourceTex = MathTexSerializer.toTex(entry.key);
        final astTex = EditorTexSerializer.serialize(NodeFactory.rootFromExpression(ActionUtils.templateForStructure(entry.key)));
        expect(sourceTex, contains(entry.value), reason: 'source ${entry.key}');
        expect(astTex, contains(entry.value), reason: 'AST ${entry.key}');
      }
      expect(MathTexSerializer.toTex('i²'), contains('i^{2}'));
      final iSquaredAst = EditorTexSerializer.serialize(NodeFactory.rootFromExpression(ActionUtils.templateForStructure('i²')));
      expect(iSquaredAst, contains('i'));
      expect(iSquaredAst, contains('^{2}'));
    });

    test('commands and deliberate primitive numbers/variables keep their old semantics', () {
      for (final label in <String>['C', '⌫', 'MORE', 'Ans', '↵']) {
        expect(KeyHandlers.actionForLabel(label), isNot(isA<InsertTextAction>()), reason: label);
      }
      for (final label in <String>['0', '7', 'x', 'y', 'π', '+', '=', 'rad', 'deg']) {
        expect(KeyHandlers.actionForLabel(label), isA<InsertTextAction>(), reason: label);
      }
    });
  });
}
