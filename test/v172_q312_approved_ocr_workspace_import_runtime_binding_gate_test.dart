import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_approved_ocr_workspace_import_runtime_binding_gate.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_approved_ocr_workspace_import_runtime_binding_gate_policy.dart';

void main() {
  test('q312-workspace-import-binding-gate-is-static-default-off', () {
    final result = GaussApprovedOcrWorkspaceImportRuntimeBindingGate.evaluate(
      GaussApprovedOcrWorkspaceImportRuntimeBindingGateInput.q312Default(),
    );

    expect(result.phase, GaussApprovedOcrWorkspaceImportRuntimeBindingGatePolicy.phase);
    expect(result.sourcePhase, GaussApprovedOcrWorkspaceImportRuntimeBindingGatePolicy.sourcePhase);
    expect(result.contractStaticReady, isTrue);
    expect(result.workspaceImportBindingGateDefined, isTrue);
    expect(result.workspaceImportBindingDefaultOff, isTrue);
    expect(result.q311ReviewUiBindingGatePresent, isTrue);
    expect(result.q311RealEditableReviewOpened, isFalse);
    expect(result.q311RealUserApprovalCaptured, isFalse);
    expect(result.q311ApprovedReviewDraftEnvelopePresent, isFalse);
    expect(result.realWorkspaceImportExecuted, isFalse);
    expect(result.workspaceImportActuallyMutatedWorkspace, isFalse);
    expect(result.autoEvaluateEnabled, isFalse);
    expect(result.autoSolveGraphSolutionHistoryEnabled, isFalse);
    expect(result.solutionHistoryWriteEnabled, isFalse);
    expect(result.ocrPassClaimed, isFalse);
    expect(result.directSolveGraphSolutionHistoryBlocked, isTrue);
  });

  test('q312-must-not-accept-complete-workspace-import-evidence-inside-static-package', () {
    final result = GaussApprovedOcrWorkspaceImportRuntimeBindingGate.evaluate(
      const GaussApprovedOcrWorkspaceImportRuntimeBindingGateInput(
        q311ReviewUiBindingGatePresent: true,
        q311RealEditableReviewOpened: true,
        q311RealUserApprovalCaptured: true,
        q311ApprovedReviewDraftEnvelopePresent: true,
        approvedLatexDraftSanitized: true,
        reviewMetadataPreserved: true,
        engineMetadataPreserved: true,
        cropAndImageShaPreserved: true,
        explicitUserApprovalRequiredBeforeWorkspaceImport: true,
        defaultOffFeatureFlagPresent: true,
        realAndroidDeviceWorkspaceImportLogRequired: true,
        importRollbackPolicyPresent: true,
        importTimeoutPolicyPresent: true,
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
        nativeRuntimeDependencyAdded: false,
        methodChannelRuntimeBoundInsidePackage: false,
        jniNativeHandlerImplementedInsidePackage: false,
        productionDownloadEnabled: false,
        modelBinaryBundledInBaseApp: false,
        realPrivateArtifactLoaded: false,
        realRuntimeStartupExecuted: false,
        realDummyInputRuntimeCallExecuted: false,
        cameraImageSentToRuntime: false,
        realImageToLatexInferenceExecuted: false,
        runtimeLatexResponseParsed: false,
        realEditableMathLiveReviewOpened: false,
        realWorkspaceImportExecuted: false,
        workspaceImportActuallyMutatedWorkspace: false,
        autoEvaluateEnabled: false,
        autoSolveGraphSolutionHistoryEnabled: false,
        solutionHistoryWriteEnabled: false,
        workspaceImportPassClaimed: false,
        reviewBindingPassClaimed: false,
        runtimeIntegrationPassClaimed: false,
        ocrPassClaimed: false,
        cameraOcrRuntimePassClaimed: false,
        storeReadyPassClaimed: false,
        releasePassClaimed: false,
        trialLabel: 'complete-workspace-import-evidence-must-remain-external',
      ),
    );

    expect(result.contractStaticReady, isFalse);
    expect(
      result.rejectionReasons,
      contains('q312-must-not-accept-complete-workspace-import-evidence-inside-static-package'),
    );
  });

  test('q312-blocks-workspace-mutation-runtime-and-fake-pass-claims', () {
    final result = GaussApprovedOcrWorkspaceImportRuntimeBindingGate.evaluate(
      const GaussApprovedOcrWorkspaceImportRuntimeBindingGateInput(
        q311ReviewUiBindingGatePresent: true,
        q311RealEditableReviewOpened: false,
        q311RealUserApprovalCaptured: false,
        q311ApprovedReviewDraftEnvelopePresent: false,
        approvedLatexDraftSanitized: true,
        reviewMetadataPreserved: true,
        engineMetadataPreserved: true,
        cropAndImageShaPreserved: true,
        explicitUserApprovalRequiredBeforeWorkspaceImport: true,
        defaultOffFeatureFlagPresent: true,
        realAndroidDeviceWorkspaceImportLogRequired: true,
        importRollbackPolicyPresent: true,
        importTimeoutPolicyPresent: true,
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
        nativeRuntimeDependencyAdded: true,
        methodChannelRuntimeBoundInsidePackage: true,
        jniNativeHandlerImplementedInsidePackage: true,
        productionDownloadEnabled: false,
        modelBinaryBundledInBaseApp: false,
        realPrivateArtifactLoaded: true,
        realRuntimeStartupExecuted: true,
        realDummyInputRuntimeCallExecuted: true,
        cameraImageSentToRuntime: true,
        realImageToLatexInferenceExecuted: true,
        runtimeLatexResponseParsed: true,
        realEditableMathLiveReviewOpened: true,
        realWorkspaceImportExecuted: true,
        workspaceImportActuallyMutatedWorkspace: true,
        autoEvaluateEnabled: true,
        autoSolveGraphSolutionHistoryEnabled: true,
        solutionHistoryWriteEnabled: true,
        workspaceImportPassClaimed: true,
        reviewBindingPassClaimed: true,
        runtimeIntegrationPassClaimed: true,
        ocrPassClaimed: true,
        cameraOcrRuntimePassClaimed: false,
        storeReadyPassClaimed: false,
        releasePassClaimed: false,
        trialLabel: 'forbidden-workspace-import-runtime-mutation',
      ),
    );

    expect(result.contractStaticReady, isFalse);
    expect(
      result.rejectionReasons,
      contains('workspace-import-or-runtime-mutation-forbidden-in-q312'),
    );
    expect(result.rejectionReasons, contains('fake-pass-claim-forbidden'));
  });
}
