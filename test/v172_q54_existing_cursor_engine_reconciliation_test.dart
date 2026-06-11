import 'dart:io';
import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/editor/math_node.dart';
import 'package:mathpro_flutter_phase17/features/editor/slot_registry.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/existing_cursor_engine_reconciliation_policy.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';

void main() {
  group('V172-Q54 existing cursor engine reconciliation', () {
    test('metadata advances to Q54 without claiming real-device +95 PASS', () {
      expect(MathProPackageContract.version, '0.172.112+172');
      expect(MathProPackageContract.pubspecDescription, contains('V172-Q80'));
      expect(MathProPackageContract.auditTitle, contains('Q62'));
      expect(MathProPackageContract.nextPhase, contains('Q81'));
      expect(MathProPackageContract.cursorLineageTitles, contains('V172-Q54 Existing Cursor Engine Reconciliation'));
      expect(MathProPackageContract.q54ExistingCursorEngineReconciliationRule, contains('structural-first'));
      expect(ExistingCursorEngineReconciliationPolicy.existingCursorEngineReconciled, isTrue);
      expect(ExistingCursorEngineReconciliationPolicy.existingCursorMotorPreserved, isTrue);
      expect(ExistingCursorEngineReconciliationPolicy.realDevicePlus95PassClaimed, isFalse);
    });

    test('slot interaction is separated from visible overlay painting', () {
      const entry = SlotEntry(
        id: 'integral-upper',
        nodeId: 'integral-1',
        nodeKind: MathNodeKind.integral,
        slotKey: 'upper',
        role: 'integralUpperLimit',
        priority: 120,
        minTouchSize: 88,
        normalizedBounds: NormalizedSlotBounds(left: 0, top: 0, width: 0.42, height: 0.36),
      );
      const registry = SlotRegistry(version: 'q54-test', entries: <SlotEntry>[entry]);

      expect(
        ExistingCursorEngineReconciliationPolicy.slotInteractionEnabled(
          rendererPolicyAllowsSlots: false,
          registry: registry,
          expression: '∫_{□}^{□}(□)d□',
        ),
        isTrue,
      );
      expect(ExistingCursorEngineReconciliationPolicy.slotInteractionSeparatedFromVisibleOverlay, isTrue);
      expect(ExistingCursorEngineReconciliationPolicy.keyboardSurfaceMutationAllowed, isFalse);
      expect(ExistingCursorEngineReconciliationPolicy.moreSurfaceMutationAllowed, isFalse);
      expect(ExistingCursorEngineReconciliationPolicy.longPressSurfaceMutationAllowed, isFalse);
      expect(ExistingCursorEngineReconciliationPolicy.appShellMutationAllowed, isFalse);
      expect(ExistingCursorEngineReconciliationPolicy.graphHistorySolutionMutationAllowed, isFalse);
    });

    test('structural nearest fallback is blocked after Q71/Q73 native SlotBox hardening', () {
      const upper = SlotEntry(
        id: 'integral-upper',
        nodeId: 'integral-1',
        nodeKind: MathNodeKind.integral,
        slotKey: 'upper',
        role: 'integralUpperLimit',
        priority: 120,
        minTouchSize: 88,
        normalizedBounds: NormalizedSlotBounds(left: 0, top: 0, width: 0.42, height: 0.36),
      );
      const lower = SlotEntry(
        id: 'integral-lower',
        nodeId: 'integral-1',
        nodeKind: MathNodeKind.integral,
        slotKey: 'lower',
        role: 'integralLowerLimit',
        priority: 120,
        minTouchSize: 88,
        normalizedBounds: NormalizedSlotBounds(left: 0, top: 0.64, width: 0.42, height: 0.36),
      );
      final visualRects = <SlotEntry, Rect>{
        upper: const Rect.fromLTWH(190, 34, 32, 24),
        lower: const Rect.fromLTWH(180, 116, 32, 24),
      };

      final hit = ExistingCursorEngineReconciliationPolicy.reconcileStructuralHit(
        point: const Offset(176, 42),
        visualRects: visualRects,
        primaryHit: null,
        structuralInteractionEnabled: true,
      );

      expect(hit, isNull);
      expect(ExistingCursorEngineReconciliationPolicy.nearestStructuralFallbackEnabled, isFalse);
      expect(ExistingCursorEngineReconciliationPolicy.directNearestStructuralHitHardBlocked, isTrue);
    });

    test('structural template region suppresses detached linear fallback', () {
      const body = SlotEntry(
        id: 'integral-body',
        nodeId: 'integral-1',
        nodeKind: MathNodeKind.integral,
        slotKey: 'body',
        role: 'integralBody',
        priority: 84,
        minTouchSize: 82,
        normalizedBounds: NormalizedSlotBounds(left: 0.34, top: 0.20, width: 0.48, height: 0.62),
      );
      final visualRects = <SlotEntry, Rect>{
        body: const Rect.fromLTWH(220, 70, 48, 42),
      };

      expect(
        ExistingCursorEngineReconciliationPolicy.shouldSuppressLinearFallback(
          point: const Offset(172, 82),
          visualRects: visualRects,
          structuralInteractionEnabled: true,
        ),
        isTrue,
      );
      expect(
        ExistingCursorEngineReconciliationPolicy.shouldSuppressLinearFallback(
          point: const Offset(4, 4),
          visualRects: visualRects,
          structuralInteractionEnabled: true,
        ),
        isFalse,
      );
    });

    test('empty structural payloads keep the Q52 leading-rail caret index law', () {
      expect(
        ExistingCursorEngineReconciliationPolicy.reconciledStructuralCaretIndex(
          payload: '□',
          role: 'integralDifferential',
          requestedCaretIndex: 1,
        ),
        0,
      );
      expect(
        ExistingCursorEngineReconciliationPolicy.reconciledStructuralCaretIndex(
          payload: '300',
          role: 'functionArgument',
          requestedCaretIndex: 2,
        ),
        2,
      );
    });

    test('editor interaction layer is wired to Q54 without visible green overlay', () {
      final source = File('lib/features/editor/render/editor_interaction_layer.dart').readAsStringSync();
      expect(source, contains('ExistingCursorEngineReconciliationPolicy.slotInteractionEnabled'));
      expect(source, contains('reconcileStructuralHit'));
      expect(source, contains('shouldSuppressLinearFallback'));
      expect(source, contains('reconciledStructuralCaretIndex'));
      expect(source, contains('paintVisibleSlotOverlay = false'));
      expect(source, isNot(contains('paintVisibleSlotOverlay: true')));
    });
  });
}
