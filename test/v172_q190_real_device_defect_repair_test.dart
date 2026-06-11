import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_real_device_defect_repair_policy.dart';

void main() {
  test('V172-Q190 is scoped to the Q189 real Android failure', () {
    expect(MathLiveRealDeviceDefectRepairPolicy.phase, 'V172-Q190');
    expect(MathLiveRealDeviceDefectRepairPolicy.failureSource, 'Q189_REAL_ANDROID_DEVICE_FAIL');
    expect(MathLiveRealDeviceDefectRepairPolicy.repairScope, 'production-mathlive-freeze-render-bridge-defect');
    expect(MathLiveRealDeviceDefectRepairPolicy.newFeatureAllowed, isFalse);
  });

  test('Q190 preserves red-line UI boundaries', () {
    expect(MathLiveRealDeviceDefectRepairPolicy.keyboardLayoutMutationAllowed, isFalse);
    expect(MathLiveRealDeviceDefectRepairPolicy.moreInventoryMutationAllowed, isFalse);
    expect(MathLiveRealDeviceDefectRepairPolicy.longPressOrderMutationAllowed, isFalse);
    expect(MathLiveRealDeviceDefectRepairPolicy.graphUiMutationAllowed, isFalse);
    expect(MathLiveRealDeviceDefectRepairPolicy.graphControllerMutationAllowed, isFalse);
    expect(MathLiveRealDeviceDefectRepairPolicy.historyControllerMutationAllowed, isFalse);
    expect(MathLiveRealDeviceDefectRepairPolicy.historyPanelMutationAllowed, isFalse);
    expect(MathLiveRealDeviceDefectRepairPolicy.solutionStepsPanelMutationAllowed, isFalse);
    expect(MathLiveRealDeviceDefectRepairPolicy.solverMutationAllowed, isFalse);
  });

  test('Q190 hardens Android bridge dispatch against key/template lockups', () {
    expect(MathLiveRealDeviceDefectRepairPolicy.productionSurfaceDispatchHardened, isTrue);
    expect(MathLiveRealDeviceDefectRepairPolicy.productionBridgeFireAndStatePush, isTrue);
    expect(MathLiveRealDeviceDefectRepairPolicy.androidReturningResultForKeypressesDisabled, isTrue);
    expect(MathLiveRealDeviceDefectRepairPolicy.commandDispatchSerialized, isTrue);
    expect(MathLiveRealDeviceDefectRepairPolicy.commandTimeoutPreventsQueueLock, isTrue);
    expect(MathLiveRealDeviceDefectRepairPolicy.insertCommitFallbackEnabled, isTrue);
    expect(MathLiveRealDeviceDefectRepairPolicy.postInsertStatePushRequired, isTrue);
    expect(MathLiveRealDeviceDefectRepairPolicy.clearMustPurgeMathLiveState, isTrue);
  });

  test('Q190 covers the reported real-device failure questions', () {
    expect(MathLiveRealDeviceDefectRepairPolicy.repairedFailureQuestions, contains('MathPro key press state neden takılıyor?'));
    expect(MathLiveRealDeviceDefectRepairPolicy.repairedFailureQuestions, contains('WebView JS bridge insertLatex çağrısı Android’de hata mı veriyor?'));
    expect(MathLiveRealDeviceDefectRepairPolicy.repairedFailureQuestions, contains('insertLatex sonrası notifyFlutterState dönüyor mu?'));
    expect(MathLiveRealDeviceDefectRepairPolicy.repairedFailureQuestions, contains('C tuşu ve clear MathLive state’i temizliyor mu?'));
  });
}
