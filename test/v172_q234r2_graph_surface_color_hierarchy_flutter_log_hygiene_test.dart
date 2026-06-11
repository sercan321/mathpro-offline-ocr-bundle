import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/graph/graph_surface_color_hierarchy_flutter_log_hygiene_policy.dart';

void main() {
  test('V172-Q234R2 policy records Flutter log hygiene scope without fake PASS', () {
    expect(GraphSurfaceColorHierarchyFlutterLogHygienePolicy.phase, 'V172-Q234R2');
    expect(GraphSurfaceColorHierarchyFlutterLogHygienePolicy.q234SurfaceRendererPreserved, isTrue);
    expect(GraphSurfaceColorHierarchyFlutterLogHygienePolicy.q156PopupEnvelopeTestAlignedWithQ231Successor, isTrue);
    expect(GraphSurfaceColorHierarchyFlutterLogHygienePolicy.q210ThreeDRouteTestAlignedWithQ234SurfaceSuccessor, isTrue);
    expect(GraphSurfaceColorHierarchyFlutterLogHygienePolicy.q225MiniPanelTestAlignedWithQ234SurfaceSuccessor, isTrue);
    expect(GraphSurfaceColorHierarchyFlutterLogHygienePolicy.q222GraphSettingsTestScrollsToApplyAfterColorPicker, isTrue);
    expect(GraphSurfaceColorHierarchyFlutterLogHygienePolicy.q234AnalyzerInfoCleanupApplied, isTrue);
    expect(GraphSurfaceColorHierarchyFlutterLogHygienePolicy.graphSurface3DRewritten, isFalse);
    expect(GraphSurfaceColorHierarchyFlutterLogHygienePolicy.keyboardLayoutMutationAllowed, isFalse);
    expect(GraphSurfaceColorHierarchyFlutterLogHygienePolicy.longPressInventoryMutationAllowed, isFalse);
    expect(GraphSurfaceColorHierarchyFlutterLogHygienePolicy.longPressRuntimeMutationAllowed, isFalse);
    expect(GraphSurfaceColorHierarchyFlutterLogHygienePolicy.mathLiveProductionMutationAllowed, isFalse);
    expect(GraphSurfaceColorHierarchyFlutterLogHygienePolicy.flutterAnalyzePassClaimedByAssistant, isFalse);
    expect(GraphSurfaceColorHierarchyFlutterLogHygienePolicy.flutterTestPassClaimedByAssistant, isFalse);
  });

  test('V172-Q234R2 aligns stale Flutter test markers with Q234/Q231 successors', () {
    final q156Test = File('test/v172_q156_mathlive_popup_envelope_final_rebalance_test.dart').readAsStringSync();
    final q210Test = File('test/v172_q210_graph_3d_route_fullscreen_binding_test.dart').readAsStringSync();
    final q225Test = File('test/v172_q225_graph_mini_panel_visual_parity_repair_test.dart').readAsStringSync();
    final q222Test = File('test/v172_q222_graph_settings_bottom_sheet_control_migration_test.dart').readAsStringSync();

    expect(q156Test, contains('greaterThanOrEqualTo(96)'));
    expect(q156Test, isNot(contains('LongPressPopup.boundedIntegralChipWidth, greaterThanOrEqualTo(104)')));
    expect(q210Test, contains('GraphSurfaceColorRamp.colorAt'));
    expect(q210Test, contains('quad.meanZ'));
    expect(q225Test, contains('3D örnek üretilemedi'));
    expect(q225Test, contains('GraphSurfaceColorRamp.colorAt'));
    expect(q222Test, contains('dragUntilVisible'));
    expect(q222Test, contains('SingleChildScrollView'));
    expect(q222Test, contains("ValueKey('mathpro-graph-settings-apply')"));
  });

  test('V172-Q234R2 source keeps analyzer cleanup narrow and non-behavioral', () {
    final hierarchy = File('lib/features/graph/graph_color_hierarchy.dart').readAsStringSync();
    final popup = File('lib/features/keyboard/long_press_popup.dart').readAsStringSync();
    final settings = File('lib/features/graph/graph_settings_sheet.dart').readAsStringSync();

    expect(hierarchy, contains('const gridBase = Color(0xFF94A5A8)'));
    expect(hierarchy, contains('const axisBase = Color(0xFFC5D0D2)'));
    expect(popup, contains('const edgeInset = PremiumPopupFitPolicy.longPressPanelHorizontalInset'));
    expect(popup, contains('final actualKeyCenterX = anchorCenterX?.clamp'));
    expect(popup, contains('class _SegmentDivider extends StatelessWidget'));
    expect(popup, contains('return const Padding('));
    expect(settings, contains('mathpro-graph-settings-function-color-picker-q234'));
    expect(settings, contains('padding: const EdgeInsets.fromLTRB(18, 12, 18, 14)'));
  });
}
