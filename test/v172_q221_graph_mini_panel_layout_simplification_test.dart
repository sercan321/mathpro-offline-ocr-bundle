import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/graph/graph_card.dart';
import 'package:mathpro_flutter_phase17/features/graph/graph_mini_panel_layout_simplification_policy.dart';
import 'package:mathpro_flutter_phase17/features/graph/graph_models.dart';

void main() {
  test('V172-Q221 policy records graph mini panel simplification without protected-surface claims', () {
    expect(GraphMiniPanelLayoutSimplificationPolicy.phase, 'V172-Q221');
    expect(GraphMiniPanelLayoutSimplificationPolicy.graphMiniPanelSimplified, isTrue);
    expect(GraphMiniPanelLayoutSimplificationPolicy.graphCanvasIsPrimaryVisualFocus, isTrue);
    expect(GraphMiniPanelLayoutSimplificationPolicy.largeDomainRangePillsRemovedFromMiniPanel, isTrue);
    expect(GraphMiniPanelLayoutSimplificationPolicy.textTraceResetZoomButtonsRemovedFromMiniPanel, isTrue);
    expect(GraphMiniPanelLayoutSimplificationPolicy.floatingZoomControlsAddedInsideCanvas, isTrue);
    expect(GraphMiniPanelLayoutSimplificationPolicy.graphPreviewScalesInsteadOfCroppingWhenTight, isTrue);
    expect(GraphMiniPanelLayoutSimplificationPolicy.keyboardMutationAllowed, isFalse);
    expect(GraphMiniPanelLayoutSimplificationPolicy.mathLiveProductionMutationAllowed, isFalse);
    expect(GraphMiniPanelLayoutSimplificationPolicy.flutterAnalyzePassClaimedByAssistant, isFalse);
    expect(GraphMiniPanelLayoutSimplificationPolicy.androidRealDevicePassClaimedByAssistant, isFalse);
  });

  test('V172-Q221 graph card source removes mini-panel text action clutter', () {
    final graphCard = File('lib/features/graph/graph_card.dart').readAsStringSync();
    expect(graphCard, contains('mathpro-graph-canvas-preview'));
    expect(graphCard, contains('mathpro-graph-floating-zoom-in'));
    expect(graphCard, contains('mathpro-graph-floating-zoom-out'));
    expect(graphCard, contains('mathpro-graph-compact-info-row'));
    expect(graphCard, isNot(contains("label: 'Trace On'")));
    expect(graphCard, isNot(contains("label: 'Trace Off'")));
    expect(graphCard, isNot(contains("label: 'Reset'")));
    expect(graphCard, isNot(contains("label: 'Zoom +'")));
    expect(graphCard, isNot(contains("label: 'Zoom −'")));
    expect(graphCard, isNot(contains("label: 'Domain'")));
    expect(graphCard, isNot(contains("label: 'Range'")));
  });

  testWidgets('V172-Q221 graph preview renders full canvas and compact controls in tight height', (tester) async {
    var zoomedIn = false;
    var zoomedOut = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 390,
            height: 116,
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
    expect(find.byKey(const ValueKey('mathpro-graph-compact-info-row')), findsOneWidget);
    expect(find.text('Trace On'), findsNothing);
    expect(find.text('Reset'), findsNothing);
    expect(find.text('Zoom +'), findsNothing);
    expect(find.text('Zoom −'), findsNothing);
    expect(find.text('Domain'), findsNothing);
    expect(find.text('Range'), findsNothing);

    await tester.tap(find.byKey(const ValueKey('mathpro-graph-floating-zoom-in')));
    await tester.pump();
    await tester.tap(find.byKey(const ValueKey('mathpro-graph-floating-zoom-out')));
    await tester.pump();
    expect(zoomedIn, isTrue);
    expect(zoomedOut, isTrue);
  });
}
