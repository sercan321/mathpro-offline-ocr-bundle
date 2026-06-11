import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_full_real_camera_ocr_regression.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_store_release_candidate_audit.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_store_release_candidate_audit_policy.dart';

void main() {
  group('V172-Q299 Store Release Candidate Audit', () {
    test('is static-ready only and refuses store/release/OCR PASS claims', () {
      const input = GaussStoreReleaseCandidateAuditInput(
        q298FullRealCameraOcrRegressionPresent: true,
        q298FullRealCameraOcrRegressionStaticReady: true,
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
        storeReleaseCandidatePassClaimed: false,
        storeReadyPassClaimed: false,
        releasePassClaimed: false,
        privacyPolicyPassClaimed: false,
        dataSafetyPassClaimed: false,
        ocrPassClaimed: false,
        cameraOcrRuntimePassClaimed: false,
        auditLabel: 'q299-store-release-candidate-audit-test',
      );

      final result = GaussStoreReleaseCandidateAudit.evaluate(input);

      expect(result.phase, GaussStoreReleaseCandidateAuditPolicy.phase);
      expect(result.sourcePhase, GaussStoreReleaseCandidateAuditPolicy.sourcePhase);
      expect(result.auditFeatureFlag, 'gauss.storeReleaseCandidate.audit.defaultOff');
      expect(result.storeAuditContractStaticReady, isTrue);
      expect(result.readyForFutureStoreSubmissionEvidenceOnly, isTrue);
      expect(result.decision, GaussStoreReleaseCandidateAuditDecision.storeAuditContractReadyReleaseBlocked);
      expect(result.rejectionReasons, isEmpty);
      expect(result.canSubmitStoreReleaseInQ299, isFalse);
      expect(result.canClaimStoreReadyPassInQ299, isFalse);
      expect(result.canClaimReleasePassInQ299, isFalse);
      expect(result.canClaimOcrPassInQ299, isFalse);
      expect(result.canMutateWorkspaceFromCameraInQ299, isFalse);
      expect(result.canEvaluateSolveGraphFromCameraInQ299, isFalse);
      expect(result.requiredStoreAuditGates, contains('privacy-policy-required'));
      expect(result.requiredStoreAuditGates, contains('data-safety-form-required'));
      expect(result.requiredStoreAuditGates, contains('camera-permission-disclosure-required'));
      expect(result.requiredStoreAuditGates, contains('no-auto-evaluate-solve-graph-solution-history'));
      expect(result.storeAuditCourtCases, contains('play-console-data-safety-form-review'));
      expect(result.storeAuditCourtCases, contains('fake-pass-release-claim-guard'));
      expect(result.blockedUntilRealEvidence, contains('real-play-console-data-safety-form-screenshot-or-export'));
      expect(result.blockedUntilRealEvidence, contains('real-flutter-run-device-log'));
      expect(result.forbiddenActions, contains('claimReleasePassWithoutRealDeviceAndStoreAuditEvidence'));
      expect(result.forbiddenActions, contains('autoSolveCameraOutput'));
      expect(result.storeReadyPassClaimed, isFalse);
      expect(result.releasePassClaimed, isFalse);
      expect(result.ocrPassClaimed, isFalse);
    });

    test('can derive a safe Q299 input from the Q298 regression contract', () {
      final q298Result = GaussFullRealCameraOcrRegression.evaluate(
        const GaussFullRealCameraOcrRegressionInput(
          q297ApprovedWorkspaceImportPresent: true,
          q297ApprovedWorkspaceImportStaticReady: true,
          q296EditableMathLiveReviewPresent: true,
          q295ImageToLatexInferencePresent: true,
          q294DummyInputRuntimeCallPresent: true,
          q293RuntimeStartupSmokePresent: true,
          q292PrivateArtifactLoadSmokePresent: true,
          q291PrivateModelDownloadShaPresent: true,
          q290NativeHandlerAndroidBindingPresent: true,
          q289RuntimeDependencyTrialDefaultOffPresent: true,
          q288ArtifactSourceIntakePresent: true,
          keyboardLayoutProtected: true,
          moreTemplateTrayProtected: true,
          longPressListsProtected: true,
          mathLiveProductionRouteProtected: true,
          mathLiveBridgeProtected: true,
          graphSurfaceProtected: true,
          solutionSurfaceProtected: true,
          historySurfaceProtected: true,
          appShellWorkspaceProtected: true,
          splashIconProtected: true,
          androidManifestMainActivityProtected: true,
          cameraDependenciesProtected: true,
          androidToolchainProtected: true,
          cameraShellRuntimeProtected: true,
          cameraEntryButtonStillAvailable: true,
          cameraPreviewStillAvailable: true,
          cameraCaptureStillAvailable: true,
          cropScanFrameMetadataStillAvailable: true,
          editableMathLiveReviewStillRequired: true,
          explicitUserApprovalStillRequired: true,
          workspaceImportOnlyAfterApproval: true,
          manualSolveGraphAfterImportOnly: true,
          directWorkspaceMutationAttempted: false,
          autoEvaluateAttempted: false,
          autoSolveAttempted: false,
          autoGraphAttempted: false,
          autoSolutionAttempted: false,
          autoHistoryAttempted: false,
          fullRealCameraOcrRegressionExecutedInQ298: false,
          realWorkspaceImportRuntimeExecutedInQ298: false,
          realEditableMathLiveReviewOpenedInQ298: false,
          realImageToLatexInferenceExecutedInQ298: false,
          realRuntimeInvocationExecutedInQ298: false,
          nativeRuntimeBridgeInvokedInQ298: false,
          paddleRuntimeAdded: false,
          paddleOcrDependencyAdded: false,
          runtimeDependencyAddedToPubspec: false,
          gradleNativeRuntimeDependencyAdded: false,
          nativeHandlerImplementationAdded: false,
          jniBindingAdded: false,
          methodChannelRuntimeBindingAdded: false,
          modelBinaryBundledInBaseApp: false,
          productionDownloadEnabled: false,
          fullRegressionPassClaimed: false,
          workspaceImportPassClaimed: false,
          reviewBindingPassClaimed: false,
          imageToLatexPassClaimed: false,
          ocrPassClaimed: false,
          cameraOcrRuntimePassClaimed: false,
          premiumFinalPassClaimed: false,
          storeReadyPassClaimed: false,
          releasePassClaimed: false,
          regressionLabel: 'q298-for-q299-test',
        ),
      );
      final result = GaussStoreReleaseCandidateAudit.evaluate(
        GaussStoreReleaseCandidateAuditInput.fromQ298Contract(q298Result: q298Result),
      );

      expect(q298Result.fullRegressionCourtStaticReady, isTrue);
      expect(result.storeAuditContractStaticReady, isTrue);
      expect(result.storeSubmissionPerformed, isFalse);
      expect(result.playConsoleConfigured, isFalse);
      expect(result.productionReleaseCreated, isFalse);
      expect(result.storeReadyPassClaimed, isFalse);
      expect(result.releasePassClaimed, isFalse);
      expect(result.cameraOcrRuntimePassClaimed, isFalse);
    });

    test('blocks missing store disclosures and fake release claims', () {
      const input = GaussStoreReleaseCandidateAuditInput(
        q298FullRealCameraOcrRegressionPresent: true,
        q298FullRealCameraOcrRegressionStaticReady: true,
        q297ApprovedWorkspaceImportPresent: true,
        q296EditableMathLiveReviewPresent: true,
        q295ImageToLatexInferencePresent: true,
        q294DummyInputRuntimeCallPresent: true,
        q293RuntimeStartupSmokePresent: true,
        q292PrivateArtifactLoadSmokePresent: true,
        q291PrivateModelDownloadShaPresent: true,
        q288ArtifactSourceIntakePresent: true,
        privacyPolicyRequired: false,
        dataSafetyFormRequired: true,
        cameraPermissionDisclosureRequired: true,
        modelLicenseDisclosureRequired: true,
        truthfulOcrClaimsRequired: true,
        screenshotsRealDeviceEvidenceRequired: true,
        localizationReviewRequired: true,
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
        storeReleaseCandidatePassClaimed: false,
        storeReadyPassClaimed: false,
        releasePassClaimed: true,
        privacyPolicyPassClaimed: false,
        dataSafetyPassClaimed: false,
        ocrPassClaimed: false,
        cameraOcrRuntimePassClaimed: false,
        auditLabel: 'q299-blocking-test',
      );

      final result = GaussStoreReleaseCandidateAudit.evaluate(input);

      expect(result.storeAuditContractStaticReady, isFalse);
      expect(result.decision, GaussStoreReleaseCandidateAuditDecision.blockedMissingStoreDisclosureGate);
      expect(result.rejectionReasons, contains('missingStoreDisclosureGate'));
      expect(result.rejectionReasons, contains('fakePassClaim'));
    });

    test('policy preserves runtime blockers and requires user-side retest', () {
      expect(GaussStoreReleaseCandidateAuditPolicy.changesRuntimeBehavior, isFalse);
      expect(GaussStoreReleaseCandidateAuditPolicy.keyboardLayoutChanged, isFalse);
      expect(GaussStoreReleaseCandidateAuditPolicy.mathLiveProductionRouteChanged, isFalse);
      expect(GaussStoreReleaseCandidateAuditPolicy.cameraShellRuntimeChanged, isFalse);
      expect(GaussStoreReleaseCandidateAuditPolicy.androidManifestChanged, isFalse);
      expect(GaussStoreReleaseCandidateAuditPolicy.mainActivityChanged, isFalse);
      expect(GaussStoreReleaseCandidateAuditPolicy.paddleRuntimeAdded, isFalse);
      expect(GaussStoreReleaseCandidateAuditPolicy.paddleOcrDependencyAdded, isFalse);
      expect(GaussStoreReleaseCandidateAuditPolicy.modelBinaryBundledInBaseApp, isFalse);
      expect(GaussStoreReleaseCandidateAuditPolicy.productionDownloadEnabled, isFalse);
      expect(GaussStoreReleaseCandidateAuditPolicy.storeSubmissionPerformed, isFalse);
      expect(GaussStoreReleaseCandidateAuditPolicy.playConsoleConfigured, isFalse);
      expect(GaussStoreReleaseCandidateAuditPolicy.privacyPolicyPublished, isFalse);
      expect(GaussStoreReleaseCandidateAuditPolicy.dataSafetyFormCompleted, isFalse);
      expect(GaussStoreReleaseCandidateAuditPolicy.storeReadyPassClaimed, isFalse);
      expect(GaussStoreReleaseCandidateAuditPolicy.releasePassClaimed, isFalse);
      expect(GaussStoreReleaseCandidateAuditPolicy.ocrPassClaimed, isFalse);
      expect(GaussStoreReleaseCandidateAuditPolicy.requiresUserSideRetest, contains('flutter analyze'));
      expect(GaussStoreReleaseCandidateAuditPolicy.requiresUserSideRetest, contains('flutter test'));
    });
  });
}
