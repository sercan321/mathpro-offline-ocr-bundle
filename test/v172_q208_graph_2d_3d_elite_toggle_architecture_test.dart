import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/graph/graph_2d_3d_elite_toggle_architecture_policy.dart';
import 'package:mathpro_flutter_phase17/features/graph/graph_models.dart';

void main() {
  test('V172-Q208 graph 2D/3D elite toggle policy is honest about 3D readiness', () {
    expect(Graph2D3DEliteToggleArchitecturePolicy.phase, 'V172-Q208');
    expect(Graph2D3DEliteToggleArchitecturePolicy.elite2D3DToggleAdded, isTrue);
    expect(Graph2D3DEliteToggleArchitecturePolicy.twoDUsesExistingGraphSurface, isTrue);
    expect(Graph2D3DEliteToggleArchitecturePolicy.fake3DRendererClaimed, isFalse);
    // Q209 successor replaces the guarded readiness panel with a real custom-painted
    // 3D surface foundation while keeping Q208's toggle/state architecture intact.
    expect(Graph2D3DEliteToggleArchitecturePolicy.real3DRendererDeferredToQ209, isTrue);
    expect(Graph2D3DEliteToggleArchitecturePolicy.mathLiveEditorMutationAllowed, isFalse);
    expect(Graph2D3DEliteToggleArchitecturePolicy.keyboardLayoutMutationAllowed, isFalse);
    expect(Graph2D3DEliteToggleArchitecturePolicy.flutterAnalyzePassClaimedByAssistant, isFalse);
    expect(Graph2D3DEliteToggleArchitecturePolicy.flutterTestPassClaimedByAssistant, isFalse);
    expect(Graph2D3DEliteToggleArchitecturePolicy.androidRealDevicePassClaimed, isFalse);
  });

  test('V172-Q208 graph render mode enum and GraphCard source expose 2D and 3D routes', () {
    expect(GraphRenderMode.values, containsAll(<GraphRenderMode>[GraphRenderMode.twoD, GraphRenderMode.threeD]));
    final graphCard = File('lib/features/graph/graph_card.dart').readAsStringSync();
    expect(graphCard, contains('mathpro-graph-2d-3d-elite-toggle'));
    expect(graphCard, contains('_GraphRenderModeToggle'));
    expect(graphCard, anyOf(contains('_Graph3DReadinessPanel'), contains('GraphSurface3D(')));
    expect(graphCard, contains('GraphSurface('));
    expect(graphCard, isNot(contains('_ActionChipButton(label: \'Settings\'')));
  });

  test('V172-Q208 does not touch MathLive production editor or retired legacy runtime paths', () {
    final mathLiveHtml = File('assets/mathlive/main_editor_prod.html').readAsStringSync();
    final bridge = File('assets/mathlive/mathlive_prod_bridge.js').readAsStringSync();
    final workspace = File('lib/features/workspace/workspace_panel.dart').readAsStringSync();
    final appShell = File('lib/app/app_shell.dart').readAsStringSync();

    expect(mathLiveHtml, contains('font-size: clamp(28px, 7.8vw, 38px);'));
    expect(bridge, isNot(contains('runJavaScript' 'ReturningResult')));
    expect(workspace, contains('renderMode: graphRenderMode'));
    expect(appShell, contains('GraphRenderMode _graphRenderMode = GraphRenderMode.twoD;'));

    for (final path in <String>[
      'lib/features/workspace/editor_viewport.dart',
      'lib/features/workspace/editor_caret_overlay.dart',
      'lib/features/editor/render/mathjax_render_surface.dart',
      'lib/features/editor_adapter/legacy_flutter_slot_editor_adapter.dart',
      'assets/mathjax/tex-svg.js',
    ]) {
      expect(File(path).existsSync(), isFalse, reason: '$path must stay retired');
    }
  });
}
