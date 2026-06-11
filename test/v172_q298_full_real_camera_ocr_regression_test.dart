import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_approved_ocr_workspace_import_real_runtime.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_full_real_camera_ocr_regression.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_full_real_camera_ocr_regression_policy.dart';

void main() {
  group('V172-Q298 full real Camera/OCR regression', () {
    const readyInput = GaussFullRealCameraOcrRegressionInput(
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
      regressionLabel: 'q298-full-real-camera-ocr-regression',
    );

    test('is static-ready only and refuses real OCR/runtime/PASS claims', () {
      final result = GaussFullRealCameraOcrRegression.evaluate(readyInput);

      expect(result.phase, GaussFullRealCameraOcrRegressionPolicy.phase);
      expect(result.sourcePhase, 'V172-Q297-APPROVED-OCR-WORKSPACE-IMPORT-REAL-RUNTIME');
      expect(result.selectedEngineLabel, 'PP-FormulaNet-S');
      expect(result.regressionFeatureFlag, 'gauss.ppFormulaNetS.fullRealCameraOcrRegression.defaultOff');
      expect(result.fullRegressionCourtStaticReady, isTrue);
      expect(result.readyForFutureFullRuntimeRegressionEvidenceOnly, isTrue);
      expect(result.decision, GaussFullRealCameraOcrRegressionDecision.fullRegressionContractReadyRealRuntimeBlocked);
      expect(result.canRunRealOcrInQ298, isFalse);
      expect(result.canMutateWorkspaceFromCameraInQ298, isFalse);
      expect(result.canEvaluateFromCameraInQ298, isFalse);
      expect(result.canSolveFromCameraInQ298, isFalse);
      expect(result.canGraphFromCameraInQ298, isFalse);
      expect(result.canWriteSolutionOrHistoryFromCameraInQ298, isFalse);
      expect(result.canClaimFullCameraOcrRegressionPassInQ298, isFalse);
      expect(result.canClaimOcrPassInQ298, isFalse);
      expect(result.requiredRegressionGates, contains('q297-approved-ocr-workspace-import-contract-present'));
      expect(result.requiredRegressionGates, contains('no-auto-evaluate-solve-graph-solution-history'));
      expect(result.regressionCourtCases, contains('keyboard-more-longpress-regression-guard'));
      expect(result.blockedUntilRealEvidence, contains('real-flutter-run-device-log'));
      expect(result.forbiddenActions, contains('autoSolveCameraOutput'));
      expect(result.ocrPassClaimed, isFalse);
      expect(result.releasePassClaimed, isFalse);
    });

    test('can derive a safe Q298 input from the Q297 contract result', () {
      final q297Result = GaussApprovedOcrWorkspaceImportRealRuntime.evaluateContract();
      final result = GaussFullRealCameraOcrRegression.evaluate(
        GaussFullRealCameraOcrRegressionInput.fromQ297Contract(q297Result: q297Result),
      );

      expect(q297Result.realWorkspaceImportRuntimeExecuted, isFalse);
      expect(result.fullRegressionCourtStaticReady, isTrue);
      expect(result.fullRealCameraOcrRegressionExecuted, isFalse);
      expect(result.realWorkspaceImportRuntimeExecuted, isFalse);
      expect(result.realImageToLatexInferenceExecuted, isFalse);
      expect(result.methodChannelRuntimeBindingAdded, isFalse);
      expect(result.modelBinaryBundledInBaseApp, isFalse);
      expect(result.productionDownloadEnabled, isFalse);
    });

    test('blocks missing Q297 approved workspace import chain', () {
      final result = GaussFullRealCameraOcrRegression.evaluate(
        const GaussFullRealCameraOcrRegressionInput(
          q297ApprovedWorkspaceImportPresent: false,
          q297ApprovedWorkspaceImportStaticReady: false,
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
          regressionLabel: 'missing-q297',
        ),
      );

      expect(result.fullRegressionCourtStaticReady, isFalse);
      expect(result.decision, GaussFullRealCameraOcrRegressionDecision.blockedMissingQ297ApprovedWorkspaceImport);
      expect(result.rejectionReasons, contains('missingQ297ApprovedOcrWorkspaceImportRealRuntime'));
    });

    test('policy keeps dependency/runtime/download/workspace side effects blocked', () {
      expect(GaussFullRealCameraOcrRegressionPolicy.fullRealCameraOcrRegressionExecuted, isFalse);
      expect(GaussFullRealCameraOcrRegressionPolicy.realImageToLatexInferenceExecuted, isFalse);
      expect(GaussFullRealCameraOcrRegressionPolicy.methodChannelRuntimeBindingAdded, isFalse);
      expect(GaussFullRealCameraOcrRegressionPolicy.paddleRuntimeAdded, isFalse);
      expect(GaussFullRealCameraOcrRegressionPolicy.paddleOcrDependencyAdded, isFalse);
      expect(GaussFullRealCameraOcrRegressionPolicy.modelBinaryBundledInBaseApp, isFalse);
      expect(GaussFullRealCameraOcrRegressionPolicy.productionDownloadEnabled, isFalse);
      expect(GaussFullRealCameraOcrRegressionPolicy.directWorkspaceImportEnabled, isFalse);
      expect(GaussFullRealCameraOcrRegressionPolicy.autoEvaluateEnabled, isFalse);
      expect(GaussFullRealCameraOcrRegressionPolicy.autoSolveGraphSolutionHistoryEnabled, isFalse);
      expect(GaussFullRealCameraOcrRegressionPolicy.ocrPassClaimed, isFalse);
      expect(GaussFullRealCameraOcrRegressionPolicy.cameraOcrRuntimePassClaimed, isFalse);
      expect(GaussFullRealCameraOcrRegressionPolicy.releasePassClaimed, isFalse);
      expect(GaussFullRealCameraOcrRegressionPolicy.requiresUserSideRetest, contains('flutter test'));
    });
  });
}
