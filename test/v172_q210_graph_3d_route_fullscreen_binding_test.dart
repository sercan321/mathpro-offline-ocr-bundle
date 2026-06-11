import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/graph/graph_3d_route_fullscreen_binding_policy.dart';
import 'package:mathpro_flutter_phase17/features/graph/graph_eligibility.dart';
import 'package:mathpro_flutter_phase17/features/graph/graph_models.dart';
import 'package:mathpro_flutter_phase17/features/graph/graph_painter.dart';

void main() {
  test('V172-Q210 graph 3D route/fullscreen binding policy is honest', () {
    expect(Graph3DRouteFullscreenBindingPolicy.phase, 'V172-Q210');
    expect(Graph3DRouteFullscreenBindingPolicy.zFunctionEligibilityAdded, isTrue);
    expect(Graph3DRouteFullscreenBindingPolicy.xySurfaceEligibilityAdded, isTrue);
    expect(Graph3DRouteFullscreenBindingPolicy.graphExpressionPreferredRenderModeAdded, isTrue);
    expect(Graph3DRouteFullscreenBindingPolicy.previewHeaderUsesRenderModeExpression, isTrue);
    expect(Graph3DRouteFullscreenBindingPolicy.fullscreenReceivesInitialRenderMode, isTrue);
    expect(Graph3DRouteFullscreenBindingPolicy.fullscreenCanRenderGraphSurface3D, isTrue);
    expect(Graph3DRouteFullscreenBindingPolicy.fullscreenHas2D3DToggle, isTrue);
    expect(Graph3DRouteFullscreenBindingPolicy.fullscreenReturnsRenderMode, isTrue);
    expect(Graph3DRouteFullscreenBindingPolicy.fake3DRendererClaimed, isFalse);
    expect(Graph3DRouteFullscreenBindingPolicy.flutterAnalyzePassClaimedByAssistant, isFalse);
    expect(Graph3DRouteFullscreenBindingPolicy.flutterTestPassClaimedByAssistant, isFalse);
    expect(Graph3DRouteFullscreenBindingPolicy.androidRealDevice3DPassClaimed, isFalse);
  });

  test('V172-Q210 classifies z=f(x,y) and raw xy surfaces as graphable 3D candidates', () {
    final zSurface = GraphEligibility.classify(expression: 'z = x^2 + y^2', result: '');
    expect(zSurface.canOpenDirectly, isTrue);
    expect(zSurface.normalizedExpression, 'x^2 + y^2');
    final zGraph = GraphEligibility.expressionFromEligibility(originalExpression: 'z = x^2 + y^2', result: zSurface);
    expect(zGraph.preferredRenderMode, GraphRenderMode.threeD);
    expect(zGraph.displayExpressionFor(GraphRenderMode.threeD), 'z = x^2 + y^2');

    final rawSurface = GraphEligibility.classify(expression: 'sin(x) + cos(y)', result: '');
    expect(rawSurface.canOpenDirectly, isTrue);
    expect(rawSurface.normalizedExpression, 'sin(x) + cos(y)');
    final rawGraph = GraphEligibility.expressionFromEligibility(originalExpression: 'sin(x) + cos(y)', result: rawSurface);
    expect(rawGraph.preferredRenderMode, GraphRenderMode.threeD);
    expect(GraphExpressionEvaluator(rawGraph.normalizedExpression).evaluate2D(0, 0), closeTo(1, 1e-9));
  });

  test('V172-Q210 keeps y=f(x) as 2D while fullscreen and preview can bind 3D mode', () {
    final yFunction = GraphEligibility.classify(expression: 'y = x^2', result: '');
    expect(yFunction.canOpenDirectly, isTrue);
    final yGraph = GraphEligibility.expressionFromEligibility(originalExpression: 'y = x^2', result: yFunction);
    expect(yGraph.preferredRenderMode, GraphRenderMode.twoD);
    expect(yGraph.displayExpressionFor(GraphRenderMode.twoD), 'y = x^2');

    final graphModels = File('lib/features/graph/graph_models.dart').readAsStringSync();
    final graphCard = File('lib/features/graph/graph_card.dart').readAsStringSync();
    final fullscreen = File('lib/features/graph/graph_fullscreen_page.dart').readAsStringSync();
    final appShell = File('lib/app/app_shell.dart').readAsStringSync();
    final graph3d = File('lib/features/graph/graph_surface_3d.dart').readAsStringSync();

    expect(graphModels, contains('GraphRenderMode get preferredRenderMode'));
    expect(graphModels, contains('String displayExpressionFor(GraphRenderMode renderMode)'));
    expect(graphCard, contains('GraphSurface3D('));
    expect(graphCard, contains('compact: canvasCompact || canvasPixelTight'));
    expect(graphCard, contains(r'x[${_GraphValueFormatter.format(expression.xMin)},${_GraphValueFormatter.format(expression.xMax)}]'));
    expect(fullscreen, contains('class GraphFullscreenResult'));
    expect(fullscreen, contains('initialRenderMode'));
    expect(fullscreen, contains('GraphSurface3D('));
    expect(fullscreen, contains('mathpro-fullscreen-graph-2d-3d-toggle'));
    expect(fullscreen, contains('Navigator.of(context).pop(GraphFullscreenResult'));
    expect(appShell, contains('GraphFullscreenPage(expression: graph, initialRenderMode: _graphRenderMode)'));
    expect(appShell, contains('_applyGraphUpdate(updated.expression, renderMode: updated.renderMode)'));
    expect(appShell, contains('_graphRenderMode = openedGraph.preferredRenderMode'));
    expect(graph3d, contains('GraphSurfaceColorRamp.colorAt'));
    expect(graph3d, contains('quad.meanZ'));
    expect(graph3d, contains('clamp(-0.22, 1.22).toDouble()'));
    expect(graph3d, contains('3D Ribbon'));
    expect(graph3d, contains('3D Surface'));
  });
}
