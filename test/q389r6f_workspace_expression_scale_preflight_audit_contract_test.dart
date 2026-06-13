import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/workspace/workspace_expression_compact_scale_audit_q389r6f.dart';

void main() {
  group('Q389R6F workspace expression scale preflight audit contract', () {
    test('is a non-mutating audit phase with red lines frozen', () {
      expect(WorkspaceExpressionCompactScaleAuditQ389R6F.runtimeBehaviorChanged, isFalse);
      expect(WorkspaceExpressionCompactScaleAuditQ389R6F.visualScaleChanged, isFalse);
      expect(WorkspaceExpressionCompactScaleAuditQ389R6F.cursorDragChanged, isFalse);
      expect(WorkspaceExpressionCompactScaleAuditQ389R6F.longExpressionScrollChanged, isFalse);

      expect(WorkspaceExpressionCompactScaleAuditQ389R6F.q389r6gMayTouchMathliveProductionHtmlCssOnly, isTrue);
      expect(WorkspaceExpressionCompactScaleAuditQ389R6F.q389r6hMustPreserveMinimumReadableScale, isTrue);
      expect(WorkspaceExpressionCompactScaleAuditQ389R6F.q389r6iMustPreserveNativeMathLiveCaretAuthority, isTrue);

      expect(WorkspaceExpressionCompactScaleAuditQ389R6F.keyboardLayoutMutationAllowed, isFalse);
      expect(WorkspaceExpressionCompactScaleAuditQ389R6F.mathLiveBridgeMutationAllowedInQ389R6G, isFalse);
      expect(WorkspaceExpressionCompactScaleAuditQ389R6F.ocrMutationAllowed, isFalse);
      expect(WorkspaceExpressionCompactScaleAuditQ389R6F.androidNativeMutationAllowed, isFalse);
      expect(WorkspaceExpressionCompactScaleAuditQ389R6F.graphMutationAllowed, isFalse);
      expect(WorkspaceExpressionCompactScaleAuditQ389R6F.solverMutationAllowed, isFalse);
      expect(WorkspaceExpressionCompactScaleAuditQ389R6F.legacyFlutterCursorAllowed, isFalse);
    });
  });
}
