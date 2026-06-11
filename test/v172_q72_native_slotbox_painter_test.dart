import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';

import 'package:mathpro_flutter_phase17/features/editor/math_node.dart';
import 'package:mathpro_flutter_phase17/features/editor/slot_registry.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/native_slotbox_painter_policy.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/slot_geometry_bundle_authority.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';

void main() {
  group('V172-Q72 Native SlotBox Painter', () {
    test('package identity advances to Q72 without claiming device PASS', () {
      expect(MathProPackageContract.version, '0.172.112+172');
      expect(MathProPackageContract.pubspecDescription, contains('V172-Q80'));
      expect(MathProPackageContract.auditTitle, contains('Q73'));
      expect(MathProPackageContract.nextPhase, contains('Q81'));
      expect(MathProPackageContract.q72NativeSlotBoxPainterRule, contains('SlotGeometryBundle'));
      expect(NativeSlotBoxPainterPolicy.realDevicePlus95PassClaimed, isFalse);
      expect(NativeSlotBoxPainterPolicy.fullNativeMathRendererClaimed, isFalse);
    });

    test('paint model uses the exact SlotGeometryBundle source as hit-test', () {
      const entry = SlotEntry(
        id: 'slot.function.arg',
        nodeId: 'node.function',
        nodeKind: MathNodeKind.functionCall,
        slotKey: 'arg',
        role: 'functionArgument',
        priority: 126,
        minTouchSize: 96,
        normalizedBounds: NormalizedSlotBounds(left: 0.46, top: 0.02, width: 0.54, height: 0.96),
      );
      const canvasSize = Size(360, 160);
      final bundle = SlotGeometryBundleAuthority.bundleFor(
        entry: entry,
        visualRect: const Rect.fromLTWH(120, 44, 62, 58),
        placeholderRect: const Rect.fromLTWH(138, 58, 24, 26),
        baselineY: 82,
        canvasSize: canvasSize,
      );
      final model = NativeSlotBoxPainterPolicy.paintModelForBundle(
        bundle: bundle,
        isEmptySlot: true,
        caretIndex: 1,
        childCount: 1,
        canvasSize: canvasSize,
      );

      expect(NativeSlotBoxPainterPolicy.modelUsesSameBundle(model: model, bundle: bundle), isTrue);
      expect(model.visualRect, bundle.visualRect);
      expect(model.placeholderRect, bundle.placeholderRect);
      expect(model.hitRect, bundle.hitRect);
      expect(model.caretUsesHitRect, isFalse);
      expect(model.activeEmptySlot, isTrue);
      expect(NativeSlotBoxPainterPolicy.caretIsPaintSafe(model), isTrue);
    });

    test('protected UI mutation gates remain closed for Q72', () {
      expect(NativeSlotBoxPainterPolicy.cursorOnlyChange, isTrue);
      expect(NativeSlotBoxPainterPolicy.keyboardSurfaceMutationAllowed, isFalse);
      expect(NativeSlotBoxPainterPolicy.moreSurfaceMutationAllowed, isFalse);
      expect(NativeSlotBoxPainterPolicy.longPressSurfaceMutationAllowed, isFalse);
      expect(NativeSlotBoxPainterPolicy.appShellMutationAllowed, isFalse);
      expect(NativeSlotBoxPainterPolicy.graphHistorySolutionMutationAllowed, isFalse);
      expect(NativeSlotBoxPainterPolicy.visibleSlotBoxesEnabledByDefault, isFalse);
      expect(NativeSlotBoxPainterPolicy.emptySlotPaintLaw, '|□');
    });
  });
}
