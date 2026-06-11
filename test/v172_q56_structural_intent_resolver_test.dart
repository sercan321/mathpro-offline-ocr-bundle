import 'dart:io';
import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/editor/math_node.dart';
import 'package:mathpro_flutter_phase17/features/editor/slot_registry.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/slot_geometry_bundle_authority.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/structural_intent_resolver_policy.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';

void main() {
  group('V172-Q56 structural intent resolver', () {
    test('metadata advances to Q56 without claiming real-device +95 PASS', () {
      expect(MathProPackageContract.version, '0.172.112+172');
      expect(MathProPackageContract.pubspecDescription, contains('V172-Q80'));
      expect(MathProPackageContract.auditTitle, contains('Q62'));
      expect(MathProPackageContract.nextPhase, contains('Q81'));
      expect(MathProPackageContract.cursorLineageTitles, contains('V172-Q57 Active Empty Slot Leading-Rail Finalizer'));
      expect(MathProPackageContract.cursorLineageTitles, contains('V172-Q56 Structural Intent Resolver'));
      expect(MathProPackageContract.q56StructuralIntentResolverRule, contains('template-region intent'));
      expect(StructuralIntentResolverPolicy.structuralIntentResolverAvailable, isTrue);
      expect(StructuralIntentResolverPolicy.templateRegionBeatsLinearFallback, isTrue);
      expect(StructuralIntentResolverPolicy.realDevicePlus95PassClaimed, isFalse);
      expect(StructuralIntentResolverPolicy.keyboardSurfaceMutationAllowed, isFalse);
      expect(StructuralIntentResolverPolicy.moreSurfaceMutationAllowed, isFalse);
      expect(StructuralIntentResolverPolicy.longPressSurfaceMutationAllowed, isFalse);
      expect(StructuralIntentResolverPolicy.appShellMutationAllowed, isFalse);
      expect(StructuralIntentResolverPolicy.graphHistorySolutionMutationAllowed, isFalse);
    });

    test('exact bundle hit resolves structural slot before linear fallback', () {
      const canvas = Size(360, 180);
      const differential = SlotEntry(
        id: 'integral-differential',
        nodeId: 'integral-1',
        nodeKind: MathNodeKind.integral,
        slotKey: 'differential',
        role: 'integralDifferential',
        priority: 120,
        minTouchSize: 88,
        normalizedBounds: NormalizedSlotBounds(left: 0.66, top: 0.54, width: 0.18, height: 0.18),
      );
      final bundles = SlotGeometryBundleAuthority.buildFromVisualRects(
        visualRects: <SlotEntry, Rect>{
          differential: const Rect.fromLTWH(242, 98, 36, 30),
        },
        canvasSize: canvas,
      );

      final hit = StructuralIntentResolverPolicy.resolveIntent(
        point: const Offset(248, 110),
        bundles: bundles,
        primaryHit: null,
        structuralInteractionEnabled: true,
      );

      expect(hit, isNotNull);
      expect(hit!.entry.id, 'integral-differential');
      expect(hit.source, anyOf('q56-structural-intent-exact-bundle-hit', 'q77-native-integral-slotbox-lane-hit'));
    });

    test('Q71 disables nearest structural guessing outside authoritative SlotBox hit rects', () {
      const canvas = Size(360, 180);
      const upper = SlotEntry(
        id: 'integral-upper',
        nodeId: 'integral-2',
        nodeKind: MathNodeKind.integral,
        slotKey: 'upper',
        role: 'integralUpperLimit',
        priority: 120,
        minTouchSize: 88,
        normalizedBounds: NormalizedSlotBounds(left: 0.44, top: 0.12, width: 0.12, height: 0.12),
      );
      const body = SlotEntry(
        id: 'integral-body',
        nodeId: 'integral-2',
        nodeKind: MathNodeKind.integral,
        slotKey: 'body',
        role: 'integralBody',
        priority: 110,
        minTouchSize: 88,
        normalizedBounds: NormalizedSlotBounds(left: 0.50, top: 0.40, width: 0.18, height: 0.16),
      );
      final bundles = SlotGeometryBundleAuthority.buildFromVisualRects(
        visualRects: <SlotEntry, Rect>{
          upper: const Rect.fromLTWH(170, 28, 32, 24),
          body: const Rect.fromLTWH(178, 74, 42, 34),
        },
        canvasSize: canvas,
      );

      final hit = StructuralIntentResolverPolicy.resolveIntent(
        point: const Offset(42, 58),
        bundles: bundles,
        primaryHit: null,
        structuralInteractionEnabled: true,
      );

      expect(hit, isNull);
      expect(StructuralIntentResolverPolicy.structuralNearestHitEnabled, isFalse);
      expect(
        StructuralIntentResolverPolicy.shouldSuppressLinearFallbackForTemplateRegion(
          point: const Offset(42, 58),
          bundles: bundles,
          structuralInteractionEnabled: true,
        ),
        isFalse,
      );
    });

    test('outside template region still allows normal linear fallback', () {
      const canvas = Size(360, 180);
      const argument = SlotEntry(
        id: 'function-argument',
        nodeId: 'sin-1',
        nodeKind: MathNodeKind.functionCall,
        slotKey: 'argument',
        role: 'functionArgument',
        priority: 90,
        minTouchSize: 72,
        normalizedBounds: NormalizedSlotBounds(left: 0.45, top: 0.42, width: 0.20, height: 0.18),
      );
      final bundles = SlotGeometryBundleAuthority.buildFromVisualRects(
        visualRects: <SlotEntry, Rect>{
          argument: const Rect.fromLTWH(164, 74, 52, 40),
        },
        canvasSize: canvas,
      );

      expect(
        StructuralIntentResolverPolicy.shouldSuppressLinearFallbackForTemplateRegion(
          point: const Offset(4, 4),
          bundles: bundles,
          structuralInteractionEnabled: true,
        ),
        isFalse,
      );
    });

    test('editor interaction layer is wired to Q56 structural intent resolver', () {
      final interactionSource = File('lib/features/editor/render/editor_interaction_layer.dart').readAsStringSync();
      expect(interactionSource, contains('StructuralIntentResolverPolicy.resolveIntent'));
      expect(interactionSource, contains('shouldSuppressLinearFallbackForTemplateRegion'));
      expect(interactionSource, contains('geometryBundles'));
      expect(interactionSource, contains('ExistingCursorEngineReconciliationPolicy.reconcileStructuralHit'));
      expect(interactionSource, isNot(contains('paintVisibleSlotOverlay: true')));
    });
  });
}
