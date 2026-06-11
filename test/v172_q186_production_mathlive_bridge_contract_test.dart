import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_production_bridge_contract_policy.dart';

void main() {
  test('V172-Q186 production bridge contract is minimal and conservative', () {
    expect(MathLiveProductionBridgeContractPolicy.phase, 'V172-Q186');
    expect(MathLiveProductionBridgeContractPolicy.minimalPublicApiFrozen, isTrue);
    expect(MathLiveProductionBridgeContractPolicy.publicBridgeApi, <String>[
      'mount',
      'insertLatex',
      'deleteBackward',
      'clear',
      'setLatex',
      'getLatex',
      'focus',
      'keepCaretVisible',
      'notifyFlutterState',
    ]);
    expect(MathLiveProductionBridgeContractPolicy.executeMathProCommandAllowed, isFalse);
    expect(MathLiveProductionBridgeContractPolicy.exposedScheduleMountAllowed, isFalse);
    expect(MathLiveProductionBridgeContractPolicy.exposedFlushQueueAllowed, isFalse);
    expect(MathLiveProductionBridgeContractPolicy.exposedDiagnosticCourtAllowed, isFalse);
    expect(MathLiveProductionBridgeContractPolicy.exposedRuntimeSmokeAllowed, isFalse);
    expect(MathLiveProductionBridgeContractPolicy.exposedRealDeviceDumpAllowed, isFalse);
    expect(MathLiveProductionBridgeContractPolicy.realDeviceFlutterMirrorFeedsProductionSurface, isFalse);
    expect(MathLiveProductionBridgeContractPolicy.flutterTestMirrorFallbackOnly, isTrue);
    expect(MathLiveProductionBridgeContractPolicy.strictRuntimeMountedRequiresCustomElement, isTrue);
    expect(MathLiveProductionBridgeContractPolicy.keyboardLayoutMutationAllowed, isFalse);
    expect(MathLiveProductionBridgeContractPolicy.graphHistorySolutionMutationAllowed, isFalse);
    expect(MathLiveProductionBridgeContractPolicy.realDevicePremiumPassClaimed, isFalse);
  });
}
