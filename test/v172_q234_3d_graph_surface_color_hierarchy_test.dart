import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/graph/graph_color_hierarchy.dart';
import 'package:mathpro_flutter_phase17/features/graph/graph_models.dart';
import 'package:mathpro_flutter_phase17/features/graph/graph_settings_sheet.dart';
import 'package:mathpro_flutter_phase17/features/graph/graph_surface_3d.dart';
import 'package:mathpro_flutter_phase17/features/graph/graph_surface_color_hierarchy_policy.dart';

void main() {
  test('V172-Q234 graph surface color hierarchy policy is scoped and honest', () {
    expect(GraphSurfaceColorHierarchyPolicy.phase, 'V172-Q234');
    expect(GraphSurfaceColorHierarchyPolicy.surfaceFirst3DRendererAdded, isTrue);
    expect(GraphSurfaceColorHierarchyPolicy.denseWireframeDefaultRetired, isTrue);
    expect(GraphSurfaceColorHierarchyPolicy.surfaceFillUsesDepthSortedQuads, isTrue);
    expect(GraphSurfaceColorHierarchyPolicy.surfaceFillUsesZGradient, isTrue);
    expect(GraphSurfaceColorHierarchyPolicy.subtleMeshOverlayAdded, isTrue);
    expect(GraphSurfaceColorHierarchyPolicy.singleVariable3DUsesRibbonSurface, isTrue);
    expect(GraphSurfaceColorHierarchyPolicy.gridAxisCurveHierarchySeparated, isTrue);
    expect(GraphSurfaceColorHierarchyPolicy.graphSettingsFunctionColorPickerAdded, isTrue);
    expect(GraphSurfaceColorHierarchyPolicy.defaultFunctionColorKey, 'aquaTeal');
    expect(GraphSurfaceColorHierarchyPolicy.defaultFunctionColorHex, '#78F2E6');
    expect(GraphSurfaceColorHierarchyPolicy.keyboardMutationAllowed, isFalse);
    expect(GraphSurfaceColorHierarchyPolicy.mathLiveProductionMutationAllowed, isFalse);
    expect(GraphSurfaceColorHierarchyPolicy.workspaceLayoutMutationAllowed, isFalse);
    expect(GraphSurfaceColorHierarchyPolicy.flutterAnalyzePassClaimedByAssistant, isFalse);
    expect(GraphSurfaceColorHierarchyPolicy.androidRealDeviceVisualPassClaimedByAssistant, isFalse);
  });

  test('V172-Q234 premium graph function color palette exposes stable keys and default aqua teal', () {
    expect(GraphFunctionColorPalette.defaultKey, 'aquaTeal');
    expect(GraphFunctionColorPalette.defaultColor, const Color(0xFF78F2E6));
    expect(GraphFunctionColorPalette.options.map((option) => option.key), <String>[
      'aquaTeal',
      'iceBlue',
      'violet',
      'rose',
      'softAmber',
      'mint',
      'coralRed',
      'pearl',
    ]);
    expect(GraphFunctionColorPalette.byKey('iceBlue').color, const Color(0xFF6EA8FF));
    expect(GraphFunctionColorPalette.byKey('violet').color, const Color(0xFFB88CFF));
    expect(GraphFunctionColorPalette.byKey('softAmber').color, const Color(0xFFFFC857));
  });

  test('V172-Q234 GraphExpression persists stable graphColorKey', () {
    final expression = GraphExpression(
      originalExpression: 'y = sin(x)',
      normalizedExpression: 'sin(x)',
      type: GraphType.explicit,
      graphColor: GraphFunctionColorPalette.byKey('violet').color,
      graphColorKey: 'violet',
    );
    final restored = GraphExpression.fromJson(expression.toJson())!;
    expect(restored.graphColorKey, 'violet');
    expect(restored.graphColor, const Color(0xFFB88CFF));
  });

  testWidgets('V172-Q234 Graph Settings exposes function color picker without replacing existing controls', (tester) async {
    const expression = GraphExpression(originalExpression: 'y = sin(x)', normalizedExpression: 'sin(x)', type: GraphType.explicit);
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: GraphSettingsSheet(expression: expression),
        ),
      ),
    );
    expect(find.byKey(const ValueKey('mathpro-graph-settings-mode-segment')), findsOneWidget);
    expect(find.byKey(const ValueKey('mathpro-graph-settings-window-fields')), findsOneWidget);
    expect(find.byKey(const ValueKey('mathpro-graph-settings-trace-toggle')), findsOneWidget);
    expect(find.byKey(const ValueKey('mathpro-graph-settings-function-color-picker-q234')), findsOneWidget);
    expect(find.text('Fonksiyon Rengi'), findsOneWidget);
    expect(find.text('Aqua Teal'), findsOneWidget);
  });

  test('V172-Q234 GraphSurface3D remains constructible for two-variable and single-variable surfaces', () {
    const twoVariable = GraphExpression(originalExpression: 'z = x^2 + y^2', normalizedExpression: 'x^2+y^2', type: GraphType.explicit);
    const singleVariable = GraphExpression(originalExpression: 'z = sin(x)', normalizedExpression: 'sin(x)', type: GraphType.explicit);
    expect(const GraphSurface3D(expression: twoVariable), isA<GraphSurface3D>());
    expect(const GraphSurface3D(expression: singleVariable), isA<GraphSurface3D>());
  });
}
