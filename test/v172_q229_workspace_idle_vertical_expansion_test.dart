import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('V172-Q229 idle workspace expands without touching keyboard or context panels', () {
    final workspace = File('lib/features/workspace/workspace_panel.dart').readAsStringSync();
    final policy = File('lib/features/workspace/workspace_idle_vertical_expansion_policy.dart').readAsStringSync();

    expect(workspace, contains('final idleExpansion = graphExpression == null && !templateTrayOpen && !showSolutionPanel;'));
    expect(workspace, contains('idleExpansion: idleExpansion'));
    expect(workspace, contains('final resultFlex = !stepsPanelOpen && cardVisualHeight >= 260 ? 3 : 2;'));
    expect(workspace, contains('Q229R4 root fix: the parent already allocates the exact vertical slot'));
    expect(workspace, contains('return availableHeight;'));
    expect(policy, contains("successorPhase = 'V172-Q229R4-WORKSPACE-CARD-SLOT-FILL-PHANTOM-GAP-FIX'"));
    expect(workspace, isNot(contains('.clamp(260.0, 348.0)')));
    expect(workspace, contains('if (templateTrayOpen) {'));
    expect(workspace, contains('if (stepsPanelOpen) {'));

    expect(policy, contains("keyboardLayoutMayChange = false"));
    expect(policy, contains("mathLiveProductionEditorMayChange = false"));
    expect(policy, contains("graphRuntimeMayBeRedesigned = false"));
    expect(policy, contains("onlyIdleWorkspaceMayReclaimDeadGap = true"));
  });
}
