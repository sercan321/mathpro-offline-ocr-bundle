import 'dart:io';
import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/editor/math_node.dart';
import 'package:mathpro_flutter_phase17/features/editor/slot_registry.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/native_fraction_function_root_log_slotbox_specialization_policy.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/native_slotbox_hit_test_policy.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/native_slotbox_input_surface_integration_policy.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/slot_geometry_bundle_authority.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';

void main() {
  group('V172-Q78 fraction/function/root/log native SlotBox specialization', () {
    test('metadata advances to Q78 without claiming real-device +95 PASS', () {
      expect(MathProPackageContract.version, '0.172.112+172');
      expect(MathProPackageContract.pubspecDescription, contains('V172-Q80'));
      expect(MathProPackageContract.auditTitle, contains('V172-Q80'));
      expect(MathProPackageContract.nextPhase, contains('Q81'));
      expect(MathProPackageContract.cursorLineageTitles, contains('V172-Q78 Fraction Function Root Log Native SlotBox Specialization'));
      expect(MathProPackageContract.q78FractionFunctionRootLogNativeSlotBoxSpecializationRule, contains('log base'));
      expect(NativeFractionFunctionRootLogSlotBoxSpecializationPolicy.realDevicePlus95PassClaimed, isFalse);
      expect(NativeFractionFunctionRootLogSlotBoxSpecializationPolicy.fullNativeMathRendererClaimed, isFalse);
    });

    test('fraction numerator and denominator resolve through native lanes', () {
      final bundles = _fractionBundles();
      final numerator = NativeSlotBoxHitTestPolicy.hitTest(point: const Offset(110, 48), bundles: bundles);
      final denominator = NativeSlotBoxHitTestPolicy.hitTest(point: const Offset(110, 122), bundles: bundles);
      expect(numerator, isNotNull);
      expect(numerator!.entry.role, 'fractionNumerator');
      expect(numerator.source, 'q78-native-fraction-function-root-log-slotbox-lane-hit');
      expect(denominator, isNotNull);
      expect(denominator!.entry.role, 'fractionDenominator');
      expect(denominator.source, 'q78-native-fraction-function-root-log-slotbox-lane-hit');
    });

    test('log base and argument resolve without cross-lane guessing', () {
      final bundles = _logBundles();
      final base = NativeSlotBoxHitTestPolicy.hitTest(point: const Offset(72, 118), bundles: bundles);
      final argument = NativeSlotBoxHitTestPolicy.hitTest(point: const Offset(164, 90), bundles: bundles);
      expect(base, isNotNull);
      expect(base!.entry.role, 'logBase');
      expect(base.source, 'q78-native-fraction-function-root-log-slotbox-lane-hit');
      expect(argument, isNotNull);
      expect(argument!.entry.role, 'functionArgument');
      expect(argument.source, 'q78-native-fraction-function-root-log-slotbox-lane-hit');
    });

    test('root index and body resolve as separate native SlotBoxes', () {
      final bundles = _rootBundles();
      final index = NativeSlotBoxHitTestPolicy.hitTest(point: const Offset(54, 46), bundles: bundles);
      final body = NativeSlotBoxHitTestPolicy.hitTest(point: const Offset(146, 90), bundles: bundles);
      expect(index, isNotNull);
      expect(index!.entry.role, 'rootIndex');
      expect(body, isNotNull);
      expect(body!.entry.role, 'sqrtValue');
    });

    test('native families suppress detached linear fallback only inside measured SlotBoxes', () {
      final bundles = _logBundles();
      final base = bundles.values.singleWhere((bundle) => bundle.role == 'logBase');
      expect(NativeFractionFunctionRootLogSlotBoxSpecializationPolicy.provesPipeBoxLaw(bundle: base), isTrue);
      expect(NativeFractionFunctionRootLogSlotBoxSpecializationPolicy.shouldSuppressDetachedLinearFallback(
        point: base.placeholderRect.center,
        bundles: bundles.values,
      ), isTrue);
      expect(NativeFractionFunctionRootLogSlotBoxSpecializationPolicy.shouldSuppressDetachedLinearFallback(
        point: const Offset(330, 170),
        bundles: bundles.values,
      ), isFalse);
    });

    test('runtime wiring remains cursor-only and protected surfaces are untouched', () {
      final hitTestSource = File('lib/features/formula_engine/native_slotbox_hit_test_policy.dart').readAsStringSync();
      final bundleSource = File('lib/features/formula_engine/slot_geometry_bundle_authority.dart').readAsStringSync();
      final integrationSource = File('lib/features/formula_engine/native_slotbox_input_surface_integration_policy.dart').readAsStringSync();
      expect(hitTestSource, contains('NativeFractionFunctionRootLogSlotBoxSpecializationPolicy.resolveNativeCandidate'));
      expect(bundleSource, contains('NativeFractionFunctionRootLogSlotBoxSpecializationPolicy.refineHitRectForRole'));
      expect(integrationSource, contains('hasNativeFractionFunctionRootLogSlotSet'));
      expect(NativeSlotBoxInputSurfaceIntegrationPolicy.q78FractionFunctionRootLogSlotBoxesRideSameInputSurfaceFrame, isTrue);
      expect(NativeFractionFunctionRootLogSlotBoxSpecializationPolicy.keyboardSurfaceMutationAllowed, isFalse);
      expect(NativeFractionFunctionRootLogSlotBoxSpecializationPolicy.moreSurfaceMutationAllowed, isFalse);
      expect(NativeFractionFunctionRootLogSlotBoxSpecializationPolicy.longPressSurfaceMutationAllowed, isFalse);
      expect(NativeFractionFunctionRootLogSlotBoxSpecializationPolicy.appShellMutationAllowed, isFalse);
      expect(NativeFractionFunctionRootLogSlotBoxSpecializationPolicy.graphHistorySolutionMutationAllowed, isFalse);
    });
  });
}

Map<SlotEntry, SlotGeometryBundle> _fractionBundles() {
  const canvas = Size(360, 180);
  const numerator = SlotEntry(
    id: 'fraction-numerator',
    nodeId: 'fraction-native-1',
    nodeKind: MathNodeKind.fraction,
    slotKey: 'numerator',
    role: 'fractionNumerator',
    priority: 110,
    minTouchSize: 76,
    normalizedBounds: NormalizedSlotBounds(left: 0.20, top: 0.12, width: 0.36, height: 0.28),
  );
  const denominator = SlotEntry(
    id: 'fraction-denominator',
    nodeId: 'fraction-native-1',
    nodeKind: MathNodeKind.fraction,
    slotKey: 'denominator',
    role: 'fractionDenominator',
    priority: 110,
    minTouchSize: 76,
    normalizedBounds: NormalizedSlotBounds(left: 0.20, top: 0.60, width: 0.36, height: 0.28),
  );
  return SlotGeometryBundleAuthority.buildFromVisualRects(
    visualRects: <SlotEntry, Rect>{
      numerator: const Rect.fromLTWH(84, 34, 58, 28),
      denominator: const Rect.fromLTWH(84, 108, 58, 28),
    },
    canvasSize: canvas,
  );
}

Map<SlotEntry, SlotGeometryBundle> _logBundles() {
  const canvas = Size(360, 180);
  const base = SlotEntry(
    id: 'log-base',
    nodeId: 'log-native-1',
    nodeKind: MathNodeKind.functionCall,
    slotKey: 'base',
    role: 'logBase',
    priority: 118,
    minTouchSize: 64,
    normalizedBounds: NormalizedSlotBounds(left: 0.12, top: 0.58, width: 0.18, height: 0.20),
  );
  const argument = SlotEntry(
    id: 'log-argument',
    nodeId: 'log-native-1',
    nodeKind: MathNodeKind.functionCall,
    slotKey: 'argument',
    role: 'functionArgument',
    priority: 90,
    minTouchSize: 72,
    normalizedBounds: NormalizedSlotBounds(left: 0.36, top: 0.38, width: 0.34, height: 0.34),
  );
  return SlotGeometryBundleAuthority.buildFromVisualRects(
    visualRects: <SlotEntry, Rect>{
      base: const Rect.fromLTWH(58, 106, 28, 22),
      argument: const Rect.fromLTWH(132, 72, 66, 42),
    },
    canvasSize: canvas,
  );
}

Map<SlotEntry, SlotGeometryBundle> _rootBundles() {
  const canvas = Size(360, 180);
  const index = SlotEntry(
    id: 'root-index',
    nodeId: 'root-native-1',
    nodeKind: MathNodeKind.indexedRoot,
    slotKey: 'index',
    role: 'rootIndex',
    priority: 112,
    minTouchSize: 64,
    normalizedBounds: NormalizedSlotBounds(left: 0.10, top: 0.16, width: 0.18, height: 0.20),
  );
  const body = SlotEntry(
    id: 'root-body',
    nodeId: 'root-native-1',
    nodeKind: MathNodeKind.indexedRoot,
    slotKey: 'body',
    role: 'sqrtValue',
    priority: 92,
    minTouchSize: 76,
    normalizedBounds: NormalizedSlotBounds(left: 0.34, top: 0.36, width: 0.38, height: 0.34),
  );
  return SlotGeometryBundleAuthority.buildFromVisualRects(
    visualRects: <SlotEntry, Rect>{
      index: const Rect.fromLTWH(42, 34, 26, 22),
      body: const Rect.fromLTWH(118, 70, 82, 44),
    },
    canvasSize: canvas,
  );
}
