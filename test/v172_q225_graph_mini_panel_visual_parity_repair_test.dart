import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/graph/graph_mini_panel_visual_parity_repair_policy.dart';
import 'package:mathpro_flutter_phase17/features/graph/graph_models.dart';

void main() {
  test('V172-Q225 policy records canvas dominance, trace clean state, and 3D compact binding', () {
    expect(GraphMiniPanelVisualParityRepairPolicy.phase, 'V172-Q225');
    expect(GraphMiniPanelVisualParityRepairPolicy.canvasDominanceRepairAdded, isTrue);
    expect(GraphMiniPanelVisualParityRepairPolicy.normalGraphCardHeightRaised, isTrue);
    expect(GraphMiniPanelVisualParityRepairPolicy.compactGraphCardHeightRaised, isTrue);
    expect(GraphMiniPanelVisualParityRepairPolicy.headerChromeThinnedForCanvasDominance, isTrue);
    expect(GraphMiniPanelVisualParityRepairPolicy.infoRowChromeThinnedForCanvasDominance, isTrue);
    expect(GraphMiniPanelVisualParityRepairPolicy.graphPreviewMustRemainUncroppedWhenTight, isTrue);
    expect(GraphMiniPanelVisualParityRepairPolicy.traceDefaultCleanStateAdded, isTrue);
    expect(GraphMiniPanelVisualParityRepairPolicy.miniPanelTraceOverlayDefaultOff, isTrue);
    expect(GraphMiniPanelVisualParityRepairPolicy.traceStillControlledFromSettingsSheet, isTrue);
    expect(GraphMiniPanelVisualParityRepairPolicy.threeDMiniSurfaceCompactBindingAdded, isTrue);
    expect(GraphMiniPanelVisualParityRepairPolicy.threeDCompactTextClutterSuppressed, isTrue);
    expect(GraphMiniPanelVisualParityRepairPolicy.keyboardMutationAllowed, isFalse);
    expect(GraphMiniPanelVisualParityRepairPolicy.mathLiveProductionMutationAllowed, isFalse);
    expect(GraphMiniPanelVisualParityRepairPolicy.graphFullscreenRuntimeMutationAllowed, isFalse);
    expect(GraphMiniPanelVisualParityRepairPolicy.threeDGraphPassClaimedByAssistant, isFalse);
  });

  test('V172-Q225 makes new graph previews trace-clean by default without removing settings trace control', () {
    const expression = GraphExpression(
      originalExpression: 'sin(x)',
      normalizedExpression: 'sin(x)',
      type: GraphType.explicit,
    );
    expect(expression.traceEnabled, isFalse);

    final restored = GraphExpression.fromJson(<String, Object?>{
      'originalExpression': 'sin(x)',
      'normalizedExpression': 'sin(x)',
      'type': 'explicit',
    });
    expect(restored, isNotNull);
    expect(restored!.traceEnabled, isFalse);

    final settingsSheet = File('lib/features/graph/graph_settings_sheet.dart').readAsStringSync();
    expect(settingsSheet, contains('mathpro-graph-settings-trace-toggle'));
    expect(settingsSheet, contains('_traceEnabled = expression.traceEnabled'));
  });

  test('V172-Q225 source applies canvas dominance and 3D mini compact fit', () {
    final workspace = File('lib/features/workspace/workspace_panel.dart').readAsStringSync();
    final graphCard = File('lib/features/graph/graph_card.dart').readAsStringSync();
    final graph3d = File('lib/features/graph/graph_surface_3d.dart').readAsStringSync();

    expect(workspace, contains('layoutHeight >= 420'));
    expect(workspace, contains('? 226.0'));
    expect(workspace, contains('? 176.0'));
    expect(workspace, contains(': 148.0'));
    expect(workspace, isNot(contains('compact ? 132.0 : 188.0')));

    expect(graphCard, contains('Q225: canvas dominance pass'));
    expect(graphCard, contains('final outerPadding = pixelTight ? 4.0'));
    expect(graphCard, contains('final headerGap = pixelTight ? 2.0'));
    expect(graphCard, contains('final infoGap = pixelTight ? 2.0'));
    expect(graphCard, contains('final height = tight ? 18.0 : compact ? 20.0 : 22.0'));
    expect(graphCard, contains('compact: canvasCompact || canvasPixelTight'));
    expect(graphCard, contains('GraphTraceOverlay'));
    expect(graphCard, contains('renderMode == GraphRenderMode.twoD && expression.traceEnabled'));

    expect(graph3d, contains('if (!compact && rect.width >= 150 && rect.height >= 92)'));
    expect(graph3d, contains('if (!compact) {'));
    expect(
      graph3d,
      anyOf(
        contains('3D surface için geçerli örnek üretilemedi'),
        contains('3D örnek üretilemedi'),
      ),
    );
    expect(graph3d, contains('GraphSurfaceColorRamp.colorAt'));
  });
}
