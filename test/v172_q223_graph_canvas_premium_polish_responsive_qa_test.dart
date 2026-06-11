import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/graph/graph_canvas_premium_polish_policy.dart';
import 'package:mathpro_flutter_phase17/features/graph/graph_card.dart';
import 'package:mathpro_flutter_phase17/features/graph/graph_models.dart';
import 'package:mathpro_flutter_phase17/features/graph/graph_painter.dart';
import 'package:mathpro_flutter_phase17/features/graph/graph_style.dart';
import 'package:mathpro_flutter_phase17/features/graph/graph_surface.dart';

void main() {
  test('V172-Q223 policy records canvas polish without broad runtime claims', () {
    expect(GraphCanvasPremiumPolishPolicy.phase, 'V172-Q223');
    expect(GraphCanvasPremiumPolishPolicy.graphCanvasPremiumPolished, isTrue);
    expect(GraphCanvasPremiumPolishPolicy.premiumSurfaceGradientAdded, isTrue);
    expect(GraphCanvasPremiumPolishPolicy.pixelTightCanvasFitGuardAdded, isTrue);
    expect(GraphCanvasPremiumPolishPolicy.graphPreviewScalesInsteadOfCroppingWhenTight, isTrue);
    expect(GraphCanvasPremiumPolishPolicy.floatingZoomControlsScaleDownWhenTight, isTrue);
    expect(GraphCanvasPremiumPolishPolicy.gridAxisCurveVisualBalancePolished, isTrue);
    expect(GraphCanvasPremiumPolishPolicy.axisLabelsSuppressedWhenTooTight, isTrue);
    expect(GraphCanvasPremiumPolishPolicy.graphRuntimeEvaluatorMutationAllowed, isFalse);
    expect(GraphCanvasPremiumPolishPolicy.graphEligibilityMutationAllowed, isFalse);
    expect(GraphCanvasPremiumPolishPolicy.keyboardMutationAllowed, isFalse);
    expect(GraphCanvasPremiumPolishPolicy.mathLiveProductionMutationAllowed, isFalse);
    expect(GraphCanvasPremiumPolishPolicy.flutterAnalyzePassClaimedByAssistant, isFalse);
    expect(GraphCanvasPremiumPolishPolicy.androidRealDevicePassClaimedByAssistant, isFalse);
  });

  test('V172-Q223 graph source exposes fit guard, pixel-tight painter, and premium surface markers', () {
    final graphCard = File('lib/features/graph/graph_card.dart').readAsStringSync();
    final graphSurface = File('lib/features/graph/graph_surface.dart').readAsStringSync();
    final graphPainter = File('lib/features/graph/graph_painter.dart').readAsStringSync();
    final graphStyle = File('lib/features/graph/graph_style.dart').readAsStringSync();

    expect(graphCard, contains('mathpro-graph-canvas-fit-guard-q223'));
    expect(graphCard, contains('canvasPixelTight'));
    expect(graphCard, contains('pixelTight: canvasPixelTight'));
    expect(graphCard, contains('mathpro-graph-floating-zoom-in'));
    expect(graphCard, isNot(contains("label: 'Zoom +'")));
    expect(graphCard, isNot(contains("label: 'Domain'")));

    expect(graphSurface, contains('pixelTight'));
    expect(graphSurface, contains('premiumSurfaceGradient'));
    expect(graphPainter, contains('pixelTight'));
    expect(graphPainter, contains('samples: pixelTight ? 96'));
    expect(graphPainter, contains('if (compact || pixelTight || plotRect.height < 52 || plotRect.width < 104) return;'));
    expect(graphStyle, contains('premiumSurfaceGradient'));
  });

  testWidgets('V172-Q223 graph preview stays fully mounted in very tight top-panel height', (tester) async {
    var zoomedIn = false;
    var zoomedOut = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 320,
            height: 104,
            child: GraphCard(
              expression: const GraphExpression(
                originalExpression: 'sin(x)',
                normalizedExpression: 'sin(x)',
                type: GraphType.explicit,
              ),
              onClose: () {},
              onFullscreen: () {},
              onSettings: () {},
              onTraceToggle: () {},
              onReset: () {},
              onZoomIn: () => zoomedIn = true,
              onZoomOut: () => zoomedOut = true,
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('mathpro-premium-graph-card')), findsOneWidget);
    expect(find.byKey(const ValueKey('mathpro-graph-canvas-preview')), findsOneWidget);
    expect(find.byKey(const ValueKey('mathpro-graph-canvas-fit-guard-q223')), findsOneWidget);
    expect(find.byKey(const ValueKey('mathpro-graph-compact-info-row')), findsOneWidget);
    expect(find.text('Zoom +'), findsNothing);
    expect(find.text('Domain'), findsNothing);

    await tester.tap(find.byKey(const ValueKey('mathpro-graph-floating-zoom-in')));
    await tester.pump();
    await tester.tap(find.byKey(const ValueKey('mathpro-graph-floating-zoom-out')));
    await tester.pump();
    expect(zoomedIn, isTrue);
    expect(zoomedOut, isTrue);
  });

  test('V172-Q223 surface and painter can be constructed with pixel-tight fit mode', () {
    const expression = GraphExpression(
      originalExpression: 'x^2',
      normalizedExpression: 'x^2',
      type: GraphType.explicit,
    );
    const surface = GraphSurface(expression: expression, compact: true, pixelTight: true);
    const painter = GraphPainter(expression: expression, compact: true, pixelTight: true);
    expect(surface.pixelTight, isTrue);
    expect(painter.pixelTight, isTrue);
    expect(GraphStyle.premiumSurfaceGradient.colors.length, 3);
  });
}
