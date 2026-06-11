import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_release_candidate_freeze.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_release_candidate_freeze_policy.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_store_release_candidate_audit.dart';

void main() {
  group('V172-Q300 Release Candidate Freeze', () {
    test('is freeze-contract-ready only and refuses release/store/OCR PASS claims', () {
      const input = GaussReleaseCandidateFreezeInput(
        q299StoreReleaseCandidateAuditPresent: true,
        q299StoreReleaseCandidateAuditStaticReady: true,
        q298FullRealCameraOcrRegressionPresent: true,
        q297ApprovedWorkspaceImportPresent: true,
        q296EditableMathLiveReviewPresent: true,
        q295ImageToLatexInferencePresent: true,
        q294DummyInputRuntimeCallPresent: true,
        q293RuntimeStartupSmokePresent: true,
        q292PrivateArtifactLoadSmokePresent: true,
        q291PrivateModelDownloadShaPresent: true,
        q288ArtifactSourceIntakePresent: true,
        privacyPolicyRequired: true,
        dataSafetyFormRequired: true,
        cameraPermissionDisclosureRequired: true,
        modelLicenseDisclosureRequired: true,
        truthfulOcrClaimsRequired: true,
        screenshotsRealDeviceEvidenceRequired: true,
        localizationReviewRequired: true,
        contentRatingEvidenceRequired: true,
        internalTestingEvidenceRequired: true,
        noMedicalFinancialOrExamGuaranteeClaims: true,
        keyboardLayoutProtected: true,
        moreTemplateTrayProtected: true,
        longPressListsProtected: true,
        mathLiveProductionRouteProtected: true,
        mathLiveBridgeProtected: true,
        graphSolutionHistoryProtected: true,
        appShellWorkspaceProtected: true,
        androidManifestMainActivityProtected: true,
        cameraDependenciesProtected: true,
        androidToolchainProtected: true,
        cameraShellRuntimeProtected: true,
        editableMathLiveReviewStillRequired: true,
        explicitUserApprovalStillRequired: true,
        workspaceImportOnlyAfterApproval: true,
        manualSolveGraphAfterImportOnly: true,
        storeSubmissionPerformed: false,
        playConsoleConfigured: false,
        productionReleaseCreated: false,
        releaseAabCreated: false,
        releaseApkCreated: false,
        internalTestingTrackUploaded: false,
        realStoreListingAssetsAttached: false,
        realLocalizedListingsAttached: false,
        directWorkspaceMutationAttempted: false,
        autoEvaluateAttempted: false,
        autoSolveGraphSolutionHistoryAttempted: false,
        runtimeDependencyAdded: false,
        methodChannelRuntimeBindingAdded: false,
        nativeRuntimeInvoked: false,
        modelBinaryBundledInBaseApp: false,
        productionDownloadEnabled: false,
        releaseCandidateFreezePassClaimed: false,
        storeReleaseCandidatePassClaimed: false,
        storeReadyPassClaimed: false,
        releasePassClaimed: false,
        privacyPolicyPassClaimed: false,
        dataSafetyPassClaimed: false,
        ocrPassClaimed: false,
        cameraOcrRuntimePassClaimed: false,
        freezeLabel: 'q300-release-candidate-freeze-test',
      );

      final result = GaussReleaseCandidateFreeze.evaluate(input);

      expect(result.phase, GaussReleaseCandidateFreezePolicy.phase);
      expect(result.sourcePhase, GaussReleaseCandidateFreezePolicy.sourcePhase);
      expect(result.freezeFeatureFlag, 'gauss.releaseCandidate.freeze.defaultOff');
      expect(result.freezeContractStaticReady, isTrue);
      expect(result.readyForFutureReleaseEvidenceOnly, isTrue);
      expect(result.decision, GaussReleaseCandidateFreezeDecision.releaseCandidateFreezeContractReadyReleaseBlocked);
      expect(result.rejectionReasons, isEmpty);
      expect(result.canSubmitStoreReleaseInQ300, isFalse);
      expect(result.canCreateReleaseBuildInQ300, isFalse);
      expect(result.canClaimStoreReadyPassInQ300, isFalse);
      expect(result.canClaimReleasePassInQ300, isFalse);
      expect(result.canClaimOcrPassInQ300, isFalse);
      expect(result.canMutateWorkspaceFromCameraInQ300, isFalse);
      expect(result.canEvaluateSolveGraphFromCameraInQ300, isFalse);
      expect(result.requiredFreezeGates, contains('q299-store-release-candidate-audit-contract-present'));
      expect(result.requiredFreezeGates, contains('privacy-policy-required'));
      expect(result.requiredFreezeGates, contains('content-rating-evidence-required'));
      expect(result.requiredFreezeGates, contains('no-auto-evaluate-solve-graph-solution-history'));
      expect(result.releaseFreezeCourtCases, contains('fake-pass-release-store-ocr-claim-guard'));
      expect(result.blockedUntilRealEvidence, contains('real-flutter-run-device-log'));
      expect(result.blockedUntilRealEvidence, contains('real-internal-test-track-upload-evidence'));
      expect(result.forbiddenActions, contains('buildReleaseAabOrApkInQ300'));
      expect(result.forbiddenActions, contains('autoSolveCameraOutput'));
      expect(result.releaseCandidateFreezePassClaimed, isFalse);
      expect(result.storeReadyPassClaimed, isFalse);
      expect(result.releasePassClaimed, isFalse);
      expect(result.ocrPassClaimed, isFalse);
    });

    test('can derive a safe Q300 input from the Q299 audit contract', () {
      const q299Result = GaussStoreReleaseCandidateAuditResult(
        phase: 'V172-Q299-STORE-RELEASE-CANDIDATE-AUDIT',
        sourcePhase: 'V172-Q298-FULL-REAL-CAMERA-OCR-REGRESSION',
        selectedEngineLabel: 'PP-FormulaNet-S',
        auditFeatureFlag: 'gauss.storeReleaseCandidate.audit.defaultOff',
        auditReadinessState: 'BLOCKED_PENDING_REAL_STORE_ASSET_PRIVACY_POLICY_DATA_SAFETY_DEVICE_AND_OCR_EVIDENCE',
        storeAuditContractStaticReady: true,
        readyForFutureStoreSubmissionEvidenceOnly: true,
        decision: GaussStoreReleaseCandidateAuditDecision.storeAuditContractReadyReleaseBlocked,
        rejectionReasons: <String>[],
        requiredStoreAuditGates: <String>[],
        storeAuditCourtCases: <String>[],
        blockedUntilRealEvidence: <String>[],
        forbiddenActions: <String>[],
        storeSubmissionPerformed: false,
        playConsoleConfigured: false,
        productionReleaseCreated: false,
        internalTestingTrackUploaded: false,
        realStoreListingAssetsAttached: false,
        realLocalizedListingsAttached: false,
        methodChannelRuntimeBindingAdded: false,
        modelBinaryBundledInBaseApp: false,
        productionDownloadEnabled: false,
        storeReleaseCandidatePassClaimed: false,
        storeReadyPassClaimed: false,
        releasePassClaimed: false,
        ocrPassClaimed: false,
        cameraOcrRuntimePassClaimed: false,
        auditLabel: 'q299-for-q300-test',
      );

      final result = GaussReleaseCandidateFreeze.evaluate(
        GaussReleaseCandidateFreezeInput.fromQ299Contract(q299Result: q299Result),
      );

      expect(result.freezeContractStaticReady, isTrue);
      expect(result.storeSubmissionPerformed, isFalse);
      expect(result.playConsoleConfigured, isFalse);
      expect(result.productionReleaseCreated, isFalse);
      expect(result.releaseAabCreated, isFalse);
      expect(result.releaseApkCreated, isFalse);
      expect(result.storeReadyPassClaimed, isFalse);
      expect(result.releasePassClaimed, isFalse);
      expect(result.cameraOcrRuntimePassClaimed, isFalse);
    });

    test('blocks missing release evidence and fake release claims', () {
      const input = GaussReleaseCandidateFreezeInput(
        q299StoreReleaseCandidateAuditPresent: true,
        q299StoreReleaseCandidateAuditStaticReady: true,
        q298FullRealCameraOcrRegressionPresent: true,
        q297ApprovedWorkspaceImportPresent: true,
        q296EditableMathLiveReviewPresent: true,
        q295ImageToLatexInferencePresent: true,
        q294DummyInputRuntimeCallPresent: true,
        q293RuntimeStartupSmokePresent: true,
        q292PrivateArtifactLoadSmokePresent: true,
        q291PrivateModelDownloadShaPresent: true,
        q288ArtifactSourceIntakePresent: true,
        privacyPolicyRequired: true,
        dataSafetyFormRequired: false,
        cameraPermissionDisclosureRequired: true,
        modelLicenseDisclosureRequired: true,
        truthfulOcrClaimsRequired: true,
        screenshotsRealDeviceEvidenceRequired: true,
        localizationReviewRequired: true,
        contentRatingEvidenceRequired: true,
        internalTestingEvidenceRequired: true,
        noMedicalFinancialOrExamGuaranteeClaims: true,
        keyboardLayoutProtected: true,
        moreTemplateTrayProtected: true,
        longPressListsProtected: true,
        mathLiveProductionRouteProtected: true,
        mathLiveBridgeProtected: true,
        graphSolutionHistoryProtected: true,
        appShellWorkspaceProtected: true,
        androidManifestMainActivityProtected: true,
        cameraDependenciesProtected: true,
        androidToolchainProtected: true,
        cameraShellRuntimeProtected: true,
        editableMathLiveReviewStillRequired: true,
        explicitUserApprovalStillRequired: true,
        workspaceImportOnlyAfterApproval: true,
        manualSolveGraphAfterImportOnly: true,
        storeSubmissionPerformed: false,
        playConsoleConfigured: false,
        productionReleaseCreated: false,
        releaseAabCreated: false,
        releaseApkCreated: false,
        internalTestingTrackUploaded: false,
        realStoreListingAssetsAttached: false,
        realLocalizedListingsAttached: false,
        directWorkspaceMutationAttempted: false,
        autoEvaluateAttempted: false,
        autoSolveGraphSolutionHistoryAttempted: false,
        runtimeDependencyAdded: false,
        methodChannelRuntimeBindingAdded: false,
        nativeRuntimeInvoked: false,
        modelBinaryBundledInBaseApp: false,
        productionDownloadEnabled: false,
        releaseCandidateFreezePassClaimed: false,
        storeReleaseCandidatePassClaimed: false,
        storeReadyPassClaimed: false,
        releasePassClaimed: true,
        privacyPolicyPassClaimed: false,
        dataSafetyPassClaimed: false,
        ocrPassClaimed: false,
        cameraOcrRuntimePassClaimed: false,
        freezeLabel: 'q300-blocking-test',
      );

      final result = GaussReleaseCandidateFreeze.evaluate(input);

      expect(result.freezeContractStaticReady, isFalse);
      expect(result.decision, GaussReleaseCandidateFreezeDecision.blockedMissingStoreReleaseEvidenceGate);
      expect(result.rejectionReasons, contains('missingStoreReleaseEvidenceGate'));
      expect(result.rejectionReasons, contains('fakePassClaim'));
    });

    test('policy preserves runtime blockers and requires user-side retest', () {
      expect(GaussReleaseCandidateFreezePolicy.changesRuntimeBehavior, isFalse);
      expect(GaussReleaseCandidateFreezePolicy.keyboardLayoutChanged, isFalse);
      expect(GaussReleaseCandidateFreezePolicy.mathLiveProductionRouteChanged, isFalse);
      expect(GaussReleaseCandidateFreezePolicy.cameraShellRuntimeChanged, isFalse);
      expect(GaussReleaseCandidateFreezePolicy.androidManifestChanged, isFalse);
      expect(GaussReleaseCandidateFreezePolicy.mainActivityChanged, isFalse);
      expect(GaussReleaseCandidateFreezePolicy.pubspecChanged, isFalse);
      expect(GaussReleaseCandidateFreezePolicy.paddleRuntimeAdded, isFalse);
      expect(GaussReleaseCandidateFreezePolicy.paddleOcrDependencyAdded, isFalse);
      expect(GaussReleaseCandidateFreezePolicy.modelBinaryBundledInBaseApp, isFalse);
      expect(GaussReleaseCandidateFreezePolicy.productionDownloadEnabled, isFalse);
      expect(GaussReleaseCandidateFreezePolicy.storeSubmissionPerformed, isFalse);
      expect(GaussReleaseCandidateFreezePolicy.playConsoleConfigured, isFalse);
      expect(GaussReleaseCandidateFreezePolicy.productionReleaseCreated, isFalse);
      expect(GaussReleaseCandidateFreezePolicy.releaseAabCreated, isFalse);
      expect(GaussReleaseCandidateFreezePolicy.releaseApkCreated, isFalse);
      expect(GaussReleaseCandidateFreezePolicy.releaseCandidateFreezePassClaimed, isFalse);
      expect(GaussReleaseCandidateFreezePolicy.storeReadyPassClaimed, isFalse);
      expect(GaussReleaseCandidateFreezePolicy.releasePassClaimed, isFalse);
      expect(GaussReleaseCandidateFreezePolicy.ocrPassClaimed, isFalse);
      expect(GaussReleaseCandidateFreezePolicy.requiresUserSideRetest, contains('flutter analyze'));
      expect(GaussReleaseCandidateFreezePolicy.requiresUserSideRetest, contains('flutter test'));
    });
  });
}
