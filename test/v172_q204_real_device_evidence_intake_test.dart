import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_final_static_production_freeze_policy.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_real_device_evidence_intake_policy.dart';

void main() {
  test('V172-Q204 is an evidence intake gate on top of Q203 freeze', () {
    expect(MathLiveRealDeviceEvidenceIntakePolicy.phase, 'V172-Q204');
    expect(
      MathLiveRealDeviceEvidenceIntakePolicy.fullPhase,
      'V172-Q204-REAL-DEVICE-EVIDENCE-INTAKE-GATE',
    );
    expect(
      MathLiveRealDeviceEvidenceIntakePolicy.baseline,
      MathLiveFinalStaticProductionFreezePolicy.fullPhase,
    );
    expect(MathLiveRealDeviceEvidenceIntakePolicy.q203FinalStaticFreezeRequired, isTrue);
    expect(MathLiveRealDeviceEvidenceIntakePolicy.q199CommandContractRequired, isTrue);
    expect(MathLiveRealDeviceEvidenceIntakePolicy.q200NoFreezeContractRequired, isTrue);
    expect(MathLiveRealDeviceEvidenceIntakePolicy.q201CaretFocusSlotContractRequired, isTrue);
    expect(MathLiveRealDeviceEvidenceIntakePolicy.q202GraphHistorySolutionStateRequired, isTrue);
  });

  test('V172-Q204 requires real user-side Flutter and Android evidence', () {
    expect(MathLiveRealDeviceEvidenceIntakePolicy.userSideFlutterAnalyzeEvidenceRequired, isTrue);
    expect(MathLiveRealDeviceEvidenceIntakePolicy.userSideFlutterTestEvidenceRequired, isTrue);
    expect(MathLiveRealDeviceEvidenceIntakePolicy.userSideFlutterRunEvidenceRequired, isTrue);
    expect(MathLiveRealDeviceEvidenceIntakePolicy.androidRealDeviceVideoOrScreenshotsRequired, isTrue);
    expect(MathLiveRealDeviceEvidenceIntakePolicy.caretPlacementScenarioEvidenceRequired, isTrue);
    expect(MathLiveRealDeviceEvidenceIntakePolicy.templateVisualScenarioEvidenceRequired, isTrue);
    expect(MathLiveRealDeviceEvidenceIntakePolicy.noFreezeKeyboardTapEvidenceRequired, isTrue);
    expect(MathLiveRealDeviceEvidenceIntakePolicy.graphHistorySolutionEvidenceRequired, isTrue);
  });

  test('V172-Q204 blocks all PASS claims without evidence', () {
    expect(MathLiveRealDeviceEvidenceIntakePolicy.assistantMayInferPassWithoutEvidence, isFalse);
    expect(MathLiveRealDeviceEvidenceIntakePolicy.flutterAnalyzePassClaimedByAssistant, isFalse);
    expect(MathLiveRealDeviceEvidenceIntakePolicy.flutterTestPassClaimedByAssistant, isFalse);
    expect(MathLiveRealDeviceEvidenceIntakePolicy.flutterRunPassClaimedByAssistant, isFalse);
    expect(MathLiveRealDeviceEvidenceIntakePolicy.androidRealDevicePassClaimed, isFalse);
    expect(MathLiveRealDeviceEvidenceIntakePolicy.caretRealDevicePassClaimed, isFalse);
    expect(MathLiveRealDeviceEvidenceIntakePolicy.premiumVisualDevicePassClaimed, isFalse);
    expect(MathLiveRealDeviceEvidenceIntakePolicy.noFreezeDevicePassClaimed, isFalse);
    expect(MathLiveRealDeviceEvidenceIntakePolicy.graphHistorySolutionDevicePassClaimed, isFalse);
    expect(MathLiveRealDeviceEvidenceIntakePolicy.finalReleasePassClaimed, isFalse);
  });

  test('V172-Q204 scenario thresholds require zero blocking failures', () {
    expect(
      MathLiveRealDeviceEvidenceIntakePolicy.enoughScenarioEvidence(
        caretScenarios: 12,
        templateVisualScenarios: 12,
        noFreezeTapScenarios: 10,
        graphHistorySolutionScenarios: 6,
        blockingFailures: 0,
      ),
      isTrue,
    );
    expect(
      MathLiveRealDeviceEvidenceIntakePolicy.enoughScenarioEvidence(
        caretScenarios: 12,
        templateVisualScenarios: 12,
        noFreezeTapScenarios: 10,
        graphHistorySolutionScenarios: 6,
        blockingFailures: 1,
      ),
      isFalse,
    );
  });
}
