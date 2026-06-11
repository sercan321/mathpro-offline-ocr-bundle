import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_runtime_dependency_real_trial_default_off.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_runtime_dependency_real_trial_default_off_policy.dart';

void main() {
  group('V172-Q303 Runtime Dependency Real Trial Default-Off', () {
    test('defines default-off real dependency trial while keeping pubspec and runtime untouched', () {
      final result = GaussRuntimeDependencyRealTrialDefaultOff.evaluate(
        GaussRuntimeDependencyRealTrialDefaultOffInput.q303Default(),
      );

      expect(result.phase, GaussRuntimeDependencyRealTrialDefaultOffPolicy.phase);
      expect(result.sourcePhase, GaussRuntimeDependencyRealTrialDefaultOffPolicy.sourcePhase);
      expect(result.selectedEngineLabel, 'PP-FormulaNet-S');
      expect(result.dependencyTrialFeatureFlag, 'gauss.ppFormulaNetS.runtimeDependencyRealTrial.defaultOff');
      expect(result.dependencyTrialMode, 'real-dependency-trial-gate-default-off-no-pubspec-mutation');
      expect(result.decision, GaussRuntimeDependencyRealTrialDefaultOffDecision.realDependencyTrialGateDefinedDefaultOff);
      expect(result.contractStaticReady, isTrue);
      expect(result.rejectionReasons, isEmpty);
      expect(result.runtimeDependencyTrialDefined, isTrue);
      expect(result.runtimeDependencyTrialDefaultOff, isTrue);
      expect(result.requiredBeforeRealDependencyAdd, contains('q302-expected-actual-sha256-match'));
      expect(result.requiredBeforeRealDependencyAdd, contains('runtime-library-candidate-name-version-source'));
      expect(result.requiredBeforeRealDependencyAdd, contains('rollback-plan'));
      expect(result.protectedSurfaceMarkers, contains('keyboard-layout-preserved'));
      expect(result.protectedSurfaceMarkers, contains('mathlive-production-route-preserved'));
      expect(result.forbiddenActions, contains('mutatePubspecInQ303'));
      expect(result.forbiddenActions, contains('addPaddleRuntimeDependencyWithoutQ302Sha'));
      expect(result.pubspecChanged, isFalse);
      expect(result.runtimeDependencyActuallyAdded, isFalse);
      expect(result.paddleRuntimeAdded, isFalse);
      expect(result.paddleOcrDependencyAdded, isFalse);
      expect(result.methodChannelRuntimeBindingAdded, isFalse);
      expect(result.nativeRuntimeHandlerImplemented, isFalse);
      expect(result.modelBinaryBundledInBaseApp, isFalse);
      expect(result.productionDownloadEnabled, isFalse);
      expect(result.realImageToLatexInferenceExecuted, isFalse);
      expect(result.reviewBeforeImportRequired, isTrue);
      expect(result.explicitUserApprovalRequired, isTrue);
      expect(result.directSolveGraphSolutionHistoryBlocked, isTrue);
      expect(result.runtimeDependencyPassClaimed, isFalse);
      expect(result.ocrPassClaimed, isFalse);
      expect(result.cameraOcrRuntimePassClaimed, isFalse);
      expect(result.releasePassClaimed, isFalse);
    });

    test('blocks dependency addition when Q302 SHA/runtime/ABI/license evidence is incomplete', () {
      const input = GaussRuntimeDependencyRealTrialDefaultOffInput(
        q302ArtifactUrlShaLockPresent: true,
        q302ExpectedSha256: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
        q302ActualSha256: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
        q302ExpectedSha256Verified: true,
        q302ActualSha256Computed: true,
        artifactAcceptedForRuntime: true,
        runtimeLibraryCandidateEvidencePresent: true,
        licenseCompatibilityReviewed: true,
        androidAbiMatrixPresent: true,
        apkSizeDeltaBudgetReviewed: true,
        ramLatencyBudgetReviewed: true,
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
        runtimeDependencyActuallyAdded: false,
        paddleRuntimeAdded: false,
        paddleOcrDependencyAdded: false,
        onnxRuntimeAdded: false,
        tfliteRuntimeAdded: false,
        jniBindingAdded: false,
        methodChannelRuntimeBindingAdded: false,
        nativeRuntimeHandlerImplemented: false,
        modelBinaryBundledInBaseApp: false,
        productionDownloadEnabled: false,
        realPrivateArtifactLoaded: false,
        realRuntimeStartupExecuted: false,
        realImageToLatexInferenceExecuted: false,
        realEditableMathLiveReviewOpened: false,
        realWorkspaceImportExecuted: false,
        runtimeDependencyPassClaimed: false,
        ocrPassClaimed: false,
        cameraOcrRuntimePassClaimed: false,
        storeReadyPassClaimed: false,
        releasePassClaimed: false,
        trialLabel: 'bad-premature-evidence-acceptance',
      );

      final result = GaussRuntimeDependencyRealTrialDefaultOff.evaluate(input);
      expect(result.contractStaticReady, isFalse);
      expect(result.decision, GaussRuntimeDependencyRealTrialDefaultOffDecision.blockedMissingShaRuntimeAbiLicenseEvidence);
      expect(result.rejectionReasons, contains('real-runtime-dependency-evidence-not-complete-for-q303'));
    });

    test('blocks pubspec/runtime mutation and fake PASS claims', () {
      const input = GaussRuntimeDependencyRealTrialDefaultOffInput(
        q302ArtifactUrlShaLockPresent: true,
        q302ExpectedSha256: 'PENDING_CONTROLLED_DOWNLOAD_HASH_VERIFICATION',
        q302ActualSha256: 'NOT_DOWNLOADED_IN_Q302',
        q302ExpectedSha256Verified: false,
        q302ActualSha256Computed: false,
        artifactAcceptedForRuntime: false,
        runtimeLibraryCandidateEvidencePresent: false,
        licenseCompatibilityReviewed: false,
        androidAbiMatrixPresent: false,
        apkSizeDeltaBudgetReviewed: false,
        ramLatencyBudgetReviewed: false,
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
        runtimeDependencyActuallyAdded: true,
        paddleRuntimeAdded: true,
        paddleOcrDependencyAdded: true,
        onnxRuntimeAdded: false,
        tfliteRuntimeAdded: false,
        jniBindingAdded: true,
        methodChannelRuntimeBindingAdded: true,
        nativeRuntimeHandlerImplemented: true,
        modelBinaryBundledInBaseApp: true,
        productionDownloadEnabled: true,
        realPrivateArtifactLoaded: true,
        realRuntimeStartupExecuted: true,
        realImageToLatexInferenceExecuted: true,
        realEditableMathLiveReviewOpened: true,
        realWorkspaceImportExecuted: true,
        runtimeDependencyPassClaimed: true,
        ocrPassClaimed: true,
        cameraOcrRuntimePassClaimed: true,
        storeReadyPassClaimed: false,
        releasePassClaimed: true,
        trialLabel: 'forbidden-runtime-mutation',
      );

      final result = GaussRuntimeDependencyRealTrialDefaultOff.evaluate(input);
      expect(result.contractStaticReady, isFalse);
      expect(result.rejectionReasons, contains('runtime-dependency-or-runtime-mutation-forbidden-in-q303'));
      expect(result.rejectionReasons, contains('fake-pass-claim-forbidden'));
    });
  });
}
