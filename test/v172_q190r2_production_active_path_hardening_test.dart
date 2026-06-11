import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_production_active_path_hardening_policy.dart';

void main() {
  test('V172-Q190R2 is active-path hardening, not a new feature phase', () {
    expect(MathLiveProductionActivePathHardeningPolicy.phase, 'V172-Q190R2');
    expect(MathLiveProductionActivePathHardeningPolicy.baseline, 'V172-Q190R1_REAL_DEVICE_DEFECT_REPAIR_COMPILE_FIX');
    expect(MathLiveProductionActivePathHardeningPolicy.newFeatureAllowed, isFalse);
  });

  test('Q190R2 preserves red-line UI boundaries', () {
    expect(MathLiveProductionActivePathHardeningPolicy.keyboardLayoutMutationAllowed, isFalse);
    expect(MathLiveProductionActivePathHardeningPolicy.moreInventoryMutationAllowed, isFalse);
    expect(MathLiveProductionActivePathHardeningPolicy.longPressOrderMutationAllowed, isFalse);
    expect(MathLiveProductionActivePathHardeningPolicy.graphUiMutationAllowed, isFalse);
    expect(MathLiveProductionActivePathHardeningPolicy.graphControllerMutationAllowed, isFalse);
    expect(MathLiveProductionActivePathHardeningPolicy.historyControllerMutationAllowed, isFalse);
    expect(MathLiveProductionActivePathHardeningPolicy.historyPanelMutationAllowed, isFalse);
    expect(MathLiveProductionActivePathHardeningPolicy.solutionStepsPanelMutationAllowed, isFalse);
    expect(MathLiveProductionActivePathHardeningPolicy.solverMutationAllowed, isFalse);
  });

  test('Q190R2 codifies production route and insert hardening gates', () {
    expect(MathLiveProductionActivePathHardeningPolicy.activeWorkspaceRouteMustUseProductionSurface, isTrue);
    expect(MathLiveProductionActivePathHardeningPolicy.productionSurfaceMustLoadProductionHtml, isTrue);
    expect(MathLiveProductionActivePathHardeningPolicy.productionSurfaceMustLoadProductionBridge, isTrue);
    expect(MathLiveProductionActivePathHardeningPolicy.productionSurfaceMustLoadBundledRuntime, isTrue);
    expect(MathLiveProductionActivePathHardeningPolicy.productionSurfaceMustInlineMathLiveCss, isTrue);
    expect(MathLiveProductionActivePathHardeningPolicy.productionBridgeMustRejectRawInsertTokenCommit, isTrue);
    expect(MathLiveProductionActivePathHardeningPolicy.productionBridgeMustRollbackRawInsertTokenLeak, isTrue);
    expect(MathLiveProductionActivePathHardeningPolicy.productionBridgeMustAppendSanitizedDocumentLatexFallback, isTrue);
  });

  test('Q190R2 does not falsely claim legacy cleanup, fonts, Flutter, or Android PASS', () {
    expect(MathLiveProductionActivePathHardeningPolicy.legacySurfacePhysicalCleanupCompleted, isFalse);
    expect(MathLiveProductionActivePathHardeningPolicy.mathLiveFontsBundledAndVerified, isFalse);
    expect(MathLiveProductionActivePathHardeningPolicy.androidRealDevicePassClaimed, isFalse);
    expect(MathLiveProductionActivePathHardeningPolicy.flutterAnalyzePassClaimedByAssistant, isFalse);
    expect(MathLiveProductionActivePathHardeningPolicy.flutterTestPassClaimedByAssistant, isFalse);
    expect(MathLiveProductionActivePathHardeningPolicy.flutterRunPassClaimedByAssistant, isFalse);
  });
}
