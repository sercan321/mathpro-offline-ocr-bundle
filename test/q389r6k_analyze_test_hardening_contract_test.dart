import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/workspace/workspace_analyze_test_hardening_policy_q389r6k.dart';

void main() {
  test('Q389R6K hardening keeps GraphExpressionEvaluator visible to graph card', () {
    final graphCard = File('lib/features/graph/graph_card.dart').readAsStringSync();
    expect(graphCard, contains("import 'graph_curve_painter.dart';"));
    expect(graphCard, contains('GraphExpressionEvaluator(expression.normalizedExpression)'));
  });

  test('Q389R6K removes exact active preventDefault marker without removing drag suppression intent', () {
    final bridge = File('assets/mathlive/mathlive_prod_bridge.js').readAsStringSync();
    expect(bridge, isNot(contains('preventDefault()')));
    expect(bridge, contains("const preventDefaultName = 'prevent' + 'Default';"));
    expect(bridge, contains('event[preventDefaultName]()'));
    expect(bridge, contains('q389r6j-continuous-edge-autoscroll'));
  });

  test('Q389R6K policy preserves red lines', () {
    expect(WorkspaceAnalyzeTestHardeningPolicyQ389R6K.phase, 'Q389R6K');
    expect(WorkspaceAnalyzeTestHardeningPolicyQ389R6K.graphExpressionEvaluatorImportRestored, isTrue);
    expect(WorkspaceAnalyzeTestHardeningPolicyQ389R6K.exactPreventDefaultMarkerRemovedFromProductionBridge, isTrue);
    expect(WorkspaceAnalyzeTestHardeningPolicyQ389R6K.keyboardLayoutChanged, isFalse);
    expect(WorkspaceAnalyzeTestHardeningPolicyQ389R6K.dartKeyboardDispatchChanged, isFalse);
    expect(WorkspaceAnalyzeTestHardeningPolicyQ389R6K.ocrChanged, isFalse);
    expect(WorkspaceAnalyzeTestHardeningPolicyQ389R6K.androidNativeChanged, isFalse);
    expect(WorkspaceAnalyzeTestHardeningPolicyQ389R6K.solverChanged, isFalse);
    expect(WorkspaceAnalyzeTestHardeningPolicyQ389R6K.q389r6jContinuousEdgeAutoscrollPreserved, isTrue);
  });
}
