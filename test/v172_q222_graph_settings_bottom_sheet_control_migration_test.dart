import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/graph/graph_models.dart';
import 'package:mathpro_flutter_phase17/features/graph/graph_settings_bottom_sheet_control_migration_policy.dart';
import 'package:mathpro_flutter_phase17/features/graph/graph_settings_sheet.dart';

void main() {
  test('V172-Q222 policy records settings sheet control migration without broad runtime claims', () {
    expect(GraphSettingsBottomSheetControlMigrationPolicy.phase, 'V172-Q222');
    expect(GraphSettingsBottomSheetControlMigrationPolicy.graphSettingsBottomSheetActivated, isTrue);
    expect(GraphSettingsBottomSheetControlMigrationPolicy.modeControlMigratedToSheet, isTrue);
    expect(GraphSettingsBottomSheetControlMigrationPolicy.viewportWindowFieldsMigratedToSheet, isTrue);
    expect(GraphSettingsBottomSheetControlMigrationPolicy.traceControlMigratedToSheet, isTrue);
    expect(GraphSettingsBottomSheetControlMigrationPolicy.resetViewMigratedToSheet, isTrue);
    expect(GraphSettingsBottomSheetControlMigrationPolicy.miniPanelRemainsCanvasFirst, isTrue);
    expect(GraphSettingsBottomSheetControlMigrationPolicy.graphCanvasCropPreventionPreserved, isTrue);
    expect(GraphSettingsBottomSheetControlMigrationPolicy.appShellMutationLimitedToSettingsBinding, isTrue);
    expect(GraphSettingsBottomSheetControlMigrationPolicy.keyboardMutationAllowed, isFalse);
    expect(GraphSettingsBottomSheetControlMigrationPolicy.mathLiveProductionMutationAllowed, isFalse);
    expect(GraphSettingsBottomSheetControlMigrationPolicy.graphRuntimeEvaluatorMutationAllowed, isFalse);
    expect(GraphSettingsBottomSheetControlMigrationPolicy.flutterAnalyzePassClaimedByAssistant, isFalse);
    expect(GraphSettingsBottomSheetControlMigrationPolicy.androidRealDevicePassClaimedByAssistant, isFalse);
  });

  test('V172-Q222 graph settings sheet source exposes mode, window, trace and reset view controls', () {
    final sheet = File('lib/features/graph/graph_settings_sheet.dart').readAsStringSync();
    final graphCard = File('lib/features/graph/graph_card.dart').readAsStringSync();
    final appShell = File('lib/app/app_shell.dart').readAsStringSync();

    expect(sheet, contains('mathpro-graph-settings-sheet-q222'));
    expect(sheet, contains('mathpro-graph-settings-mode-segment'));
    expect(sheet, contains('mathpro-graph-settings-window-fields'));
    expect(sheet, contains('mathpro-graph-settings-trace-toggle'));
    expect(sheet, contains('mathpro-graph-settings-reset-view'));
    expect(sheet, contains('Reset View'));
    expect(sheet, contains('Graph Settings'));
    expect(sheet, contains('onRenderModeChanged'));
    expect(sheet, isNot(contains('GraphSurface(')));
    expect(sheet, isNot(contains('void _applyConstantPreset()')));

    expect(graphCard, contains('mathpro-graph-canvas-preview'));
    expect(graphCard, contains('mathpro-graph-floating-zoom-in'));
    expect(graphCard, isNot(contains("label: 'Trace On'")));
    expect(graphCard, isNot(contains("label: 'Zoom +'")));
    expect(graphCard, isNot(contains("label: 'Domain'")));

    expect(appShell, contains('renderMode: _graphRenderMode'));
    expect(appShell, contains('onRenderModeChanged: _setGraphRenderMode'));
  });

  testWidgets('V172-Q222 settings sheet applies trace, viewport and render mode without graph card clutter', (tester) async {
    GraphExpression? appliedExpression;
    GraphRenderMode? appliedMode;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: GraphSettingsSheet(
            expression: const GraphExpression(
              originalExpression: 'sin(x)',
              normalizedExpression: 'sin(x)',
              type: GraphType.explicit,
              xMin: -10,
              xMax: 10,
              yMin: -5,
              yMax: 5,
              traceEnabled: false,
            ),
            renderMode: GraphRenderMode.twoD,
            onRenderModeChanged: (mode) => appliedMode = mode,
            onApply: (expression) => appliedExpression = expression,
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('mathpro-graph-settings-sheet-q222')), findsOneWidget);
    expect(find.byKey(const ValueKey('mathpro-graph-settings-mode-segment')), findsOneWidget);
    expect(find.byKey(const ValueKey('mathpro-graph-settings-window-fields')), findsOneWidget);
    expect(find.byKey(const ValueKey('mathpro-graph-settings-trace-toggle')), findsOneWidget);
    expect(find.text('Trace On'), findsNothing);
    expect(find.text('Zoom +'), findsNothing);
    expect(find.text('Domain'), findsNothing);

    await tester.tap(find.text('3D'));
    await tester.pump();
    await tester.tap(find.text('On'));
    await tester.pump();
    final applyButton = find.byKey(const ValueKey('mathpro-graph-settings-apply'));
    await tester.dragUntilVisible(
      applyButton,
      find.byType(SingleChildScrollView),
      const Offset(0, -80),
    );
    await tester.pumpAndSettle();
    await tester.tap(applyButton);
    await tester.pumpAndSettle();

    expect(appliedMode, GraphRenderMode.threeD);
    expect(appliedExpression, isNotNull);
    expect(appliedExpression!.traceEnabled, isTrue);
  });
}
