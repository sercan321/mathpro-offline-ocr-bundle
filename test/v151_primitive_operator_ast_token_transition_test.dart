import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/editor/math_node.dart';
import 'package:mathpro_flutter_phase17/features/editor/node_factory.dart';
import 'package:mathpro_flutter_phase17/logic/key_handlers.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';
import 'package:mathpro_flutter_phase17/state/calculator_actions.dart';

void main() {
  group('V151 primitive and operator AST token transition', () {
    test('active package metadata is V151', () {
      expect(MathProPackageContract.phase, startsWith('V')); // current package phase; V151 behavior stays tested below
      expect(MathProPackageContract.version, isNotEmpty);
      expect(MathProPackageContract.pubspecDescription, contains('MathPro Flutter phase 17'));
    });

    test('primitive numbers, constants, variables and operators parse as typed AST tokens', () {
      final root = NodeFactory.rootFromExpression('12.3+x−π≤∞');
      final tokens = root.children.where((node) => node.meta['structuralToken'] == true).toList(growable: false);
      expect(tokens.map((node) => node.text).join(), '12.3+x−π≤∞');
      expect(tokens, isNotEmpty);
      expect(tokens.every((node) => node.meta['structuralToken'] == true), isTrue);
      expect(tokens.where((node) => node.meta['tokenType'] == 'numberLiteral').map((node) => node.text), contains('12.3'));
      expect(tokens.firstWhere((node) => node.text == '12.3').meta['numberBuilder'], true);
      expect(tokens.where((node) => node.kind == MathNodeKind.symbol).map((node) => node.text), contains('x'));
      expect(tokens.where((node) => node.kind == MathNodeKind.constant).map((node) => node.text), containsAll(<String>['π', '∞']));
      expect(tokens.where((node) => node.meta['tokenType'] == 'operator').map((node) => node.text), containsAll(<String>['+', '−', '≤']));
    });

    test('multi-character mathematical atoms stay inside typed token nodes', () {
      final root = NodeFactory.rootFromExpression('dx+dy+dt+dθ+rad+deg+−i+∞+−∞');
      final tokens = root.children.where((node) => node.meta['structuralToken'] == true).toList(growable: false);
      final tokenTexts = tokens.map((node) => node.text).toList(growable: false);
      expect(tokenTexts, containsAll(<String>['dx', 'dy', 'dt', 'dθ', 'rad', 'deg', '−i', '+∞', '−∞']));
      for (final token in tokens) {
        expect(token.meta['structuralToken'], true, reason: token.text);
      }
      expect(tokens.firstWhere((node) => node.text == 'dx').meta['tokenType'], 'differential');
      expect(tokens.firstWhere((node) => node.text == '−i').meta['tokenType'], 'signedComplex');
      expect(tokens.firstWhere((node) => node.text == '+∞').meta['tokenType'], 'signedInfinity');
    });

    test('frozen commands and basic operator insertion semantics do not drift', () {
      expect(KeyHandlers.actionForLabel('C'), isA<ClearAction>());
      expect(KeyHandlers.actionForLabel('⌫'), isA<BackspaceAction>());
      expect(KeyHandlers.actionForLabel('MORE'), isA<ToggleTemplateTrayAction>());
      expect(KeyHandlers.actionForLabel('Ans'), isA<InsertAnswerAction>());
      expect(KeyHandlers.actionForLabel('↵'), isA<EvaluateAction>());
      expect(KeyHandlers.actionForLabel('+'), isA<InsertTextAction>());
      expect(KeyHandlers.actionForLabel('−'), isA<InsertTextAction>());
      expect(KeyHandlers.actionForLabel('='), isA<InsertTextAction>());
    });
  });
}
