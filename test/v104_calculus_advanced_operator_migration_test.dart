import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/editor/editor_commands.dart';
import 'package:mathpro_flutter_phase17/features/editor/render/math_tex_serializer.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/calculus_operator_policy.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/math_expression_render_bridge.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/structural_renderer_bridge.dart';

void main() {
  group('V104 calculus advanced operator migration lock', () {
    test('calculus policy canonicalizes legacy limit, integral and big-operator display forms', () {
      expect(CalculusOperatorPolicy.version, 'mathpro-v104-calculus-operator-policy');
      expect(MathExpressionRenderBridge.canonicalDisplayExpression('lim_y → 8(8)'), 'lim₍y→8₎(8)');
      expect(MathExpressionRenderBridge.canonicalDisplayExpression('lim x→∞'), 'lim₍x→∞₎(□)');
      expect(MathExpressionRenderBridge.canonicalDisplayExpression('∫₀¹(x)dx'), '∫_{0}^{1}(x)dx');
      expect(MathExpressionRenderBridge.canonicalDisplayExpression('Σᵢ₌₁ⁿ(x)'), 'Σ_{i=1}^{n}(x)');
      expect(MathExpressionRenderBridge.canonicalDisplayExpression('Πᵢ₌₁ⁿ(x)'), 'Π_{i=1}^{n}(x)');
    });

    test('compact limit is parsed as a real limit node with editable slots', () {
      final snapshot = StructuralRendererBridge.snapshotForExpression('lim₍y→8₎(8)');
      expect(snapshot.registry.entries.map((entry) => entry.role), containsAll(<String>['limitVariable', 'limitTarget', 'limitBody']));
      expect(snapshot.tex, contains(r'\lim_{y\to 8}'));

      final target = snapshot.registry.entries.firstWhere((entry) => entry.role == 'limitTarget');
      expect(EditorCommands.replaceSelectedSlot('lim₍y→8₎(8)', '0', activeSlotId: target.id), 'lim₍y→0₎(8)');
    });

    test('explicit editable definite integral exposes only genuine open slots while fixed filled limits stay structural', () {
      final editable = StructuralRendererBridge.snapshotForExpression('∫_{□}^{□}(□)d□');
      expect(editable.registry.entries.map((entry) => entry.role), containsAll(<String>['integralLowerLimit', 'integralUpperLimit', 'integralBody', 'integralDifferential']));
      expect(editable.tex, contains(r'\int_{\Box}^{\Box}'));

      final fixed = StructuralRendererBridge.snapshotForExpression('∫₀¹(x)dx');
      expect(fixed.expression, '∫_{0}^{1}(x)dx');
      expect(fixed.registry.entries, isEmpty);
      expect(fixed.tex, contains(r'\int_{0}^{1}'));

      final openDifferential = StructuralRendererBridge.snapshotForExpression('∫_{0}^{1}(x)d□');
      final differential = openDifferential.registry.entries.singleWhere((entry) => entry.role == 'integralDifferential');
      expect(EditorCommands.replaceSelectedSlot('∫_{0}^{1}(x)d□', 't', activeSlotId: differential.id), '∫_{0}^{1}(x)dt');
    });

    test('compact Σ/Π notations become structural big operators with editable limits', () {
      final sum = StructuralRendererBridge.snapshotForExpression('Σᵢ₌₁ⁿ(x)');
      expect(sum.expression, 'Σ_{i=1}^{n}(x)');
      expect(sum.registry.entries.map((entry) => entry.role), containsAll(<String>['sumLowerLimit', 'sumUpperLimit', 'sumBody']));
      expect(sum.tex, contains(r'\sum_{i=1}^{n}'));

      final product = StructuralRendererBridge.snapshotForExpression('Πᵢ₌₁ⁿ(x)');
      expect(product.expression, 'Π_{i=1}^{n}(x)');
      expect(product.registry.entries.map((entry) => entry.role), containsAll(<String>['productLowerLimit', 'productUpperLimit', 'productBody']));
      expect(product.tex, contains(r'\prod_{i=1}^{n}'));
    });

    test('direct TeX fallback handles compact calculus forms without raw programmer display', () {
      expect(MathTexSerializer.toTex('lim₍x→0₎(sin(x)⁄x)'), contains(r'\lim_{x\to 0}'));
      expect(MathTexSerializer.toTex('∫_{0}^{1}(x)dx'), contains(r'\int_{0}^{1}'));
      expect(MathExpressionRenderBridge.exposesProgrammerToken('lim₍x→0₎(x)'), isFalse);
    });
  });
}
