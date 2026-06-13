import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/workspace/workspace_analyze_test_hardening_policy_q389r6m.dart';

void main() {
  test('Q389R6M records analyze/test hardening without protected surface mutation claims', () {
    expect(WorkspaceAnalyzeTestHardeningPolicyQ389R6M.phase, 'Q389R6M-ANALYZE-TEST-HARDENING-ROUND-2');
    expect(WorkspaceAnalyzeTestHardeningPolicyQ389R6M.graphCriticalPointQuadraticExtremumToleranceRepaired, isTrue);
    expect(WorkspaceAnalyzeTestHardeningPolicyQ389R6M.graphSettingsStaleTextTapTestRepaired, isTrue);
    expect(WorkspaceAnalyzeTestHardeningPolicyQ389R6M.staleQ208MathLiveFontExpectationRepaired, isTrue);
    expect(WorkspaceAnalyzeTestHardeningPolicyQ389R6M.staleOnnxCommentCompatibilityRestoredWithoutRuntimeDependency, isTrue);
    expect(WorkspaceAnalyzeTestHardeningPolicyQ389R6M.fakeFlutterPassWordingRemovedFromAuditMarkdown, isTrue);
    expect(WorkspaceAnalyzeTestHardeningPolicyQ389R6M.keyboardLayoutTouched, isFalse);
    expect(WorkspaceAnalyzeTestHardeningPolicyQ389R6M.mathLiveDispatchTouched, isFalse);
    expect(WorkspaceAnalyzeTestHardeningPolicyQ389R6M.androidNativeTouched, isFalse);
    expect(WorkspaceAnalyzeTestHardeningPolicyQ389R6M.ocrRuntimeTouched, isFalse);
    expect(WorkspaceAnalyzeTestHardeningPolicyQ389R6M.solverTouched, isFalse);
    expect(WorkspaceAnalyzeTestHardeningPolicyQ389R6M.flutterPassClaimed, isFalse);
  });

  test('Q389R6M source repairs exact user-side log failures', () {
    final overlay = File('lib/features/graph/graph_interaction_overlay.dart').readAsStringSync();
    final criticalPoints = File('lib/features/graph/graph_critical_points.dart').readAsStringSync();
    final graphHistoryTest = File('test/graph_history_regression_test.dart').readAsStringSync();
    final q208Test = File('test/v172_q208_graph_2d_3d_elite_toggle_architecture_test.dart').readAsStringSync();
    final auditDoc = File('docs/audit/V172_Q382R24R1_STALE_TEST_EXPECTATION_REPAIR.md').readAsStringSync();
    final pubspec = File('pubspec.yaml').readAsStringSync().toLowerCase();

    expect(overlay, contains(r"'$sign$absNπ'"));
    expect(overlay, contains(r"'$absNπ'"));
    expect(criticalPoints, contains('ySpan * 0.000001'));
    expect(graphHistoryTest, contains("find.widgetWithText(ElevatedButton, 'Apply')"));
    expect(q208Test, contains('font-size: clamp(23px, 6.35vw, 31px);'));
    expect(auditDoc, isNot(contains('flutter analyze PASS')));
    expect(auditDoc, isNot(contains('flutter test PASS')));
    expect(pubspec, isNot(contains('onnx')));
    expect(pubspec, isNot(contains(RegExp(r'^\s*onnxruntime\s*:', multiLine: true))));
  });
}
