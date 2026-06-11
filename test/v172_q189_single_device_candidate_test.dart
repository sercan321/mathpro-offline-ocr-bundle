import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_single_device_candidate_policy.dart';

void main() {
  test('V172-Q189 freezes the Q184-Q188 production path as a device candidate', () {
    expect(MathLiveSingleDeviceCandidatePolicy.phase, 'V172-Q189');
    expect(MathLiveSingleDeviceCandidatePolicy.baseline, 'V172-Q188_PRODUCTION_GRAPH_HISTORY_SOLUTION_ADAPTER');
    expect(MathLiveSingleDeviceCandidatePolicy.packagesQ184MinimalProductionSurface, isTrue);
    expect(MathLiveSingleDeviceCandidatePolicy.packagesQ185MinimalProductionHtml, isTrue);
    expect(MathLiveSingleDeviceCandidatePolicy.packagesQ186MinimalProductionBridge, isTrue);
    expect(MathLiveSingleDeviceCandidatePolicy.packagesQ187TemplateCommandContract, isTrue);
    expect(MathLiveSingleDeviceCandidatePolicy.packagesQ188GraphHistorySolutionAdapter, isTrue);
    expect(MathLiveSingleDeviceCandidatePolicy.singleDeviceCandidateOnly, isTrue);
    expect(MathLiveSingleDeviceCandidatePolicy.finalReleaseClaimAllowed, isFalse);
    expect(MathLiveSingleDeviceCandidatePolicy.newFeatureAllowed, isFalse);
  });

  test('Q189 preserves red-line UI boundaries and blocks fake claims', () {
    expect(MathLiveSingleDeviceCandidatePolicy.keyboardLayoutMutationAllowed, isFalse);
    expect(MathLiveSingleDeviceCandidatePolicy.moreInventoryMutationAllowed, isFalse);
    expect(MathLiveSingleDeviceCandidatePolicy.longPressOrderMutationAllowed, isFalse);
    expect(MathLiveSingleDeviceCandidatePolicy.graphUiMutationAllowed, isFalse);
    expect(MathLiveSingleDeviceCandidatePolicy.historyUiMutationAllowed, isFalse);
    expect(MathLiveSingleDeviceCandidatePolicy.solutionUiMutationAllowed, isFalse);
    expect(MathLiveSingleDeviceCandidatePolicy.solverMutationAllowed, isFalse);
    expect(MathLiveSingleDeviceCandidatePolicy.fakeEvidenceAllowed, isFalse);
    expect(MathLiveSingleDeviceCandidatePolicy.flutterAnalyzePassClaimedByAssistant, isFalse);
    expect(MathLiveSingleDeviceCandidatePolicy.flutterTestPassClaimedByAssistant, isFalse);
    expect(MathLiveSingleDeviceCandidatePolicy.flutterRunPassClaimedByAssistant, isFalse);
    expect(MathLiveSingleDeviceCandidatePolicy.realDevicePassClaimed, isFalse);
    expect(MathLiveSingleDeviceCandidatePolicy.photomathLevelClaimed, isFalse);
  });

  test('Q189 requires Flutter, verifier, and manual Android evidence', () {
    expect(MathLiveSingleDeviceCandidatePolicy.requiredFlutterCommands, contains('flutter analyze'));
    expect(MathLiveSingleDeviceCandidatePolicy.requiredFlutterCommands, contains('flutter test'));
    expect(MathLiveSingleDeviceCandidatePolicy.requiredFlutterCommands, contains('flutter run -d 23106RN0DA'));
    expect(
      MathLiveSingleDeviceCandidatePolicy.requiredVerifierCommands,
      contains('node tool/verify_mathlive_single_device_candidate_v172_q189.mjs'),
    );
    expect(MathLiveSingleDeviceCandidatePolicy.requiredManualScenarios, contains('taylor-template-not-raw-text'));
    expect(MathLiveSingleDeviceCandidatePolicy.requiredManualScenarios, contains('graph-open-from-mathlive-state'));
    expect(MathLiveSingleDeviceCandidatePolicy.requiredManualScenarios, contains('solution-evaluator-candidate-from-mathlive-state'));
  });

  test('Q189 cannot be final without full device evidence', () {
    expect(
      MathLiveSingleDeviceCandidatePolicy.isFinalEvidenceComplete(
        flutterAnalyzePass: true,
        flutterTestPass: true,
        flutterRunCaptured: false,
        allVerifierCommandsPass: true,
        allManualScenariosPass: true,
        graphHistorySolutionAccepted: true,
        noRedLineRegressionObserved: true,
      ),
      isFalse,
    );
    expect(
      MathLiveSingleDeviceCandidatePolicy.candidateStatus(
        flutterAnalyzePass: true,
        flutterTestPass: true,
        flutterRunCaptured: false,
        allVerifierCommandsPass: true,
        allManualScenariosPass: true,
        graphHistorySolutionAccepted: true,
        noRedLineRegressionObserved: true,
      ),
      'Q189_PACKAGE_READY_BUT_DEVICE_EVIDENCE_REQUIRED',
    );
    expect(
      MathLiveSingleDeviceCandidatePolicy.candidateStatus(
        flutterAnalyzePass: true,
        flutterTestPass: true,
        flutterRunCaptured: true,
        allVerifierCommandsPass: true,
        allManualScenariosPass: true,
        graphHistorySolutionAccepted: true,
        noRedLineRegressionObserved: true,
      ),
      'Q189_DEVICE_CANDIDATE_EVIDENCE_COMPLETE_READY_FOR_FINAL_REVIEW',
    );
  });
}
