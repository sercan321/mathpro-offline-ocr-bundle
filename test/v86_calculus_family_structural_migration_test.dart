import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';

import 'package:mathpro_flutter_phase17/features/editor/math_node.dart';
import 'package:mathpro_flutter_phase17/features/editor/node_factory.dart';
import 'package:mathpro_flutter_phase17/features/editor/slot_registry.dart';
import 'package:mathpro_flutter_phase17/features/editor/tex_serializer.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/math_layout_engine.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/render_mapped_slot_hit_test.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/slot_hit_testing.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/structural_renderer_bridge.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/template_slot_navigation_policy.dart';
import 'package:mathpro_flutter_phase17/logic/action_utils.dart';
import 'package:mathpro_flutter_phase17/logic/premium_math_key_specs.dart';

void main() {
  group('MathPro V86 calculus family structural migration', () {
    test('promotes derivative templates from function-call strings to derivative nodes', () {
      final cases = <String, String>{
        'd/dx(□)': r'\frac{d}{dx}\left(\Box\right)',
        'd²/dx²(□)': r'\frac{d^{2}}{dx^{2}}\left(\Box\right)',
        'd³/dx³(□)': r'\frac{d^{3}}{dx^{3}}\left(\Box\right)',
        '∂/∂x(□)': r'\frac{\partial}{\partial x}\left(\Box\right)',
        '∂²/∂x²(□)': r'\frac{\partial^{2}}{\partial x^{2}}\left(\Box\right)',
      };

      for (final item in cases.entries) {
        final root = NodeFactory.rootFromExpression(item.key);
        expect(root.children.first.kind, MathNodeKind.derivative, reason: item.key);
        final registry = SlotRegistry.build(root);
        expect(registry.entries.map((entry) => entry.role), contains('derivativeBody'), reason: item.key);
        expect(EditorTexSerializer.serialize(root), item.value, reason: item.key);
      }
    });

    test('keeps Leibniz dy/dx notations structural without pretending to solve them', () {
      final first = NodeFactory.rootFromExpression('dy/dx');
      final second = NodeFactory.rootFromExpression('d²y/dx²');
      expect(first.children.first.kind, MathNodeKind.derivative);
      expect(second.children.first.kind, MathNodeKind.derivative);
      expect(EditorTexSerializer.serialize(first), r'\frac{dy}{dx}');
      expect(EditorTexSerializer.serialize(second), r'\frac{d^{2}y}{dx^{2}}');
      expect(SlotRegistry.build(first).entries, isEmpty);
      expect(SlotRegistry.build(second).entries, isEmpty);
    });

    test('binds calculus key specs and action routing to derivativeBody instead of generic functionArgument', () {
      for (final label in <String>['d/dx', 'd/dx(□)', 'd²/dx²(□)', 'd³/dx³(□)', '∂/∂x(□)', '∂²/∂x²(□)']) {
        final spec = PremiumMathKeySpecs.specFor(label)!;
        final actionSpec = ActionUtils.templateSpecForStructure(label);
        expect(spec.expectedRootKind, MathNodeKind.derivative, reason: label);
        expect(spec.focusRole, 'derivativeBody', reason: label);
        expect(actionSpec.focusRole, 'derivativeBody', reason: label);
        expect(actionSpec.expression, spec.expression, reason: label);
      }
    });

    test('orders and hit-tests derivative body slots as their own calculus slot family', () {
      const expression = 'd²/dx²(□)';
      const canvas = Size(720, 180);
      final snapshot = StructuralRendererBridge.snapshotForExpression(expression);
      final roles = TemplateSlotNavigationPolicy.orderedSlots(snapshot.registry.entries).map((entry) => entry.role).toList(growable: false);
      expect(roles, equals(<String>['derivativeBody']));

      final layout = MathLayoutEngine.deriveSlotRects(canvasSize: canvas, registry: snapshot.registry);
      final resolved = RenderMappedSlotHitTest.resolveSlotRects(
        expression: expression,
        canvasSize: canvas,
        registry: snapshot.registry,
        baseLayout: layout,
      );
      final rect = resolved.entries.singleWhere((entry) => entry.key.role == 'derivativeBody').value;
      final hit = SlotHitTesting.hitTest(rect.center, resolved);
      expect(hit?.entry.role, 'derivativeBody');
      expect(rect.width, greaterThanOrEqualTo(58.0));
      expect(rect.height, greaterThanOrEqualTo(58.0));
    });

    test('does not change protected keyboard calculus long-press contracts', () {
      final derivative = ActionUtils.templateSpecForStructure('d/dx');
      final integral = ActionUtils.templateSpecForStructure('∫ₐᵇ');
      expect(derivative.expression, 'd/dx(□)');
      expect(integral.expression, '∫_{□}^{□}(□)d□');
    });
  });
}
