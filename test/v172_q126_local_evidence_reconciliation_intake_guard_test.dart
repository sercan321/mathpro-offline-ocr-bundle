import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/editor_adapter/local_evidence_reconciliation_intake_guard_v172_q126_policy.dart';

void main() {
  test('V172-Q126 Local Evidence Reconciliation Intake Guard remains guard-only and blocks unsafe progression', () {
    expect(LocalEvidenceReconciliationIntakeGuardV172Q126Policy.phase, 'V172-Q126');
    expect(LocalEvidenceReconciliationIntakeGuardV172Q126Policy.guardOnly, isTrue);
    expect(LocalEvidenceReconciliationIntakeGuardV172Q126Policy.packageSideBatchPhase, isTrue);
    expect(LocalEvidenceReconciliationIntakeGuardV172Q126Policy.legacyFlutterSlotEditorRemainsDefault, isTrue);
    expect(LocalEvidenceReconciliationIntakeGuardV172Q126Policy.mathLiveDefaultSwitchImplementedInThisPackage, isFalse);
    expect(LocalEvidenceReconciliationIntakeGuardV172Q126Policy.legacyCursorPhysicalDeletionImplementedInThisPackage, isFalse);
    expect(LocalEvidenceReconciliationIntakeGuardV172Q126Policy.releasePassClaimedInThisPackage, isFalse);
    expect(LocalEvidenceReconciliationIntakeGuardV172Q126Policy.cursorPassClaimedInThisPackage, isFalse);
    expect(LocalEvidenceReconciliationIntakeGuardV172Q126Policy.keyboardMutationAllowed, isFalse);
    expect(LocalEvidenceReconciliationIntakeGuardV172Q126Policy.graphHistorySolutionUiMutationAllowed, isFalse);
  });
}
