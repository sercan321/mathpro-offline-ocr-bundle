import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_pp_formulanet_s_production_artifact_resolver_gate.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_pp_formulanet_s_production_artifact_resolver_gate_policy.dart';

// Q258 dependency sentinels: camera: 0.10.6, camera_android: 0.10.9+3, AGP: 8.6.1
void main() {
  group('V172-Q258 PP-FormulaNet-S production artifact resolver gate', () {
    const readyInput = GaussPpFormulaNetSProductionArtifactResolverInput(
      q257DownloadOrchestratorUiGuardPresent: true,
      q256ArtifactManifestShaGatePresent: true,
      officialArtifactSourceLabelPresent: true,
      artifactVersionLabelPresent: true,
      artifactLicenseLabelPresent: true,
      artifactStorageSizeBudgetPresent: true,
      androidRuntimeCompatibilityLabelPresent: true,
      latencyAndMemoryBudgetPresent: true,
      productionArtifactUrlCandidateBound: false,
      expectedSha256Candidate: '',
      productionDownloadEnabled: false,
      noRealNetworkDownloadWorkerImplemented: true,
      noModelBinaryBundledInBaseApp: true,
      noPaddleRuntimeDependencyAdded: true,
      noPaddleOcrDependencyAdded: true,
      noProductionInferenceAllowed: true,
      checksumMismatchBlocksReadyState: true,
      urlCannotEnableDownloadWithoutExpectedSha: true,
      downloadDisabledByDefaultVisible: true,
      mathLiveReviewAndUserApprovalRequired: true,
      noDirectSolveGraphSolutionHistoryFromCamera: true,
      resolverLabel: 'q258-production-artifact-resolver-gate',
    );

    test('records production artifact resolver gate without URL, SHA lock, download, runtime, or inference', () {
      expect(GaussPpFormulaNetSProductionArtifactResolverGatePolicy.phase, 'V172-Q258-PP-FORMULANET-S-PRODUCTION-ARTIFACT-RESOLVER-GATE');
      expect(GaussPpFormulaNetSProductionArtifactResolverGatePolicy.sourcePhase, 'V172-Q257-PP-FORMULANET-S-DOWNLOAD-ORCHESTRATOR-UI-GUARD');
      expect(GaussPpFormulaNetSProductionArtifactResolverGatePolicy.selectedEngineLabel, 'PP-FormulaNet-S');
      expect(GaussPpFormulaNetSProductionArtifactResolverGatePolicy.fallbackEngineLabel, 'PP-FormulaNet_plus-L');
      expect(GaussPpFormulaNetSProductionArtifactResolverGatePolicy.productionDownloadEnabled, isFalse);
      expect(GaussPpFormulaNetSProductionArtifactResolverGatePolicy.productionModelUrlBound, isFalse);
      expect(GaussPpFormulaNetSProductionArtifactResolverGatePolicy.expectedProductionSha256Locked, isFalse);
      expect(GaussPpFormulaNetSProductionArtifactResolverGatePolicy.realNetworkDownloadWorkerImplemented, isFalse);
      expect(GaussPpFormulaNetSProductionArtifactResolverGatePolicy.modelBinaryBundledInBaseApp, isFalse);
      expect(GaussPpFormulaNetSProductionArtifactResolverGatePolicy.productionInferenceAllowed, isFalse);
      expect(GaussPpFormulaNetSProductionArtifactResolverGatePolicy.directSolveFromCameraAllowed, isFalse);
      expect(GaussPpFormulaNetSProductionArtifactResolverGatePolicy.requiredResolverFields, contains('productionArtifactUrlCandidate'));
      expect(GaussPpFormulaNetSProductionArtifactResolverGatePolicy.requiredResolverSafetyGates, contains('urlCannotEnableDownloadWithoutExpectedSha'));
    });

    test('passes only when resolver fields, SHA rules, disabled download, and review guards are intact', () {
      final result = GaussPpFormulaNetSProductionArtifactResolverGate.evaluate(readyInput);

      expect(result.decision, GaussPpFormulaNetSProductionArtifactResolverDecision.productionArtifactResolverGateStaticReady);
      expect(result.productionArtifactResolverGateStaticReady, isTrue);
      expect(result.requiredResolverFields, contains('expectedSha256Candidate'));
      expect(result.requiredResolverSafetyGates, contains('checksumMismatchBlocksReadyState'));
      expect(result.blockedUntilRealEvidence, contains('officialArtifactUrlResolved'));
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
      expect(result.canResolveProductionArtifactUrl, isFalse);
      expect(result.canLockExpectedProductionSha256, isFalse);
      expect(result.canEnableProductionDownloadInQ258, isFalse);
      expect(result.canClaimModelDownloadPass, isFalse);
      expect(result.canClaimOcrPass, isFalse);
      expect(result.canRunPpFormulaNetSInference, isFalse);
      expect(result.canImportCameraOutputWithoutUserApproval, isFalse);
    });

    test('blocks missing Q257/Q256 gates, missing fields, invalid SHA, production download, URL/runtime binding, and review regressions', () {
      expect(
        GaussPpFormulaNetSProductionArtifactResolverGate.evaluate(readyInput.copyForTest(q257DownloadOrchestratorUiGuardPresent: false)).decision,
        GaussPpFormulaNetSProductionArtifactResolverDecision.blockedMissingQ257OrchestratorGate,
      );
      expect(
        GaussPpFormulaNetSProductionArtifactResolverGate.evaluate(readyInput.copyForTest(q256ArtifactManifestShaGatePresent: false)).decision,
        GaussPpFormulaNetSProductionArtifactResolverDecision.blockedMissingQ256ArtifactShaGate,
      );
      expect(
        GaussPpFormulaNetSProductionArtifactResolverGate.evaluate(readyInput.copyForTest(artifactLicenseLabelPresent: false)).decision,
        GaussPpFormulaNetSProductionArtifactResolverDecision.blockedMissingResolverManifestFields,
      );
      expect(
        GaussPpFormulaNetSProductionArtifactResolverGate.evaluate(readyInput.copyForTest(expectedSha256Candidate: 'not-a-sha')).decision,
        GaussPpFormulaNetSProductionArtifactResolverDecision.blockedInvalidShaCandidate,
      );
      expect(
        GaussPpFormulaNetSProductionArtifactResolverGate.evaluate(readyInput.copyForTest(productionDownloadEnabled: true)).decision,
        GaussPpFormulaNetSProductionArtifactResolverDecision.blockedProductionDownloadEnabled,
      );
      expect(
        GaussPpFormulaNetSProductionArtifactResolverGate.evaluate(readyInput.copyForTest(productionArtifactUrlCandidateBound: true)).decision,
        GaussPpFormulaNetSProductionArtifactResolverDecision.blockedUnsafeUrlOrRuntimeBinding,
      );
      expect(
        GaussPpFormulaNetSProductionArtifactResolverGate.evaluate(readyInput.copyForTest(androidRuntimeCompatibilityLabelPresent: false)).decision,
        GaussPpFormulaNetSProductionArtifactResolverDecision.blockedMissingResolverManifestFields,
      );
      expect(
        GaussPpFormulaNetSProductionArtifactResolverGate.evaluate(readyInput.copyForTest(checksumMismatchBlocksReadyState: false)).decision,
        GaussPpFormulaNetSProductionArtifactResolverDecision.blockedMissingChecksumSafety,
      );
      expect(
        GaussPpFormulaNetSProductionArtifactResolverGate.evaluate(readyInput.copyForTest(mathLiveReviewAndUserApprovalRequired: false)).decision,
        GaussPpFormulaNetSProductionArtifactResolverDecision.blockedMissingMathLiveReviewSafety,
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

extension on GaussPpFormulaNetSProductionArtifactResolverInput {
  GaussPpFormulaNetSProductionArtifactResolverInput copyForTest({
    bool? q257DownloadOrchestratorUiGuardPresent,
    bool? q256ArtifactManifestShaGatePresent,
    bool? officialArtifactSourceLabelPresent,
    bool? artifactVersionLabelPresent,
    bool? artifactLicenseLabelPresent,
    bool? artifactStorageSizeBudgetPresent,
    bool? androidRuntimeCompatibilityLabelPresent,
    bool? latencyAndMemoryBudgetPresent,
    bool? productionArtifactUrlCandidateBound,
    String? expectedSha256Candidate,
    bool? productionDownloadEnabled,
    bool? noRealNetworkDownloadWorkerImplemented,
    bool? noModelBinaryBundledInBaseApp,
    bool? noPaddleRuntimeDependencyAdded,
    bool? noPaddleOcrDependencyAdded,
    bool? noProductionInferenceAllowed,
    bool? checksumMismatchBlocksReadyState,
    bool? urlCannotEnableDownloadWithoutExpectedSha,
    bool? downloadDisabledByDefaultVisible,
    bool? mathLiveReviewAndUserApprovalRequired,
    bool? noDirectSolveGraphSolutionHistoryFromCamera,
    String? resolverLabel,
  }) {
    return GaussPpFormulaNetSProductionArtifactResolverInput(
      q257DownloadOrchestratorUiGuardPresent: q257DownloadOrchestratorUiGuardPresent ?? this.q257DownloadOrchestratorUiGuardPresent,
      q256ArtifactManifestShaGatePresent: q256ArtifactManifestShaGatePresent ?? this.q256ArtifactManifestShaGatePresent,
      officialArtifactSourceLabelPresent: officialArtifactSourceLabelPresent ?? this.officialArtifactSourceLabelPresent,
      artifactVersionLabelPresent: artifactVersionLabelPresent ?? this.artifactVersionLabelPresent,
      artifactLicenseLabelPresent: artifactLicenseLabelPresent ?? this.artifactLicenseLabelPresent,
      artifactStorageSizeBudgetPresent: artifactStorageSizeBudgetPresent ?? this.artifactStorageSizeBudgetPresent,
      androidRuntimeCompatibilityLabelPresent: androidRuntimeCompatibilityLabelPresent ?? this.androidRuntimeCompatibilityLabelPresent,
      latencyAndMemoryBudgetPresent: latencyAndMemoryBudgetPresent ?? this.latencyAndMemoryBudgetPresent,
      productionArtifactUrlCandidateBound: productionArtifactUrlCandidateBound ?? this.productionArtifactUrlCandidateBound,
      expectedSha256Candidate: expectedSha256Candidate ?? this.expectedSha256Candidate,
      productionDownloadEnabled: productionDownloadEnabled ?? this.productionDownloadEnabled,
      noRealNetworkDownloadWorkerImplemented: noRealNetworkDownloadWorkerImplemented ?? this.noRealNetworkDownloadWorkerImplemented,
      noModelBinaryBundledInBaseApp: noModelBinaryBundledInBaseApp ?? this.noModelBinaryBundledInBaseApp,
      noPaddleRuntimeDependencyAdded: noPaddleRuntimeDependencyAdded ?? this.noPaddleRuntimeDependencyAdded,
      noPaddleOcrDependencyAdded: noPaddleOcrDependencyAdded ?? this.noPaddleOcrDependencyAdded,
      noProductionInferenceAllowed: noProductionInferenceAllowed ?? this.noProductionInferenceAllowed,
      checksumMismatchBlocksReadyState: checksumMismatchBlocksReadyState ?? this.checksumMismatchBlocksReadyState,
      urlCannotEnableDownloadWithoutExpectedSha: urlCannotEnableDownloadWithoutExpectedSha ?? this.urlCannotEnableDownloadWithoutExpectedSha,
      downloadDisabledByDefaultVisible: downloadDisabledByDefaultVisible ?? this.downloadDisabledByDefaultVisible,
      mathLiveReviewAndUserApprovalRequired: mathLiveReviewAndUserApprovalRequired ?? this.mathLiveReviewAndUserApprovalRequired,
      noDirectSolveGraphSolutionHistoryFromCamera: noDirectSolveGraphSolutionHistoryFromCamera ?? this.noDirectSolveGraphSolutionHistoryFromCamera,
      resolverLabel: resolverLabel ?? this.resolverLabel,
    );
  }
}
