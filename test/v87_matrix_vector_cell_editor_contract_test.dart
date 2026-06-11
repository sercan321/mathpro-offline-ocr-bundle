import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';

import 'package:mathpro_flutter_phase17/features/editor/math_node.dart';
import 'package:mathpro_flutter_phase17/features/editor/matrix_cell_navigation_policy.dart';
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
  group('MathPro V87 matrix/vector real cell editor contract', () {
    test('parses placeholder and filled matrices as matrix nodes with addressable row-major cells', () {
      final empty = NodeFactory.rootFromExpression('[□ □; □ □]');
      final filled = NodeFactory.rootFromExpression('[1 2; 3 4]');
      expect(empty.children.first.kind, MathNodeKind.matrix);
      expect(filled.children.first.kind, MathNodeKind.matrix);

      final emptyMatrix = empty.children.first;
      final filledMatrix = filled.children.first;
      expect(MatrixCellNavigationPolicy.orderedCellKeys(emptyMatrix), <String>['cell_0_0', 'cell_0_1', 'cell_1_0', 'cell_1_1']);
      expect(MatrixCellNavigationPolicy.orderedCellKeys(filledMatrix), <String>['cell_0_0', 'cell_0_1', 'cell_1_0', 'cell_1_1']);

      final registry = SlotRegistry.build(filled);
      final cells = MatrixCellNavigationPolicy.orderedCellEntries(registry.entries);
      expect(cells.map((entry) => entry.slotKey), <String>['cell_0_0', 'cell_0_1', 'cell_1_0', 'cell_1_1']);
      expect(cells.every((entry) => entry.role == 'matrixCell'), isTrue);
      expect(EditorTexSerializer.serialize(filled), r'\begin{bmatrix}1 & 2 \\ 3 & 4\end{bmatrix}');
    });

    test('parses column and row vectors as vector nodes with real editable cells', () {
      final column = NodeFactory.rootFromExpression('[5; 6; 7]');
      final row = NodeFactory.rootFromExpression('[5 6 7]');
      expect(column.children.first.kind, MathNodeKind.vector);
      expect(row.children.first.kind, MathNodeKind.vector);
      expect(column.children.first.meta['column'], isTrue);
      expect(row.children.first.meta['column'], isFalse);

      expect(MatrixCellNavigationPolicy.orderedCellKeys(column.children.first), <String>['cell_0', 'cell_1', 'cell_2']);
      expect(MatrixCellNavigationPolicy.orderedCellKeys(row.children.first), <String>['cell_0', 'cell_1', 'cell_2']);
      expect(EditorTexSerializer.serialize(column), r'\begin{bmatrix}5 \\ 6 \\ 7\end{bmatrix}');
      expect(EditorTexSerializer.serialize(row), r'\begin{bmatrix}5 & 6 & 7\end{bmatrix}');
    });

    test('keeps matrix hit-test geometry two-dimensional instead of flattening rows to one line', () {
      const expression = '[□ □; □ □]';
      const canvas = Size(720, 220);
      final snapshot = StructuralRendererBridge.snapshotForExpression(expression);
      final layout = MathLayoutEngine.deriveSlotRects(canvasSize: canvas, registry: snapshot.registry);
      final resolved = RenderMappedSlotHitTest.resolveSlotRects(
        expression: expression,
        canvasSize: canvas,
        registry: snapshot.registry,
        baseLayout: layout,
      );
      final cells = MatrixCellNavigationPolicy.orderedCellEntries(resolved.keys);
      expect(cells.length, 4);

      final rects = <String, Rect>{for (final entry in cells) entry.slotKey: resolved[entry]!};
      expect(rects['cell_0_0']!.center.dy, lessThan(rects['cell_1_0']!.center.dy));
      expect(rects['cell_0_1']!.center.dy, lessThan(rects['cell_1_1']!.center.dy));
      expect(rects['cell_0_0']!.center.dx, lessThan(rects['cell_0_1']!.center.dx));
      expect(rects['cell_1_0']!.center.dx, lessThan(rects['cell_1_1']!.center.dx));

      for (final entry in cells) {
        final hit = SlotHitTesting.hitTest(resolved[entry]!.center, resolved);
        expect(hit?.entry.slotKey, entry.slotKey, reason: entry.slotKey);
      }
    });

    test('orders matrix cells row-major for focus advancement', () {
      final snapshot = StructuralRendererBridge.snapshotForExpression('[□ □ □; □ □ □; □ □ □]');
      final ordered = TemplateSlotNavigationPolicy.orderedSlots(snapshot.registry.entries).where((entry) => entry.role == 'matrixCell').toList(growable: false);
      expect(ordered.map((entry) => entry.slotKey), <String>[
        'cell_0_0', 'cell_0_1', 'cell_0_2',
        'cell_1_0', 'cell_1_1', 'cell_1_2',
        'cell_2_0', 'cell_2_1', 'cell_2_2',
      ]);
      expect(MatrixCellNavigationPolicy.nextCell(ordered, ordered[2])?.slotKey, 'cell_1_0');
      expect(MatrixCellNavigationPolicy.previousCell(ordered, ordered[3])?.slotKey, 'cell_0_2');
    });

    test('binds public lineer algebra matrix/vector keys to real matrix/vector node specs', () {
      final labels = <String, MathNodeKind>{
        '2×2': MathNodeKind.matrix,
        '3×3': MathNodeKind.matrix,
        '4×4': MathNodeKind.matrix,
        'm×n': MathNodeKind.matrix,
        '0 matris': MathNodeKind.matrix,
        '2D vektör': MathNodeKind.vector,
        '3D vektör': MathNodeKind.vector,
        'nD vektör': MathNodeKind.vector,
        'satır vektörü': MathNodeKind.vector,
        'sütun vektörü': MathNodeKind.vector,
      };

      for (final item in labels.entries) {
        final spec = PremiumMathKeySpecs.specFor(item.key)!;
        final action = ActionUtils.templateSpecForStructure(item.key);
        expect(spec.expectedRootKind, item.value, reason: item.key);
        expect(spec.focusRole, 'matrixCell', reason: item.key);
        expect(action.expression, spec.expression, reason: item.key);
        final root = NodeFactory.rootFromExpression(action.expression);
        expect(root.children.first.kind, item.value, reason: item.key);
      }
    });
  });
}
