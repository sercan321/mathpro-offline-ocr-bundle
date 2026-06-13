import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/graph/graph_expression_refresh_policy.dart';

void main() {
  group('Q389R6E graph Enter refresh contract', () {
    test('refreshes only an already visible graph and preserves red lines', () {
      expect(GraphExpressionRefreshPolicy.evaluateEnterRefreshesVisibleGraph, isTrue);
      expect(GraphExpressionRefreshPolicy.refreshOnlyWhenGraphPreviewAlreadyVisible, isTrue);
      expect(GraphExpressionRefreshPolicy.preserveRenderModeOnRefresh, isTrue);
      expect(GraphExpressionRefreshPolicy.preserveGraphDisplayTogglesOnRefresh, isTrue);
      expect(GraphExpressionRefreshPolicy.resetViewportForNewExpression, isTrue);
      expect(GraphExpressionRefreshPolicy.preserveViewportWhenExpressionUnchanged, isTrue);
      expect(GraphExpressionRefreshPolicy.closeStaleGraphWhenNewExpressionIsNotGraphable, isTrue);

      expect(GraphExpressionRefreshPolicy.perKeystrokeGraphRefreshAllowed, isFalse);
      expect(GraphExpressionRefreshPolicy.keyboardLayoutMutationAllowed, isFalse);
      expect(GraphExpressionRefreshPolicy.mathLiveBridgeMutationAllowed, isFalse);
      expect(GraphExpressionRefreshPolicy.ocrMutationAllowed, isFalse);
      expect(GraphExpressionRefreshPolicy.androidNativeMutationAllowed, isFalse);
      expect(GraphExpressionRefreshPolicy.solverMutationAllowed, isFalse);
      expect(GraphExpressionRefreshPolicy.workspaceLayoutMutationAllowed, isFalse);
    });
  });
}
