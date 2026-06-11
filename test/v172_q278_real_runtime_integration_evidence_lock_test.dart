import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_real_runtime_integration_evidence_lock.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_real_runtime_integration_evidence_lock_policy.dart';

void main() {
  group('V172-Q278 real runtime integration evidence lock', () {
    const validSha = '0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef';
    const approvedInput = GaussRealRuntimeIntegrationEvidenceLockInput(
      q277r3TapLatencyCadenceBaselinePresent: true,
      userFlutterAnalyzeClean: true,
      userFlutterTestPassed: true,
      realDeviceUiRegressionAccepted: true,
      officialModelRepositoryUrlDocumented: true,
      productionArtifactUrlDocumented: true,
      expectedProductionArtifactSha256: validSha,
      licenseCompatibilityDocumented: true,
      modelSizeMb: 256,
      selectedRuntimePathDocumented: true,
      abiMatrixDocumented: true,
      androidToolchainCompatibilityDocumented: true,
      runtimeLatencyBudgetMs: 1200,
      runtimePeakMemoryBudgetMb: 256,
      privateAppStoragePlanDocumented: true,
      checksumBeforeReadyRequired: true,
      atomicMoveAfterChecksumRequired: true,
      offlineReadyOnlyAfterVerifiedPrivateArtifactRequired: true,
      editableMathLiveReviewRequired: true,
      explicitUserApprovalRequiredBeforeWorkspaceImport: true,
      directSolveGraphSolutionHistoryBlocked: true,
      noPaddleRuntimeDependencyAdded: true,
      noPaddleOcrDependencyAdded: true,
      noNativeBridgeImplementationAdded: true,
      noJniBindingAdded: true,
      noMethodChannelRuntimeBindingAdded: true,
      noModelBinaryBundledInBaseApp: true,
      noProductionModelUrlBound: true,
      noProductionDownloadEnabled: true,
      noRealNetworkDownloadWorkerImplemented: true,
      noImageToLatexInferenceExecuted: true,
      runtimeIntegrationPassClaimed: false,
      ocrPassClaimed: false,
      releasePassClaimed: false,
      evidenceLabel: 'Q278 evidence lock ready for future Q279 dependency trial only',
    );

    test('locks real runtime evidence without adding runtime or claiming OCR pass', () {
      final result = GaussRealRuntimeIntegrationEvidenceLock.evaluate(approvedInput);

      expect(result.decision, GaussRealRuntimeIntegrationEvidenceLockDecision.readyForQ279DependencyTrialOnly);
      expect(result.evidenceStaticReady, isTrue);
      expect(result.readyForQ279DependencyTrialOnly, isTrue);
      expect(result.phase, GaussRealRuntimeIntegrationEvidenceLockPolicy.phase);
      expect(result.sourcePhase, GaussRealRuntimeIntegrationEvidenceLockPolicy.sourcePhase);
      expect(result.selectedEngineLabel, 'PP-FormulaNet-S');
      expect(result.fallbackEngineLabel, 'PP-FormulaNet_plus-L only');
      expect(result.evidenceLockMode, 'real-runtime-integration-evidence-lock-only-no-dependency-no-runtime-no-inference');
      expect(result.requiredEvidenceLocks, contains('officialModelRepositoryEvidence'));
      expect(result.requiredEvidenceLocks, contains('productionArtifactUrlEvidence'));
      expect(result.requiredEvidenceLocks, contains('expectedProductionArtifactSha256Evidence'));
      expect(result.requiredEvidenceLocks, contains('editableMathLiveReviewRequired'));
      expect(result.blockedUntilRealEvidence, contains('officialPPFormulaNetSModelRepositoryUrl'));
      expect(result.blockedUntilRealEvidence, contains('realDeviceQ277R3UiAndTapCadenceAcceptance'));
      expect(result.forbiddenActions, contains('addPaddleRuntimeInQ278'));
      expect(result.forbiddenActions, contains('runImageToLatexInferenceInQ278'));
      expect(result.realOcrRuntimeAdded, isFalse);
      expect(result.paddleRuntimeAdded, isFalse);
      expect(result.paddleOcrDependencyAdded, isFalse);
      expect(result.nativeBridgeImplementationAdded, isFalse);
      expect(result.jniBindingAdded, isFalse);
      expect(result.methodChannelRuntimeBindingAdded, isFalse);
      expect(result.modelBinaryBundledInBaseApp, isFalse);
      expect(result.productionModelUrlBound, isFalse);
      expect(result.productionDownloadEnabled, isFalse);
      expect(result.realNetworkDownloadWorkerImplemented, isFalse);
      expect(result.realImageToLatexInferenceExecuted, isFalse);
      expect(result.runtimeIntegrationPassClaimed, isFalse);
      expect(result.ocrPassClaimed, isFalse);
      expect(result.releasePassClaimed, isFalse);
      expect(result.canAddRuntimeDependencyInQ278, isFalse);
      expect(result.canBindNativeBridgeInQ278, isFalse);
      expect(result.canRunImageToLatexInferenceInQ278, isFalse);
      expect(result.canClaimRuntimeIntegrationPassInQ278, isFalse);
      expect(result.canClaimOcrPassInQ278, isFalse);
      expect(result.canImportCameraOutputWithoutReview, isFalse);
    });

    test('rejects missing source evidence, invalid SHA, unsafe review bypass, and fake pass claims', () {
      expect(
        GaussRealRuntimeIntegrationEvidenceLock.evaluate(const GaussRealRuntimeIntegrationEvidenceLockInput(
          q277r3TapLatencyCadenceBaselinePresent: false,
          userFlutterAnalyzeClean: true,
          userFlutterTestPassed: true,
          realDeviceUiRegressionAccepted: true,
          officialModelRepositoryUrlDocumented: true,
          productionArtifactUrlDocumented: true,
          expectedProductionArtifactSha256: validSha,
          licenseCompatibilityDocumented: true,
          modelSizeMb: 256,
          selectedRuntimePathDocumented: true,
          abiMatrixDocumented: true,
          androidToolchainCompatibilityDocumented: true,
          runtimeLatencyBudgetMs: 1200,
          runtimePeakMemoryBudgetMb: 256,
          privateAppStoragePlanDocumented: true,
          checksumBeforeReadyRequired: true,
          atomicMoveAfterChecksumRequired: true,
          offlineReadyOnlyAfterVerifiedPrivateArtifactRequired: true,
          editableMathLiveReviewRequired: true,
          explicitUserApprovalRequiredBeforeWorkspaceImport: true,
          directSolveGraphSolutionHistoryBlocked: true,
          noPaddleRuntimeDependencyAdded: true,
          noPaddleOcrDependencyAdded: true,
          noNativeBridgeImplementationAdded: true,
          noJniBindingAdded: true,
          noMethodChannelRuntimeBindingAdded: true,
          noModelBinaryBundledInBaseApp: true,
          noProductionModelUrlBound: true,
          noProductionDownloadEnabled: true,
          noRealNetworkDownloadWorkerImplemented: true,
          noImageToLatexInferenceExecuted: true,
          runtimeIntegrationPassClaimed: false,
          ocrPassClaimed: false,
          releasePassClaimed: false,
          evidenceLabel: 'missing Q277R3',
        )).decision,
        GaussRealRuntimeIntegrationEvidenceLockDecision.blockedMissingQ277R3Baseline,
      );

      expect(
        GaussRealRuntimeIntegrationEvidenceLock.evaluate(const GaussRealRuntimeIntegrationEvidenceLockInput(
          q277r3TapLatencyCadenceBaselinePresent: true,
          userFlutterAnalyzeClean: true,
          userFlutterTestPassed: true,
          realDeviceUiRegressionAccepted: true,
          officialModelRepositoryUrlDocumented: false,
          productionArtifactUrlDocumented: true,
          expectedProductionArtifactSha256: validSha,
          licenseCompatibilityDocumented: true,
          modelSizeMb: 256,
          selectedRuntimePathDocumented: true,
          abiMatrixDocumented: true,
          androidToolchainCompatibilityDocumented: true,
          runtimeLatencyBudgetMs: 1200,
          runtimePeakMemoryBudgetMb: 256,
          privateAppStoragePlanDocumented: true,
          checksumBeforeReadyRequired: true,
          atomicMoveAfterChecksumRequired: true,
          offlineReadyOnlyAfterVerifiedPrivateArtifactRequired: true,
          editableMathLiveReviewRequired: true,
          explicitUserApprovalRequiredBeforeWorkspaceImport: true,
          directSolveGraphSolutionHistoryBlocked: true,
          noPaddleRuntimeDependencyAdded: true,
          noPaddleOcrDependencyAdded: true,
          noNativeBridgeImplementationAdded: true,
          noJniBindingAdded: true,
          noMethodChannelRuntimeBindingAdded: true,
          noModelBinaryBundledInBaseApp: true,
          noProductionModelUrlBound: true,
          noProductionDownloadEnabled: true,
          noRealNetworkDownloadWorkerImplemented: true,
          noImageToLatexInferenceExecuted: true,
          runtimeIntegrationPassClaimed: false,
          ocrPassClaimed: false,
          releasePassClaimed: false,
          evidenceLabel: 'missing source',
        )).decision,
        GaussRealRuntimeIntegrationEvidenceLockDecision.blockedMissingOfficialSourceEvidence,
      );

      expect(
        GaussRealRuntimeIntegrationEvidenceLock.evaluate(const GaussRealRuntimeIntegrationEvidenceLockInput(
          q277r3TapLatencyCadenceBaselinePresent: true,
          userFlutterAnalyzeClean: true,
          userFlutterTestPassed: true,
          realDeviceUiRegressionAccepted: true,
          officialModelRepositoryUrlDocumented: true,
          productionArtifactUrlDocumented: true,
          expectedProductionArtifactSha256: 'not-a-sha',
          licenseCompatibilityDocumented: true,
          modelSizeMb: 256,
          selectedRuntimePathDocumented: true,
          abiMatrixDocumented: true,
          androidToolchainCompatibilityDocumented: true,
          runtimeLatencyBudgetMs: 1200,
          runtimePeakMemoryBudgetMb: 256,
          privateAppStoragePlanDocumented: true,
          checksumBeforeReadyRequired: true,
          atomicMoveAfterChecksumRequired: true,
          offlineReadyOnlyAfterVerifiedPrivateArtifactRequired: true,
          editableMathLiveReviewRequired: true,
          explicitUserApprovalRequiredBeforeWorkspaceImport: true,
          directSolveGraphSolutionHistoryBlocked: true,
          noPaddleRuntimeDependencyAdded: true,
          noPaddleOcrDependencyAdded: true,
          noNativeBridgeImplementationAdded: true,
          noJniBindingAdded: true,
          noMethodChannelRuntimeBindingAdded: true,
          noModelBinaryBundledInBaseApp: true,
          noProductionModelUrlBound: true,
          noProductionDownloadEnabled: true,
          noRealNetworkDownloadWorkerImplemented: true,
          noImageToLatexInferenceExecuted: true,
          runtimeIntegrationPassClaimed: false,
          ocrPassClaimed: false,
          releasePassClaimed: false,
          evidenceLabel: 'bad sha',
        )).decision,
        GaussRealRuntimeIntegrationEvidenceLockDecision.blockedMissingArtifactUrlOrSha,
      );

      expect(
        GaussRealRuntimeIntegrationEvidenceLock.evaluate(const GaussRealRuntimeIntegrationEvidenceLockInput(
          q277r3TapLatencyCadenceBaselinePresent: true,
          userFlutterAnalyzeClean: true,
          userFlutterTestPassed: true,
          realDeviceUiRegressionAccepted: true,
          officialModelRepositoryUrlDocumented: true,
          productionArtifactUrlDocumented: true,
          expectedProductionArtifactSha256: validSha,
          licenseCompatibilityDocumented: true,
          modelSizeMb: 256,
          selectedRuntimePathDocumented: true,
          abiMatrixDocumented: true,
          androidToolchainCompatibilityDocumented: true,
          runtimeLatencyBudgetMs: 1200,
          runtimePeakMemoryBudgetMb: 256,
          privateAppStoragePlanDocumented: true,
          checksumBeforeReadyRequired: true,
          atomicMoveAfterChecksumRequired: true,
          offlineReadyOnlyAfterVerifiedPrivateArtifactRequired: true,
          editableMathLiveReviewRequired: false,
          explicitUserApprovalRequiredBeforeWorkspaceImport: true,
          directSolveGraphSolutionHistoryBlocked: true,
          noPaddleRuntimeDependencyAdded: true,
          noPaddleOcrDependencyAdded: true,
          noNativeBridgeImplementationAdded: true,
          noJniBindingAdded: true,
          noMethodChannelRuntimeBindingAdded: true,
          noModelBinaryBundledInBaseApp: true,
          noProductionModelUrlBound: true,
          noProductionDownloadEnabled: true,
          noRealNetworkDownloadWorkerImplemented: true,
          noImageToLatexInferenceExecuted: true,
          runtimeIntegrationPassClaimed: false,
          ocrPassClaimed: false,
          releasePassClaimed: false,
          evidenceLabel: 'review bypass',
        )).decision,
        GaussRealRuntimeIntegrationEvidenceLockDecision.blockedMissingReviewApprovalBoundary,
      );

      expect(
        GaussRealRuntimeIntegrationEvidenceLock.evaluate(const GaussRealRuntimeIntegrationEvidenceLockInput(
          q277r3TapLatencyCadenceBaselinePresent: true,
          userFlutterAnalyzeClean: true,
          userFlutterTestPassed: true,
          realDeviceUiRegressionAccepted: true,
          officialModelRepositoryUrlDocumented: true,
          productionArtifactUrlDocumented: true,
          expectedProductionArtifactSha256: validSha,
          licenseCompatibilityDocumented: true,
          modelSizeMb: 256,
          selectedRuntimePathDocumented: true,
          abiMatrixDocumented: true,
          androidToolchainCompatibilityDocumented: true,
          runtimeLatencyBudgetMs: 1200,
          runtimePeakMemoryBudgetMb: 256,
          privateAppStoragePlanDocumented: true,
          checksumBeforeReadyRequired: true,
          atomicMoveAfterChecksumRequired: true,
          offlineReadyOnlyAfterVerifiedPrivateArtifactRequired: true,
          editableMathLiveReviewRequired: true,
          explicitUserApprovalRequiredBeforeWorkspaceImport: true,
          directSolveGraphSolutionHistoryBlocked: true,
          noPaddleRuntimeDependencyAdded: true,
          noPaddleOcrDependencyAdded: true,
          noNativeBridgeImplementationAdded: true,
          noJniBindingAdded: true,
          noMethodChannelRuntimeBindingAdded: true,
          noModelBinaryBundledInBaseApp: true,
          noProductionModelUrlBound: true,
          noProductionDownloadEnabled: true,
          noRealNetworkDownloadWorkerImplemented: true,
          noImageToLatexInferenceExecuted: true,
          runtimeIntegrationPassClaimed: true,
          ocrPassClaimed: false,
          releasePassClaimed: false,
          evidenceLabel: 'fake runtime pass',
        )).decision,
        GaussRealRuntimeIntegrationEvidenceLockDecision.blockedUnsafeRuntimeMutationOrPassClaim,
      );
    });

    test('package metadata records Q278 without model/runtime artifacts', () {
      final manifest = File('assets/mathlive/manifest.json').readAsStringSync();
      final readme = File('README.md').readAsStringSync();
      final audit = File('docs/audit/V172_Q278_REAL_RUNTIME_INTEGRATION_EVIDENCE_LOCK_AUDIT.md').readAsStringSync();
      final changed = File('docs/audit/V172_Q278_CHANGED_FILES.md').readAsStringSync();
      final pubspec = File('pubspec.yaml').readAsStringSync().toLowerCase();

      expect(manifest, contains('V172-Q278-REAL-RUNTIME-INTEGRATION-EVIDENCE-LOCK'));
      expect(manifest, contains('real-runtime-integration-evidence-lock-only-no-dependency-no-runtime-no-inference'));
      expect(readme, contains('V172-Q278'));
      expect(audit, contains('no Paddle runtime'));
      expect(changed, contains('gauss_real_runtime_integration_evidence_lock.dart'));
      expect(pubspec, isNot(contains('paddleocr')));
      expect(pubspec, isNot(contains('onnxruntime')));
      expect(pubspec, isNot(contains('flutter_downloader')));
    });
  });
}
