import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_sha_verification_atomic_move_real_runtime_gate.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_sha_verification_atomic_move_real_runtime_gate_policy.dart';

void main() {
  group('V172-Q306 SHA Verification + Atomic Move Real Runtime Gate', () {
    test('defines default-off SHA verification and atomic move gate without accepting an artifact', () {
      final result = GaussShaVerificationAtomicMoveRealRuntimeGate.evaluate(
        GaussShaVerificationAtomicMoveRealRuntimeGateInput.q306Default(),
      );

      expect(result.phase, GaussShaVerificationAtomicMoveRealRuntimeGatePolicy.phase);
      expect(result.sourcePhase, GaussShaVerificationAtomicMoveRealRuntimeGatePolicy.sourcePhase);
      expect(result.selectedEngineLabel, 'PP-FormulaNet-S');
      expect(result.verificationFeatureFlag, 'gauss.ppFormulaNetS.shaVerificationAtomicMove.defaultOff');
      expect(result.verificationMode, 'sha-verification-atomic-move-gate-default-off-no-file-move');
      expect(result.decision, GaussShaVerificationAtomicMoveRealRuntimeGateDecision.shaVerificationAtomicMoveGateDefinedDefaultOff);
      expect(result.contractStaticReady, isTrue);
      expect(result.rejectionReasons, contains('q302-q305-download-sha-evidence-not-complete-for-q306'));
      expect(result.requiredBeforeArtifactReady, contains('q302-expected-actual-sha256-match'));
      expect(result.requiredBeforeArtifactReady, contains('atomic-move-after-checksum-pass'));
      expect(result.verificationEnvelopeFields, contains('actualSha256'));
      expect(result.verificationEnvelopeFields, contains('verifiedPrivatePath'));
      expect(result.atomicMoveStates, contains('checksumVerified'));
      expect(result.atomicMoveStates, contains('atomicMoveSucceeded'));
      expect(result.errorCodes, contains('checksumMismatch'));
      expect(result.errorCodes, contains('atomicMoveAttemptedBeforeChecksumPass'));
      expect(result.protectedSurfaceMarkers, contains('mathlive-production-route-preserved'));
      expect(result.forbiddenActions, contains('computeRealArtifactShaInsideQ306Package'));
      expect(result.forbiddenActions, contains('performAtomicMoveInsideQ306Package'));
      expect(result.shaVerificationAtomicMoveGateDefined, isTrue);
      expect(result.shaVerificationAtomicMoveDefaultOff, isTrue);
      expect(result.q305DownloadWorkerGatePresent, isTrue);
      expect(result.q302ExpectedSha256Locked, isFalse);
      expect(result.q302ActualSha256Computed, isFalse);
      expect(result.q302ExpectedActualSha256Match, isFalse);
      expect(result.temporaryPrivatePathReviewed, isTrue);
      expect(result.verifiedPrivatePathReviewed, isTrue);
      expect(result.checksumBeforeReadyPolicyReviewed, isTrue);
      expect(result.atomicMoveAfterChecksumPolicyReviewed, isTrue);
      expect(result.partialCorruptCleanupPolicyReviewed, isTrue);
      expect(result.pubspecChanged, isFalse);
      expect(result.androidManifestChanged, isFalse);
      expect(result.mainActivityChanged, isFalse);
      expect(result.productionDownloadEnabled, isFalse);
      expect(result.realModelDownloadExecuted, isFalse);
      expect(result.actualSha256ComputedInPackage, isFalse);
      expect(result.shaVerificationExecutedInPackage, isFalse);
      expect(result.atomicMoveExecutedInPackage, isFalse);
      expect(result.artifactAcceptedForRuntime, isFalse);
      expect(result.realRuntimeStartupExecuted, isFalse);
      expect(result.realImageToLatexInferenceExecuted, isFalse);
      expect(result.reviewBeforeImportRequired, isTrue);
      expect(result.explicitUserApprovalRequired, isTrue);
      expect(result.directWorkspaceImportBlocked, isTrue);
      expect(result.directSolveGraphSolutionHistoryBlocked, isTrue);
      expect(result.shaVerificationPassClaimed, isFalse);
      expect(result.atomicMovePassClaimed, isFalse);
      expect(result.modelReadyPassClaimed, isFalse);
      expect(result.ocrPassClaimed, isFalse);
      expect(result.cameraOcrRuntimePassClaimed, isFalse);
      expect(result.releasePassClaimed, isFalse);
    });

    test('blocks complete SHA evidence acceptance inside the static Q306 package', () {
      final result = GaussShaVerificationAtomicMoveRealRuntimeGate.evaluate(
        const GaussShaVerificationAtomicMoveRealRuntimeGateInput(
          q305DownloadWorkerGatePresent: true,
          q302ExpectedSha256Locked: true,
          q302ActualSha256Computed: true,
          q302ExpectedActualSha256Match: true,
          temporaryPrivatePathReviewed: true,
          verifiedPrivatePathReviewed: true,
          checksumBeforeReadyPolicyReviewed: true,
          atomicMoveAfterChecksumPolicyReviewed: true,
          partialCorruptCleanupPolicyReviewed: true,
          rollbackPlanPresent: true,
          defaultOffFeatureFlagPresent: true,
          keyboardLayoutProtected: true,
          moreTemplateTrayProtected: true,
          longPressListsProtected: true,
          mathLiveProductionRouteProtected: true,
          mathLiveBridgeProtected: true,
          graphSolutionHistoryProtected: true,
          appShellWorkspaceProtected: true,
          androidManifestMainActivityProtected: true,
          cameraShellRuntimeProtected: true,
          splashIconProtected: true,
          pubspecChanged: false,
          androidManifestChanged: false,
          mainActivityChanged: false,
          productionDownloadEnabled: false,
          modelBinaryBundledInBaseApp: false,
          realModelDownloadExecuted: false,
          actualSha256ComputedInPackage: false,
          shaVerificationExecutedInPackage: false,
          atomicMoveExecutedInPackage: false,
          artifactAcceptedForRuntime: false,
          realPrivateArtifactLoaded: false,
          realRuntimeStartupExecuted: false,
          realDummyInputRuntimeCallExecuted: false,
          realImageToLatexInferenceExecuted: false,
          realEditableMathLiveReviewOpened: false,
          realWorkspaceImportExecuted: false,
          shaVerificationPassClaimed: false,
          atomicMovePassClaimed: false,
          modelReadyPassClaimed: false,
          runtimeIntegrationPassClaimed: false,
          ocrPassClaimed: false,
          cameraOcrRuntimePassClaimed: false,
          storeReadyPassClaimed: false,
          releasePassClaimed: false,
          trialLabel: 'premature-complete-sha-evidence',
        ),
      );

      expect(result.contractStaticReady, isFalse);
      expect(result.decision, GaussShaVerificationAtomicMoveRealRuntimeGateDecision.blockedMissingQ302ShaOrQ305DownloadEvidence);
      expect(result.rejectionReasons, contains('q306-must-not-accept-complete-sha-evidence-inside-static-package'));
    });

    test('blocks file move/runtime mutations and fake PASS claims', () {
      final result = GaussShaVerificationAtomicMoveRealRuntimeGate.evaluate(
        const GaussShaVerificationAtomicMoveRealRuntimeGateInput(
          q305DownloadWorkerGatePresent: true,
          q302ExpectedSha256Locked: false,
          q302ActualSha256Computed: false,
          q302ExpectedActualSha256Match: false,
          temporaryPrivatePathReviewed: true,
          verifiedPrivatePathReviewed: true,
          checksumBeforeReadyPolicyReviewed: true,
          atomicMoveAfterChecksumPolicyReviewed: true,
          partialCorruptCleanupPolicyReviewed: true,
          rollbackPlanPresent: true,
          defaultOffFeatureFlagPresent: true,
          keyboardLayoutProtected: true,
          moreTemplateTrayProtected: true,
          longPressListsProtected: true,
          mathLiveProductionRouteProtected: true,
          mathLiveBridgeProtected: true,
          graphSolutionHistoryProtected: true,
          appShellWorkspaceProtected: true,
          androidManifestMainActivityProtected: true,
          cameraShellRuntimeProtected: true,
          splashIconProtected: true,
          pubspecChanged: true,
          androidManifestChanged: true,
          mainActivityChanged: true,
          productionDownloadEnabled: true,
          modelBinaryBundledInBaseApp: true,
          realModelDownloadExecuted: true,
          actualSha256ComputedInPackage: true,
          shaVerificationExecutedInPackage: true,
          atomicMoveExecutedInPackage: true,
          artifactAcceptedForRuntime: true,
          realPrivateArtifactLoaded: true,
          realRuntimeStartupExecuted: true,
          realDummyInputRuntimeCallExecuted: true,
          realImageToLatexInferenceExecuted: true,
          realEditableMathLiveReviewOpened: true,
          realWorkspaceImportExecuted: true,
          shaVerificationPassClaimed: true,
          atomicMovePassClaimed: true,
          modelReadyPassClaimed: true,
          runtimeIntegrationPassClaimed: true,
          ocrPassClaimed: true,
          cameraOcrRuntimePassClaimed: true,
          storeReadyPassClaimed: true,
          releasePassClaimed: true,
          trialLabel: 'forbidden-atomic-move-and-fake-pass',
        ),
      );

      expect(result.contractStaticReady, isFalse);
      expect(result.rejectionReasons, contains('sha-verification-atomic-move-or-runtime-mutation-forbidden-in-q306'));
      expect(result.rejectionReasons, contains('fake-pass-claim-forbidden'));
    });
  });
}
