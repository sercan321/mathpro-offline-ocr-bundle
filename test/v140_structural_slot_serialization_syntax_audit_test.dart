import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:mathpro_flutter_phase17/features/editor/editor_commands.dart';
import 'package:mathpro_flutter_phase17/features/editor/math_node.dart';
import 'package:mathpro_flutter_phase17/features/editor/node_factory.dart';
import 'package:mathpro_flutter_phase17/features/editor/slot_registry.dart';
import 'package:mathpro_flutter_phase17/features/editor/tex_serializer.dart';
import 'package:mathpro_flutter_phase17/logic/action_utils.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';

void main() {
  group('V140 structural slot serialization syntax and round-trip audit', () {
    test('package metadata is current and stale V139 markers are not active', () {
      final pubspec = File('pubspec.yaml').readAsStringSync();
      final readmeHead = File('README.md').readAsStringSync().split('\n').take(8).join('\n');

      expect(MathProPackageContract.phase, isNotEmpty);
      expect(pubspec, contains('version: ${MathProPackageContract.version}'));
      expect(pubspec, contains(MathProPackageContract.pubspecDescription));
      expect(readmeHead, contains(MathProPackageContract.readmeTitle));
      for (final stale in MathProPackageContract.staleVersionMarkers) {
        expect(pubspec, isNot(contains(stale)), reason: stale);
      }
    });

    test('plain serializer source no longer contains the stale matrix extra-brace defect', () {
      final source = File('lib/features/editor/editor_commands.dart').readAsStringSync();
      expect(
        source,
        isNot(contains(r'''rowValues.add(cells.join(' '));
    }
    }
    return '[${rowValues.join('; ')}]';''')),
      );
      expect(source, contains(r'''rowValues.add(cells.join(' '));
    }
    return '[${rowValues.join('; ')}]';'''));
    });

    test('filled definite integral slots round-trip as an IntegralNode', () {
      var expression = ActionUtils.templateForStructure('∫ₐᵇ');
      expression = _replaceRole(expression, 'integralLowerLimit', '0');
      expression = _replaceRole(expression, 'integralUpperLimit', '1');
      expression = _replaceRole(expression, 'integralBody', 'x');
      expression = _replaceRole(expression, 'integralDifferential', 'x');

      final root = NodeFactory.rootFromExpression(expression);
      expect(root.children.single.kind, MathNodeKind.integral);
      final roles = SlotRegistry.build(root).entries.map((slot) => slot.role).toSet();
      expect(roles, isNot(contains('integralLowerLimit')));
      expect(roles, isNot(contains('integralUpperLimit')));
      expect(roles, isNot(contains('integralBody')));
      expect(roles, isNot(contains('integralDifferential')));
      final tex = EditorTexSerializer.serialize(root);
      expect(tex, contains(r'\int_{0}^{1}'));
      expect(tex, contains('dx'));
    });

    test('filled limit and Σ/Π slots stay structural instead of raw text', () {
      var limitExpression = ActionUtils.templateForStructure('lim');
      limitExpression = _replaceRole(limitExpression, 'limitTarget', '6');
      limitExpression = _replaceRole(limitExpression, 'limitBody', 'x');
      final limitRoot = NodeFactory.rootFromExpression(limitExpression);
      expect(limitRoot.children.single.kind, MathNodeKind.limit);
      final limitTex = EditorTexSerializer.serialize(limitRoot);
      expect(limitTex, contains(r'\lim_{'));
      expect(limitTex, contains(r'\to 6'));

      var sumExpression = ActionUtils.templateForStructure('Σ');
      sumExpression = _replaceRole(sumExpression, 'sumLowerLimit', 'n=0');
      sumExpression = _replaceRole(sumExpression, 'sumUpperLimit', '∞');
      sumExpression = _replaceRole(sumExpression, 'sumBody', 'x');
      final sumRoot = NodeFactory.rootFromExpression(sumExpression);
      expect(sumRoot.children.single.kind, MathNodeKind.bigOperator);
      expect(EditorTexSerializer.serialize(sumRoot), contains(r'\sum_{'));

      var productExpression = ActionUtils.templateForStructure('Π');
      productExpression = _replaceRole(productExpression, 'productLowerLimit', 'i=1');
      productExpression = _replaceRole(productExpression, 'productUpperLimit', 'n');
      productExpression = _replaceRole(productExpression, 'productBody', 'x');
      final productRoot = NodeFactory.rootFromExpression(productExpression);
      expect(productRoot.children.single.kind, MathNodeKind.bigOperator);
      expect(EditorTexSerializer.serialize(productRoot), contains(r'\prod_{'));
    });

    test('matrix, vector and postfix slot edits round-trip without serializer corruption', () {
      var matrixExpression = '[□ □; □ □]';
      matrixExpression = _replaceRole(matrixExpression, 'matrixCell', '1');
      final matrixRoot = NodeFactory.rootFromExpression(matrixExpression);
      expect(matrixRoot.children.single.kind, MathNodeKind.matrix);
      expect(EditorTexSerializer.serialize(matrixRoot), contains(r'\begin{bmatrix}'));
      expect(EditorTexSerializer.serialize(matrixRoot), contains('1'));

      var vectorExpression = '[□; □]';
      vectorExpression = _replaceRole(vectorExpression, 'matrixCell', '2');
      final vectorRoot = NodeFactory.rootFromExpression(vectorExpression);
      expect(vectorRoot.children.single.kind, MathNodeKind.vector);
      expect(EditorTexSerializer.serialize(vectorRoot), contains(r'\begin{bmatrix}'));
      expect(EditorTexSerializer.serialize(vectorRoot), contains('2'));

      var factorialExpression = ActionUtils.templateForStructure('□!');
      factorialExpression = _replaceRole(factorialExpression, 'postfixTarget', 'n');
      final factorialRoot = NodeFactory.rootFromExpression(factorialExpression);
      expect(factorialRoot.children.single.kind, MathNodeKind.postfix);
      expect(EditorTexSerializer.serialize(factorialRoot), contains('n'));
      expect(EditorTexSerializer.serialize(factorialRoot), contains('!'));
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
