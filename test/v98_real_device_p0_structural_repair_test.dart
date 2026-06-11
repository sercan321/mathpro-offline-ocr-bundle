import 'dart:io';

import 'dart:ui';
import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/editor/editor_commands.dart';
import 'package:mathpro_flutter_phase17/features/editor/render/math_tex_serializer.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/math_layout_engine.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/render_mapped_slot_hit_test.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/structural_renderer_bridge.dart';

void main() {
  group('V98 real-device P0 structural repair lock', () {
    test('filled fraction numerator and denominator remain editable after 3⁄4', () {
      final snapshot = StructuralRendererBridge.snapshotForExpression('3⁄4');
      final numerator = snapshot.registry.entries.firstWhere((entry) => entry.role == 'fractionNumerator');
      final denominator = snapshot.registry.entries.firstWhere((entry) => entry.role == 'fractionDenominator');

      expect(EditorCommands.clearSelectedSlot('3⁄4', activeSlotId: numerator.id), '□⁄4');
      expect(EditorCommands.replaceSelectedSlot('3⁄4', '9', activeSlotId: denominator.id), '3⁄9');
    });

    test('log base replacement never serializes to programmer call chain', () {
      final snapshot = StructuralRendererBridge.snapshotForExpression('log₍2₎(5)');
      final base = snapshot.registry.entries.firstWhere((entry) => entry.role == 'logBase');
      final arg = snapshot.registry.entries.firstWhere((entry) => entry.role == 'functionArgument');

      final changedBase = EditorCommands.replaceSelectedSlot('log₍2₎(5)', '10', activeSlotId: base.id);
      final changedArg = EditorCommands.replaceSelectedSlot('log₍2₎(5)', '8', activeSlotId: arg.id);

      expect(changedBase, 'log₍10₎(5)');
      expect(changedArg, 'log₍2₎(8)');
      expect(changedBase, isNot(contains('log(10)(5)')));
      expect(MathTexSerializer.toTex(changedBase!), contains(r'\log_{10}'));
    });

    test('filled limit variable target and body remain addressable', () {
      const expression = 'lim_y → 8(8)';
      final snapshot = StructuralRendererBridge.snapshotForExpression(expression);
      final variable = snapshot.registry.entries.firstWhere((entry) => entry.role == 'limitVariable');
      final target = snapshot.registry.entries.firstWhere((entry) => entry.role == 'limitTarget');
      final body = snapshot.registry.entries.firstWhere((entry) => entry.role == 'limitBody');

      expect(EditorCommands.replaceSelectedSlot(expression, 'x', activeSlotId: variable.id), 'lim₍x→8₎(8)');
      expect(EditorCommands.replaceSelectedSlot(expression, '0', activeSlotId: target.id), 'lim₍y→0₎(8)');
      expect(EditorCommands.clearSelectedSlot(expression, activeSlotId: body.id), 'lim₍y→8₎(□)');
    });

    test('serialized sum/product keeps upper lower body slots editable', () {
      const expression = r'Σ_{1}^{n}(x)';
      final snapshot = StructuralRendererBridge.snapshotForExpression(expression);
      expect(snapshot.registry.entries.map((entry) => entry.role), containsAll(<String>['sumLowerLimit', 'sumUpperLimit', 'sumBody']));

      final body = snapshot.registry.entries.firstWhere((entry) => entry.role == 'sumBody');
      final lower = snapshot.registry.entries.firstWhere((entry) => entry.role == 'sumLowerLimit');

      expect(EditorCommands.clearSelectedSlot(expression, activeSlotId: body.id), r'Σ_{1}^{n}(□)');
      expect(EditorCommands.replaceSelectedSlot(expression, '0', activeSlotId: lower.id), r'Σ_{0}^{n}(x)');
      expect(MathTexSerializer.toTex(r'Σ_{0}^{n}(x)'), contains(r'\sum_{0}^{n}'));
    });

    test('active slot visual rectangles stay bounded instead of giant overlays', () {
      final snapshot = StructuralRendererBridge.snapshotForExpression('lim_y → 8(8)');
      const canvas = Size(360, 120);
      final layout = MathLayoutEngine.deriveSlotRects(canvasSize: canvas, registry: snapshot.registry);
      final rects = RenderMappedSlotHitTest.resolveSlotRects(
        expression: 'lim_y → 8(8)',
        canvasSize: canvas,
        registry: snapshot.registry,
        baseLayout: layout,
      );

      for (final rect in rects.values) {
        expect(rect.width, lessThanOrEqualTo(72));
        expect(rect.height, lessThanOrEqualTo(62));
      }
    });

    test('editor interaction layer no longer runs duplicate tap-up selection', () {
      final source = File('lib/features/editor/render/editor_interaction_layer.dart').readAsStringSync();
      expect(source, isNot(contains('source: \'tap-up\'')));
      expect(source, contains('source: \'tap-down\''));
    });
  });
}
