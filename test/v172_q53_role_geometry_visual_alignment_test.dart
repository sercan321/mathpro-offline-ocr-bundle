import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/editor/math_node.dart';
import 'package:mathpro_flutter_phase17/features/editor/node_factory.dart';
import 'package:mathpro_flutter_phase17/features/editor/slot_registry.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/active_empty_slot_leading_rail_caret_policy.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/deterministic_slot_geometry_registry.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/native_layout_box_cursor_layer.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/role_geometry_visual_alignment_policy.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/structural_cursor_release_hardening_policy.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';

void main() {
  group('V172-Q53 integral/root/fraction/function role geometry repair', () {
    test('metadata advances to Q53 without claiming real-device +95 PASS', () {
      expect(MathProPackageContract.version, '0.172.112+172');
      expect(MathProPackageContract.title, contains('V172-Q58'));
      expect(MathProPackageContract.pubspecDescription, contains('V172-Q80'));
      expect(MathProPackageContract.auditTitle, contains('Q62'));
      expect(MathProPackageContract.cursorLineageTitles, contains('V172-Q52 Active Empty Slot Leading-Rail Caret Repair'));
      expect(MathProPackageContract.cursorLineageTitles, contains('V172-Q53R3 Real Flutter Log Metadata Repair'));
      expect(MathProPackageContract.q52CaretRule, contains('|□'));
      expect(MathProPackageContract.q53RoleGeometryRule, contains('fraction numerator/denominator'));
      expect(RoleGeometryVisualAlignmentPolicy.realDevicePlus95PassClaimed, isFalse);
      expect(RoleGeometryVisualAlignmentPolicy.keyboardSurfaceMutationAllowed, isFalse);
      expect(RoleGeometryVisualAlignmentPolicy.moreSurfaceMutationAllowed, isFalse);
      expect(RoleGeometryVisualAlignmentPolicy.longPressSurfaceMutationAllowed, isFalse);
      expect(RoleGeometryVisualAlignmentPolicy.appShellMutationAllowed, isFalse);
      expect(RoleGeometryVisualAlignmentPolicy.graphHistorySolutionMutationAllowed, isFalse);
    });

    test('Q53 owns the photographed role families while preserving Q52 leading rail', () {
      for (final role in <String>[
        'fractionNumerator',
        'fractionDenominator',
        'functionArgument',
        'sqrtValue',
        'rootIndex',
        'integralUpperLimit',
        'integralLowerLimit',
        'integralBody',
        'integralDifferential',
        'logBase',
        'powerExponent',
        'subscript',
      ]) {
        expect(RoleGeometryVisualAlignmentPolicy.ownsRole(role), isTrue, reason: role);
      }
      expect(RoleGeometryVisualAlignmentPolicy.activeEmptySlotLeadingRailPreserved, isTrue);
      expect(RoleGeometryVisualAlignmentPolicy.caretInsidePlaceholderAllowed, isFalse);
      expect(ActiveEmptySlotLeadingRailCaretPolicy.q53RoleGeometryVisualAlignmentAvailable, isTrue);
      expect(NativeLayoutBoxCursorLayer.q53RoleGeometryVisualAlignmentAvailable, isTrue);
      expect(StructuralCursorReleaseHardeningPolicy.q53RoleGeometryFinalizerAvailable, isTrue);
    });

    test('active empty fraction/function/root/integral slots keep caret immediately before the placeholder', () {
      const canvas = Size(360, 180);
      for (final role in <String>[
        'fractionDenominator',
        'functionArgument',
        'sqrtValue',
        'integralUpperLimit',
        'integralLowerLimit',
        'integralBody',
        'integralDifferential',
      ]) {
        final entry = SlotEntry(
          id: 'slot-$role',
          nodeId: 'node-$role',
          nodeKind: MathNodeKind.placeholder,
          slotKey: 'value',
          role: role,
          priority: 1,
          minTouchSize: 44,
          normalizedBounds: const NormalizedSlotBounds(left: 0.4, top: 0.4, width: 0.12, height: 0.12),
        );
        final raw = Rect.fromCenter(center: const Offset(180, 90), width: 42, height: 34);
        final geometry = DeterministicSlotGeometryRegistry.geometryFor(entry: entry, rawRect: raw, canvasSize: canvas);
        final caret = NativeLayoutBoxCursorLayer.caretRectForBox(
          visualRect: geometry.rect,
          placeholderRect: geometry.placeholderRect,
          role: role,
          type: NativeLayoutBoxCursorLayer.boxTypeForRole(role),
          baselineY: geometry.baselineY,
          caretIndex: 0,
          childCount: 1,
          canvasSize: canvas,
          activeEmptySlotLeadingRail: true,
        );
        final finalCaret = StructuralCursorReleaseHardeningPolicy.finalizeCaretRect(
          nativeCaretRect: caret,
          visualRect: geometry.rect,
          placeholderRect: geometry.placeholderRect,
          role: role,
          canvasSize: canvas,
          activeEmptySlotLeadingRail: true,
          baselineY: geometry.baselineY,
        );
        expect(finalCaret.overlaps(geometry.placeholderRect), isFalse, reason: role);
        expect(RoleGeometryVisualAlignmentPolicy.isCaretImmediatelyBeforePlaceholder(
          caretRect: finalCaret,
          placeholderRect: geometry.placeholderRect,
          role: role,
        ), isTrue, reason: role);
      }
    });

    test('filled structural slots keep content caret stops instead of forcing every caret to entry rail', () {
      const canvas = Size(360, 180);
      const entry = SlotEntry(
        id: 'fractionDenominator-filled',
        nodeId: 'fraction-filled',
        nodeKind: MathNodeKind.fraction,
        slotKey: 'denominator',
        role: 'fractionDenominator',
        priority: 1,
        minTouchSize: 44,
        normalizedBounds: NormalizedSlotBounds(left: 0.44, top: 0.52, width: 0.14, height: 0.12),
      );
      final geometry = DeterministicSlotGeometryRegistry.geometryFor(
        entry: entry,
        rawRect: Rect.fromCenter(center: const Offset(184, 112), width: 46, height: 34),
        canvasSize: canvas,
      );
      final entryCaret = NativeLayoutBoxCursorLayer.caretRectForBox(
        visualRect: geometry.rect,
        placeholderRect: geometry.placeholderRect,
        role: entry.role,
        type: NativeLayoutBoxCursorLayer.boxTypeForRole(entry.role),
        baselineY: geometry.baselineY,
        caretIndex: 0,
        childCount: 3,
        canvasSize: canvas,
      );
      final middleCaret = NativeLayoutBoxCursorLayer.caretRectForBox(
        visualRect: geometry.rect,
        placeholderRect: geometry.placeholderRect,
        role: entry.role,
        type: NativeLayoutBoxCursorLayer.boxTypeForRole(entry.role),
        baselineY: geometry.baselineY,
        caretIndex: 2,
        childCount: 3,
        canvasSize: canvas,
      );
      expect(middleCaret.left, greaterThan(entryCaret.left));
    });

    test('node factory still exposes structural roles for Q53 core examples', () {
      final examples = <String, String>{
        '□⁄□': 'fractionDenominator',
        'sin(□)': 'functionArgument',
        '√(□)': 'sqrtValue',
        '∫_{□}^{□}(□)d□': 'integralDifferential',
      };
      for (final item in examples.entries) {
        final node = NodeFactory.rootFromExpression(item.key);
        final registry = SlotRegistry.fromRoot(node);
        expect(registry.entries.map((entry) => entry.role), contains(item.value), reason: item.key);
      }
    });
  });
}
