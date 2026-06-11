import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_pp_formulanet_s_first_runtime_smoke_prototype.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_pp_formulanet_s_first_runtime_smoke_prototype_policy.dart';

void main() {
  group('V172-Q272-PP-FORMULANET-S-FIRST-RUNTIME-SMOKE-PROTOTYPE', () {
    const approvedInput = GaussPpFormulaNetSFirstRuntimeSmokePrototypeInput(
      q271PrivateArtifactLoadPrototypePresent: true,
      q271StillNoRuntimeNoInference: true,
      privateArtifactAccessEnvelopeDocumented: true,
      artifactShaAcceptedBeforeSmoke: true,
      modelFormatProbePlanDocumented: true,
      runtimePathCandidateDocumented: true,
      bridgeProtocolCandidateDocumented: true,
      noRuntimeDependencyAdded: true,
      noNativeBridgeImplementationBound: true,
      dummyInputEnvelopeDocumented: true,
      runtimeStartupEnvelopeDocumented: true,
      timeoutCancellationPolicyDocumented: true,
      memoryPressurePolicyDocumented: true,
      smokeErrorTaxonomyDocumented: true,
      latencyBudgetMs: 1800,
      peakMemoryBudgetMb: 192,
      featureFlagDefaultOffDocumented: true,
      noDefaultRuntimeEnablement: true,
      editableMathLiveReviewRequired: true,
      userApprovalRequiredBeforeWorkspaceImport: true,
      directSolveBlocked: true,
      directGraphSolutionHistoryBlocked: true,
      noPaddleRuntimeAdded: true,
      noPaddleOcrDependencyAdded: true,
      noNativeBridgeImplementationAdded: true,
      noJniBindingAdded: true,
      noMethodChannelRuntimeBindingAdded: true,
      noModelBinaryBundledInBaseApp: true,
      noProductionModelUrlBound: true,
      noRealNetworkDownloadWorkerImplemented: true,
      productionDownloadEnabled: false,
      noProductionInferenceAllowed: true,
      noImageToLatexInferenceExecuted: true,
      firstRuntimeSmokePassClaimed: false,
      ocrPassClaimed: false,
      smokeLabel: 'Q272 ready for future first runtime smoke only',
    );

    test('gates first runtime smoke without dependency, bridge implementation, or inference in Q272', () {
      final result = GaussPpFormulaNetSFirstRuntimeSmokePrototype.evaluate(approvedInput);

      expect(result.decision, GaussPpFormulaNetSFirstRuntimeSmokePrototypeDecision.readyForFutureFirstRuntimeSmokeOnly);
      expect(result.firstRuntimeSmokePrototypeStaticReady, isTrue);
      expect(result.readyForFutureRuntimeSmokeOnly, isTrue);
      expect(result.phase, GaussPpFormulaNetSFirstRuntimeSmokePrototypePolicy.phase);
      expect(result.sourcePhase, GaussPpFormulaNetSFirstRuntimeSmokePrototypePolicy.sourcePhase);
      expect(result.selectedEngineLabel, 'PP-FormulaNet-S');
      expect(result.smokePrototypeMode, 'first-runtime-smoke-prototype-gate-only-no-real-runtime-no-inference');
      expect(result.requiredSmokeGates, contains('q271PrivateArtifactLoadPrototypePresent'));
      expect(result.requiredSmokeGates, contains('runtimeStartupDoesNotRunImageToLatex'));
      expect(result.requiredSmokeGates, contains('noProductionInferenceInQ272'));
      expect(result.runtimeSmokeInputEnvelopeFields, contains('dummyInputPayloadHash'));
      expect(result.runtimeSmokeOutputEnvelopeFields, contains('noInferenceExecuted'));
      expect(result.runtimeSmokeFailureCodes, contains('runtimeStartupTimeout'));
      expect(result.forbiddenActions, contains('runImageToLatexInQ272'));
      expect(result.realOcrRuntimeAdded, isFalse);
      expect(result.paddleRuntimeAdded, isFalse);
      expect(result.paddleOcrDependencyAdded, isFalse);
      expect(result.nativeBridgeImplementationAdded, isFalse);
      expect(result.jniBindingAdded, isFalse);
      expect(result.methodChannelRuntimeBindingAdded, isFalse);
      expect(result.modelBinaryBundledInBaseApp, isFalse);
      expect(result.productionDownloadEnabled, isFalse);
      expect(result.productionInferenceAllowed, isFalse);
      expect(result.runtimeFeatureFlagDefaultOff, isTrue);
      expect(result.dummyInputOnly, isTrue);
      expect(result.imageToLatexInferenceExecuted, isFalse);
      expect(result.firstRuntimeSmokePassClaimed, isFalse);
      expect(result.ocrPassClaimed, isFalse);
      expect(result.canStartRealRuntimeInQ272, isFalse);
      expect(result.canRunDummyInputBridgeInQ272, isFalse);
      expect(result.canRunImageToLatexInQ272, isFalse);
      expect(result.canClaimRuntimeSmokePassInQ272, isFalse);
      expect(result.canClaimOcrPassInQ272, isFalse);
      expect(result.canEnableRuntimeByDefaultInQ272, isFalse);
      expect(result.canImportCameraOutputWithoutUserApproval, isFalse);
    });

    test('rejects unsafe dependency/bridge/inference attempts', () {
      final dependencyAdded = GaussPpFormulaNetSFirstRuntimeSmokePrototype.evaluate(
        const GaussPpFormulaNetSFirstRuntimeSmokePrototypeInput(
          q271PrivateArtifactLoadPrototypePresent: true,
          q271StillNoRuntimeNoInference: true,
          privateArtifactAccessEnvelopeDocumented: true,
          artifactShaAcceptedBeforeSmoke: true,
          modelFormatProbePlanDocumented: true,
          runtimePathCandidateDocumented: true,
          bridgeProtocolCandidateDocumented: true,
          noRuntimeDependencyAdded: false,
          noNativeBridgeImplementationBound: true,
          dummyInputEnvelopeDocumented: true,
          runtimeStartupEnvelopeDocumented: true,
          timeoutCancellationPolicyDocumented: true,
          memoryPressurePolicyDocumented: true,
          smokeErrorTaxonomyDocumented: true,
          latencyBudgetMs: 1800,
          peakMemoryBudgetMb: 192,
          featureFlagDefaultOffDocumented: true,
          noDefaultRuntimeEnablement: true,
          editableMathLiveReviewRequired: true,
          userApprovalRequiredBeforeWorkspaceImport: true,
          directSolveBlocked: true,
          directGraphSolutionHistoryBlocked: true,
          noPaddleRuntimeAdded: false,
          noPaddleOcrDependencyAdded: true,
          noNativeBridgeImplementationAdded: true,
          noJniBindingAdded: true,
          noMethodChannelRuntimeBindingAdded: true,
          noModelBinaryBundledInBaseApp: true,
          noProductionModelUrlBound: true,
          noRealNetworkDownloadWorkerImplemented: true,
          productionDownloadEnabled: false,
          noProductionInferenceAllowed: true,
          noImageToLatexInferenceExecuted: true,
          firstRuntimeSmokePassClaimed: false,
          ocrPassClaimed: false,
          smokeLabel: 'dependency added',
        ),
      );
      expect(dependencyAdded.decision, GaussPpFormulaNetSFirstRuntimeSmokePrototypeDecision.blockedRuntimeDependencyAddedUnexpectedly);
      expect(dependencyAdded.canStartRealRuntimeInQ272, isFalse);

      final unsafeInference = GaussPpFormulaNetSFirstRuntimeSmokePrototype.evaluate(
        const GaussPpFormulaNetSFirstRuntimeSmokePrototypeInput(
          q271PrivateArtifactLoadPrototypePresent: true,
          q271StillNoRuntimeNoInference: true,
          privateArtifactAccessEnvelopeDocumented: true,
          artifactShaAcceptedBeforeSmoke: true,
          modelFormatProbePlanDocumented: true,
          runtimePathCandidateDocumented: true,
          bridgeProtocolCandidateDocumented: true,
          noRuntimeDependencyAdded: true,
          noNativeBridgeImplementationBound: true,
          dummyInputEnvelopeDocumented: true,
          runtimeStartupEnvelopeDocumented: true,
          timeoutCancellationPolicyDocumented: true,
          memoryPressurePolicyDocumented: true,
          smokeErrorTaxonomyDocumented: true,
          latencyBudgetMs: 1800,
          peakMemoryBudgetMb: 192,
          featureFlagDefaultOffDocumented: true,
          noDefaultRuntimeEnablement: true,
          editableMathLiveReviewRequired: true,
          userApprovalRequiredBeforeWorkspaceImport: true,
          directSolveBlocked: true,
          directGraphSolutionHistoryBlocked: true,
          noPaddleRuntimeAdded: true,
          noPaddleOcrDependencyAdded: true,
          noNativeBridgeImplementationAdded: true,
          noJniBindingAdded: true,
          noMethodChannelRuntimeBindingAdded: true,
          noModelBinaryBundledInBaseApp: true,
          noProductionModelUrlBound: true,
          noRealNetworkDownloadWorkerImplemented: true,
          productionDownloadEnabled: false,
          noProductionInferenceAllowed: false,
          noImageToLatexInferenceExecuted: false,
          firstRuntimeSmokePassClaimed: true,
          ocrPassClaimed: true,
          smokeLabel: 'unsafe inference',
        ),
      );
      expect(unsafeInference.decision, GaussPpFormulaNetSFirstRuntimeSmokePrototypeDecision.blockedInferenceOrOcrPassClaimedInQ272);
      expect(unsafeInference.canRunImageToLatexInQ272, isFalse);
    });

    test('keeps runtime dependency and protected production surfaces unchanged', () {
      final pubspec = File('pubspec.yaml').readAsStringSync().toLowerCase();
      for (final forbidden in <String>[
        'google_mlkit_text_recognition',
        'paddleocr',
        'paddle_flutter',
        'paddle_lite',
        'onnxruntime',
        'tesseract',
        'pix2text',
        'flutter_downloader',
        'background_downloader',
        'dio',
      ]) {
        expect(pubspec.contains(forbidden), isFalse, reason: 'Q272 must not add $forbidden');
      }
      expect(pubspec.contains('camera: 0.10.6'), isTrue);
      expect(pubspec.contains('camera_android: 0.10.9+3'), isTrue);

      final manifest = File('assets/mathlive/manifest.json').readAsStringSync();
      expect(manifest.contains(GaussPpFormulaNetSFirstRuntimeSmokePrototypePolicy.phase), isTrue);
      expect(manifest.contains('"realOcrRuntimeAdded": false'), isTrue);
      expect(manifest.contains('"paddleRuntimeAdded": false'), isTrue);
      expect(manifest.contains('"nativeBridgeImplementationAdded": false'), isTrue);
      expect(manifest.contains('"productionInferenceAllowed": false'), isTrue);
      expect(manifest.contains('"imageToLatexInferenceExecuted": false'), isTrue);
      expect(manifest.contains('"runtimeFeatureFlagDefaultOff": true'), isTrue);
      expect(manifest.contains('"runtimeDefaultEnabled": false'), isTrue);

      expect(File('assets/mathlive/mathlive_prod_bridge.js').readAsStringSync().contains('V172-Q272'), isFalse);
      expect(File('assets/mathlive/main_editor_prod.html').readAsStringSync().contains('V172-Q272'), isFalse);
      expect(File('lib/features/graph/graph_card.dart').readAsStringSync().contains('V172-Q272'), isFalse);
      expect(File('lib/features/solution/solution_steps_panel.dart').readAsStringSync().contains('V172-Q272'), isFalse);
      expect(File('lib/features/history/history_panel.dart').readAsStringSync().contains('V172-Q272'), isFalse);
    });
  });
}
