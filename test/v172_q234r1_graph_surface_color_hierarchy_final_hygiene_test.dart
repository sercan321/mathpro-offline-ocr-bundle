import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/graph/graph_color_hierarchy.dart';
import 'package:mathpro_flutter_phase17/features/graph/graph_models.dart';
import 'package:mathpro_flutter_phase17/features/graph/graph_surface_color_hierarchy_final_hygiene_policy.dart';

void main() {
  test('V172-Q234R1 final hygiene policy is scoped and honest', () {
    expect(GraphSurfaceColorHierarchyFinalHygienePolicy.phase, 'V172-Q234R1');
    expect(GraphSurfaceColorHierarchyFinalHygienePolicy.q234SurfaceRendererPreserved, isTrue);
    expect(GraphSurfaceColorHierarchyFinalHygienePolicy.q225VerifierAcceptsQ234SurfaceSuccessor, isTrue);
    expect(GraphSurfaceColorHierarchyFinalHygienePolicy.fullscreenGraphSettingsRenderModeBindingRepaired, isTrue);
    expect(GraphSurfaceColorHierarchyFinalHygienePolicy.duplicateApplyKeyAnalyzerHygieneRepaired, isTrue);
    expect(GraphSurfaceColorHierarchyFinalHygienePolicy.graphPainterMutationAllowed, isFalse);
    expect(GraphSurfaceColorHierarchyFinalHygienePolicy.graphSurface3DMutationAllowed, isFalse);
    expect(GraphSurfaceColorHierarchyFinalHygienePolicy.keyboardMutationAllowed, isFalse);
    expect(GraphSurfaceColorHierarchyFinalHygienePolicy.mathLiveProductionMutationAllowed, isFalse);
    expect(GraphSurfaceColorHierarchyFinalHygienePolicy.workspaceLayoutMutationAllowed, isFalse);
    expect(GraphSurfaceColorHierarchyFinalHygienePolicy.flutterAnalyzePassClaimedByAssistant, isFalse);
    expect(GraphSurfaceColorHierarchyFinalHygienePolicy.androidGraphVisualPassClaimedByAssistant, isFalse);
  });

  test('V172-Q234R1 graph color persistence scope is explicitly expression-level', () {
    expect(GraphSurfaceColorHierarchyFinalHygienePolicy.graphColorPersistenceScope, 'expression-level');
    expect(GraphSurfaceColorHierarchyFinalHygienePolicy.graphColorStoredInGraphExpression, isTrue);
    expect(GraphSurfaceColorHierarchyFinalHygienePolicy.graphColorKeyStoredInGraphJson, isTrue);
    expect(GraphSurfaceColorHierarchyFinalHygienePolicy.globalGraphColorDefaultPreferenceAdded, isFalse);

    final expression = GraphExpression(
      originalExpression: 'y = sin(x)',
      normalizedExpression: 'sin(x)',
      type: GraphType.explicit,
      graphColor: GraphFunctionColorPalette.byKey('iceBlue').color,
      graphColorKey: 'iceBlue',
    );
    final restored = GraphExpression.fromJson(expression.toJson())!;
    expect(restored.graphColorKey, 'iceBlue');
    expect(restored.graphColor, GraphFunctionColorPalette.byKey('iceBlue').color);
  });
}
