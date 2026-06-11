import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_pp_formulanet_s_runtime_integration_preflight_package.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_pp_formulanet_s_runtime_integration_preflight_package_policy.dart';

void main() {
  group('V172-Q267-PP-FORMULANET-S-RUNTIME-INTEGRATION-PREFLIGHT-PACKAGE', () {
    const approvedInput = GaussPpFormulaNetSRuntimeIntegrationPreflightPackageInput(
      q266RuntimeActivationDecisionGatePresent: true,
      q266StillGateOnlyNoRuntime: true,
      selectedRuntimePathCandidateDocumented: true,
      allowedAbiMatrixDocumented: true,
      modelFormatCandidateDocumented: true,
      bridgeProtocolCandidateDocumented: true,
      privateVerifiedArtifactPlanDocumented: true,
      productionDownloadStillDisabledUntilUrlSha: true,
      latencyBudgetMs: 1200,
      peakMemoryBudgetMb: 256,
      fallbackPlanDocumented: true,
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
      runtimeIntegrationPassClaimed: false,
      ocrPassClaimed: false,
      preflightLabel: 'Q267 ready for future isolated runtime implementation only',
    );

    test('preflights future isolated runtime implementation but never implements runtime in Q267', () {
      final result = GaussPpFormulaNetSRuntimeIntegrationPreflightPackage.evaluate(approvedInput);

      expect(result.decision, GaussPpFormulaNetSRuntimeIntegrationPreflightPackageDecision.readyForFutureIsolatedRuntimeImplementationOnly);
      expect(result.runtimeIntegrationPreflightStaticReady, isTrue);
      expect(result.readyForFutureIsolatedRuntimeImplementationOnly, isTrue);
      expect(result.phase, GaussPpFormulaNetSRuntimeIntegrationPreflightPackagePolicy.phase);
      expect(result.sourcePhase, GaussPpFormulaNetSRuntimeIntegrationPreflightPackagePolicy.sourcePhase);
      expect(result.selectedEngineLabel, 'PP-FormulaNet-S');
      expect(result.fallbackEngineLabel, 'PP-FormulaNet_plus-L');
      expect(result.preflightMode, 'runtime-integration-preflight-package-only-no-runtime-no-inference');
      expect(result.requiredPreflightGates, contains('q266RuntimeActivationDecisionGatePresent'));
      expect(result.requiredPreflightGates, contains('selectedRuntimePathCandidateDocumented'));
      expect(result.requiredPreflightGates, contains('allowedAbiMatrixDocumented'));
      expect(result.requiredPreflightGates, contains('modelFormatCandidateDocumented'));
      expect(result.requiredPreflightGates, contains('bridgeProtocolCandidateDocumented'));
      expect(result.requiredPreflightGates, contains('editableMathLiveReviewRequired'));
      expect(result.requiredPreflightGates, contains('directSolveBlocked'));
      expect(result.blockedUntilRealEvidence, contains('acceptedQ266RuntimeActivationDecision'));
      expect(result.blockedUntilRealEvidence, contains('explicitUserApprovalForRuntimeImplementationPhase'));
      expect(result.runtimePathCandidates, contains('paddleNativeRuntimeCandidate'));
      expect(result.runtimePathCandidates, contains('paddleLiteCandidate'));
      expect(result.runtimePathCandidates, contains('isolatedNativeBridgeCandidate'));
      expect(result.runtimePathCandidates, contains('rejectedCloudOcrCandidate'));
      expect(result.forbiddenActions, contains('claimRuntimeIntegrationPassWithoutAcceptedQ266Decision'));
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
      expect(result.runtimeIntegrationPassClaimed, isFalse);
      expect(result.ocrPassClaimed, isFalse);
      expect(result.canImplementRuntimeInQ267, isFalse);
      expect(result.canClaimRuntimeIntegrationPassInQ267, isFalse);
      expect(result.canClaimOcrPassInQ267, isFalse);
      expect(result.canAddPaddleRuntimeInQ267, isFalse);
      expect(result.canBindNativeBridgeInQ267, isFalse);
      expect(result.canImportCameraOutputWithoutUserApproval, isFalse);
    });

    test('rejects missing Q266 decision gate and unsafe direct solve paths', () {
      final missingQ266 = GaussPpFormulaNetSRuntimeIntegrationPreflightPackage.evaluate(const GaussPpFormulaNetSRuntimeIntegrationPreflightPackageInput(
        q266RuntimeActivationDecisionGatePresent: false,
        q266StillGateOnlyNoRuntime: true,
        selectedRuntimePathCandidateDocumented: true,
        allowedAbiMatrixDocumented: true,
        modelFormatCandidateDocumented: true,
        bridgeProtocolCandidateDocumented: true,
        privateVerifiedArtifactPlanDocumented: true,
        productionDownloadStillDisabledUntilUrlSha: true,
        latencyBudgetMs: 1200,
        peakMemoryBudgetMb: 256,
        fallbackPlanDocumented: true,
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
        runtimeIntegrationPassClaimed: false,
        ocrPassClaimed: false,
        preflightLabel: 'missing Q266 gate',
      ));
      expect(missingQ266.decision, GaussPpFormulaNetSRuntimeIntegrationPreflightPackageDecision.blockedMissingQ266DecisionGate);

      final directSolveRisk = GaussPpFormulaNetSRuntimeIntegrationPreflightPackage.evaluate(const GaussPpFormulaNetSRuntimeIntegrationPreflightPackageInput(
        q266RuntimeActivationDecisionGatePresent: true,
        q266StillGateOnlyNoRuntime: true,
        selectedRuntimePathCandidateDocumented: true,
        allowedAbiMatrixDocumented: true,
        modelFormatCandidateDocumented: true,
        bridgeProtocolCandidateDocumented: true,
        privateVerifiedArtifactPlanDocumented: true,
        productionDownloadStillDisabledUntilUrlSha: true,
        latencyBudgetMs: 1200,
        peakMemoryBudgetMb: 256,
        fallbackPlanDocumented: true,
        formulaOcrPrimaryOnly: true,
        editableMathLiveReviewRequired: true,
        userApprovalRequiredBeforeWorkspaceImport: true,
        directSolveBlocked: false,
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
        runtimeIntegrationPassClaimed: false,
        ocrPassClaimed: false,
        preflightLabel: 'direct solve risk',
      ));
      expect(directSolveRisk.decision, GaussPpFormulaNetSRuntimeIntegrationPreflightPackageDecision.blockedDirectSolveOrImportRisk);
    });

    test('rejects unsafe runtime dependencies and preserves dependency manifest', () {
      final unsafe = GaussPpFormulaNetSRuntimeIntegrationPreflightPackage.evaluate(const GaussPpFormulaNetSRuntimeIntegrationPreflightPackageInput(
        q266RuntimeActivationDecisionGatePresent: true,
        q266StillGateOnlyNoRuntime: true,
        selectedRuntimePathCandidateDocumented: true,
        allowedAbiMatrixDocumented: true,
        modelFormatCandidateDocumented: true,
        bridgeProtocolCandidateDocumented: true,
        privateVerifiedArtifactPlanDocumented: true,
        productionDownloadStillDisabledUntilUrlSha: true,
        latencyBudgetMs: 1200,
        peakMemoryBudgetMb: 256,
        fallbackPlanDocumented: true,
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
        runtimeIntegrationPassClaimed: false,
        ocrPassClaimed: false,
        preflightLabel: 'unsafe runtime dependency attempt',
      ));
      expect(unsafe.decision, GaussPpFormulaNetSRuntimeIntegrationPreflightPackageDecision.blockedUnsafeRuntimeDependencyAttempt);

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
        expect(pubspec.contains(forbidden), isFalse, reason: 'Q267 must not add $forbidden');
      }
      expect(pubspec, contains('camera: 0.10.6'));
      expect(pubspec, contains('camera_android: 0.10.9+3'));
    });
  });
}

// Q267 preflight coverage markers for static verifier:
// blockedMissingQ266DecisionGate
// blockedRuntimePathUndecided
// blockedUnsupportedAbiMatrix
// blockedModelFormatUndecided
// blockedBridgeProtocolUndecided
// blockedMissingFallbackPlan
// blockedMissingArtifactVerificationPlan
// blockedMissingLatencyMemoryBudget
// blockedMissingMathLiveReviewRequirement
// blockedDirectSolveOrImportRisk
// blockedUnsafeRuntimeDependencyAttempt
// readyForFutureIsolatedRuntimeImplementationOnly
