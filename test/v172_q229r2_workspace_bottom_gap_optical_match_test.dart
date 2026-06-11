import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('V172-Q229R2 matches idle workspace bottom gap to MORE-open optical spacing without touching protected systems', () {
    final workspace = File('lib/features/workspace/workspace_panel.dart').readAsStringSync();
    final policy = File('lib/features/workspace/workspace_bottom_gap_optical_match_policy.dart').readAsStringSync();

    expect(workspace, contains('Q229R2: mirror the compact MORE-open rhythm'));
    expect(workspace, contains('if (height >= 420) return const EdgeInsets.fromLTRB(0.0, 8, 0.0, 5);'));
    expect(workspace, contains('if (height >= 360) return const EdgeInsets.fromLTRB(0.0, 7, 0.0, 5);'));
    expect(workspace, contains('Q229R4 root fix: the parent already allocates the exact vertical slot'));
    expect(workspace, contains('return availableHeight;'));
    expect(workspace, isNot(contains('availableHeight.clamp(220.0, 292.0)')));
    expect(workspace, contains('if (templateTrayOpen || stepsPanelOpen || idleExpansion) {'));
    expect(workspace, contains('final resultFlex = !stepsPanelOpen && cardVisualHeight >= 260 ? 3 : 2;'));

    expect(policy, contains("phase = 'V172-Q229R2-WORKSPACE-BOTTOM-GAP-OPTICAL-MATCH'"));
    expect(policy, contains('keyboardLayoutMayChange = false'));
    expect(policy, contains('mathLiveProductionEditorMayChange = false'));
    expect(policy, contains('graphRuntimeMayChange = false'));
    expect(policy, contains('solutionRuntimeMayChange = false'));
    expect(policy, contains("successorPhase = 'V172-Q229R4-WORKSPACE-CARD-SLOT-FILL-PHANTOM-GAP-FIX'"));
    expect(policy, contains('idleBottomGapTargetMin = 8'));
    expect(policy, contains('idleBottomGapTargetMax = 12'));
  });
}
