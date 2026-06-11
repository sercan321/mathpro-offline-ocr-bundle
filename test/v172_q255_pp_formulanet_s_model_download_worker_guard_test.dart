import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_pp_formulanet_s_model_download_worker_guard.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_pp_formulanet_s_model_download_worker_guard_policy.dart';

// Q255 dependency sentinels: camera: 0.10.6, camera_android: 0.10.9+3, AGP: 8.6.1
void main() {
  group('V172-Q255 PP-FormulaNet-S model download worker guard', () {
    const readyInput = GaussPpFormulaNetSModelDownloadWorkerGuardInput(
      officialSourceEvidenceVerified: true,
      expectedSha256RecordedBeforeDownload: true,
      actualSha256VerificationPlannedAfterDownload: true,
      downloadsIntoTemporaryPrivateFile: true,
      atomicMoveOnlyAfterChecksumPass: true,
      partialDownloadCleanupPlanned: true,
      corruptArtifactCleanupPlanned: true,
      neverUseUnverifiedModel: true,
      offlineAfterInstallReadyStatePlanned: true,
      networkPolicyRequiresUserConsentOrWifi: true,
      noModelBinaryBundledInBaseApp: true,
      noProductionModelUrlBound: true,
      noRealNetworkDownloadWorkerImplemented: true,
      noPaddleRuntimeDependencyAdded: true,
      noProductionInferenceAllowed: true,
      mathLiveReviewAndUserApprovalRequired: true,
      noDirectSolveGraphSolutionHistoryFromCamera: true,
      guardLabel: 'q255-download-worker-guard-only',
    );

    test('records PP-FormulaNet-S model download worker guard without real downloader', () {
      expect(GaussPpFormulaNetSModelDownloadWorkerGuardPolicy.phase, 'V172-Q255-PP-FORMULANET-S-MODEL-DOWNLOAD-WORKER-GUARD');
      expect(GaussPpFormulaNetSModelDownloadWorkerGuardPolicy.sourcePhase, 'V172-Q254-PP-FORMULANET-S-RUNTIME-SOURCE-EVIDENCE-GATE');
      expect(GaussPpFormulaNetSModelDownloadWorkerGuardPolicy.selectedEngineLabel, 'PP-FormulaNet-S');
      expect(GaussPpFormulaNetSModelDownloadWorkerGuardPolicy.fallbackEngineLabel, 'PP-FormulaNet_plus-L');
      expect(GaussPpFormulaNetSModelDownloadWorkerGuardPolicy.modelBinaryBundledInBaseApp, isFalse);
      expect(GaussPpFormulaNetSModelDownloadWorkerGuardPolicy.productionModelUrlBound, isFalse);
      expect(GaussPpFormulaNetSModelDownloadWorkerGuardPolicy.realNetworkDownloadWorkerImplemented, isFalse);
      expect(GaussPpFormulaNetSModelDownloadWorkerGuardPolicy.productionInferenceAllowed, isFalse);
      expect(GaussPpFormulaNetSModelDownloadWorkerGuardPolicy.expectedSha256RequiredBeforeDownload, isTrue);
      expect(GaussPpFormulaNetSModelDownloadWorkerGuardPolicy.actualSha256RequiredAfterDownload, isTrue);
      expect(GaussPpFormulaNetSModelDownloadWorkerGuardPolicy.atomicMoveAfterVerifyRequired, isTrue);
      expect(GaussPpFormulaNetSModelDownloadWorkerGuardPolicy.corruptDownloadCleanupRequired, isTrue);
      expect(GaussPpFormulaNetSModelDownloadWorkerGuardPolicy.directSolveFromCameraAllowed, isFalse);
    });

    test('passes only when checksum, private storage, cleanup, offline, and review guards are intact', () {
      final result = GaussPpFormulaNetSModelDownloadWorkerGuard.evaluate(readyInput);

      expect(result.decision, GaussPpFormulaNetSModelDownloadWorkerGuardDecision.modelDownloadWorkerGuardStaticReady);
      expect(result.modelDownloadWorkerGuardStaticReady, isTrue);
      expect(result.installStates, containsAll(<String>['notInstalled', 'queued', 'downloading', 'verifying', 'ready', 'failed', 'updateAvailable', 'disabledByUser']));
      expect(result.requiredWorkerSafetyGates, contains('atomicMoveOnlyAfterChecksumPass'));
      expect(result.realOcrRuntimeAdded, isFalse);
      expect(result.paddleRuntimeAdded, isFalse);
      expect(result.modelBinaryBundledInBaseApp, isFalse);
      expect(result.productionModelUrlBound, isFalse);
      expect(result.realNetworkDownloadWorkerImplemented, isFalse);
      expect(result.productionInferenceAllowed, isFalse);
      expect(result.editableMathLiveReviewRequired, isTrue);
      expect(result.userApprovalRequiredBeforeWorkspaceImport, isTrue);
      expect(result.canClaimModelDownloadPass, isFalse);
      expect(result.canClaimOcrPass, isFalse);
      expect(result.canRunPpFormulaNetSInference, isFalse);
      expect(result.canUseUnverifiedDownloadedModel, isFalse);
      expect(result.canBindProductionModelUrlWithoutChecksum, isFalse);
      expect(result.canImportCameraOutputWithoutUserApproval, isFalse);
    });

    test('blocks missing source, checksum, storage, cleanup, network, unsafe binding, and review regressions', () {
      expect(
        GaussPpFormulaNetSModelDownloadWorkerGuard.evaluate(
          const GaussPpFormulaNetSModelDownloadWorkerGuardInput(
            officialSourceEvidenceVerified: false,
            expectedSha256RecordedBeforeDownload: true,
            actualSha256VerificationPlannedAfterDownload: true,
            downloadsIntoTemporaryPrivateFile: true,
            atomicMoveOnlyAfterChecksumPass: true,
            partialDownloadCleanupPlanned: true,
            corruptArtifactCleanupPlanned: true,
            neverUseUnverifiedModel: true,
            offlineAfterInstallReadyStatePlanned: true,
            networkPolicyRequiresUserConsentOrWifi: true,
            noModelBinaryBundledInBaseApp: true,
            noProductionModelUrlBound: true,
            noRealNetworkDownloadWorkerImplemented: true,
            noPaddleRuntimeDependencyAdded: true,
            noProductionInferenceAllowed: true,
            mathLiveReviewAndUserApprovalRequired: true,
            noDirectSolveGraphSolutionHistoryFromCamera: true,
            guardLabel: 'missing-source',
          ),
        ).decision,
        GaussPpFormulaNetSModelDownloadWorkerGuardDecision.blockedMissingOfficialSourceEvidence,
      );

      expect(
        GaussPpFormulaNetSModelDownloadWorkerGuard.evaluate(readyInput.copyForTest(expectedSha256RecordedBeforeDownload: false)).decision,
        GaussPpFormulaNetSModelDownloadWorkerGuardDecision.blockedMissingChecksumPlan,
      );
      expect(
        GaussPpFormulaNetSModelDownloadWorkerGuard.evaluate(readyInput.copyForTest(atomicMoveOnlyAfterChecksumPass: false)).decision,
        GaussPpFormulaNetSModelDownloadWorkerGuardDecision.blockedUnsafeStoragePlan,
      );
      expect(
        GaussPpFormulaNetSModelDownloadWorkerGuard.evaluate(readyInput.copyForTest(corruptArtifactCleanupPlanned: false)).decision,
        GaussPpFormulaNetSModelDownloadWorkerGuardDecision.blockedMissingCleanupPlan,
      );
      expect(
        GaussPpFormulaNetSModelDownloadWorkerGuard.evaluate(readyInput.copyForTest(networkPolicyRequiresUserConsentOrWifi: false)).decision,
        GaussPpFormulaNetSModelDownloadWorkerGuardDecision.blockedMissingNetworkPolicy,
      );
      expect(
        GaussPpFormulaNetSModelDownloadWorkerGuard.evaluate(readyInput.copyForTest(noProductionModelUrlBound: false)).decision,
        GaussPpFormulaNetSModelDownloadWorkerGuardDecision.blockedUnsafeRuntimeBindingAttempt,
      );
      expect(
        GaussPpFormulaNetSModelDownloadWorkerGuard.evaluate(readyInput.copyForTest(mathLiveReviewAndUserApprovalRequired: false)).decision,
        GaussPpFormulaNetSModelDownloadWorkerGuardDecision.blockedMissingMathLiveReviewSafety,
      );
    });

    test('keeps app dependencies, production runtime, and base APK clean', () {
      final pubspec = File('pubspec.yaml').readAsStringSync();
      final settings = File('android/settings.gradle').readAsStringSync();
      final prodBridge = File('assets/mathlive/mathlive_prod_bridge.js').readAsStringSync();

      expect(pubspec, contains('camera: 0.10.6'));
      expect(pubspec, contains('camera_android: 0.10.9+3'));
      expect(pubspec, isNot(contains('camera_android_camerax')));
      expect(pubspec.toLowerCase(), isNot(contains('google_mlkit_text_recognition')));
      expect(pubspec.toLowerCase(), isNot(contains('paddleocr')));
      expect(pubspec.toLowerCase(), isNot(contains('paddle_flutter')));
      expect(pubspec.toLowerCase(), isNot(contains('onnxruntime')));
      expect(pubspec.toLowerCase(), isNot(contains('flutter_downloader')));
      expect(settings, contains("id 'com.android.application' version '8.6.1' apply false"));
      expect(settings, contains("id 'org.jetbrains.kotlin.android' version '2.1.0' apply false"));
      expect(prodBridge, isNot(contains('FormulaRecognition(')));
      expect(prodBridge, isNot(contains('runPpFormulaNetSInference')));
      expect(prodBridge, isNot(contains('setWorkspaceLatexWithoutUserApproval')));
    });
  });
}

extension on GaussPpFormulaNetSModelDownloadWorkerGuardInput {
  GaussPpFormulaNetSModelDownloadWorkerGuardInput copyForTest({
    bool? officialSourceEvidenceVerified,
    bool? expectedSha256RecordedBeforeDownload,
    bool? actualSha256VerificationPlannedAfterDownload,
    bool? downloadsIntoTemporaryPrivateFile,
    bool? atomicMoveOnlyAfterChecksumPass,
    bool? partialDownloadCleanupPlanned,
    bool? corruptArtifactCleanupPlanned,
    bool? neverUseUnverifiedModel,
    bool? offlineAfterInstallReadyStatePlanned,
    bool? networkPolicyRequiresUserConsentOrWifi,
    bool? noModelBinaryBundledInBaseApp,
    bool? noProductionModelUrlBound,
    bool? noRealNetworkDownloadWorkerImplemented,
    bool? noPaddleRuntimeDependencyAdded,
    bool? noProductionInferenceAllowed,
    bool? mathLiveReviewAndUserApprovalRequired,
    bool? noDirectSolveGraphSolutionHistoryFromCamera,
    String? guardLabel,
  }) {
    return GaussPpFormulaNetSModelDownloadWorkerGuardInput(
      officialSourceEvidenceVerified: officialSourceEvidenceVerified ?? this.officialSourceEvidenceVerified,
      expectedSha256RecordedBeforeDownload: expectedSha256RecordedBeforeDownload ?? this.expectedSha256RecordedBeforeDownload,
      actualSha256VerificationPlannedAfterDownload: actualSha256VerificationPlannedAfterDownload ?? this.actualSha256VerificationPlannedAfterDownload,
      downloadsIntoTemporaryPrivateFile: downloadsIntoTemporaryPrivateFile ?? this.downloadsIntoTemporaryPrivateFile,
      atomicMoveOnlyAfterChecksumPass: atomicMoveOnlyAfterChecksumPass ?? this.atomicMoveOnlyAfterChecksumPass,
      partialDownloadCleanupPlanned: partialDownloadCleanupPlanned ?? this.partialDownloadCleanupPlanned,
      corruptArtifactCleanupPlanned: corruptArtifactCleanupPlanned ?? this.corruptArtifactCleanupPlanned,
      neverUseUnverifiedModel: neverUseUnverifiedModel ?? this.neverUseUnverifiedModel,
      offlineAfterInstallReadyStatePlanned: offlineAfterInstallReadyStatePlanned ?? this.offlineAfterInstallReadyStatePlanned,
      networkPolicyRequiresUserConsentOrWifi: networkPolicyRequiresUserConsentOrWifi ?? this.networkPolicyRequiresUserConsentOrWifi,
      noModelBinaryBundledInBaseApp: noModelBinaryBundledInBaseApp ?? this.noModelBinaryBundledInBaseApp,
      noProductionModelUrlBound: noProductionModelUrlBound ?? this.noProductionModelUrlBound,
      noRealNetworkDownloadWorkerImplemented: noRealNetworkDownloadWorkerImplemented ?? this.noRealNetworkDownloadWorkerImplemented,
      noPaddleRuntimeDependencyAdded: noPaddleRuntimeDependencyAdded ?? this.noPaddleRuntimeDependencyAdded,
      noProductionInferenceAllowed: noProductionInferenceAllowed ?? this.noProductionInferenceAllowed,
      mathLiveReviewAndUserApprovalRequired: mathLiveReviewAndUserApprovalRequired ?? this.mathLiveReviewAndUserApprovalRequired,
      noDirectSolveGraphSolutionHistoryFromCamera: noDirectSolveGraphSolutionHistoryFromCamera ?? this.noDirectSolveGraphSolutionHistoryFromCamera,
      guardLabel: guardLabel ?? this.guardLabel,
    );
  }
}
