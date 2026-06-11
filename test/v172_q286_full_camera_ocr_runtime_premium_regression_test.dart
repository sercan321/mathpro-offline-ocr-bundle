import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_approved_ocr_workspace_import_runtime_court.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_full_camera_ocr_runtime_premium_regression.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_full_camera_ocr_runtime_premium_regression_policy.dart';

void main() {
  group('V172-Q286 Full Camera/OCR runtime premium regression court', () {
    const readyInput = GaussFullCameraOcrRuntimePremiumRegressionInput(
      q285ApprovedWorkspaceImportRuntimeCourtPresent: true,
      q285ApprovedWorkspaceImportRuntimeCourtStaticReady: true,
      q284EditableMathLiveReviewRuntimeBindingPresent: true,
      q283ImageToLatexInferenceCourtPresent: true,
      q282RuntimeSmokeCourtPresent: true,
      q281PrivateArtifactLoadSmokePresent: true,
      q280NativeRuntimeBridgeGatePresent: true,
      q279DependencyTrialDefaultOffPresent: true,
      q278RealRuntimeEvidenceLockPresent: true,
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
      realFullCameraOcrRuntimeRegressionExecutedInQ286: false,
      realWorkspaceImportRuntimeExecutedInQ286: false,
      realImageToLatexInferenceExecutedInQ286: false,
      realRuntimeSmokeExecutedInQ286: false,
      realRuntimeInvocationExecutedInQ286: false,
      nativeRuntimeBridgeInvokedInQ286: false,
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
      fullCameraOcrRuntimeRegressionPassClaimed: false,
      workspaceImportRuntimePassClaimed: false,
      reviewBindingPassClaimed: false,
      imageToLatexPassClaimed: false,
      runtimeSmokePassClaimed: false,
      ocrPassClaimed: false,
      cameraOcrRuntimePassClaimed: false,
      premiumFinalPassClaimed: false,
      releasePassClaimed: false,
      regressionLabel: 'q286-full-camera-ocr-runtime-premium-regression',
    );

    test('is static-ready only and refuses OCR/runtime/pass claims', () {
      final result = GaussFullCameraOcrRuntimePremiumRegression.evaluate(readyInput);

      expect(result.phase, GaussFullCameraOcrRuntimePremiumRegressionPolicy.phase);
      expect(result.sourcePhase, 'V172-Q285-APPROVED-OCR-WORKSPACE-IMPORT-RUNTIME-COURT');
      expect(result.selectedEngineLabel, 'PP-FormulaNet-S');
      expect(result.fullRegressionCourtStaticReady, isTrue);
      expect(result.readyForFutureFullRuntimeRegressionEvidenceOnly, isTrue);
      expect(result.decision, GaussFullCameraOcrRuntimePremiumRegressionDecision.readyForFutureFullRuntimeRegressionEvidenceOnly);
      expect(result.canRunRealOcrInQ286, isFalse);
      expect(result.canMutateWorkspaceFromCameraInQ286, isFalse);
      expect(result.canEvaluateFromCameraInQ286, isFalse);
      expect(result.canSolveFromCameraInQ286, isFalse);
      expect(result.canGraphFromCameraInQ286, isFalse);
      expect(result.canWriteSolutionOrHistoryFromCameraInQ286, isFalse);
      expect(result.canClaimFullCameraOcrRuntimeRegressionPassInQ286, isFalse);
      expect(result.canClaimOcrPassInQ286, isFalse);
      expect(result.modelBinaryBundledInBaseApp, isFalse);
      expect(result.ocrPassClaimed, isFalse);
      expect(result.requiredFullRegressionGates, contains('keyboardLayoutPreserved'));
      expect(result.requiredFullRegressionGates, contains('noAutoSolveAfterCamera'));
      expect(result.blockedUntilRealEvidence, contains('realFlutterRunDeviceLog'));
      expect(result.regressionCourtCases, contains('cameraCaptureReviewSurfaceSmoke'));
      expect(result.forbiddenActions, contains('autoSolveCameraOutput'));
    });

    test('blocks missing Q285 approved workspace import court', () {
      final result = GaussFullCameraOcrRuntimePremiumRegression.evaluate(
        const GaussFullCameraOcrRuntimePremiumRegressionInput(
          q285ApprovedWorkspaceImportRuntimeCourtPresent: false,
          q285ApprovedWorkspaceImportRuntimeCourtStaticReady: false,
          q284EditableMathLiveReviewRuntimeBindingPresent: true,
          q283ImageToLatexInferenceCourtPresent: true,
          q282RuntimeSmokeCourtPresent: true,
          q281PrivateArtifactLoadSmokePresent: true,
          q280NativeRuntimeBridgeGatePresent: true,
          q279DependencyTrialDefaultOffPresent: true,
          q278RealRuntimeEvidenceLockPresent: true,
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
          realFullCameraOcrRuntimeRegressionExecutedInQ286: false,
          realWorkspaceImportRuntimeExecutedInQ286: false,
          realImageToLatexInferenceExecutedInQ286: false,
          realRuntimeSmokeExecutedInQ286: false,
          realRuntimeInvocationExecutedInQ286: false,
          nativeRuntimeBridgeInvokedInQ286: false,
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
          fullCameraOcrRuntimeRegressionPassClaimed: false,
          workspaceImportRuntimePassClaimed: false,
          reviewBindingPassClaimed: false,
          imageToLatexPassClaimed: false,
          runtimeSmokePassClaimed: false,
          ocrPassClaimed: false,
          cameraOcrRuntimePassClaimed: false,
          premiumFinalPassClaimed: false,
          releasePassClaimed: false,
          regressionLabel: 'missing-q285',
        ),
      );

      expect(result.fullRegressionCourtStaticReady, isFalse);
      expect(result.decision, GaussFullCameraOcrRuntimePremiumRegressionDecision.blockedMissingQ285ApprovedImportCourt);
      expect(result.rejectionReasons, contains('missingQ285ApprovedWorkspaceImportRuntimeCourt'));
    });

    test('blocks protected surface regression and automatic side effects', () {
      final protectedResult = GaussFullCameraOcrRuntimePremiumRegression.evaluate(
        const GaussFullCameraOcrRuntimePremiumRegressionInput(
          q285ApprovedWorkspaceImportRuntimeCourtPresent: true,
          q285ApprovedWorkspaceImportRuntimeCourtStaticReady: true,
          q284EditableMathLiveReviewRuntimeBindingPresent: true,
          q283ImageToLatexInferenceCourtPresent: true,
          q282RuntimeSmokeCourtPresent: true,
          q281PrivateArtifactLoadSmokePresent: true,
          q280NativeRuntimeBridgeGatePresent: true,
          q279DependencyTrialDefaultOffPresent: true,
          q278RealRuntimeEvidenceLockPresent: true,
          keyboardLayoutProtected: false,
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
          realFullCameraOcrRuntimeRegressionExecutedInQ286: false,
          realWorkspaceImportRuntimeExecutedInQ286: false,
          realImageToLatexInferenceExecutedInQ286: false,
          realRuntimeSmokeExecutedInQ286: false,
          realRuntimeInvocationExecutedInQ286: false,
          nativeRuntimeBridgeInvokedInQ286: false,
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
          fullCameraOcrRuntimeRegressionPassClaimed: false,
          workspaceImportRuntimePassClaimed: false,
          reviewBindingPassClaimed: false,
          imageToLatexPassClaimed: false,
          runtimeSmokePassClaimed: false,
          ocrPassClaimed: false,
          cameraOcrRuntimePassClaimed: false,
          premiumFinalPassClaimed: false,
          releasePassClaimed: false,
          regressionLabel: 'keyboard-regression',
        ),
      );
      expect(protectedResult.decision, GaussFullCameraOcrRuntimePremiumRegressionDecision.blockedProtectedSurfaceRegression);

      final autoSolveResult = GaussFullCameraOcrRuntimePremiumRegression.evaluate(
        const GaussFullCameraOcrRuntimePremiumRegressionInput(
          q285ApprovedWorkspaceImportRuntimeCourtPresent: true,
          q285ApprovedWorkspaceImportRuntimeCourtStaticReady: true,
          q284EditableMathLiveReviewRuntimeBindingPresent: true,
          q283ImageToLatexInferenceCourtPresent: true,
          q282RuntimeSmokeCourtPresent: true,
          q281PrivateArtifactLoadSmokePresent: true,
          q280NativeRuntimeBridgeGatePresent: true,
          q279DependencyTrialDefaultOffPresent: true,
          q278RealRuntimeEvidenceLockPresent: true,
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
          autoSolveAttempted: true,
          autoGraphAttempted: true,
          autoSolutionAttempted: false,
          autoHistoryAttempted: false,
          realFullCameraOcrRuntimeRegressionExecutedInQ286: false,
          realWorkspaceImportRuntimeExecutedInQ286: false,
          realImageToLatexInferenceExecutedInQ286: false,
          realRuntimeSmokeExecutedInQ286: false,
          realRuntimeInvocationExecutedInQ286: false,
          nativeRuntimeBridgeInvokedInQ286: false,
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
          fullCameraOcrRuntimeRegressionPassClaimed: false,
          workspaceImportRuntimePassClaimed: false,
          reviewBindingPassClaimed: false,
          imageToLatexPassClaimed: false,
          runtimeSmokePassClaimed: false,
          ocrPassClaimed: false,
          cameraOcrRuntimePassClaimed: false,
          premiumFinalPassClaimed: false,
          releasePassClaimed: false,
          regressionLabel: 'auto-solve-risk',
        ),
      );
      expect(autoSolveResult.decision, GaussFullCameraOcrRuntimePremiumRegressionDecision.blockedAutoEvaluateSolveGraphSolutionHistoryRisk);
    });

    test('can be built from Q285 court result and still blocks OCR execution', () {
      final q285Result = GaussApprovedOcrWorkspaceImportRuntimeCourt.evaluate(
        const GaussApprovedOcrWorkspaceImportRuntimeCourtInput(
          q284RealMathLiveReviewRuntimeBindingPresent: true,
          acceptedEditableMathLiveReviewDraftEvidence: true,
          editableReviewDraftPresent: true,
          reviewDraftMayBeEditedBeforeApproval: true,
          explicitUserApprovalReceived: true,
          approvedLatexDraft: r'x^2+1',
          workspaceImportPreparedOnlyAfterUserApproval: true,
          workspaceImportEnvelopePreservesReviewMetadata: true,
          workspaceImportEnvelopePreservesEngineMetadata: true,
          workspaceImportEnvelopePreservesImageInputMetadata: true,
          workspaceMutationRuntimeExecutionAttemptedInQ285: false,
          autoEvaluateAfterImport: false,
          autoSolveAfterImport: false,
          autoGraphAfterImport: false,
          autoSolutionAfterImport: false,
          autoHistoryAfterImport: false,
          manualSolveGraphAfterImportOnly: true,
          noRealWorkspaceImportRuntimeExecutedInQ285: true,
          noRealMathLiveReviewRuntimeBindingExecutedInQ285: true,
          noRealImageToLatexInferenceExecutedInQ285: true,
          noRealRuntimeInvocationExecutedInQ285: true,
          noNativeRuntimeBridgeInvokedInQ285: true,
          noPaddleRuntimeAdded: true,
          noPaddleOcrDependencyAdded: true,
          noNativeHandlerImplementationAdded: true,
          noJniBindingAdded: true,
          noMethodChannelRuntimeBindingAdded: true,
          noRuntimeDependencyAddedToPubspec: true,
          noGradleNativeRuntimeDependencyAdded: true,
          noModelBinaryBundledInBaseApp: true,
          noProductionModelUrlBound: true,
          noProductionDownloadEnabled: true,
          noRealNetworkDownloadWorkerImplemented: true,
          workspaceImportRuntimePassClaimed: false,
          ocrPassClaimed: false,
          releasePassClaimed: false,
          importLabel: 'q286-from-q285',
        ),
      );
      final q286Input = GaussFullCameraOcrRuntimePremiumRegressionInput.fromQ285Court(q285Result: q285Result);
      final result = GaussFullCameraOcrRuntimePremiumRegression.evaluate(q286Input);

      expect(q285Result.workspaceImportRuntimeCourtStaticReady, isTrue);
      expect(result.fullRegressionCourtStaticReady, isTrue);
      expect(result.canRunRealOcrInQ286, isFalse);
      expect(result.canMutateWorkspaceFromCameraInQ286, isFalse);
      expect(result.canClaimFullCameraOcrRuntimeRegressionPassInQ286, isFalse);
    });
  });
}
