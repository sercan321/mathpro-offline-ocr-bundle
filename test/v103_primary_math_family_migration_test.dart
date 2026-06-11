import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/editor/editor_commands.dart';
import 'package:mathpro_flutter_phase17/features/editor/render/math_tex_serializer.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/math_expression_render_bridge.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/math_node_family_policy.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/structural_renderer_bridge.dart';

void main() {
  group('V103 primary math family migration lock', () {
    test('canonical bridge promotes common primary-family display forms', () {
      expect(MathNodeFamilyPolicy.version, 'mathpro-v103-primary-family-policy');
      expect(MathExpressionRenderBridge.canonicalDisplayExpression('asin(x)'), 'sin⁻¹(x)');
      expect(MathExpressionRenderBridge.canonicalDisplayExpression('log(2)(5)'), 'log₍2₎(5)');
      expect(MathExpressionRenderBridge.canonicalDisplayExpression('√x'), '√(x)');
      expect(MathExpressionRenderBridge.canonicalDisplayExpression('x²'), 'x^(2)');
      expect(MathExpressionRenderBridge.canonicalDisplayExpression('3/4'), '3⁄4');
    });

    test('structural snapshot parses primary families instead of raw text', () {
      final log = StructuralRendererBridge.snapshotForExpression('log(2)(5)');
      expect(log.expression, 'log₍2₎(5)');
      expect(log.registry.entries.map((entry) => entry.role), containsAll(<String>['logBase', 'functionArgument']));

      final root = StructuralRendererBridge.snapshotForExpression('√x');
      expect(root.expression, '√(x)');
      expect(root.registry.entries.map((entry) => entry.role), contains('sqrtValue'));

      final power = StructuralRendererBridge.snapshotForExpression('x²');
      expect(power.expression, 'x^(2)');
      expect(power.registry.entries.map((entry) => entry.role), containsAll(<String>['powerBase', 'powerExponent']));
    });

    test('filled fraction slot replacement preserves grouped numerator and denominator', () {
      final snapshot = StructuralRendererBridge.snapshotForExpression('(1+2)⁄4');
      final denominator = snapshot.registry.entries.firstWhere((entry) => entry.role == 'fractionDenominator');
      final changed = EditorCommands.replaceSelectedSlot('(1+2)⁄4', '5-1', activeSlotId: denominator.id);
      expect(changed, '(1+2)⁄(5-1)');
      expect(MathTexSerializer.toTex(changed!), contains(r'\frac'));
    });

    test('fixed log base and compact log base render through the same TeX route', () {
      expect(MathTexSerializer.toTex('log₂(5)'), contains(r'\log_{2}'));
      expect(MathTexSerializer.toTex('log₍10₎(5)'), contains(r'\log_{10}'));
    });

    test('safe fallback does not expose raw TeX when render fails', () {
      final label = MathExpressionRenderBridge.safeFallbackLabel(
        expression: 'log(2)(5)',
        tex: r'\log_{2}\left(5\right)',
      );
      expect(label, 'log₍2₎(5)');
      expect(label, isNot(contains(r'\log')));
    });
  });
}
