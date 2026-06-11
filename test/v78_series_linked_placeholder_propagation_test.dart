import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/editor/editor_commands.dart';
import 'package:mathpro_flutter_phase17/features/editor/math_node.dart';
import 'package:mathpro_flutter_phase17/features/editor/node_factory.dart';
import 'package:mathpro_flutter_phase17/features/editor/render/math_tex_serializer.dart';
import 'package:mathpro_flutter_phase17/logic/action_utils.dart';
import 'package:mathpro_flutter_phase17/state/calculator_controller.dart';

void main() {
  group('MathPro V78 series linked placeholder propagation', () {
    test('Taylor x, n and a placeholders propagate as linked symbolic groups', () {
      final controller = CalculatorController();
      controller.handleKey('Taylor');

      controller.handleKey('x');
      expect(controller.state.expressionText, 'f(x)=Σ□₌₀∞(f⁽□⁾(□)⁄□!)(x-□)^□');

      controller.handleKey('n');
      expect(controller.state.expressionText, 'f(x)=Σn₌₀∞(f⁽n⁾(□)⁄n!)(x-□)^n');

      controller.handleKey('a');
      expect(controller.state.expressionText, 'f(x)=Σn₌₀∞(f⁽n⁾(a)⁄n!)(x-a)^n');
      expect(
        MathTexSerializer.toTex(controller.state.expressionText),
        r'f(x)=\sum_{n=0}^{\infty}\frac{f^{(n)}(a)}{n!}(x-a)^{n}',
      );
      controller.dispose();
    });

    test('Binom propagates variable, parameter and index groups without inserting name-call text', () {
      final controller = CalculatorController();
      controller.handleKey('Binom');

      controller.handleKey('x');
      expect(controller.state.expressionText, '(1+x)^□=Σ□₌₀∞(□C□)x^□');

      controller.handleKey('α');
      expect(controller.state.expressionText, '(1+x)^α=Σ□₌₀∞(αC□)x^□');

      controller.handleKey('n');
      expect(controller.state.expressionText, '(1+x)^α=Σn₌₀∞(αCn)x^n');
      expect(controller.state.expressionText, isNot(contains('Binom(')));
      controller.dispose();
    });

    test('Geometric series propagates coefficient and ratio groups across both sides', () {
      final afterIndex = EditorCommands.replaceLinkedSeriesSlot(
        ActionUtils.templateForStructure('Geometrik'),
        'n',
      );
      expect(afterIndex?.expression, 'Σn₌₀∞□·□^n=□⁄(1-□)');

      final afterCoefficient = EditorCommands.replaceLinkedSeriesSlot(afterIndex!.expression, 'a');
      expect(afterCoefficient?.expression, 'Σn₌₀∞a·□^n=a⁄(1-□)');

      final afterRatio = EditorCommands.replaceLinkedSeriesSlot(afterCoefficient!.expression, 'r');
      expect(afterRatio?.expression, 'Σn₌₀∞a·r^n=a⁄(1-r)');
    });

    test('series placeholders carry linkGroup metadata for renderer and audit layers', () {
      final root = NodeFactory.rootFromExpression(ActionUtils.templateForStructure('Taylor'));
      final groups = <Object?>[];

      void visit(MathNode node) {
        if (node.meta.containsKey('linkGroup')) groups.add(node.meta['linkGroup']);
        for (final child in node.children) {
          visit(child);
        }
        for (final slot in node.slots.values) {
          visit(slot);
        }
      }

      visit(root);
      expect(groups, containsAll(<String>['x', 'n', 'a']));
      expect(groups.where((group) => group == 'n').length, greaterThanOrEqualTo(3));
    });
  });
}
