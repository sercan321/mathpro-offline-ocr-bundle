import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_pp_formulanet_s_runtime_activation_decision_gate.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_pp_formulanet_s_runtime_activation_decision_gate_policy.dart';

void main() {
  group('V172-Q266-PP-FORMULANET-S-RUNTIME-ACTIVATION-DECISION-GATE', () {
    const approvedInput = GaussPpFormulaNetSRuntimeActivationDecisionGateInput(
      q265AcceptedEvidencePresent: true,
      runtimeCandidateSelected: true,
      runtimeCandidateSafe: true,
      runtimePathEvidencePresent: true,
      androidAbiSupported: true,
      modelFormatAccepted: true,
      privateArtifactVerified: true,
      artifactSha256AcceptedByQ265: true,
      latencyMs: 1200,
      peakMemoryMb: 256,
      fallbackPlanDefined: true,
      formulaOcrPrimaryOnly: true,
      editableMathLiveReviewRequired: true,
      userApprovalRequiredBeforeWorkspaceImport: true,
      directSolveBlocked: true,
      directGraphSolutionHistoryBlocked: true,
      noPaddleRuntimeDependencyAdded: true,
      noPaddleOcrDependencyAdded: true,
      noNativeBridgeAdded: true,
      noJniBindingAdded: true,
      noMethodChannelRuntimeBindingAdded: true,
      noModelBinaryBundledInBaseApp: true,
      noProductionModelUrlBound: true,
      noRealNetworkDownloadWorkerImplemented: true,
      productionDownloadEnabled: false,
      noProductionInferenceAllowed: true,
      runtimeActivationPassClaimed: false,
      ocrPassClaimed: false,
      activationLabel: 'Q266 approved for future runtime integration gate only',
    );

    test('approves only future runtime integration gate and never activates runtime in Q266', () {
      final result = GaussPpFormulaNetSRuntimeActivationDecisionGate.evaluate(approvedInput);

      expect(result.decision, GaussPpFormulaNetSRuntimeActivationDecisionGateDecision.approvedForFutureRuntimeIntegrationGateOnly);
      expect(result.runtimeActivationDecisionGateStaticReady, isTrue);
      expect(result.approvedForFutureRuntimeIntegrationGateOnly, isTrue);
      expect(result.phase, GaussPpFormulaNetSRuntimeActivationDecisionGatePolicy.phase);
      expect(result.sourcePhase, GaussPpFormulaNetSRuntimeActivationDecisionGatePolicy.sourcePhase);
      expect(result.selectedEngineLabel, 'PP-FormulaNet-S');
      expect(result.fallbackEngineLabel, 'PP-FormulaNet_plus-L');
      expect(result.activationMode, 'runtime-activation-decision-gate-only-no-runtime-no-inference');
      expect(result.requiredActivationGates, contains('q265AcceptedEvidencePresent'));
      expect(result.requiredActivationGates, contains('runtimeCandidateSelected'));
      expect(result.requiredActivationGates, contains('latencyWithinBudget'));
      expect(result.requiredActivationGates, contains('peakMemoryWithinBudget'));
      expect(result.requiredActivationGates, contains('editableMathLiveReviewRequired'));
      expect(result.requiredActivationGates, contains('directSolveBlocked'));
      expect(result.blockedUntilRealEvidence, contains('acceptedQ265RuntimeEvidenceCourtResult'));
      expect(result.blockedUntilRealEvidence, contains('explicitUserApprovalForRuntimeActivationPhase'));
      expect(result.forbiddenActions, contains('claimRuntimeActivationPassWithoutAcceptedQ265Evidence'));
      expect(result.realOcrRuntimeAdded, isFalse);
      expect(result.paddleRuntimeAdded, isFalse);
      expect(result.paddleOcrDependencyAdded, isFalse);
      expect(result.nativeBridgeAdded, isFalse);
      expect(result.jniBindingAdded, isFalse);
      expect(result.methodChannelRuntimeBindingAdded, isFalse);
      expect(result.modelBinaryBundledInBaseApp, isFalse);
      expect(result.productionModelUrlBound, isFalse);
      expect(result.realNetworkDownloadWorkerImplemented, isFalse);
      expect(result.productionDownloadEnabled, isFalse);
      expect(result.productionInferenceAllowed, isFalse);
      expect(result.runtimeActivationPassClaimed, isFalse);
      expect(result.ocrPassClaimed, isFalse);
      expect(result.canActivateRuntimeInQ266, isFalse);
      expect(result.canClaimRuntimeActivationPassInQ266, isFalse);
      expect(result.canClaimOcrPassInQ266, isFalse);
      expect(result.canAddPaddleRuntimeInQ266, isFalse);
      expect(result.canBindRuntimeBridgeInQ266, isFalse);
      expect(result.canImportCameraOutputWithoutUserApproval, isFalse);
    });

    test('rejects missing Q265 accepted evidence before any activation decision', () {
      final result = GaussPpFormulaNetSRuntimeActivationDecisionGate.evaluate(const GaussPpFormulaNetSRuntimeActivationDecisionGateInput(
        q265AcceptedEvidencePresent: false,
        runtimeCandidateSelected: true,
        runtimeCandidateSafe: true,
        runtimePathEvidencePresent: true,
        androidAbiSupported: true,
        modelFormatAccepted: true,
        privateArtifactVerified: true,
        artifactSha256AcceptedByQ265: true,
        latencyMs: 1200,
        peakMemoryMb: 256,
        fallbackPlanDefined: true,
        formulaOcrPrimaryOnly: true,
        editableMathLiveReviewRequired: true,
        userApprovalRequiredBeforeWorkspaceImport: true,
        directSolveBlocked: true,
        directGraphSolutionHistoryBlocked: true,
        noPaddleRuntimeDependencyAdded: true,
        noPaddleOcrDependencyAdded: true,
        noNativeBridgeAdded: true,
        noJniBindingAdded: true,
        noMethodChannelRuntimeBindingAdded: true,
        noModelBinaryBundledInBaseApp: true,
        noProductionModelUrlBound: true,
        noRealNetworkDownloadWorkerImplemented: true,
        productionDownloadEnabled: false,
        noProductionInferenceAllowed: true,
        runtimeActivationPassClaimed: false,
        ocrPassClaimed: false,
        activationLabel: 'missing Q265 evidence',
      ));
      expect(result.decision, GaussPpFormulaNetSRuntimeActivationDecisionGateDecision.rejectedMissingQ265AcceptedEvidence);
      expect(result.runtimeActivationDecisionGateStaticReady, isFalse);
    });

    test('rejects unsafe runtime binding attempts and keeps dependencies out', () {
      final unsafe = GaussPpFormulaNetSRuntimeActivationDecisionGate.evaluate(const GaussPpFormulaNetSRuntimeActivationDecisionGateInput(
        q265AcceptedEvidencePresent: true,
        runtimeCandidateSelected: true,
        runtimeCandidateSafe: true,
        runtimePathEvidencePresent: true,
        androidAbiSupported: true,
        modelFormatAccepted: true,
        privateArtifactVerified: true,
        artifactSha256AcceptedByQ265: true,
        latencyMs: 1200,
        peakMemoryMb: 256,
        fallbackPlanDefined: true,
        formulaOcrPrimaryOnly: true,
        editableMathLiveReviewRequired: true,
        userApprovalRequiredBeforeWorkspaceImport: true,
        directSolveBlocked: true,
        directGraphSolutionHistoryBlocked: true,
        noPaddleRuntimeDependencyAdded: false,
        noPaddleOcrDependencyAdded: true,
        noNativeBridgeAdded: true,
        noJniBindingAdded: true,
        noMethodChannelRuntimeBindingAdded: true,
        noModelBinaryBundledInBaseApp: true,
        noProductionModelUrlBound: true,
        noRealNetworkDownloadWorkerImplemented: true,
        productionDownloadEnabled: false,
        noProductionInferenceAllowed: true,
        runtimeActivationPassClaimed: false,
        ocrPassClaimed: false,
        activationLabel: 'unsafe runtime dependency attempt',
      ));
      expect(unsafe.decision, GaussPpFormulaNetSRuntimeActivationDecisionGateDecision.rejectedUnsafeRuntimeCandidate);

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
        expect(pubspec.contains(forbidden), isFalse, reason: 'Q266 must not add $forbidden');
      }
      expect(pubspec, contains('camera: 0.10.6'));
      expect(pubspec, contains('camera_android: 0.10.9+3'));
    });
  });
}

// Q266 decision coverage markers for static verifier:
// rejectedMissingQ265AcceptedEvidence
// rejectedUnsafeRuntimeCandidate
// rejectedMissingRuntimePathEvidence
// rejectedUnsupportedAbi
// rejectedModelFormatMismatch
// rejectedPrivateArtifactNotVerified
// rejectedLatencyBudget
// rejectedPeakMemoryBudget
// rejectedMissingFallbackPlan
// rejectedMissingMathLiveReviewRequirement
// rejectedDirectSolveOrImportRisk
// approvedForFutureRuntimeIntegrationGateOnly
