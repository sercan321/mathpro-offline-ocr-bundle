import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/workspace/workspace_long_expression_scroll_policy_q389r6h.dart';

void main() {
  group('Q389R6H workspace long-expression scroll contract', () {
    test('keeps a readable minimum scale and scrolls horizontally', () {
      expect(WorkspaceLongExpressionScrollPolicyQ389R6H.phase, 'Q389R6H');
      expect(WorkspaceLongExpressionScrollPolicyQ389R6H.baseCompactFontClamp, 'clamp(23px, 6.35vw, 31px)');
      expect(WorkspaceLongExpressionScrollPolicyQ389R6H.minimumReadableScrollFontClamp, 'clamp(21px, 5.75vw, 28px)');
      expect(WorkspaceLongExpressionScrollPolicyQ389R6H.horizontalOverflowScrollAllowed, isTrue);
      expect(WorkspaceLongExpressionScrollPolicyQ389R6H.unreadableMicroScaleForbidden, isTrue);
      expect(WorkspaceLongExpressionScrollPolicyQ389R6H.scrollbarHiddenForPremiumSurface, isTrue);
      expect(WorkspaceLongExpressionScrollPolicyQ389R6H.scrollPaddingInlinePx, 24);
      expect(WorkspaceLongExpressionScrollPolicyQ389R6H.caretVisibilityUsesNativeMathLivePosition, isTrue);
      expect(WorkspaceLongExpressionScrollPolicyQ389R6H.selectionChangeSchedulesVisibilityRefresh, isTrue);
    });

    test('does not cross protected red lines', () {
      expect(WorkspaceLongExpressionScrollPolicyQ389R6H.longPressCursorDragImplemented, isFalse);
      expect(WorkspaceLongExpressionScrollPolicyQ389R6H.nativeMathLiveCaretAuthorityPreserved, isTrue);
      expect(WorkspaceLongExpressionScrollPolicyQ389R6H.legacyFlutterCursorAllowed, isFalse);
      expect(WorkspaceLongExpressionScrollPolicyQ389R6H.mathLiveBridgeRewritten, isFalse);
      expect(WorkspaceLongExpressionScrollPolicyQ389R6H.keyboardLayoutChanged, isFalse);
      expect(WorkspaceLongExpressionScrollPolicyQ389R6H.graphChanged, isFalse);
      expect(WorkspaceLongExpressionScrollPolicyQ389R6H.ocrChanged, isFalse);
      expect(WorkspaceLongExpressionScrollPolicyQ389R6H.androidNativeChanged, isFalse);
      expect(WorkspaceLongExpressionScrollPolicyQ389R6H.solverChanged, isFalse);
    });
  });
}
