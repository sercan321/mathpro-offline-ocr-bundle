import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';

import 'package:mathpro_flutter_phase17/features/editor/math_node.dart';
import 'package:mathpro_flutter_phase17/features/editor/slot_registry.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/existing_cursor_engine_reconciliation_policy.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/native_slotbox_hit_test_policy.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/slot_geometry_bundle_authority.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';

void main() {
  group('V172-Q73 Native SlotBox Hit-Test Engine', () {
    test('package identity advances to Q73 without claiming device PASS', () {
      expect(MathProPackageContract.version, '0.172.112+172');
      expect(MathProPackageContract.pubspecDescription, contains('V172-Q80'));
      expect(MathProPackageContract.auditTitle, contains('Q73'));
      expect(MathProPackageContract.nextPhase, contains('Q81'));
      expect(MathProPackageContract.q73NativeSlotBoxHitTestRule, contains('authoritative hitRect'));
      expect(NativeSlotBoxHitTestPolicy.realDevicePlus95PassClaimed, isFalse);
      expect(NativeSlotBoxHitTestPolicy.nearestDistanceFallbackAllowed, isFalse);
    });

    test('structural taps route only through authoritative SlotGeometryBundle hitRects', () {
      const canvasSize = Size(420, 180);
      const baseEntry = SlotEntry(
        id: 'slot.log.base',
        nodeId: 'node.log',
        nodeKind: MathNodeKind.logBase,
        slotKey: 'base',
        role: 'logBase',
        priority: 138,
        minTouchSize: 84,
        normalizedBounds: NormalizedSlotBounds(left: 0.22, top: 0.48, width: 0.30, height: 0.48),
      );
      const argumentEntry = SlotEntry(
        id: 'slot.log.argument',
        nodeId: 'node.log',
        nodeKind: MathNodeKind.logBase,
        slotKey: 'arg',
        role: 'functionArgument',
        priority: 126,
        minTouchSize: 96,
        normalizedBounds: NormalizedSlotBounds(left: 0.46, top: 0.02, width: 0.54, height: 0.96),
      );
      final baseBundle = SlotGeometryBundleAuthority.bundleFor(
        entry: baseEntry,
        visualRect: const Rect.fromLTWH(84, 96, 34, 32),
        placeholderRect: const Rect.fromLTWH(94, 104, 14, 16),
        baselineY: 118,
        canvasSize: canvasSize,
      );
      final argumentBundle = SlotGeometryBundleAuthority.bundleFor(
        entry: argumentEntry,
        visualRect: const Rect.fromLTWH(150, 48, 68, 66),
        placeholderRect: const Rect.fromLTWH(172, 66, 24, 28),
        baselineY: 86,
        canvasSize: canvasSize,
      );
      final bundles = <SlotEntry, SlotGeometryBundle>{
        baseEntry: baseBundle,
        argumentEntry: argumentBundle,
      };
      final resultBase = NativeSlotBoxHitTestPolicy.hitTest(
        point: baseBundle.placeholderRect.center,
        bundles: bundles,
      );
      final resultArgument = NativeSlotBoxHitTestPolicy.hitTest(
        point: argumentBundle.placeholderRect.center,
        bundles: bundles,
      );
      final resultOutside = NativeSlotBoxHitTestPolicy.hitTest(
        point: const Offset(404, 168),
        bundles: bundles,
      );

      expect(resultBase?.entry.id, 'slot.log.base');
      expect(resultBase?.source, anyOf('q73-native-slotbox-authoritative-hitrect', 'q78-native-fraction-function-root-log-slotbox-lane-hit'));
      expect(resultArgument?.entry.id, 'slot.log.argument');
      expect(resultOutside, isNull);
    });

    test('Q73 blocks the old nearest structural reconciliation fallback', () {
      const entry = SlotEntry(
        id: 'slot.fraction.denominator',
        nodeId: 'node.fraction',
        nodeKind: MathNodeKind.fraction,
        slotKey: 'denominator',
        role: 'fractionDenominator',
        priority: 112,
        minTouchSize: 88,
        normalizedBounds: NormalizedSlotBounds(left: 0.00, top: 0.54, width: 1.00, height: 0.46),
      );
      final result = ExistingCursorEngineReconciliationPolicy.reconcileStructuralHit(
        point: const Offset(165, 140),
        visualRects: <SlotEntry, Rect>{entry: const Rect.fromLTWH(120, 84, 54, 34)},
        primaryHit: null,
        structuralInteractionEnabled: true,
      );

      expect(NativeSlotBoxHitTestPolicy.legacyNearestStructuralFallbackAllowed, isFalse);
      expect(ExistingCursorEngineReconciliationPolicy.nearestStructuralFallbackEnabled, isFalse);
      expect(result, isNull);
    });

    test('protected UI mutation gates remain closed for Q73', () {
      expect(NativeSlotBoxHitTestPolicy.cursorOnlyChange, isTrue);
      expect(NativeSlotBoxHitTestPolicy.keyboardSurfaceMutationAllowed, isFalse);
      expect(NativeSlotBoxHitTestPolicy.moreSurfaceMutationAllowed, isFalse);
      expect(NativeSlotBoxHitTestPolicy.longPressSurfaceMutationAllowed, isFalse);
      expect(NativeSlotBoxHitTestPolicy.appShellMutationAllowed, isFalse);
      expect(NativeSlotBoxHitTestPolicy.graphHistorySolutionMutationAllowed, isFalse);
      expect(NativeSlotBoxHitTestPolicy.fullNativeMathRendererClaimed, isFalse);
    });
  });
}
