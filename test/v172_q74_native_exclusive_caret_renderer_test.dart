import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';

import 'package:mathpro_flutter_phase17/features/editor/math_node.dart';
import 'package:mathpro_flutter_phase17/features/editor/slot_registry.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/native_exclusive_placeholder_caret_renderer_policy.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/native_slotbox_painter_policy.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/slot_geometry_bundle_authority.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';

void main() {
  group('V172-Q74 Native Exclusive |□ Caret Renderer', () {
    test('package lineage includes Q74 while current active package advances to Q75', () {
      expect(MathProPackageContract.version, '0.172.112+172');
      expect(MathProPackageContract.cursorLineageVersions, contains('0.172.105+172'));
      expect(MathProPackageContract.cursorLineageTitles, contains('V172-Q74 Native Exclusive |□ Caret Renderer'));
      expect(MathProPackageContract.q74NativeExclusiveCaretRendererRule, contains('|□'));
      expect(NativeExclusivePlaceholderCaretRendererPolicy.realDevicePlus95PassClaimed, isFalse);
    });

    test('empty slot caret cannot use hitRect, trailing rail, or placeholder overlap', () {
      const entry = SlotEntry(
        id: 'node.fn.arg',
        nodeId: 'node.fn',
        nodeKind: MathNodeKind.functionCall,
        slotKey: 'arg',
        role: 'functionArgument',
        priority: 100,
        minTouchSize: 84,
        normalizedBounds: NormalizedSlotBounds(left: 0.24, top: 0.2, width: 0.52, height: 0.6),
      );
      const canvas = Size(360, 160);
      final bundle = SlotGeometryBundleAuthority.bundleFor(
        entry: entry,
        visualRect: const Rect.fromLTWH(110, 48, 62, 52),
        placeholderRect: const Rect.fromLTWH(132, 62, 20, 24),
        baselineY: 82,
        canvasSize: canvas,
      );
      final caret = NativeExclusivePlaceholderCaretRendererPolicy.exclusiveCaretForEmptySlot(
        bundle: bundle,
        candidate: bundle.hitRect,
        payload: '□',
        canvasSize: canvas,
      );

      expect(NativeExclusivePlaceholderCaretRendererPolicy.emptySlotUsesLeadingRailOnly, isTrue);
      expect(NativeExclusivePlaceholderCaretRendererPolicy.emptySlotMayUseHitRectForCaret, isFalse);
      expect(NativeExclusivePlaceholderCaretRendererPolicy.isExclusivePipeBoxCaret(caretRect: caret, bundle: bundle), isTrue);
      expect(caret == bundle.hitRect, isFalse);
      expect(caret == bundle.trailingRailRect, isFalse);
      expect(caret.overlaps(bundle.placeholderRect), isFalse);
    });

    test('native SlotBox painter routes empty slot model through Q74 exclusive renderer', () {
      const entry = SlotEntry(
        id: 'node.frac.numerator',
        nodeId: 'node.frac',
        nodeKind: MathNodeKind.fraction,
        slotKey: 'numerator',
        role: 'fractionNumerator',
        priority: 110,
        minTouchSize: 88,
        normalizedBounds: NormalizedSlotBounds(left: 0.1, top: 0.0, width: 0.8, height: 0.5),
      );
      const canvas = Size(360, 180);
      final bundle = SlotGeometryBundleAuthority.bundleFor(
        entry: entry,
        visualRect: const Rect.fromLTWH(96, 32, 78, 42),
        placeholderRect: const Rect.fromLTWH(124, 44, 22, 20),
        baselineY: 58,
        canvasSize: canvas,
      );
      final model = NativeSlotBoxPainterPolicy.paintModelForBundle(
        bundle: bundle,
        isEmptySlot: true,
        caretIndex: 999,
        childCount: 1,
        canvasSize: canvas,
      );

      expect(NativeSlotBoxPainterPolicy.q74ExclusiveCaretRendererWired, isTrue);
      expect(model.activeEmptySlot, isTrue);
      expect(NativeSlotBoxPainterPolicy.caretIsPaintSafe(model), isTrue);
      expect(NativeExclusivePlaceholderCaretRendererPolicy.isExclusivePipeBoxCaret(caretRect: model.caretRect, bundle: bundle), isTrue);
    });
  });
}
