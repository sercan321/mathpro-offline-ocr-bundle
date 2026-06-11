import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_real_device_defect_repair_compile_fix_policy.dart';

void main() {
  test('V172-Q190R1 is compile-fix scoped, not a new feature phase', () {
    expect(MathLiveRealDeviceDefectRepairCompileFixPolicy.phase, 'V172-Q190R1');
    expect(MathLiveRealDeviceDefectRepairCompileFixPolicy.baseline, 'V172-Q190_REAL_DEVICE_DEFECT_REPAIR_COMPILE_BLOCKED');
    expect(MathLiveRealDeviceDefectRepairCompileFixPolicy.repairScope, 'production-helper-scope-and-insert-commit-predicate');
    expect(MathLiveRealDeviceDefectRepairCompileFixPolicy.newFeatureAllowed, isFalse);
  });

  test('Q190R1 preserves red-line UI boundaries', () {
    expect(MathLiveRealDeviceDefectRepairCompileFixPolicy.keyboardLayoutMutationAllowed, isFalse);
    expect(MathLiveRealDeviceDefectRepairCompileFixPolicy.moreInventoryMutationAllowed, isFalse);
    expect(MathLiveRealDeviceDefectRepairCompileFixPolicy.longPressOrderMutationAllowed, isFalse);
    expect(MathLiveRealDeviceDefectRepairCompileFixPolicy.graphUiMutationAllowed, isFalse);
    expect(MathLiveRealDeviceDefectRepairCompileFixPolicy.graphControllerMutationAllowed, isFalse);
    expect(MathLiveRealDeviceDefectRepairCompileFixPolicy.historyControllerMutationAllowed, isFalse);
    expect(MathLiveRealDeviceDefectRepairCompileFixPolicy.historyPanelMutationAllowed, isFalse);
    expect(MathLiveRealDeviceDefectRepairCompileFixPolicy.solutionStepsPanelMutationAllowed, isFalse);
    expect(MathLiveRealDeviceDefectRepairCompileFixPolicy.solverMutationAllowed, isFalse);
  });

  test('Q190R1 codifies production-helper scoping and commit predicate repair', () {
    expect(MathLiveRealDeviceDefectRepairCompileFixPolicy.productionHelpersScopedToProductionState, isTrue);
    expect(MathLiveRealDeviceDefectRepairCompileFixPolicy.legacyMainEditorStateMustNotReferenceProductionTail, isTrue);
    expect(MathLiveRealDeviceDefectRepairCompileFixPolicy.legacyMainEditorStateMustNotReferenceProductionEmitState, isTrue);
    expect(MathLiveRealDeviceDefectRepairCompileFixPolicy.enqueueProductionCommandOnlyInProductionState, isTrue);
    expect(MathLiveRealDeviceDefectRepairCompileFixPolicy.insertCommitRequiresActualDeltaWhenBeforeIsNonEmpty, isTrue);
    expect(MathLiveRealDeviceDefectRepairCompileFixPolicy.emptyBeforeMayCommitToNonEmptyAfter, isTrue);
  });

  test('Q190R1 does not claim Flutter or Android PASS inside the package', () {
    expect(MathLiveRealDeviceDefectRepairCompileFixPolicy.flutterAnalyzePassRequiredBeforeRelease, isTrue);
    expect(MathLiveRealDeviceDefectRepairCompileFixPolicy.assistantFlutterAnalyzePassClaimed, isFalse);
    expect(MathLiveRealDeviceDefectRepairCompileFixPolicy.androidRealDevicePassClaimed, isFalse);
  });
}
