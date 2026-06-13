import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/workspace/workspace_long_press_cursor_drag_hardening_policy_q389r6j.dart';

void main() {
  group('Q389R6J workspace long-press cursor drag audit hardening contract', () {
    test('hardens Q389R6I continuous edge autoscroll and pointer cleanup', () {
      expect(WorkspaceLongPressCursorDragHardeningPolicyQ389R6J.phase, 'Q389R6J');
      expect(WorkspaceLongPressCursorDragHardeningPolicyQ389R6J.buildsOnQ389R6I, isTrue);
      expect(WorkspaceLongPressCursorDragHardeningPolicyQ389R6J.continuousEdgeAutoscrollLoopImplemented, isTrue);
      expect(WorkspaceLongPressCursorDragHardeningPolicyQ389R6J.continuousEdgeAutoscrollTickMs, 72);
      expect(WorkspaceLongPressCursorDragHardeningPolicyQ389R6J.edgeAutoscrollNoLongerRequiresPointerMove, isTrue);
      expect(WorkspaceLongPressCursorDragHardeningPolicyQ389R6J.pointerCaptureCleanupHardened, isTrue);
      expect(WorkspaceLongPressCursorDragHardeningPolicyQ389R6J.touchCalloutSuppressedForMathField, isTrue);
    });

    test('keeps protected red lines closed', () {
      expect(WorkspaceLongPressCursorDragHardeningPolicyQ389R6J.q389R6IPhaseMarkersPreserved, isTrue);
      expect(WorkspaceLongPressCursorDragHardeningPolicyQ389R6J.nativeMathLiveCaretAuthorityPreserved, isTrue);
      expect(WorkspaceLongPressCursorDragHardeningPolicyQ389R6J.legacyFlutterCursorAllowed, isFalse);
      expect(WorkspaceLongPressCursorDragHardeningPolicyQ389R6J.earlyPointerDownPreventDefaultForbidden, isTrue);
      expect(WorkspaceLongPressCursorDragHardeningPolicyQ389R6J.keyboardLayoutChanged, isFalse);
      expect(WorkspaceLongPressCursorDragHardeningPolicyQ389R6J.keyboardDispatchChanged, isFalse);
      expect(WorkspaceLongPressCursorDragHardeningPolicyQ389R6J.graphChanged, isFalse);
      expect(WorkspaceLongPressCursorDragHardeningPolicyQ389R6J.ocrChanged, isFalse);
      expect(WorkspaceLongPressCursorDragHardeningPolicyQ389R6J.androidNativeChanged, isFalse);
      expect(WorkspaceLongPressCursorDragHardeningPolicyQ389R6J.solverChanged, isFalse);
    });
  });
}
