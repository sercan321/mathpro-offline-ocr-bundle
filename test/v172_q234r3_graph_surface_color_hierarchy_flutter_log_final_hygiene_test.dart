import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/graph/graph_surface_color_hierarchy_flutter_log_final_hygiene_policy.dart';

void main() {
  test('V172-Q234R3 policy records final Flutter log hygiene without fake PASS', () {
    expect(GraphSurfaceColorHierarchyFlutterLogFinalHygienePolicy.phase, 'V172-Q234R3');
    expect(GraphSurfaceColorHierarchyFlutterLogFinalHygienePolicy.q234SurfaceRendererPreserved, isTrue);
    expect(GraphSurfaceColorHierarchyFlutterLogFinalHygienePolicy.q234R2FlutterLogFollowUp, isTrue);
    expect(GraphSurfaceColorHierarchyFlutterLogFinalHygienePolicy.remainingAnalyzerInfosClosed, isTrue);
    expect(GraphSurfaceColorHierarchyFlutterLogFinalHygienePolicy.q222GraphSettingsApplyHitTestHardened, isTrue);
    expect(GraphSurfaceColorHierarchyFlutterLogFinalHygienePolicy.q222UsesDragUntilVisibleForApply, isTrue);
    expect(GraphSurfaceColorHierarchyFlutterLogFinalHygienePolicy.q234TestConstConstructorsRepaired, isTrue);
    expect(GraphSurfaceColorHierarchyFlutterLogFinalHygienePolicy.longPressPopupAnalyzerOnlyConstCleanupApplied, isTrue);
    expect(GraphSurfaceColorHierarchyFlutterLogFinalHygienePolicy.graphSurface3DRewritten, isFalse);
    expect(GraphSurfaceColorHierarchyFlutterLogFinalHygienePolicy.keyboardLayoutMutationAllowed, isFalse);
    expect(GraphSurfaceColorHierarchyFlutterLogFinalHygienePolicy.longPressInventoryMutationAllowed, isFalse);
    expect(GraphSurfaceColorHierarchyFlutterLogFinalHygienePolicy.longPressRuntimeMutationAllowed, isFalse);
    expect(GraphSurfaceColorHierarchyFlutterLogFinalHygienePolicy.mathLiveProductionMutationAllowed, isFalse);
    expect(GraphSurfaceColorHierarchyFlutterLogFinalHygienePolicy.flutterAnalyzePassClaimedByAssistant, isFalse);
    expect(GraphSurfaceColorHierarchyFlutterLogFinalHygienePolicy.flutterTestPassClaimedByAssistant, isFalse);
  });

  test('V172-Q234R3 source closes the exact user-side analyzer and Q222 test leftovers', () {
    final popup = File('lib/features/keyboard/long_press_popup.dart').readAsStringSync();
    final q234Test = File('test/v172_q234_3d_graph_surface_color_hierarchy_test.dart').readAsStringSync();
    final q222Test = File('test/v172_q222_graph_settings_bottom_sheet_control_migration_test.dart').readAsStringSync();
    final q234r2Test = File('test/v172_q234r2_graph_surface_color_hierarchy_flutter_log_hygiene_test.dart').readAsStringSync();

    expect(popup, contains('const minLeft = edgeInset;'));
    expect(popup, contains('final actualKeyCenterX = anchorCenterX?.clamp'));
    expect(q234Test, contains('const MaterialApp('));
    expect(q234Test, contains('const expression = GraphExpression('));
    expect(q222Test, contains('dragUntilVisible'));
    expect(q222Test, contains('find.byType(SingleChildScrollView)'));
    expect(q222Test, contains("ValueKey('mathpro-graph-settings-apply')"));
    expect(q234r2Test, contains('dragUntilVisible'));
    expect(q234r2Test, isNot(contains('scrollUntilVisible')));
  });
}
