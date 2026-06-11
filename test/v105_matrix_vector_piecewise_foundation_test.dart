import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/editor/editor_commands.dart';
import 'package:mathpro_flutter_phase17/features/editor/math_node.dart';
import 'package:mathpro_flutter_phase17/features/editor/node_factory.dart';
import 'package:mathpro_flutter_phase17/features/editor/render/math_tex_serializer.dart';
import 'package:mathpro_flutter_phase17/features/editor/slot_registry.dart';
import 'package:mathpro_flutter_phase17/features/editor/tex_serializer.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/structural_renderer_bridge.dart';

void main() {
  group('V105 matrix vector piecewise foundation lock', () {
    test('system templates parse as structural piecewise/system nodes', () {
      final root = NodeFactory.rootFromExpression('{□=□;□=□}');
      final node = root.children.single;
      expect(node.kind, MathNodeKind.piecewise);
      expect(node.meta['type'], 'system');

      final registry = SlotRegistry.fromRoot(root);
      expect(registry.entries.map((entry) => entry.role), containsAll(<String>['systemLeft', 'systemRight']));
      expect(registry.entries.where((entry) => entry.role == 'systemLeft'), hasLength(2));
      expect(registry.entries.where((entry) => entry.role == 'systemRight'), hasLength(2));
      expect(EditorTexSerializer.serialize(node), r'\begin{cases}\Box = \Box \\ \Box = \Box\end{cases}');
    });

    test('filled inequality systems keep left and right slots editable', () {
      final snapshot = StructuralRendererBridge.snapshotForExpression('{x≤1;y≤2}');
      expect(snapshot.registry.entries.map((entry) => entry.role), containsAll(<String>['systemLeft', 'systemRight']));
      expect(snapshot.tex, contains(r'\le'));

      final rightZero = snapshot.registry.entries.firstWhere((entry) => entry.slotKey == 'right_0');
      expect(EditorCommands.replaceSelectedSlot('{x≤1;y≤2}', '5', activeSlotId: rightZero.id), '{x≤5;y≤2}');
      expect(MathTexSerializer.toTex('{x≤5;y≤2}'), contains(r'\begin{cases}'));
    });

    test('n-equation preview keeps only real end rows addressable', () {
      final root = NodeFactory.rootFromExpression('{□=□;…;□=□}');
      final node = root.children.single;
      expect(node.kind, MathNodeKind.piecewise);
      expect(node.meta['shape'], 'nPreview');

      final registry = SlotRegistry.fromRoot(root);
      expect(registry.entries.where((entry) => entry.role == 'systemLeft'), hasLength(2));
      expect(registry.entries.where((entry) => entry.role == 'systemRight'), hasLength(2));
      expect(registry.entries.any((entry) => entry.slotKey == 'left_1' || entry.slotKey == 'right_1'), isFalse);
      expect(EditorTexSerializer.serialize(node), contains(r'\vdots'));
    });

    test('matrix n-preview serialization preserves compact ellipsis layout after edit', () {
      final root = NodeFactory.rootFromExpression('[□ … □; … ; □ … □]');
      final registry = SlotRegistry.fromRoot(root);
      expect(registry.entries.where((entry) => entry.role == 'matrixCell'), hasLength(4));

      final topLeft = registry.entries.firstWhere((entry) => entry.slotKey == 'cell_0_0');
      expect(EditorCommands.replaceSelectedSlot('[□ … □; … ; □ … □]', 'a', activeSlotId: topLeft.id), '[a … □; … ; □ … □]');
    });

    test('vector n-preview remains editable without inventing hidden cells', () {
      final root = NodeFactory.rootFromExpression('[□; … ; □]');
      final registry = SlotRegistry.fromRoot(root);
      expect(registry.entries.where((entry) => entry.role == 'matrixCell'), hasLength(2));

      final bottom = registry.entries.firstWhere((entry) => entry.slotKey == 'cell_2');
      expect(EditorCommands.replaceSelectedSlot('[□; … ; □]', 'z', activeSlotId: bottom.id), '[□; …; z]');
    });
  });
}
