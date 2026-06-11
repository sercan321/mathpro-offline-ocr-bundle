import 'dart:io';
import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/editor/math_node.dart';
import 'package:mathpro_flutter_phase17/features/editor/slot_registry.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/active_empty_slot_leading_rail_finalizer_policy.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/integral_cursor_specialization_policy.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/slot_geometry_bundle_authority.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/structural_intent_resolver_policy.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';

void main() {
  group('V172-Q58 integral cursor specialization', () {
    test('metadata advances to Q58 without claiming real-device +95 PASS', () {
      expect(MathProPackageContract.version, '0.172.112+172');
      expect(MathProPackageContract.pubspecDescription, contains('V172-Q80'));
      expect(MathProPackageContract.auditTitle, contains('Q62'));
      expect(MathProPackageContract.nextPhase, contains('Q81'));
      expect(MathProPackageContract.cursorLineageTitles, contains('V172-Q59 Fraction Function Root Log Specialization'));
      expect(MathProPackageContract.q58IntegralCursorSpecializationRule, contains('d|□'));
      expect(IntegralCursorSpecializationPolicy.integralCursorSpecializationAvailable, isTrue);
      expect(IntegralCursorSpecializationPolicy.realDevicePlus95PassClaimed, isFalse);
    });

    test('differential bundle proves d pipe-box law from leading rail, not hit rect', () {
      const canvas = Size(360, 180);
      const entry = SlotEntry(
        id: 'integral-differential',
        nodeId: 'integral-1',
        nodeKind: MathNodeKind.integral,
        slotKey: 'differential',
        role: 'integralDifferential',
        priority: 120,
        minTouchSize: 88,
        normalizedBounds: NormalizedSlotBounds(left: 0.78, top: 0.28, width: 0.22, height: 0.44),
      );
      final bundle = SlotGeometryBundleAuthority.bundleFor(
        entry: entry,
        visualRect: const Rect.fromLTWH(238, 100, 38, 30),
        placeholderRect: const Rect.fromLTWH(252, 106, 14, 14),
        baselineY: 118,
        canvasSize: canvas,
      );
      final finalized = ActiveEmptySlotLeadingRailFinalizerPolicy.finalizePaintedCaret(
        candidate: const Rect.fromLTWH(8, 90, 2, 24),
        bundle: bundle,
        payload: '□',
        canvasSize: canvas,
      );

      expect(IntegralCursorSpecializationPolicy.isDifferentialRole(bundle.role), isTrue);
      expect(finalized, bundle.leadingRailRect);
      expect(finalized.right, lessThanOrEqualTo(bundle.placeholderRect.left));
      expect(finalized.overlaps(bundle.placeholderRect), isFalse);
      expect(IntegralCursorSpecializationPolicy.provesDifferentialPipeBoxLaw(
        caretRect: finalized,
        placeholderRect: bundle.placeholderRect,
      ), isTrue);
      expect(bundle.caretSourceIsIndependentFromHitRect, isTrue);
    });

    test('integral hit regions suppress detached linear fallback inside integral template envelope', () {
      const canvas = Size(360, 180);
      const upper = SlotEntry(
        id: 'integral-upper',
        nodeId: 'integral-2',
        nodeKind: MathNodeKind.integral,
        slotKey: 'upper',
        role: 'integralUpperLimit',
        priority: 120,
        minTouchSize: 88,
        normalizedBounds: NormalizedSlotBounds(left: 0.00, top: 0.00, width: 0.42, height: 0.36),
      );
      const differential = SlotEntry(
        id: 'integral-differential',
        nodeId: 'integral-2',
        nodeKind: MathNodeKind.integral,
        slotKey: 'differential',
        role: 'integralDifferential',
        priority: 58,
        minTouchSize: 72,
        normalizedBounds: NormalizedSlotBounds(left: 0.78, top: 0.28, width: 0.22, height: 0.44),
      );
      final bundles = SlotGeometryBundleAuthority.buildFromVisualRects(
        visualRects: <SlotEntry, Rect>{
          upper: const Rect.fromLTWH(70, 32, 42, 28),
          differential: const Rect.fromLTWH(242, 94, 38, 30),
        },
        canvasSize: canvas,
      );

      final integralRects = bundles.values
          .where((bundle) => IntegralCursorSpecializationPolicy.isIntegralRole(bundle.role))
          .map((bundle) => bundle.hitRect);
      expect(IntegralCursorSpecializationPolicy.shouldSuppressLinearFallbackForIntegralRegion(
        point: const Offset(236, 110),
        integralHitRects: integralRects,
      ), isTrue);
      expect(IntegralCursorSpecializationPolicy.shouldSuppressLinearFallbackForIntegralRegion(
        point: const Offset(356, 176),
        integralHitRects: integralRects,
      ), isFalse);
    });

    test('structural resolver picks integral differential near d□ instead of detached linear caret', () {
      const canvas = Size(360, 180);
      const body = SlotEntry(
        id: 'integral-body',
        nodeId: 'integral-3',
        nodeKind: MathNodeKind.integral,
        slotKey: 'body',
        role: 'integralBody',
        priority: 84,
        minTouchSize: 82,
        normalizedBounds: NormalizedSlotBounds(left: 0.34, top: 0.20, width: 0.48, height: 0.62),
      );
      const differential = SlotEntry(
        id: 'integral-differential',
        nodeId: 'integral-3',
        nodeKind: MathNodeKind.integral,
        slotKey: 'differential',
        role: 'integralDifferential',
        priority: 58,
        minTouchSize: 72,
        normalizedBounds: NormalizedSlotBounds(left: 0.78, top: 0.28, width: 0.22, height: 0.44),
      );
      final bundles = SlotGeometryBundleAuthority.buildFromVisualRects(
        visualRects: <SlotEntry, Rect>{
          body: const Rect.fromLTWH(120, 72, 70, 56),
          differential: const Rect.fromLTWH(238, 96, 40, 32),
        },
        canvasSize: canvas,
      );
      final hit = StructuralIntentResolverPolicy.resolveIntent(
        point: const Offset(235, 112),
        bundles: bundles,
        primaryHit: null,
        structuralInteractionEnabled: true,
      );

      expect(hit, isNotNull);
      expect(hit!.entry.role, 'integralDifferential');
      expect(hit.source, anyOf(contains('structural-intent'), 'q77-native-integral-slotbox-lane-hit'));
      expect(StructuralIntentResolverPolicy.q58IntegralIntentSpecializationWired, isTrue);
    });

    test('runtime wiring is integral-only and frozen UI surfaces remain untouched', () {
      final interactionSource = File('lib/features/editor/render/editor_interaction_layer.dart').readAsStringSync();
      final bundleSource = File('lib/features/formula_engine/slot_geometry_bundle_authority.dart').readAsStringSync();
      final resolverSource = File('lib/features/formula_engine/structural_intent_resolver_policy.dart').readAsStringSync();
      expect(interactionSource, contains('IntegralCursorSpecializationPolicy.shouldSuppressLinearFallbackForIntegralRegion'));
      expect(bundleSource, contains('IntegralCursorSpecializationPolicy.refineLeadingRailRectForRole'));
      expect(resolverSource, contains('IntegralCursorSpecializationPolicy.roleBonus'));
      expect(interactionSource, isNot(contains('paintVisibleSlotOverlay: true')));
      expect(IntegralCursorSpecializationPolicy.keyboardSurfaceMutationAllowed, isFalse);
      expect(IntegralCursorSpecializationPolicy.moreSurfaceMutationAllowed, isFalse);
      expect(IntegralCursorSpecializationPolicy.longPressSurfaceMutationAllowed, isFalse);
      expect(IntegralCursorSpecializationPolicy.appShellMutationAllowed, isFalse);
      expect(IntegralCursorSpecializationPolicy.graphHistorySolutionMutationAllowed, isFalse);
    });
  });
}
