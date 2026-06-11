import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/editor_adapter/cursor_court_closure_or_repair_decision_gate_v172_q127_policy.dart';

void main() {
  test('V172-Q127 Cursor Court Closure Or Repair Decision Gate remains guard-only and blocks unsafe progression', () {
    expect(CursorCourtClosureOrRepairDecisionGateV172Q127Policy.phase, 'V172-Q127');
    expect(CursorCourtClosureOrRepairDecisionGateV172Q127Policy.guardOnly, isTrue);
    expect(CursorCourtClosureOrRepairDecisionGateV172Q127Policy.packageSideBatchPhase, isTrue);
    expect(CursorCourtClosureOrRepairDecisionGateV172Q127Policy.legacyFlutterSlotEditorRemainsDefault, isTrue);
    expect(CursorCourtClosureOrRepairDecisionGateV172Q127Policy.mathLiveDefaultSwitchImplementedInThisPackage, isFalse);
    expect(CursorCourtClosureOrRepairDecisionGateV172Q127Policy.legacyCursorPhysicalDeletionImplementedInThisPackage, isFalse);
    expect(CursorCourtClosureOrRepairDecisionGateV172Q127Policy.releasePassClaimedInThisPackage, isFalse);
    expect(CursorCourtClosureOrRepairDecisionGateV172Q127Policy.cursorPassClaimedInThisPackage, isFalse);
    expect(CursorCourtClosureOrRepairDecisionGateV172Q127Policy.keyboardMutationAllowed, isFalse);
    expect(CursorCourtClosureOrRepairDecisionGateV172Q127Policy.graphHistorySolutionUiMutationAllowed, isFalse);
  });
}
