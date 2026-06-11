import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/drag_to_move_cursor_stability_policy.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/editor_gesture_router_policy.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';

void main() {
  group('V172-Q42 drag-to-move cursor stability', () {
    test('Q42 lineage remains protected after later Q48 repairs without final +95 PASS claim', () {
      expect(MathProPackageContract.cursorLineageVersions, contains(MathProPackageContract.version));
      expect(MathProPackageContract.cursorLineageTitles, contains('V172-Q42 Drag-to-Move Cursor Stability'));
      expect(MathProPackageContract.pubspecDescription, contains('V172-Q80'));
      expect(MathProPackageContract.auditTitle, contains('Closure'));
      expect(MathProPackageContract.nextPhase, contains('Q81'));
    });

    test('policy keeps editor loupe and long-press menu disabled', () {
      expect(DragToMoveCursorStabilityPolicy.dragStabilityEngineAvailable, isTrue);
      expect(DragToMoveCursorStabilityPolicy.editorLoupeEnabled, isFalse);
      expect(DragToMoveCursorStabilityPolicy.editorLongPressMenuEnabled, isFalse);
      expect(EditorGestureRouterPolicy.q42DragToMoveCursorStabilityAvailable, isTrue);
    });

    test('suppresses duplicate drag emissions for the same slot and caret', () {
      final suppress = DragToMoveCursorStabilityPolicy.shouldSuppressSlotDrag(
        source: 'pan-update',
        currentPoint: const Offset(12.0, 10.0),
        currentSlotId: 'slot-a',
        currentRole: 'functionArgument',
        currentCaretIndex: 2,
        currentVisualRect: const Rect.fromLTWH(8, 8, 24, 20),
        previousSlotId: 'slot-a',
        previousRole: 'functionArgument',
        previousCaretIndex: 2,
        previousPoint: const Offset(11.0, 10.5),
        previousVisualRect: const Rect.fromLTWH(8, 8, 24, 20),
      );
      expect(suppress, isTrue);
    });

    test('guards compact slot jitter while allowing clear movement', () {
      final suppressed = DragToMoveCursorStabilityPolicy.shouldSuppressSlotDrag(
        source: 'pan-update',
        currentPoint: const Offset(19.0, 11.0),
        currentSlotId: 'base-slot',
        currentRole: 'mainLine',
        currentCaretIndex: 0,
        currentVisualRect: const Rect.fromLTWH(15, 8, 28, 22),
        previousSlotId: 'exp-slot',
        previousRole: 'powerExponent',
        previousCaretIndex: 0,
        previousPoint: const Offset(15.0, 10.0),
        previousVisualRect: const Rect.fromLTWH(10, 6, 20, 16),
      );
      expect(suppressed, isTrue);

      final clearMove = DragToMoveCursorStabilityPolicy.shouldSuppressSlotDrag(
        source: 'pan-update',
        currentPoint: const Offset(80.0, 42.0),
        currentSlotId: 'arg-slot',
        currentRole: 'functionArgument',
        currentCaretIndex: 1,
        currentVisualRect: const Rect.fromLTWH(72, 30, 26, 20),
        previousSlotId: 'exp-slot',
        previousRole: 'powerExponent',
        previousCaretIndex: 0,
        previousPoint: const Offset(15.0, 10.0),
        previousVisualRect: const Rect.fromLTWH(10, 6, 20, 16),
      );
      expect(clearMove, isFalse);
    });
  });
}
