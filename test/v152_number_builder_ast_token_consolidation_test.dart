import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:mathpro_flutter_phase17/features/editor/math_node.dart';
import 'package:mathpro_flutter_phase17/features/editor/node_factory.dart';
import 'package:mathpro_flutter_phase17/logic/key_handlers.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';
import 'package:mathpro_flutter_phase17/state/calculator_actions.dart';

void main() {
  group('V152 number builder AST token consolidation', () {
    test('current metadata remains active while V152 number-builder behavior stays locked', () {
      final pubspec = File('pubspec.yaml').readAsStringSync();
      final readmeHead = File('README.md').readAsStringSync().split('\n').take(8).join('\n');

      expect(MathProPackageContract.phase, startsWith('V'));
      expect(MathProPackageContract.version, isNotEmpty);
      expect(pubspec, contains('version: ${MathProPackageContract.version}'));
      expect(pubspec, contains(MathProPackageContract.pubspecDescription));
      expect(readmeHead, contains(MathProPackageContract.readmeTitle));
    });

    test('multi-digit and decimal numeric runs parse as one number literal token', () {
      final root = NodeFactory.rootFromExpression('12.3+0.5+.75+42');
      final tokens = root.children.where((node) => node.meta['structuralToken'] == true).toList(growable: false);
      final numberLiterals = tokens.where((node) => node.meta['tokenType'] == 'numberLiteral').toList(growable: false);

      expect(numberLiterals.map((node) => node.text), containsAll(<String>['12.3', '0.5', '.75', '42']));
      for (final literal in numberLiterals) {
        expect(literal.meta['structuralToken'], true, reason: literal.text);
        expect(literal.meta['numberBuilder'], true, reason: literal.text);
      }
      expect(tokens.where((node) => node.meta['tokenType'] == 'operator').map((node) => node.text), contains('+'));
    });

    test('standalone decimal point remains a primitive decimal token', () {
      final root = NodeFactory.rootFromExpression('x.');
      final tokens = root.children.where((node) => node.meta['structuralToken'] == true).toList(growable: false);
      expect(tokens.map((node) => node.text), containsAll(<String>['x', '.']));
      expect(tokens.firstWhere((node) => node.text == '.').kind, MathNodeKind.number);
      expect(tokens.firstWhere((node) => node.text == '.').meta['tokenType'], 'numberLiteral');
      expect(tokens.firstWhere((node) => node.text == '.').meta['numberBuilder'], isNull);
    });

    test('frozen command and keyboard action semantics are not converted into expression nodes', () {
      expect(KeyHandlers.actionForLabel('C'), isA<ClearAction>());
      expect(KeyHandlers.actionForLabel('⌫'), isA<BackspaceAction>());
      expect(KeyHandlers.actionForLabel('MORE'), isA<ToggleTemplateTrayAction>());
      expect(KeyHandlers.actionForLabel('Ans'), isA<InsertAnswerAction>());
      expect(KeyHandlers.actionForLabel('↵'), isA<EvaluateAction>());
    });
  });
}
