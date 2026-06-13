import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/workspace/workspace_long_press_cursor_drag_policy_q389r6i.dart';

void main() {
  group('Q389R6I workspace long-press cursor drag contract', () {
    test('adds long-press cursor drag without replacing MathLive caret authority', () {
      expect(WorkspaceLongPressCursorDragPolicyQ389R6I.phase, 'Q389R6I');
      expect(WorkspaceLongPressCursorDragPolicyQ389R6I.longPressDelayMs, 260);
      expect(WorkspaceLongPressCursorDragPolicyQ389R6I.moveCancelThresholdPx, 18);
      expect(WorkspaceLongPressCursorDragPolicyQ389R6I.edgeAutoscrollThresholdPx, 42);
      expect(WorkspaceLongPressCursorDragPolicyQ389R6I.edgeAutoscrollStepPx, 22);
      expect(WorkspaceLongPressCursorDragPolicyQ389R6I.longPressCursorDragImplemented, isTrue);
      expect(WorkspaceLongPressCursorDragPolicyQ389R6I.dragStartsOnlyAfterLongPress, isTrue);
      expect(WorkspaceLongPressCursorDragPolicyQ389R6I.tapToPlacePreserved, isTrue);
      expect(WorkspaceLongPressCursorDragPolicyQ389R6I.earlyPointerDownPreventDefaultForbidden, isTrue);
      expect(WorkspaceLongPressCursorDragPolicyQ389R6I.mathLiveGetOffsetFromPointUsed, isTrue);
      expect(WorkspaceLongPressCursorDragPolicyQ389R6I.mathLiveNativePositionUsed, isTrue);
      expect(WorkspaceLongPressCursorDragPolicyQ389R6I.edgeAutoscrollEnabled, isTrue);
      expect(WorkspaceLongPressCursorDragPolicyQ389R6I.existingQ389R6HScrollPolicyPreserved, isTrue);
    });

    test('does not cross protected red lines', () {
      expect(WorkspaceLongPressCursorDragPolicyQ389R6I.nativeMathLiveCaretAuthorityPreserved, isTrue);
      expect(WorkspaceLongPressCursorDragPolicyQ389R6I.legacyFlutterCursorAllowed, isFalse);
      expect(WorkspaceLongPressCursorDragPolicyQ389R6I.mathLiveBridgeRewritten, isFalse);
      expect(WorkspaceLongPressCursorDragPolicyQ389R6I.keyboardLayoutChanged, isFalse);
      expect(WorkspaceLongPressCursorDragPolicyQ389R6I.keyboardDispatchChanged, isFalse);
      expect(WorkspaceLongPressCursorDragPolicyQ389R6I.graphChanged, isFalse);
      expect(WorkspaceLongPressCursorDragPolicyQ389R6I.ocrChanged, isFalse);
      expect(WorkspaceLongPressCursorDragPolicyQ389R6I.androidNativeChanged, isFalse);
      expect(WorkspaceLongPressCursorDragPolicyQ389R6I.solverChanged, isFalse);
    });
  });
}
