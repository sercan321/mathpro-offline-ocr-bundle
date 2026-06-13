import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/workspace/workspace_expression_compact_scale_policy_q389r6g.dart';

void main() {
  group('Q389R6G workspace compact expression scale contract', () {
    test('applies compact visual scale without mutating red-line behavior', () {
      expect(WorkspaceExpressionCompactScalePolicyQ389R6G.compactScaleApplied, isTrue);
      expect(WorkspaceExpressionCompactScalePolicyQ389R6G.previousFontClamp, 'clamp(28px, 7.8vw, 38px)');
      expect(WorkspaceExpressionCompactScalePolicyQ389R6G.compactFontClamp, 'clamp(23px, 6.35vw, 31px)');
      expect(WorkspaceExpressionCompactScalePolicyQ389R6G.compactHostMinHeightPx, 84);
      expect(WorkspaceExpressionCompactScalePolicyQ389R6G.compactMathFieldMinHeightPx, 62);
      expect(WorkspaceExpressionCompactScalePolicyQ389R6G.compactEditablePartMinHeightPx, 54);
      expect(WorkspaceExpressionCompactScalePolicyQ389R6G.compactLineHeight, 1.20);

      expect(WorkspaceExpressionCompactScalePolicyQ389R6G.runtimeInputSemanticsChanged, isFalse);
      expect(WorkspaceExpressionCompactScalePolicyQ389R6G.mathLiveBridgeChanged, isFalse);
      expect(WorkspaceExpressionCompactScalePolicyQ389R6G.keyboardLayoutChanged, isFalse);
      expect(WorkspaceExpressionCompactScalePolicyQ389R6G.cursorDragChanged, isFalse);
      expect(WorkspaceExpressionCompactScalePolicyQ389R6G.longExpressionScrollChanged, isFalse);
      expect(WorkspaceExpressionCompactScalePolicyQ389R6G.graphChanged, isFalse);
      expect(WorkspaceExpressionCompactScalePolicyQ389R6G.ocrChanged, isFalse);
      expect(WorkspaceExpressionCompactScalePolicyQ389R6G.androidNativeChanged, isFalse);
      expect(WorkspaceExpressionCompactScalePolicyQ389R6G.solverChanged, isFalse);
      expect(WorkspaceExpressionCompactScalePolicyQ389R6G.legacyFlutterCursorAllowed, isFalse);
      expect(WorkspaceExpressionCompactScalePolicyQ389R6G.nativeMathLiveCaretAuthorityPreserved, isTrue);
    });
  });
}
