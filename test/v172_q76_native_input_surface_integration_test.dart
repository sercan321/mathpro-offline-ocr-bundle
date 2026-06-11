import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';

import 'package:mathpro_flutter_phase17/features/formula_engine/native_slotbox_input_surface_integration_policy.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/native_slotbox_input_surface_policy.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/native_slotbox_hit_test_policy.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/structural_renderer_bridge.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';

void main() {
  group('V172-Q76 Native Input Surface Integration', () {
    test('package identity advances to Q76 without claiming real-device +95 PASS', () {
      expect(MathProPackageContract.version, '0.172.112+172');
      expect(MathProPackageContract.pubspecDescription, contains('V172-Q80'));
      expect(MathProPackageContract.auditTitle, contains('Q76'));
      expect(MathProPackageContract.nextPhase, contains('Q81'));
      expect(MathProPackageContract.q76NativeInputSurfaceIntegrationRule, contains('single runtime frame'));
      expect(NativeSlotBoxInputSurfaceIntegrationPolicy.realDevicePlus95PassClaimed, isFalse);
      expect(NativeSlotBoxInputSurfaceIntegrationPolicy.singleRuntimeFrameOwnsEditorInteraction, isTrue);
      expect(NativeSlotBoxInputSurfaceIntegrationPolicy.hitTestPainterAndFallbackShareGeometryBundles, isTrue);
    });

    test('buildFrame centralizes mapped rects, geometry bundles and authoritative visual rects', () {
      final snapshot = StructuralRendererBridge.snapshotForExpression('log_□(□)');
      final frame = NativeSlotBoxInputSurfaceIntegrationPolicy.buildFrame(
        expression: 'log_□(□)',
        canvasSize: const Size(360, 180),
        registry: snapshot.registry,
        structuralInteractionEnabled: true,
      );

      expect(frame.source, anyOf('v172q76-native-input-surface-frame', 'v172q76-v172q79-native-input-surface-frame'));
      expect(frame.hasAuthoritativeGeometry, isTrue);
      expect(frame.geometryBundles.length, snapshot.registry.entries.length);
      expect(frame.authorityVisualRects.length, frame.geometryBundles.length);
      expect(frame.mappedVisualRects.length, frame.geometryBundles.length);
      expect(NativeSlotBoxInputSurfaceIntegrationPolicy.frameIsAuthoritative(frame), isTrue);
    });

    test('structural hit-test uses the frame geometry and keeps legacy placeholder guessing blocked', () {
      final snapshot = StructuralRendererBridge.snapshotForExpression('sin(□)');
      final frame = NativeSlotBoxInputSurfaceIntegrationPolicy.buildFrame(
        expression: 'sin(□)',
        canvasSize: const Size(360, 180),
        registry: snapshot.registry,
        structuralInteractionEnabled: true,
      );
      final argumentBundle = frame.geometryBundles.values.firstWhere((bundle) => bundle.role == 'functionArgument');
      final hit = frame.hitTest(argumentBundle.hitRect.center);

      expect(hit, isNotNull);
      expect(hit!.entry.id, argumentBundle.slotId);
      expect(hit.source, anyOf('q73-native-slotbox-authoritative-hitrect', 'q78-native-fraction-function-root-log-slotbox-lane-hit'));
      expect(frame.legacyPlaceholderFallbackAllowed, isFalse);
      expect(frame.shouldBlockDetachedLinearFallbackAt(argumentBundle.hitRect.center), isTrue);
      expect(NativeSlotBoxInputSurfacePolicy.legacyLinearPlaceholderFallbackAllowedWithGeometry, isFalse);
      expect(NativeSlotBoxHitTestPolicy.nearestDistanceFallbackAllowed, isFalse);
    });

    test('protected UI mutation gates remain closed for Q76', () {
      expect(NativeSlotBoxInputSurfaceIntegrationPolicy.cursorOnlyChange, isTrue);
      expect(NativeSlotBoxInputSurfaceIntegrationPolicy.keyboardSurfaceMutationAllowed, isFalse);
      expect(NativeSlotBoxInputSurfaceIntegrationPolicy.moreSurfaceMutationAllowed, isFalse);
      expect(NativeSlotBoxInputSurfaceIntegrationPolicy.longPressSurfaceMutationAllowed, isFalse);
      expect(NativeSlotBoxInputSurfaceIntegrationPolicy.appShellMutationAllowed, isFalse);
      expect(NativeSlotBoxInputSurfaceIntegrationPolicy.graphHistorySolutionMutationAllowed, isFalse);
    });
  });
}
