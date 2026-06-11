import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/graph/graph_canvas_premium_polish_policy.dart';
import 'package:mathpro_flutter_phase17/features/graph/graph_mini_panel_final_regression_freeze_policy.dart';
import 'package:mathpro_flutter_phase17/features/graph/graph_mini_panel_layout_simplification_policy.dart';
import 'package:mathpro_flutter_phase17/features/graph/graph_settings_bottom_sheet_control_migration_policy.dart';

void main() {
  test('V172-Q224 policy freezes the premium graph mini-panel without broad runtime claims', () {
    expect(GraphMiniPanelFinalRegressionFreezePolicy.phase, 'V172-Q224');
    expect(GraphMiniPanelFinalRegressionFreezePolicy.finalRegressionFreezeAdded, isTrue);
    expect(GraphMiniPanelFinalRegressionFreezePolicy.oldTextActionRailMustRemainAbsent, isTrue);
    expect(GraphMiniPanelFinalRegressionFreezePolicy.largeDomainRangePillsMustRemainAbsent, isTrue);
    expect(GraphMiniPanelFinalRegressionFreezePolicy.miniPanelMustRemainCanvasFirst, isTrue);
    expect(GraphMiniPanelFinalRegressionFreezePolicy.settingsBottomSheetMustRemainSeparated, isTrue);
    expect(GraphMiniPanelFinalRegressionFreezePolicy.floatingZoomControlsMustRemainInsideCanvas, isTrue);
    expect(GraphMiniPanelFinalRegressionFreezePolicy.compactInfoRowMustRemainPresent, isTrue);
    expect(GraphMiniPanelFinalRegressionFreezePolicy.graphPreviewMustScaleInsteadOfCroppingWhenTight, isTrue);
    expect(GraphMiniPanelFinalRegressionFreezePolicy.graphRuntimeEvaluatorMutationAllowed, isFalse);
    expect(GraphMiniPanelFinalRegressionFreezePolicy.graphEligibilityMutationAllowed, isFalse);
    expect(GraphMiniPanelFinalRegressionFreezePolicy.keyboardMutationAllowed, isFalse);
    expect(GraphMiniPanelFinalRegressionFreezePolicy.mathLiveProductionMutationAllowed, isFalse);
    expect(GraphMiniPanelFinalRegressionFreezePolicy.flutterAnalyzePassClaimedByAssistant, isFalse);
    expect(GraphMiniPanelFinalRegressionFreezePolicy.threeDGraphPassClaimedByAssistant, isFalse);
  });

  test('V172-Q224 keeps Q221, Q222, and Q223 graph mini-panel contracts active', () {
    expect(GraphMiniPanelLayoutSimplificationPolicy.graphCanvasIsPrimaryVisualFocus, isTrue);
    expect(GraphMiniPanelLayoutSimplificationPolicy.largeDomainRangePillsRemovedFromMiniPanel, isTrue);
    expect(GraphMiniPanelLayoutSimplificationPolicy.textTraceResetZoomButtonsRemovedFromMiniPanel, isTrue);
    expect(GraphSettingsBottomSheetControlMigrationPolicy.graphSettingsBottomSheetActivated, isTrue);
    expect(GraphSettingsBottomSheetControlMigrationPolicy.traceControlMigratedToSheet, isTrue);
    expect(GraphSettingsBottomSheetControlMigrationPolicy.resetViewMigratedToSheet, isTrue);
    expect(GraphCanvasPremiumPolishPolicy.graphCanvasPremiumPolished, isTrue);
    expect(GraphCanvasPremiumPolishPolicy.graphPreviewScalesInsteadOfCroppingWhenTight, isTrue);
  });

  test('V172-Q224 source freezes mini-panel clutter removal and separated settings sheet', () {
    final graphCard = File('lib/features/graph/graph_card.dart').readAsStringSync();
    final settingsSheet = File('lib/features/graph/graph_settings_sheet.dart').readAsStringSync();
    final graphSurface = File('lib/features/graph/graph_surface.dart').readAsStringSync();
    final graphPainter = File('lib/features/graph/graph_painter.dart').readAsStringSync();
    final graphStyle = File('lib/features/graph/graph_style.dart').readAsStringSync();

    expect(graphCard, contains('mathpro-graph-canvas-preview'));
    expect(graphCard, contains('mathpro-graph-canvas-fit-guard-q223'));
    expect(graphCard, contains('mathpro-graph-2d-3d-elite-toggle'));
    expect(graphCard, contains('mathpro-graph-floating-zoom-out'));
    expect(graphCard, contains('mathpro-graph-floating-zoom-in'));
    expect(graphCard, contains('mathpro-graph-compact-info-row'));
    expect(graphCard, contains('mathpro-graph-window-summary'));
    expect(graphCard, isNot(contains('class _GraphActions')));
    expect(graphCard, isNot(contains('class _ActionChipButton')));
    expect(graphCard, isNot(contains("label: 'Trace On'")));
    expect(graphCard, isNot(contains("label: 'Trace Off'")));
    expect(graphCard, isNot(contains("label: 'Reset'")));
    expect(graphCard, isNot(contains("label: 'Zoom +'")));
    expect(graphCard, isNot(contains("label: 'Zoom −'")));
    expect(graphCard, isNot(contains("label: 'Domain'")));
    expect(graphCard, isNot(contains("label: 'Range'")));

    expect(settingsSheet, contains('mathpro-graph-settings-sheet-q222'));
    expect(settingsSheet, contains('mathpro-graph-settings-mode-segment'));
    expect(settingsSheet, contains('mathpro-graph-settings-window-fields'));
    expect(settingsSheet, contains('mathpro-graph-settings-trace-toggle'));
    expect(settingsSheet, contains('mathpro-graph-settings-reset-view'));

    expect(graphSurface, contains('premiumSurfaceGradient'));
    expect(graphPainter, contains('pixelTight'));
    expect(graphPainter, contains('if (compact || pixelTight || plotRect.height < 52 || plotRect.width < 104) return;'));
    expect(graphStyle, contains('premiumSurfaceGradient'));
  });
}
