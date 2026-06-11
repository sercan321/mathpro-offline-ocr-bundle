import 'dart:io';
import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/editor/math_node.dart';
import 'package:mathpro_flutter_phase17/features/editor/slot_registry.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/native_integral_slotbox_specialization_policy.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/native_slotbox_hit_test_policy.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/native_slotbox_input_surface_integration_policy.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/slot_geometry_bundle_authority.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';

void main() {
  group('V172-Q77 integral native SlotBox specialization', () {
    test('metadata advances to Q77 without claiming real-device +95 PASS', () {
      expect(MathProPackageContract.version, '0.172.112+172');
      expect(MathProPackageContract.pubspecDescription, contains('V172-Q80'));
      expect(MathProPackageContract.auditTitle, contains('V172-Q80'));
      expect(MathProPackageContract.nextPhase, contains('Q81'));
      expect(MathProPackageContract.cursorLineageTitles, contains('V172-Q77 Integral Native SlotBox Specialization'));
      expect(MathProPackageContract.q77IntegralNativeSlotBoxSpecializationRule, contains('d□'));
      expect(NativeIntegralSlotBoxSpecializationPolicy.realDevicePlus95PassClaimed, isFalse);
      expect(NativeIntegralSlotBoxSpecializationPolicy.fullNativeMathRendererClaimed, isFalse);
    });

    test('native integral SlotBox frame exposes upper lower body and differential roles', () {
      final bundles = _integralBundles();
      expect(NativeIntegralSlotBoxSpecializationPolicy.hasCompleteIntegralSlotSet(bundles.values), isTrue);
      expect(NativeSlotBoxInputSurfaceIntegrationPolicy.q77IntegralNativeSlotBoxesRideSameInputSurfaceFrame, isTrue);
      expect(bundles.values.map((bundle) => bundle.role), containsAll(<String>{
        'integralUpperLimit',
        'integralLowerLimit',
        'integralBody',
        'integralDifferential',
      }));
    });

    test('overlapping body and differential hitRects resolve to differential lane near d□', () {
      final bundles = _integralBundles();
      final hit = NativeSlotBoxHitTestPolicy.hitTest(
        point: const Offset(242, 100),
        bundles: bundles,
      );

      expect(hit, isNotNull);
      expect(hit!.entry.role, 'integralDifferential');
      expect(hit.source, 'q77-native-integral-slotbox-lane-hit');
      expect(NativeIntegralSlotBoxSpecializationPolicy.differentialSlotBeatsBodyWhenPointIsInDifferentialLane, isTrue);
    });

    test('native integral lane resolver keeps body taps in body instead of d□', () {
      final bundles = _integralBundles();
      final hit = NativeSlotBoxHitTestPolicy.hitTest(
        point: const Offset(166, 96),
        bundles: bundles,
      );

      expect(hit, isNotNull);
      expect(hit!.entry.role, 'integralBody');
      expect(hit.source, 'q77-native-integral-slotbox-lane-hit');
    });

    test('upper and lower integral limit lanes remain deterministic', () {
      final bundles = _integralBundles();
      final upper = NativeSlotBoxHitTestPolicy.hitTest(point: const Offset(88, 36), bundles: bundles);
      final lower = NativeSlotBoxHitTestPolicy.hitTest(point: const Offset(88, 136), bundles: bundles);

      expect(upper, isNotNull);
      expect(upper!.entry.role, 'integralUpperLimit');
      expect(lower, isNotNull);
      expect(lower!.entry.role, 'integralLowerLimit');
    });

    test('differential native SlotBox proves d|□ and blocks detached linear fallback only inside measured slot', () {
      final bundles = _integralBundles();
      final differential = bundles.values.singleWhere((bundle) => bundle.role == 'integralDifferential');

      expect(NativeIntegralSlotBoxSpecializationPolicy.provesDifferentialNativeDPipeBox(bundle: differential), isTrue);
      expect(NativeIntegralSlotBoxSpecializationPolicy.shouldSuppressDetachedLinearFallback(
        point: differential.placeholderRect.center,
        bundles: bundles.values,
      ), isTrue);
      expect(NativeIntegralSlotBoxSpecializationPolicy.shouldSuppressDetachedLinearFallback(
        point: const Offset(356, 176),
        bundles: bundles.values,
      ), isFalse);
    });

    test('runtime wiring is cursor-only and protected surfaces are untouched', () {
      final hitTestSource = File('lib/features/formula_engine/native_slotbox_hit_test_policy.dart').readAsStringSync();
      final bundleSource = File('lib/features/formula_engine/slot_geometry_bundle_authority.dart').readAsStringSync();
      final integrationSource = File('lib/features/formula_engine/native_slotbox_input_surface_integration_policy.dart').readAsStringSync();
      expect(hitTestSource, contains('NativeIntegralSlotBoxSpecializationPolicy.resolveIntegralCandidate'));
      expect(bundleSource, contains('NativeIntegralSlotBoxSpecializationPolicy.refineHitRectForRole'));
      expect(integrationSource, contains('hasCompleteNativeIntegralSlotSet'));
      expect(hitTestSource, isNot(contains('nearestDistanceFallbackAllowed = true')));
      expect(NativeIntegralSlotBoxSpecializationPolicy.keyboardSurfaceMutationAllowed, isFalse);
      expect(NativeIntegralSlotBoxSpecializationPolicy.moreSurfaceMutationAllowed, isFalse);
      expect(NativeIntegralSlotBoxSpecializationPolicy.longPressSurfaceMutationAllowed, isFalse);
      expect(NativeIntegralSlotBoxSpecializationPolicy.appShellMutationAllowed, isFalse);
      expect(NativeIntegralSlotBoxSpecializationPolicy.graphHistorySolutionMutationAllowed, isFalse);
    });
  });
}

Map<SlotEntry, SlotGeometryBundle> _integralBundles() {
  const canvas = Size(360, 180);
  const upper = SlotEntry(
    id: 'integral-upper',
    nodeId: 'integral-native-1',
    nodeKind: MathNodeKind.integral,
    slotKey: 'upper',
    role: 'integralUpperLimit',
    priority: 120,
    minTouchSize: 88,
    normalizedBounds: NormalizedSlotBounds(left: 0.00, top: 0.00, width: 0.42, height: 0.36),
  );
  const lower = SlotEntry(
    id: 'integral-lower',
    nodeId: 'integral-native-1',
    nodeKind: MathNodeKind.integral,
    slotKey: 'lower',
    role: 'integralLowerLimit',
    priority: 120,
    minTouchSize: 88,
    normalizedBounds: NormalizedSlotBounds(left: 0.00, top: 0.64, width: 0.42, height: 0.36),
  );
  const body = SlotEntry(
    id: 'integral-body',
    nodeId: 'integral-native-1',
    nodeKind: MathNodeKind.integral,
    slotKey: 'body',
    role: 'integralBody',
    priority: 84,
    minTouchSize: 82,
    normalizedBounds: NormalizedSlotBounds(left: 0.34, top: 0.20, width: 0.48, height: 0.62),
  );
  const differential = SlotEntry(
    id: 'integral-differential',
    nodeId: 'integral-native-1',
    nodeKind: MathNodeKind.integral,
    slotKey: 'differential',
    role: 'integralDifferential',
    priority: 58,
    minTouchSize: 72,
    normalizedBounds: NormalizedSlotBounds(left: 0.78, top: 0.28, width: 0.22, height: 0.44),
  );
  return SlotGeometryBundleAuthority.buildFromVisualRects(
    visualRects: <SlotEntry, Rect>{
      upper: const Rect.fromLTWH(72, 24, 42, 26),
      lower: const Rect.fromLTWH(72, 130, 42, 26),
      body: const Rect.fromLTWH(130, 70, 88, 56),
      differential: const Rect.fromLTWH(236, 84, 40, 32),
    },
    canvasSize: canvas,
  );
}
