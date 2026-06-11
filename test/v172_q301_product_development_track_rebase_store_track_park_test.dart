import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_product_development_track_rebase_store_track_park.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_product_development_track_rebase_store_track_park_policy.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_release_candidate_freeze.dart';

void main() {
  group('V172-Q301 Product Development Track Rebase / Store Track Park', () {
    test('parks store work and reactivates product/OCR runtime development without PASS claims', () {
      const input = GaussProductDevelopmentTrackRebaseStoreTrackParkInput(
        q300ReleaseCandidateFreezePresent: true,
        q300ReleaseCandidateFreezeStaticReady: true,
        storeTrackParked: true,
        playStorePreparationParked: true,
        releaseCandidateFreezePreservedAsHistoricalAuditOnly: true,
        productDevelopmentTrackActive: true,
        realOcrRuntimeTrackActive: true,
        premiumUiUxTrackActive: true,
        deviceQaTrackActive: true,
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
        storeSubmissionPerformed: false,
        playConsoleConfigured: false,
        privacyPolicyWritten: false,
        dataSafetyFormCompleted: false,
        releaseAabCreated: false,
        releaseApkCreated: false,
        productionReleaseCreated: false,
        storeListingAssetsCreated: false,
        localizedStoreListingsCreated: false,
        paddleRuntimeAdded: false,
        paddleOcrDependencyAdded: false,
        jniBindingAdded: false,
        methodChannelRuntimeBindingAdded: false,
        nativeRuntimeHandlerImplemented: false,
        modelBinaryBundledInBaseApp: false,
        productionDownloadEnabled: false,
        realImageToLatexInferenceExecuted: false,
        realWorkspaceImportExecuted: false,
        autoEvaluateEnabled: false,
        autoSolveGraphSolutionHistoryEnabled: false,
        flutterAnalyzePassClaimed: false,
        flutterTestPassClaimed: false,
        flutterRunPassClaimed: false,
        androidRealDevicePassClaimed: false,
        ocrPassClaimed: false,
        cameraOcrRuntimePassClaimed: false,
        storeReadyPassClaimed: false,
        releasePassClaimed: false,
        premiumFinalPassClaimed: false,
        rebaseLabel: 'q301-product-development-rebase-test',
      );

      final result = GaussProductDevelopmentTrackRebaseStoreTrackPark.evaluate(input);

      expect(result.phase, GaussProductDevelopmentTrackRebaseStoreTrackParkPolicy.phase);
      expect(result.sourcePhase, GaussProductDevelopmentTrackRebaseStoreTrackParkPolicy.sourcePhase);
      expect(result.developmentTrackFeatureFlag, 'gauss.productDevelopment.track.rebase.defaultOff');
      expect(result.contractStaticReady, isTrue);
      expect(result.decision, GaussProductDevelopmentTrackRebaseStoreTrackParkDecision.productDevelopmentTrackRebasedStoreTrackParked);
      expect(result.rejectionReasons, isEmpty);
      expect(result.storeTrackParked, isTrue);
      expect(result.playStorePreparationParked, isTrue);
      expect(result.productDevelopmentTrackActive, isTrue);
      expect(result.realOcrRuntimeTrackActive, isTrue);
      expect(result.parkedStoreTopics, contains('play-store-listing'));
      expect(result.parkedStoreTopics, contains('release-aab-apk'));
      expect(result.activeProductTracks, contains('real-pp-formulanet-s-runtime-source-and-sha-lock'));
      expect(result.activeProductTracks, contains('mathlive-input-caret-latency-device-quality'));
      expect(result.protectedSurfaceMarkers, contains('keyboard-layout-preserved'));
      expect(result.protectedSurfaceMarkers, contains('mathlive-production-route-preserved'));
      expect(result.forbiddenActions, contains('startPlayStorePreparationInQ301'));
      expect(result.forbiddenActions, contains('runImageToLatexInferenceInQ301'));
      expect(result.canStartPlayStorePreparationInQ301, isFalse);
      expect(result.canBuildReleaseAabInQ301, isFalse);
      expect(result.canAddRuntimeDependencyInQ301, isFalse);
      expect(result.canBindNativeRuntimeInQ301, isFalse);
      expect(result.canRunImageToLatexInferenceInQ301, isFalse);
      expect(result.canAutoSolveCameraOutputInQ301, isFalse);
      expect(result.storeReadyPassClaimed, isFalse);
      expect(result.releasePassClaimed, isFalse);
      expect(result.ocrPassClaimed, isFalse);
    });

    test('can derive a safe Q301 input from the Q300 freeze contract', () {
      const q300Result = GaussReleaseCandidateFreezeResult(
        phase: 'V172-Q300-RELEASE-CANDIDATE-FREEZE',
        sourcePhase: 'V172-Q299-STORE-RELEASE-CANDIDATE-AUDIT',
        selectedEngineLabel: 'PP-FormulaNet-S',
        freezeFeatureFlag: 'gauss.releaseCandidate.freeze.defaultOff',
        freezeReadinessState: 'FROZEN_PENDING_REAL_FLUTTER_ANDROID_PLAY_CONSOLE_PRIVACY_DATA_SAFETY_AND_OCR_RUNTIME_EVIDENCE',
        freezeContractStaticReady: true,
        readyForFutureReleaseEvidenceOnly: true,
        decision: GaussReleaseCandidateFreezeDecision.releaseCandidateFreezeContractReadyReleaseBlocked,
        rejectionReasons: <String>[],
        requiredFreezeGates: <String>[],
        releaseFreezeCourtCases: <String>[],
        blockedUntilRealEvidence: <String>[],
        forbiddenActions: <String>[],
        storeSubmissionPerformed: false,
        playConsoleConfigured: false,
        productionReleaseCreated: false,
        releaseAabCreated: false,
        releaseApkCreated: false,
        methodChannelRuntimeBindingAdded: false,
        modelBinaryBundledInBaseApp: false,
        productionDownloadEnabled: false,
        releaseCandidateFreezePassClaimed: false,
        storeReadyPassClaimed: false,
        releasePassClaimed: false,
        ocrPassClaimed: false,
        cameraOcrRuntimePassClaimed: false,
        freezeLabel: 'q300-for-q301-test',
      );

      final result = GaussProductDevelopmentTrackRebaseStoreTrackPark.evaluate(
        GaussProductDevelopmentTrackRebaseStoreTrackParkInput.fromQ300Freeze(q300Result: q300Result),
      );

      expect(result.contractStaticReady, isTrue);
      expect(result.storeTrackParked, isTrue);
      expect(result.productDevelopmentTrackActive, isTrue);
      expect(result.realOcrRuntimeTrackActive, isTrue);
      expect(result.storeSubmissionPerformed, isFalse);
      expect(result.productionReleaseCreated, isFalse);
      expect(result.paddleRuntimeAdded, isFalse);
      expect(result.methodChannelRuntimeBindingAdded, isFalse);
      expect(result.nativeRuntimeHandlerImplemented, isFalse);
      expect(result.productionDownloadEnabled, isFalse);
      expect(result.releasePassClaimed, isFalse);
      expect(result.ocrPassClaimed, isFalse);
    });

    test('blocks store continuation, runtime mutation, and fake evidence claims', () {
      const input = GaussProductDevelopmentTrackRebaseStoreTrackParkInput(
        q300ReleaseCandidateFreezePresent: true,
        q300ReleaseCandidateFreezeStaticReady: true,
        storeTrackParked: true,
        playStorePreparationParked: true,
        releaseCandidateFreezePreservedAsHistoricalAuditOnly: true,
        productDevelopmentTrackActive: true,
        realOcrRuntimeTrackActive: true,
        premiumUiUxTrackActive: true,
        deviceQaTrackActive: true,
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
        storeSubmissionPerformed: true,
        playConsoleConfigured: false,
        privacyPolicyWritten: false,
        dataSafetyFormCompleted: false,
        releaseAabCreated: false,
        releaseApkCreated: false,
        productionReleaseCreated: false,
        storeListingAssetsCreated: false,
        localizedStoreListingsCreated: false,
        paddleRuntimeAdded: false,
        paddleOcrDependencyAdded: false,
        jniBindingAdded: false,
        methodChannelRuntimeBindingAdded: true,
        nativeRuntimeHandlerImplemented: false,
        modelBinaryBundledInBaseApp: false,
        productionDownloadEnabled: false,
        realImageToLatexInferenceExecuted: false,
        realWorkspaceImportExecuted: false,
        autoEvaluateEnabled: false,
        autoSolveGraphSolutionHistoryEnabled: false,
        flutterAnalyzePassClaimed: false,
        flutterTestPassClaimed: false,
        flutterRunPassClaimed: false,
        androidRealDevicePassClaimed: false,
        ocrPassClaimed: true,
        cameraOcrRuntimePassClaimed: false,
        storeReadyPassClaimed: false,
        releasePassClaimed: false,
        premiumFinalPassClaimed: false,
        rebaseLabel: 'q301-block-test',
      );

      final result = GaussProductDevelopmentTrackRebaseStoreTrackPark.evaluate(input);

      expect(result.contractStaticReady, isFalse);
      expect(result.rejectionReasons, contains('storeWorkStillActive'));
      expect(result.rejectionReasons, contains('runtimeMutationAttempted'));
      expect(result.rejectionReasons, contains('fakePassClaim'));
      expect(result.decision, GaussProductDevelopmentTrackRebaseStoreTrackParkDecision.blockedStoreWorkStillActive);
    });
  });
}
