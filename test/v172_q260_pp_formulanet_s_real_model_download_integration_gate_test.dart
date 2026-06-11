import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_pp_formulanet_s_real_model_download_integration_gate.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_pp_formulanet_s_real_model_download_integration_gate_policy.dart';

void main() {
  group('V172-Q260 PP-FormulaNet-S real model download integration gate', () {
    const readyInput = GaussPpFormulaNetSRealModelDownloadIntegrationGateInput(
      q259DryRunWorkerPresent: true,
      q258ArtifactResolverGatePresent: true,
      integrationState: 'integrationDownloadEligibleButDisabled',
      allIntegrationStatesRepresented: true,
      productionDownloadEnabled: false,
      noProductionModelUrlBound: true,
      expectedSha256LockedInPackage: false,
      noRealNetworkDownloadWorkerImplemented: true,
      noPaddleRuntimeDependencyAdded: true,
      noPaddleOcrDependencyAdded: true,
      noModelBinaryBundledInBaseApp: true,
      noProductionInferenceAllowed: true,
      productionArtifactUrlCandidatePresent: true,
      expectedSha256CandidatePresent: true,
      expectedSha256CandidateIs64Hex: true,
      explicitUserConsentRequired: true,
      wifiOrApprovedNetworkRequired: true,
      privateAppStorageOnly: true,
      temporaryFileBeforeFinalArtifact: true,
      checksumVerificationBeforeReady: true,
      checksumMismatchBlocksReady: true,
      atomicMoveOnlyAfterChecksumPass: true,
      offlineReadyOnlyAfterVerifiedArtifact: true,
      runtimeFeasibilityEvidenceRequired: true,
      mathLiveReviewAndUserApprovalRequired: true,
      noDirectSolveGraphSolutionHistoryFromCamera: true,
      integrationLabel: 'Q260 integration gate only',
    );

    test('policy keeps Q260 as a disabled-by-default integration gate', () {
      expect(GaussPpFormulaNetSRealModelDownloadIntegrationGatePolicy.phase, 'V172-Q260-PP-FORMULANET-S-REAL-MODEL-DOWNLOAD-INTEGRATION-GATE');
      expect(GaussPpFormulaNetSRealModelDownloadIntegrationGatePolicy.sourcePhase, 'V172-Q259-PP-FORMULANET-S-REAL-DOWNLOAD-WORKER-DRY-RUN');
      expect(GaussPpFormulaNetSRealModelDownloadIntegrationGatePolicy.selectedEngineLabel, 'PP-FormulaNet-S');
      expect(GaussPpFormulaNetSRealModelDownloadIntegrationGatePolicy.productionDownloadEnabled, isFalse);
      expect(GaussPpFormulaNetSRealModelDownloadIntegrationGatePolicy.productionModelUrlBound, isFalse);
      expect(GaussPpFormulaNetSRealModelDownloadIntegrationGatePolicy.expectedProductionSha256Locked, isFalse);
      expect(GaussPpFormulaNetSRealModelDownloadIntegrationGatePolicy.realNetworkDownloadWorkerImplemented, isFalse);
      expect(GaussPpFormulaNetSRealModelDownloadIntegrationGatePolicy.integrationStates, contains('integrationDownloadEligibleButDisabled'));
      expect(GaussPpFormulaNetSRealModelDownloadIntegrationGatePolicy.requiredIntegrationGates, contains('expectedSha256MustBe64Hex'));
      expect(GaussPpFormulaNetSRealModelDownloadIntegrationGatePolicy.requiredRealEvidenceBeforeEnablement, contains('realProductionArtifactUrl'));
    });

    test('passes only when URL/SHA/consent/storage/integrity/runtime/review gates are defined and download remains disabled', () {
      final result = GaussPpFormulaNetSRealModelDownloadIntegrationGate.evaluate(readyInput);

      expect(result.decision, GaussPpFormulaNetSRealModelDownloadIntegrationGateDecision.realModelDownloadIntegrationGateStaticReady);
      expect(result.realModelDownloadIntegrationGateStaticReady, isTrue);
      expect(result.integrationMode, 'real-model-download-integration-gate-no-production-network-without-url-sha-consent');
      expect(result.integrationStates, contains('integrationBlockedChecksumMismatch'));
      expect(result.requiredIntegrationGates, contains('atomicMoveOnlyAfterChecksumPass'));
      expect(result.requiredRealEvidenceBeforeEnablement, contains('AndroidFlutterDownloadRunLog'));
      expect(result.forbiddenActions, contains('startRealNetworkDownloadInQ260'));
      expect(result.realOcrRuntimeAdded, isFalse);
      expect(result.paddleRuntimeAdded, isFalse);
      expect(result.paddleOcrDependencyAdded, isFalse);
      expect(result.modelBinaryBundledInBaseApp, isFalse);
      expect(result.productionModelUrlBound, isFalse);
      expect(result.expectedProductionSha256Locked, isFalse);
      expect(result.realNetworkDownloadWorkerImplemented, isFalse);
      expect(result.productionDownloadEnabled, isFalse);
      expect(result.productionInferenceAllowed, isFalse);
      expect(result.editableMathLiveReviewRequired, isTrue);
      expect(result.userApprovalRequiredBeforeWorkspaceImport, isTrue);
      expect(result.canEnableProductionDownloadInQ260, isFalse);
      expect(result.canStartRealNetworkDownloadInQ260, isFalse);
      expect(result.canClaimModelDownloadPass, isFalse);
      expect(result.canClaimOcrPass, isFalse);
      expect(result.canRunPpFormulaNetSInference, isFalse);
      expect(result.canMarkReadyWithoutChecksumPass, isFalse);
      expect(result.canImportCameraOutputWithoutUserApproval, isFalse);
    });

    test('blocks missing dry-run, resolver, URL/SHA, production enablement, consent, storage, runtime, and review regressions', () {
      expect(
        GaussPpFormulaNetSRealModelDownloadIntegrationGate.evaluate(readyInput.copyForTest(q259DryRunWorkerPresent: false)).decision,
        GaussPpFormulaNetSRealModelDownloadIntegrationGateDecision.blockedMissingQ259DryRunWorker,
      );
      expect(
        GaussPpFormulaNetSRealModelDownloadIntegrationGate.evaluate(readyInput.copyForTest(q258ArtifactResolverGatePresent: false)).decision,
        GaussPpFormulaNetSRealModelDownloadIntegrationGateDecision.blockedMissingArtifactResolver,
      );
      expect(
        GaussPpFormulaNetSRealModelDownloadIntegrationGate.evaluate(readyInput.copyForTest(expectedSha256CandidateIs64Hex: false)).decision,
        GaussPpFormulaNetSRealModelDownloadIntegrationGateDecision.blockedMissingUrlOrShaEvidence,
      );
      expect(
        GaussPpFormulaNetSRealModelDownloadIntegrationGate.evaluate(readyInput.copyForTest(productionDownloadEnabled: true)).decision,
        GaussPpFormulaNetSRealModelDownloadIntegrationGateDecision.blockedUnsafeProductionDownloadEnablement,
      );
      expect(
        GaussPpFormulaNetSRealModelDownloadIntegrationGate.evaluate(readyInput.copyForTest(noProductionModelUrlBound: false)).decision,
        GaussPpFormulaNetSRealModelDownloadIntegrationGateDecision.blockedUnsafeProductionDownloadEnablement,
      );
      expect(
        GaussPpFormulaNetSRealModelDownloadIntegrationGate.evaluate(readyInput.copyForTest(explicitUserConsentRequired: false)).decision,
        GaussPpFormulaNetSRealModelDownloadIntegrationGateDecision.blockedMissingConsentOrNetworkPolicy,
      );
      expect(
        GaussPpFormulaNetSRealModelDownloadIntegrationGate.evaluate(readyInput.copyForTest(checksumMismatchBlocksReady: false)).decision,
        GaussPpFormulaNetSRealModelDownloadIntegrationGateDecision.blockedMissingStorageOrIntegritySafety,
      );
      expect(
        GaussPpFormulaNetSRealModelDownloadIntegrationGate.evaluate(readyInput.copyForTest(runtimeFeasibilityEvidenceRequired: false)).decision,
        GaussPpFormulaNetSRealModelDownloadIntegrationGateDecision.blockedMissingRuntimeFeasibilityEvidence,
      );
      expect(
        GaussPpFormulaNetSRealModelDownloadIntegrationGate.evaluate(readyInput.copyForTest(mathLiveReviewAndUserApprovalRequired: false)).decision,
        GaussPpFormulaNetSRealModelDownloadIntegrationGateDecision.blockedMissingMathLiveReviewSafety,
      );
    });

    test('keeps dependencies, production bridge, and base APK free of real OCR/runtime/download artifacts', () {
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
      expect(pubspec.toLowerCase(), isNot(contains('background_downloader')));
      expect(settings, contains("id 'com.android.application' version '8.6.1' apply false"));
      expect(settings, contains("id 'org.jetbrains.kotlin.android' version '2.1.0' apply false"));
      expect(prodBridge, isNot(contains('FormulaRecognition(')));
      expect(prodBridge, isNot(contains('runPpFormulaNetSInference')));
      expect(prodBridge, isNot(contains('setWorkspaceLatexWithoutUserApproval')));
      expect(prodBridge, isNot(contains('startRealNetworkDownloadInQ260')));

      final forbiddenModelExtensions = RegExp(r'\.(onnx|tflite|pt|pth|pdmodel|pdiparams|pdparams|safetensors|bin)$', caseSensitive: false);
      final modelFiles = Directory.current
          .listSync(recursive: true)
          .whereType<File>()
          .where((file) {
            final normalizedPath = file.path.replaceAll('\\', '/');
            return !normalizedPath.contains('/build/') && !normalizedPath.contains('/.dart_tool/');
          })
          .where((file) => forbiddenModelExtensions.hasMatch(file.path))
          .toList();
      expect(modelFiles, isEmpty);
    });
  });
}

extension on GaussPpFormulaNetSRealModelDownloadIntegrationGateInput {
  GaussPpFormulaNetSRealModelDownloadIntegrationGateInput copyForTest({
    bool? q259DryRunWorkerPresent,
    bool? q258ArtifactResolverGatePresent,
    String? integrationState,
    bool? allIntegrationStatesRepresented,
    bool? productionDownloadEnabled,
    bool? noProductionModelUrlBound,
    bool? expectedSha256LockedInPackage,
    bool? noRealNetworkDownloadWorkerImplemented,
    bool? noPaddleRuntimeDependencyAdded,
    bool? noPaddleOcrDependencyAdded,
    bool? noModelBinaryBundledInBaseApp,
    bool? noProductionInferenceAllowed,
    bool? productionArtifactUrlCandidatePresent,
    bool? expectedSha256CandidatePresent,
    bool? expectedSha256CandidateIs64Hex,
    bool? explicitUserConsentRequired,
    bool? wifiOrApprovedNetworkRequired,
    bool? privateAppStorageOnly,
    bool? temporaryFileBeforeFinalArtifact,
    bool? checksumVerificationBeforeReady,
    bool? checksumMismatchBlocksReady,
    bool? atomicMoveOnlyAfterChecksumPass,
    bool? offlineReadyOnlyAfterVerifiedArtifact,
    bool? runtimeFeasibilityEvidenceRequired,
    bool? mathLiveReviewAndUserApprovalRequired,
    bool? noDirectSolveGraphSolutionHistoryFromCamera,
    String? integrationLabel,
  }) {
    return GaussPpFormulaNetSRealModelDownloadIntegrationGateInput(
      q259DryRunWorkerPresent: q259DryRunWorkerPresent ?? this.q259DryRunWorkerPresent,
      q258ArtifactResolverGatePresent: q258ArtifactResolverGatePresent ?? this.q258ArtifactResolverGatePresent,
      integrationState: integrationState ?? this.integrationState,
      allIntegrationStatesRepresented: allIntegrationStatesRepresented ?? this.allIntegrationStatesRepresented,
      productionDownloadEnabled: productionDownloadEnabled ?? this.productionDownloadEnabled,
      noProductionModelUrlBound: noProductionModelUrlBound ?? this.noProductionModelUrlBound,
      expectedSha256LockedInPackage: expectedSha256LockedInPackage ?? this.expectedSha256LockedInPackage,
      noRealNetworkDownloadWorkerImplemented: noRealNetworkDownloadWorkerImplemented ?? this.noRealNetworkDownloadWorkerImplemented,
      noPaddleRuntimeDependencyAdded: noPaddleRuntimeDependencyAdded ?? this.noPaddleRuntimeDependencyAdded,
      noPaddleOcrDependencyAdded: noPaddleOcrDependencyAdded ?? this.noPaddleOcrDependencyAdded,
      noModelBinaryBundledInBaseApp: noModelBinaryBundledInBaseApp ?? this.noModelBinaryBundledInBaseApp,
      noProductionInferenceAllowed: noProductionInferenceAllowed ?? this.noProductionInferenceAllowed,
      productionArtifactUrlCandidatePresent: productionArtifactUrlCandidatePresent ?? this.productionArtifactUrlCandidatePresent,
      expectedSha256CandidatePresent: expectedSha256CandidatePresent ?? this.expectedSha256CandidatePresent,
      expectedSha256CandidateIs64Hex: expectedSha256CandidateIs64Hex ?? this.expectedSha256CandidateIs64Hex,
      explicitUserConsentRequired: explicitUserConsentRequired ?? this.explicitUserConsentRequired,
      wifiOrApprovedNetworkRequired: wifiOrApprovedNetworkRequired ?? this.wifiOrApprovedNetworkRequired,
      privateAppStorageOnly: privateAppStorageOnly ?? this.privateAppStorageOnly,
      temporaryFileBeforeFinalArtifact: temporaryFileBeforeFinalArtifact ?? this.temporaryFileBeforeFinalArtifact,
      checksumVerificationBeforeReady: checksumVerificationBeforeReady ?? this.checksumVerificationBeforeReady,
      checksumMismatchBlocksReady: checksumMismatchBlocksReady ?? this.checksumMismatchBlocksReady,
      atomicMoveOnlyAfterChecksumPass: atomicMoveOnlyAfterChecksumPass ?? this.atomicMoveOnlyAfterChecksumPass,
      offlineReadyOnlyAfterVerifiedArtifact: offlineReadyOnlyAfterVerifiedArtifact ?? this.offlineReadyOnlyAfterVerifiedArtifact,
      runtimeFeasibilityEvidenceRequired: runtimeFeasibilityEvidenceRequired ?? this.runtimeFeasibilityEvidenceRequired,
      mathLiveReviewAndUserApprovalRequired: mathLiveReviewAndUserApprovalRequired ?? this.mathLiveReviewAndUserApprovalRequired,
      noDirectSolveGraphSolutionHistoryFromCamera: noDirectSolveGraphSolutionHistoryFromCamera ?? this.noDirectSolveGraphSolutionHistoryFromCamera,
      integrationLabel: integrationLabel ?? this.integrationLabel,
    );
  }
}
