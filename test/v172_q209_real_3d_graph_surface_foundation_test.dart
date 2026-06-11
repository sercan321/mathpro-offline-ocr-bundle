import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/graph/graph_3d_surface_foundation_policy.dart';
import 'package:mathpro_flutter_phase17/features/graph/graph_models.dart';
import 'package:mathpro_flutter_phase17/features/graph/graph_painter.dart';

void main() {
  test('V172-Q209 graph 3D surface foundation policy is honest', () {
    expect(Graph3DSurfaceFoundationPolicy.phase, 'V172-Q209');
    expect(Graph3DSurfaceFoundationPolicy.graph3DSurfaceWidgetAdded, isTrue);
    expect(Graph3DSurfaceFoundationPolicy.graph3DPainterAdded, isTrue);
    expect(Graph3DSurfaceFoundationPolicy.graphExpressionEvaluatorSupportsY, isTrue);
    expect(Graph3DSurfaceFoundationPolicy.threeDModeUsesRealSurfacePainter, isTrue);
    expect(Graph3DSurfaceFoundationPolicy.threeDReadinessPanelRetired, isTrue);
    expect(Graph3DSurfaceFoundationPolicy.fake3DRendererClaimed, isFalse);
    expect(Graph3DSurfaceFoundationPolicy.twoDRendererPreserved, isTrue);
    expect(Graph3DSurfaceFoundationPolicy.q207OverflowRepairPreserved, isTrue);
    expect(Graph3DSurfaceFoundationPolicy.flutterAnalyzePassClaimedByAssistant, isFalse);
    expect(Graph3DSurfaceFoundationPolicy.flutterTestPassClaimedByAssistant, isFalse);
    expect(Graph3DSurfaceFoundationPolicy.androidRealDevice3DPassClaimed, isFalse);
  });

  test('V172-Q209 evaluator supports z=f(x,y) sampling without breaking 2D evaluate', () {
    final evaluator = GraphExpressionEvaluator('x^2 + y^2');
    expect(evaluator.evaluate2D(2, 3), closeTo(13, 1e-9));
    expect(evaluator.evaluate(2), closeTo(4, 1e-9));
  });

  test('V172-Q209 graph card routes 3D mode to real 3D surface instead of readiness panel', () {
    expect(GraphRenderMode.values, containsAll(<GraphRenderMode>[GraphRenderMode.twoD, GraphRenderMode.threeD]));
    final graphCard = File('lib/features/graph/graph_card.dart').readAsStringSync();
    final graph3d = File('lib/features/graph/graph_surface_3d.dart').readAsStringSync();
    expect(graphCard, contains('GraphSurface3D('));
    expect(graphCard, isNot(contains('_Graph3DReadinessPanel')));
    expect(graphCard, contains('GraphSurface3D('));
    expect(graphCard, contains('compact: canvasCompact || canvasPixelTight'));
    expect(graphCard, contains('mathpro-graph-canvas-preview'));
    expect(graph3d, contains('class GraphSurface3D'));
    expect(graph3d, contains('class GraphSurface3DPainter'));
    expect(graph3d, contains('evaluate2D(x, y)'));
    expect(graph3d, contains('mathpro-graph-3d-surface'));
  });
}
