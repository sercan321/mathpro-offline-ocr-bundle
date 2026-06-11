import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/editor/math_node.dart';
import 'package:mathpro_flutter_phase17/features/editor/slot_registry.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/deterministic_slot_geometry_registry.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/nested_expression_depth_cursor_policy.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/slot_hit_testing.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';

SlotEntry _slot({
  required String id,
  required String nodeId,
  required String role,
  required int depth,
  int priority = 100,
}) {
  return SlotEntry(
    id: id,
    nodeId: nodeId,
    nodeKind: MathNodeKind.functionCall,
    slotKey: 'arg',
    role: role,
    priority: priority,
    minTouchSize: 56,
    normalizedBounds: const NormalizedSlotBounds(left: 0, top: 0, width: 1, height: 1),
    depth: depth,
  );
}

void main() {
  group('V172-Q41 nested expression depth engine', () {
    test('Q41 lineage remains protected after later Q48 repairs without final +95 PASS claim', () {
      expect(MathProPackageContract.cursorLineageVersions, contains(MathProPackageContract.version));
      expect(MathProPackageContract.cursorLineageTitles, contains('V172-Q41 Nested Expression Depth Engine'));
      expect(MathProPackageContract.pubspecDescription, contains('V172-Q80'));
      expect(MathProPackageContract.auditTitle, contains('Closure'));
      expect(MathProPackageContract.nextPhase, contains('Q81'));
    });

    test('policy declares deepest-slot preference without fake renderer-glyph identity', () {
      expect(NestedExpressionDepthCursorPolicy.version, contains('v172q41'));
      expect(NestedExpressionDepthCursorPolicy.nestedExpressionDepthEngineAvailable, isTrue);
      expect(NestedExpressionDepthCursorPolicy.deepestValidSlotPreferred, isTrue);
      expect(NestedExpressionDepthCursorPolicy.parentSlotStealSuppressed, isTrue);
      expect(NestedExpressionDepthCursorPolicy.rendererGlyphIdentityClaimed, isFalse);
      expect(NestedExpressionDepthCursorPolicy.requiredCorrectNestedTapSelectionsPerTwenty, 19);
    });

    test('nested-depth resolver chooses the inner function argument over its parent', () {
      final outer = _slot(id: 'outer', nodeId: 'outer-ln', role: 'functionArgument', depth: 1, priority: 120);
      final inner = _slot(id: 'inner', nodeId: 'inner-ln', role: 'functionArgument', depth: 3, priority: 120);
      final decision = NestedExpressionDepthCursorPolicy.decideDepthForPoint(
        point: const Offset(110, 60),
        candidates: <NestedSlotCandidate>[
          NestedSlotCandidate(entry: outer, visualRect: const Rect.fromLTWH(40, 30, 160, 64)),
          NestedSlotCandidate(entry: inner, visualRect: const Rect.fromLTWH(86, 42, 60, 36)),
        ],
      );
      expect(decision, isNotNull);
      expect(decision!.slotId, 'inner');
      expect(decision.depth, 3);
    });

    test('slot hit-testing applies nested-depth filtering after role-specific lane filters', () {
      final parent = _slot(id: 'parent-slot', nodeId: 'sin-node', role: 'functionArgument', depth: 1, priority: 120);
      final child = _slot(id: 'child-slot', nodeId: 'cos-node', role: 'functionArgument', depth: 4, priority: 120);
      final result = SlotHitTesting.hitTest(
        const Offset(112, 64),
        <SlotEntry, Rect>{
          parent: const Rect.fromLTWH(44, 28, 160, 72),
          child: const Rect.fromLTWH(92, 48, 58, 34),
        },
      );
      expect(result, isNotNull);
      expect(result!.entry.id, 'child-slot');
      expect(result.entry.depth, 4);
    });

    test('deterministic geometry registry advertises Q41 nested-depth availability', () {
      expect(DeterministicSlotGeometryRegistry.version, contains('v172q41'));
      expect(DeterministicSlotGeometryRegistry.nestedExpressionDepthEngineAvailable, isTrue);
      expect(DeterministicSlotGeometryRegistry.deepestValidSlotPreferred, isTrue);
      expect(DeterministicSlotGeometryRegistry.parentSlotStealSuppressed, isTrue);
    });
  });
}
