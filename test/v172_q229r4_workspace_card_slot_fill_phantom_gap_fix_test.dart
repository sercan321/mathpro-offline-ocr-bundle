import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('V172-Q229R4 workspace card fills allocated slot without legacy phantom-gap caps', () {
    final workspace = File('lib/features/workspace/workspace_panel.dart').readAsStringSync();
    final policy = File('lib/features/workspace/workspace_card_slot_fill_phantom_gap_fix_policy.dart').readAsStringSync();

    expect(workspace, contains('Q229R4 root fix: the parent already allocates the exact vertical slot'));
    expect(workspace, contains('return availableHeight;'));
    expect(workspace, isNot(contains('availableHeight.clamp(220.0, 292.0)')));
    expect(workspace, isNot(contains('.clamp(238.0, 316.0)')));
    expect(workspace, isNot(contains('.clamp(260.0, 348.0)')));
    expect(workspace, contains('final resultFlex = !stepsPanelOpen && cardVisualHeight >= 260 ? 3 : 2;'));
    expect(workspace, contains('Graph does not reintroduce a larger card-slot phantom gap'));
    expect(policy, contains("phase = 'V172-Q229R4-WORKSPACE-CARD-SLOT-FILL-PHANTOM-GAP-FIX'"));
    expect(policy, contains('legacyIdleCapsRemoved = true'));
    expect(policy, contains('legacyMoreCapsRemoved = true'));
    expect(policy, contains('legacyGraphCapsRemoved = true'));
    expect(policy, contains('keyboardLayoutMayChange = false'));
    expect(policy, contains('mathLiveProductionEditorMayChange = false'));
    expect(policy, contains('solutionEngineMayChange = false'));
    expect(policy, contains('moreTemplateTrayContentMayChange = false'));
  });
}
