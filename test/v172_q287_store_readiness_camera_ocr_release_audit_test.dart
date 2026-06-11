import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_store_readiness_camera_ocr_release_audit.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_store_readiness_camera_ocr_release_audit_policy.dart';

void main() {
  group('V172-Q287 Store-readiness Camera/OCR release audit', () {
    const readyInput = GaussStoreReadinessCameraOcrReleaseAuditInput(
      q286FullCameraOcrRuntimePremiumRegressionPresent: true,
      q286FullCameraOcrRuntimePremiumRegressionStaticReady: true,
      realFlutterAnalyzeCleanLogAvailable: false,
      realFlutterTestPassLogAvailable: false,
      realFlutterRunDeviceLogAvailable: false,
      realCameraPreviewCaptureEvidenceAvailable: false,
      realMathLiveReviewEvidenceAvailable: false,
      storeListingCopyEvidenceAvailable: false,
      privacyPolicyEvidenceAvailable: false,
      dataSafetyFormEvidenceAvailable: false,
      cameraPermissionDisclosureEvidenceAvailable: false,
      modelLicenseEvidenceAvailable: false,
      modelSizeEvidenceAvailable: false,
      baseApkAabSizeEvidenceAvailable: false,
      noBundledModelEvidenceAvailable: true,
      crashFreeDeviceEvidenceAvailable: false,
      keyboardLayoutProtected: true,
      moreTemplateTrayProtected: true,
      longPressListsProtected: true,
      mathLiveProductionRouteProtected: true,
      graphSurfaceProtected: true,
      solutionSurfaceProtected: true,
      historySurfaceProtected: true,
      appShellWorkspaceProtected: true,
      splashIconProtected: true,
      androidManifestMainActivityProtected: true,
      cameraDependenciesProtected: true,
      androidToolchainProtected: true,
      reviewBeforeImportStillMandatory: true,
      explicitUserApprovalStillMandatory: true,
      workspaceImportOnlyAfterApproval: true,
      directWorkspaceMutationAttempted: false,
      autoEvaluateAttempted: false,
      autoSolveAttempted: false,
      autoGraphAttempted: false,
      autoSolutionAttempted: false,
      autoHistoryAttempted: false,
      playStoreSubmissionExecutedInQ287: false,
      releaseCandidateFreezeExecutedInQ287: false,
      productionAabBuiltInQ287: false,
      productionApkBuiltInQ287: false,
      paddleRuntimeAdded: false,
      paddleOcrDependencyAdded: false,
      runtimeDependencyAddedToPubspec: false,
      gradleNativeRuntimeDependencyAdded: false,
      nativeHandlerImplementationAdded: false,
      jniBindingAdded: false,
      methodChannelRuntimeBindingAdded: false,
      modelBinaryBundledInBaseApp: false,
      productionModelUrlBound: false,
      productionDownloadEnabled: false,
      realNetworkDownloadWorkerImplemented: false,
      unsafeOcrAccuracyMarketingClaimed: false,
      photomathLevelClaimedWithoutEvidence: false,
      storeReadyPassClaimed: false,
      releasePassClaimed: false,
      ocrPassClaimed: false,
      cameraOcrRuntimePassClaimed: false,
      premiumFinalPassClaimed: false,
      auditLabel: 'q287-store-readiness-camera-ocr-release-audit',
    );

    test('is gate-only and refuses store/release/OCR PASS claims', () {
      final result = GaussStoreReadinessCameraOcrReleaseAudit.evaluate(readyInput);

      expect(result.phase, GaussStoreReadinessCameraOcrReleaseAuditPolicy.phase);
      expect(result.sourcePhase, 'V172-Q286-FULL-CAMERA-OCR-RUNTIME-PREMIUM-REGRESSION');
      expect(result.selectedEngineLabel, 'PP-FormulaNet-S');
      expect(result.auditMode, contains('gate-only'));
      expect(result.storeReadinessAuditStaticReady, isTrue);
      expect(result.readyForFutureStoreReadinessEvidenceOnly, isTrue);
      expect(result.decision, GaussStoreReadinessCameraOcrReleaseAuditDecision.readyForFutureStoreReadinessEvidenceOnly);
      expect(result.canSubmitToPlayStoreInQ287, isFalse);
      expect(result.canBuildProductionAabInQ287, isFalse);
      expect(result.canClaimStoreReadyPassInQ287, isFalse);
      expect(result.canClaimReleasePassInQ287, isFalse);
      expect(result.canClaimOcrPassInQ287, isFalse);
      expect(result.canUseOcrAccuracyMarketingClaimsInQ287, isFalse);
      expect(result.playStoreSubmissionExecutedInQ287, isFalse);
      expect(result.productionAabBuiltInQ287, isFalse);
      expect(result.realOcrRuntimeAdded, isFalse);
      expect(result.modelBinaryBundledInBaseApp, isFalse);
      expect(result.releasePassClaimed, isFalse);
      expect(result.requiredStoreAuditGates, contains('playStoreListingCopyTruthful'));
      expect(result.requiredStoreAuditGates, contains('reviewBeforeImportRequired'));
      expect(result.storeEvidenceFields, contains('privacyPolicyReference'));
      expect(result.blockedUntilRealEvidence, contains('explicitStoreSubmissionApproval'));
      expect(result.forbiddenActions, contains('claimAccuracyPercentageWithoutBenchmarkEvidence'));
    });

    test('blocks missing Q286 regression court', () {
      final result = GaussStoreReadinessCameraOcrReleaseAudit.evaluate(
        readyInput.copyWithForTest(
          q286FullCameraOcrRuntimePremiumRegressionPresent: false,
          q286FullCameraOcrRuntimePremiumRegressionStaticReady: false,
        ),
      );

      expect(result.storeReadinessAuditStaticReady, isFalse);
      expect(result.decision, GaussStoreReadinessCameraOcrReleaseAuditDecision.blockedMissingQ286FullRegressionCourt);
      expect(result.rejectionReasons, contains('missingQ286FullCameraOcrRuntimePremiumRegressionCourt'));
    });

    test('blocks unsafe marketing claims and automatic side effects', () {
      final claimResult = GaussStoreReadinessCameraOcrReleaseAudit.evaluate(
        readyInput.copyWithForTest(unsafeOcrAccuracyMarketingClaimed: true),
      );
      expect(claimResult.decision, GaussStoreReadinessCameraOcrReleaseAuditDecision.blockedUnsafeClaimsOrPolicyRisk);

      final sideEffectResult = GaussStoreReadinessCameraOcrReleaseAudit.evaluate(
        readyInput.copyWithForTest(autoSolveAttempted: true),
      );
      expect(sideEffectResult.decision, GaussStoreReadinessCameraOcrReleaseAuditDecision.blockedAutomaticCameraSideEffectRisk);
    });

    test('blocks runtime/package mutations and fake release pass', () {
      final runtimeResult = GaussStoreReadinessCameraOcrReleaseAudit.evaluate(
        readyInput.copyWithForTest(modelBinaryBundledInBaseApp: true),
      );
      expect(runtimeResult.decision, GaussStoreReadinessCameraOcrReleaseAuditDecision.blockedRuntimeOrPackagingMutation);

      final fakePassResult = GaussStoreReadinessCameraOcrReleaseAudit.evaluate(
        readyInput.copyWithForTest(releasePassClaimed: true),
      );
      expect(fakePassResult.decision, GaussStoreReadinessCameraOcrReleaseAuditDecision.blockedFakeReleasePassClaim);
    });
  });
}

extension _Q287InputCopy on GaussStoreReadinessCameraOcrReleaseAuditInput {
  GaussStoreReadinessCameraOcrReleaseAuditInput copyWithForTest({
    bool? q286FullCameraOcrRuntimePremiumRegressionPresent,
    bool? q286FullCameraOcrRuntimePremiumRegressionStaticReady,
    bool? unsafeOcrAccuracyMarketingClaimed,
    bool? autoSolveAttempted,
    bool? modelBinaryBundledInBaseApp,
    bool? releasePassClaimed,
  }) {
    return GaussStoreReadinessCameraOcrReleaseAuditInput(
      q286FullCameraOcrRuntimePremiumRegressionPresent: q286FullCameraOcrRuntimePremiumRegressionPresent ?? this.q286FullCameraOcrRuntimePremiumRegressionPresent,
      q286FullCameraOcrRuntimePremiumRegressionStaticReady: q286FullCameraOcrRuntimePremiumRegressionStaticReady ?? this.q286FullCameraOcrRuntimePremiumRegressionStaticReady,
      realFlutterAnalyzeCleanLogAvailable: realFlutterAnalyzeCleanLogAvailable,
      realFlutterTestPassLogAvailable: realFlutterTestPassLogAvailable,
      realFlutterRunDeviceLogAvailable: realFlutterRunDeviceLogAvailable,
      realCameraPreviewCaptureEvidenceAvailable: realCameraPreviewCaptureEvidenceAvailable,
      realMathLiveReviewEvidenceAvailable: realMathLiveReviewEvidenceAvailable,
      storeListingCopyEvidenceAvailable: storeListingCopyEvidenceAvailable,
      privacyPolicyEvidenceAvailable: privacyPolicyEvidenceAvailable,
      dataSafetyFormEvidenceAvailable: dataSafetyFormEvidenceAvailable,
      cameraPermissionDisclosureEvidenceAvailable: cameraPermissionDisclosureEvidenceAvailable,
      modelLicenseEvidenceAvailable: modelLicenseEvidenceAvailable,
      modelSizeEvidenceAvailable: modelSizeEvidenceAvailable,
      baseApkAabSizeEvidenceAvailable: baseApkAabSizeEvidenceAvailable,
      noBundledModelEvidenceAvailable: noBundledModelEvidenceAvailable,
      crashFreeDeviceEvidenceAvailable: crashFreeDeviceEvidenceAvailable,
      keyboardLayoutProtected: keyboardLayoutProtected,
      moreTemplateTrayProtected: moreTemplateTrayProtected,
      longPressListsProtected: longPressListsProtected,
      mathLiveProductionRouteProtected: mathLiveProductionRouteProtected,
      graphSurfaceProtected: graphSurfaceProtected,
      solutionSurfaceProtected: solutionSurfaceProtected,
      historySurfaceProtected: historySurfaceProtected,
      appShellWorkspaceProtected: appShellWorkspaceProtected,
      splashIconProtected: splashIconProtected,
      androidManifestMainActivityProtected: androidManifestMainActivityProtected,
      cameraDependenciesProtected: cameraDependenciesProtected,
      androidToolchainProtected: androidToolchainProtected,
      reviewBeforeImportStillMandatory: reviewBeforeImportStillMandatory,
      explicitUserApprovalStillMandatory: explicitUserApprovalStillMandatory,
      workspaceImportOnlyAfterApproval: workspaceImportOnlyAfterApproval,
      directWorkspaceMutationAttempted: directWorkspaceMutationAttempted,
      autoEvaluateAttempted: autoEvaluateAttempted,
      autoSolveAttempted: autoSolveAttempted ?? this.autoSolveAttempted,
      autoGraphAttempted: autoGraphAttempted,
      autoSolutionAttempted: autoSolutionAttempted,
      autoHistoryAttempted: autoHistoryAttempted,
      playStoreSubmissionExecutedInQ287: playStoreSubmissionExecutedInQ287,
      releaseCandidateFreezeExecutedInQ287: releaseCandidateFreezeExecutedInQ287,
      productionAabBuiltInQ287: productionAabBuiltInQ287,
      productionApkBuiltInQ287: productionApkBuiltInQ287,
      paddleRuntimeAdded: paddleRuntimeAdded,
      paddleOcrDependencyAdded: paddleOcrDependencyAdded,
      runtimeDependencyAddedToPubspec: runtimeDependencyAddedToPubspec,
      gradleNativeRuntimeDependencyAdded: gradleNativeRuntimeDependencyAdded,
      nativeHandlerImplementationAdded: nativeHandlerImplementationAdded,
      jniBindingAdded: jniBindingAdded,
      methodChannelRuntimeBindingAdded: methodChannelRuntimeBindingAdded,
      modelBinaryBundledInBaseApp: modelBinaryBundledInBaseApp ?? this.modelBinaryBundledInBaseApp,
      productionModelUrlBound: productionModelUrlBound,
      productionDownloadEnabled: productionDownloadEnabled,
      realNetworkDownloadWorkerImplemented: realNetworkDownloadWorkerImplemented,
      unsafeOcrAccuracyMarketingClaimed: unsafeOcrAccuracyMarketingClaimed ?? this.unsafeOcrAccuracyMarketingClaimed,
      photomathLevelClaimedWithoutEvidence: photomathLevelClaimedWithoutEvidence,
      storeReadyPassClaimed: storeReadyPassClaimed,
      releasePassClaimed: releasePassClaimed ?? this.releasePassClaimed,
      ocrPassClaimed: ocrPassClaimed,
      cameraOcrRuntimePassClaimed: cameraOcrRuntimePassClaimed,
      premiumFinalPassClaimed: premiumFinalPassClaimed,
      auditLabel: auditLabel,
    );
  }
}
