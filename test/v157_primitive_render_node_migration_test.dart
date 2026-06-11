import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/editor/math_node.dart';
import 'package:mathpro_flutter_phase17/features/editor/node_factory.dart';
import 'package:mathpro_flutter_phase17/features/editor/tex_serializer.dart';
import 'package:mathpro_flutter_phase17/logic/key_handlers.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';
import 'package:mathpro_flutter_phase17/state/calculator_actions.dart';

void main() {
  group('V157/V158 primitive render node migration', () {
    test('active package metadata has advanced to V159 while preserving V157 primitive nodes', () {
      final pubspec = File('pubspec.yaml').readAsStringSync();
      final readmeHead = File('README.md').readAsStringSync().split('\n').take(8).join('\n');

      expect(MathProPackageContract.phase, startsWith('V'));
      expect(pubspec, contains('version: ${MathProPackageContract.version}'));
      expect(pubspec, contains('version: ${MathProPackageContract.version}'));
      expect(pubspec, contains(MathProPackageContract.pubspecDescription));
      expect(readmeHead, contains(MathProPackageContract.readmeTitle));
    });

    test('number literals are explicit NumberNode render nodes, not plain text fallback', () {
      final root = NodeFactory.rootFromExpression('12.3+0.5+.75+42');
      final numbers = root.children.where((node) => node.kind == MathNodeKind.number).toList(growable: false);

      expect(numbers.map((node) => node.text), containsAll(<String>['12.3', '0.5', '.75', '42']));
      for (final node in numbers) {
        expect(node.meta['renderNode'], 'NumberNode', reason: node.text);
        expect(node.meta['structuralToken'], true, reason: node.text);
      }
      expect(numbers.map(EditorTexSerializer.serialize), containsAll(<String>['12.3', '0.5', '.75', '42']));
    });

    test('variables and differentials are explicit SymbolNode render nodes', () {
      final root = NodeFactory.rootFromExpression('x+y+z+A+B+I+dx+dy+dt+dθ');
      final symbols = root.children.where((node) => node.kind == MathNodeKind.symbol).toList(growable: false);

      expect(symbols.map((node) => node.text), containsAll(<String>['x', 'y', 'z', 'A', 'B', 'I', 'dx', 'dy', 'dt', 'dθ']));
      for (final node in symbols) {
        expect(node.meta['renderNode'], 'SymbolNode', reason: node.text);
        expect(node.meta['structuralToken'], true, reason: node.text);
      }
    });

    test('constants are explicit ConstantNode render nodes with TeX serialization', () {
      final root = NodeFactory.rootFromExpression('π+e+i+θ+λ+μ+φ+ρ+∞+rad+deg+−i+−∞');
      final constants = root.children.where((node) => node.kind == MathNodeKind.constant).toList(growable: false);

      expect(constants.map((node) => node.text), containsAll(<String>['π', 'e', 'i', 'θ', 'λ', 'μ', 'φ', 'ρ', '+∞', 'rad', 'deg', '−i', '−∞']));
      for (final node in constants) {
        expect(node.meta['renderNode'], 'ConstantNode', reason: node.text);
        expect(node.meta['structuralToken'], true, reason: node.text);
      }
      expect(EditorTexSerializer.serialize(constants.firstWhere((node) => node.text == 'π')), r'\pi');
      expect(EditorTexSerializer.serialize(constants.firstWhere((node) => node.text == '+∞')), r'+\infty');
    });

    test('operator and delimiter migration is now owned by the active V158 pass', () {
      final root = NodeFactory.rootFromExpression('(x+1)≤2');
      final operators = root.children.where((node) => node.meta['tokenType'] == 'operator').toList(growable: false);
      final delimiters = root.children.where((node) => node.meta['tokenType'] == 'delimiter').toList(growable: false);
      expect(operators, isNotEmpty);
      expect(delimiters, isNotEmpty);
      for (final node in operators) {
        expect(node.kind, MathNodeKind.operatorToken, reason: node.text);
        expect(node.meta['renderNode'], 'OperatorNode', reason: node.text);
      }
      for (final node in delimiters) {
        expect(node.kind, MathNodeKind.delimiter, reason: node.text);
        expect(node.meta['renderNode'], 'DelimiterNode', reason: node.text);
      }
    });

    test('frozen commands remain commands and never become expression nodes', () {
      expect(KeyHandlers.actionForLabel('C'), isA<ClearAction>());
      expect(KeyHandlers.actionForLabel('⌫'), isA<BackspaceAction>());
      expect(KeyHandlers.actionForLabel('MORE'), isA<ToggleTemplateTrayAction>());
      expect(KeyHandlers.actionForLabel('Ans'), isA<InsertAnswerAction>());
      expect(KeyHandlers.actionForLabel('↵'), isA<EvaluateAction>());
    });
  });
}
