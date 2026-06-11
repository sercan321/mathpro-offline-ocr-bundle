import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_pp_formulanet_s_isolated_runtime_implementation_gate.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_pp_formulanet_s_isolated_runtime_implementation_gate_policy.dart';

void main() {
  group('V172-Q268-PP-FORMULANET-S-ISOLATED-RUNTIME-IMPLEMENTATION-GATE', () {
    const approvedInput = GaussPpFormulaNetSIsolatedRuntimeImplementationGateInput(
      q267RuntimeIntegrationPreflightPackagePresent: true,
      q267StillNoRuntimeNoInference: true,
      runtimePathCandidateDocumented: true,
      allowedAbiMatrixDocumented: true,
      modelFormatCandidateDocumented: true,
      bridgeProtocolCandidateDocumented: true,
      featureFlagDefaultOffDocumented: true,
      noDefaultRuntimeEnablement: true,
      privateVerifiedArtifactPlanDocumented: true,
      productionDownloadStillDisabledUntilUrlSha: true,
      timeoutCancellationPolicyDocumented: true,
      memoryPressurePolicyDocumented: true,
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
      runtimeImplementationPassClaimed: false,
      ocrPassClaimed: false,
      isolationLabel: 'Q268 ready for future isolated runtime implementation only',
    );

    test('gates future isolated runtime implementation without adding runtime in Q268', () {
      final result = GaussPpFormulaNetSIsolatedRuntimeImplementationGate.evaluate(approvedInput);

      expect(result.decision, GaussPpFormulaNetSIsolatedRuntimeImplementationGateDecision.readyForFutureIsolatedRuntimeImplementationOnly);
      expect(result.isolatedRuntimeImplementationGateStaticReady, isTrue);
      expect(result.readyForFutureIsolatedRuntimeImplementationOnly, isTrue);
      expect(result.phase, GaussPpFormulaNetSIsolatedRuntimeImplementationGatePolicy.phase);
      expect(result.sourcePhase, GaussPpFormulaNetSIsolatedRuntimeImplementationGatePolicy.sourcePhase);
      expect(result.selectedEngineLabel, 'PP-FormulaNet-S');
      expect(result.fallbackEngineLabel, 'PP-FormulaNet_plus-L');
      expect(result.isolatedRuntimeGateMode, 'isolated-runtime-implementation-gate-only-no-runtime-no-inference');
      expect(result.requiredIsolationGates, contains('q267RuntimeIntegrationPreflightPackagePresent'));
      expect(result.requiredIsolationGates, contains('featureFlagDefaultOffDocumented'));
      expect(result.requiredIsolationGates, contains('timeoutCancellationPolicyDocumented'));
      expect(result.requiredIsolationGates, contains('memoryPressurePolicyDocumented'));
      expect(result.requiredIsolationGates, contains('editableMathLiveReviewRequired'));
      expect(result.requiredIsolationGates, contains('directSolveBlocked'));
      expect(result.blockedUntilRealEvidence, contains('acceptedQ267RuntimeIntegrationPreflight'));
      expect(result.blockedUntilRealEvidence, contains('explicitUserApprovalForIsolatedRuntimeImplementationPhase'));
      expect(result.runtimeIsolationStrategies, contains('runtimeBehindDisabledFeatureFlag'));
      expect(result.runtimeIsolationStrategies, contains('noProductionWorkspaceMutationBoundary'));
      expect(result.runtimePathCandidates, contains('paddleNativeRuntimeCandidate'));
      expect(result.runtimePathCandidates, contains('paddleLiteCandidate'));
      expect(result.runtimePathCandidates, contains('isolatedNativeBridgeCandidate'));
      expect(result.runtimePathCandidates, contains('rejectedCloudOcrCandidate'));
      expect(result.forbiddenActions, contains('addPaddleRuntimeInQ268'));
      expect(result.forbiddenActions, contains('enableRuntimeByDefaultInQ268'));
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
      expect(result.runtimeDefaultEnabled, isFalse);
      expect(result.runtimeFeatureFlagDefaultOff, isTrue);
      expect(result.runtimeImplementationPassClaimed, isFalse);
      expect(result.ocrPassClaimed, isFalse);
      expect(result.canImplementRuntimeInQ268, isFalse);
      expect(result.canClaimRuntimeImplementationPassInQ268, isFalse);
      expect(result.canClaimOcrPassInQ268, isFalse);
      expect(result.canAddPaddleRuntimeInQ268, isFalse);
      expect(result.canBindNativeBridgeInQ268, isFalse);
      expect(result.canEnableRuntimeByDefaultInQ268, isFalse);
      expect(result.canImportCameraOutputWithoutUserApproval, isFalse);
    });

    test('rejects missing Q267 preflight, missing isolation, and direct solve risk', () {
      final missingQ267 = GaussPpFormulaNetSIsolatedRuntimeImplementationGate.evaluate(const GaussPpFormulaNetSIsolatedRuntimeImplementationGateInput(
        q267RuntimeIntegrationPreflightPackagePresent: false,
        q267StillNoRuntimeNoInference: true,
        runtimePathCandidateDocumented: true,
        allowedAbiMatrixDocumented: true,
        modelFormatCandidateDocumented: true,
        bridgeProtocolCandidateDocumented: true,
        featureFlagDefaultOffDocumented: true,
        noDefaultRuntimeEnablement: true,
        privateVerifiedArtifactPlanDocumented: true,
        productionDownloadStillDisabledUntilUrlSha: true,
        timeoutCancellationPolicyDocumented: true,
        memoryPressurePolicyDocumented: true,
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
        runtimeImplementationPassClaimed: false,
        ocrPassClaimed: false,
        isolationLabel: 'missing q267 preflight',
      ));
      expect(missingQ267.decision, GaussPpFormulaNetSIsolatedRuntimeImplementationGateDecision.blockedMissingQ267PreflightPackage);

      final defaultOnRisk = GaussPpFormulaNetSIsolatedRuntimeImplementationGate.evaluate(approvedInput.copyWith(featureFlagDefaultOffDocumented: false));
      expect(defaultOnRisk.decision, GaussPpFormulaNetSIsolatedRuntimeImplementationGateDecision.blockedMissingFeatureFlagIsolation);

      final directSolveRisk = GaussPpFormulaNetSIsolatedRuntimeImplementationGate.evaluate(approvedInput.copyWith(directSolveBlocked: false));
      expect(directSolveRisk.decision, GaussPpFormulaNetSIsolatedRuntimeImplementationGateDecision.blockedDirectSolveOrImportRisk);
    });

    test('rejects unsafe runtime dependencies and preserves dependency manifest', () {
      final unsafe = GaussPpFormulaNetSIsolatedRuntimeImplementationGate.evaluate(approvedInput.copyWith(noPaddleRuntimeDependencyAdded: false));
      expect(unsafe.decision, GaussPpFormulaNetSIsolatedRuntimeImplementationGateDecision.blockedUnsafeRuntimeDependencyAttempt);

      final pubspec = File('pubspec.yaml').readAsStringSync();
      expect(pubspec, contains('camera: 0.10.6'));
      expect(pubspec, contains('camera_android: 0.10.9+3'));
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
        expect(pubspec.contains(forbidden), isFalse, reason: 'Q268 must not add $forbidden');
      }
    });
  });
}

extension _Q268Copy on GaussPpFormulaNetSIsolatedRuntimeImplementationGateInput {
  GaussPpFormulaNetSIsolatedRuntimeImplementationGateInput copyWith({
    bool? q267RuntimeIntegrationPreflightPackagePresent,
    bool? q267StillNoRuntimeNoInference,
    bool? runtimePathCandidateDocumented,
    bool? allowedAbiMatrixDocumented,
    bool? modelFormatCandidateDocumented,
    bool? bridgeProtocolCandidateDocumented,
    bool? featureFlagDefaultOffDocumented,
    bool? noDefaultRuntimeEnablement,
    bool? privateVerifiedArtifactPlanDocumented,
    bool? productionDownloadStillDisabledUntilUrlSha,
    bool? timeoutCancellationPolicyDocumented,
    bool? memoryPressurePolicyDocumented,
    int? latencyBudgetMs,
    int? peakMemoryBudgetMb,
    bool? fallbackPlanDocumented,
    bool? formulaOcrPrimaryOnly,
    bool? editableMathLiveReviewRequired,
    bool? userApprovalRequiredBeforeWorkspaceImport,
    bool? directSolveBlocked,
    bool? directGraphSolutionHistoryBlocked,
    bool? noPaddleRuntimeDependencyAdded,
    bool? noPaddleOcrDependencyAdded,
    bool? noNativeBridgeAdded,
    bool? noJniBindingAdded,
    bool? noMethodChannelRuntimeBindingAdded,
    bool? noModelBinaryBundledInBaseApp,
    bool? noProductionModelUrlBound,
    bool? noRealNetworkDownloadWorkerImplemented,
    bool? productionDownloadEnabled,
    bool? noProductionInferenceAllowed,
    bool? runtimeImplementationPassClaimed,
    bool? ocrPassClaimed,
    String? isolationLabel,
  }) {
    return GaussPpFormulaNetSIsolatedRuntimeImplementationGateInput(
      q267RuntimeIntegrationPreflightPackagePresent: q267RuntimeIntegrationPreflightPackagePresent ?? this.q267RuntimeIntegrationPreflightPackagePresent,
      q267StillNoRuntimeNoInference: q267StillNoRuntimeNoInference ?? this.q267StillNoRuntimeNoInference,
      runtimePathCandidateDocumented: runtimePathCandidateDocumented ?? this.runtimePathCandidateDocumented,
      allowedAbiMatrixDocumented: allowedAbiMatrixDocumented ?? this.allowedAbiMatrixDocumented,
      modelFormatCandidateDocumented: modelFormatCandidateDocumented ?? this.modelFormatCandidateDocumented,
      bridgeProtocolCandidateDocumented: bridgeProtocolCandidateDocumented ?? this.bridgeProtocolCandidateDocumented,
      featureFlagDefaultOffDocumented: featureFlagDefaultOffDocumented ?? this.featureFlagDefaultOffDocumented,
      noDefaultRuntimeEnablement: noDefaultRuntimeEnablement ?? this.noDefaultRuntimeEnablement,
      privateVerifiedArtifactPlanDocumented: privateVerifiedArtifactPlanDocumented ?? this.privateVerifiedArtifactPlanDocumented,
      productionDownloadStillDisabledUntilUrlSha: productionDownloadStillDisabledUntilUrlSha ?? this.productionDownloadStillDisabledUntilUrlSha,
      timeoutCancellationPolicyDocumented: timeoutCancellationPolicyDocumented ?? this.timeoutCancellationPolicyDocumented,
      memoryPressurePolicyDocumented: memoryPressurePolicyDocumented ?? this.memoryPressurePolicyDocumented,
      latencyBudgetMs: latencyBudgetMs ?? this.latencyBudgetMs,
      peakMemoryBudgetMb: peakMemoryBudgetMb ?? this.peakMemoryBudgetMb,
      fallbackPlanDocumented: fallbackPlanDocumented ?? this.fallbackPlanDocumented,
      formulaOcrPrimaryOnly: formulaOcrPrimaryOnly ?? this.formulaOcrPrimaryOnly,
      editableMathLiveReviewRequired: editableMathLiveReviewRequired ?? this.editableMathLiveReviewRequired,
      userApprovalRequiredBeforeWorkspaceImport: userApprovalRequiredBeforeWorkspaceImport ?? this.userApprovalRequiredBeforeWorkspaceImport,
      directSolveBlocked: directSolveBlocked ?? this.directSolveBlocked,
      directGraphSolutionHistoryBlocked: directGraphSolutionHistoryBlocked ?? this.directGraphSolutionHistoryBlocked,
      noPaddleRuntimeDependencyAdded: noPaddleRuntimeDependencyAdded ?? this.noPaddleRuntimeDependencyAdded,
      noPaddleOcrDependencyAdded: noPaddleOcrDependencyAdded ?? this.noPaddleOcrDependencyAdded,
      noNativeBridgeAdded: noNativeBridgeAdded ?? this.noNativeBridgeAdded,
      noJniBindingAdded: noJniBindingAdded ?? this.noJniBindingAdded,
      noMethodChannelRuntimeBindingAdded: noMethodChannelRuntimeBindingAdded ?? this.noMethodChannelRuntimeBindingAdded,
      noModelBinaryBundledInBaseApp: noModelBinaryBundledInBaseApp ?? this.noModelBinaryBundledInBaseApp,
      noProductionModelUrlBound: noProductionModelUrlBound ?? this.noProductionModelUrlBound,
      noRealNetworkDownloadWorkerImplemented: noRealNetworkDownloadWorkerImplemented ?? this.noRealNetworkDownloadWorkerImplemented,
      productionDownloadEnabled: productionDownloadEnabled ?? this.productionDownloadEnabled,
      noProductionInferenceAllowed: noProductionInferenceAllowed ?? this.noProductionInferenceAllowed,
      runtimeImplementationPassClaimed: runtimeImplementationPassClaimed ?? this.runtimeImplementationPassClaimed,
      ocrPassClaimed: ocrPassClaimed ?? this.ocrPassClaimed,
      isolationLabel: isolationLabel ?? this.isolationLabel,
    );
  }
}
