import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_pp_formulanet_s_artifact_manifest_sha_lock.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_pp_formulanet_s_artifact_manifest_sha_lock_policy.dart';

// Q256 dependency sentinels: camera: 0.10.6, camera_android: 0.10.9+3, AGP: 8.6.1
void main() {
  group('V172-Q256 PP-FormulaNet-S artifact manifest and SHA lock gate', () {
    const readyInput = GaussPpFormulaNetSArtifactManifestShaLockInput(
      officialArtifactManifestRecorded: true,
      artifactSourceLabel: 'official-pp-formulanet-s-artifact-source',
      artifactVersionLabel: 'pp-formulanet-s-official-version-lock',
      licenseLabel: 'Apache-2.0',
      modelStorageSizeBytes: 224000000,
      expectedSha256: '0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef',
      expectedSha256LockedFromOfficialArtifact: true,
      artifactSizeBudgetRecorded: true,
      androidRuntimeFeasibilityBudgetRecorded: true,
      latencyAndMemoryBudgetRecorded: true,
      productionDownloadEnabled: false,
      noProductionModelUrlBound: true,
      noModelBinaryBundledInBaseApp: true,
      noRealNetworkDownloadWorkerImplemented: true,
      noPaddleRuntimeDependencyAdded: true,
      noProductionInferenceAllowed: true,
      checksumMismatchBlocksReadyState: true,
      mathLiveReviewAndUserApprovalRequired: true,
      noDirectSolveGraphSolutionHistoryFromCamera: true,
      lockLabel: 'q256-artifact-manifest-sha-lock-gate',
    );

    test('records PP-FormulaNet-S artifact manifest and SHA lock gate without production download', () {
      expect(GaussPpFormulaNetSArtifactManifestShaLockPolicy.phase, 'V172-Q256-PP-FORMULANET-S-ARTIFACT-MANIFEST-AND-SHA-LOCK');
      expect(GaussPpFormulaNetSArtifactManifestShaLockPolicy.sourcePhase, 'V172-Q255-PP-FORMULANET-S-MODEL-DOWNLOAD-WORKER-GUARD');
      expect(GaussPpFormulaNetSArtifactManifestShaLockPolicy.selectedEngineLabel, 'PP-FormulaNet-S');
      expect(GaussPpFormulaNetSArtifactManifestShaLockPolicy.fallbackEngineLabel, 'PP-FormulaNet_plus-L');
      expect(GaussPpFormulaNetSArtifactManifestShaLockPolicy.officialArtifactManifestRequired, isTrue);
      expect(GaussPpFormulaNetSArtifactManifestShaLockPolicy.expectedSha256LockRequiredBeforeDownload, isTrue);
      expect(GaussPpFormulaNetSArtifactManifestShaLockPolicy.expectedSha256MustBeSixtyFourHex, isTrue);
      expect(GaussPpFormulaNetSArtifactManifestShaLockPolicy.checksumMismatchMustBlockReadyState, isTrue);
      expect(GaussPpFormulaNetSArtifactManifestShaLockPolicy.productionModelUrlBound, isFalse);
      expect(GaussPpFormulaNetSArtifactManifestShaLockPolicy.expectedProductionSha256LockedInQ256, isFalse);
      expect(GaussPpFormulaNetSArtifactManifestShaLockPolicy.realNetworkDownloadWorkerImplemented, isFalse);
      expect(GaussPpFormulaNetSArtifactManifestShaLockPolicy.modelBinaryBundledInBaseApp, isFalse);
      expect(GaussPpFormulaNetSArtifactManifestShaLockPolicy.productionInferenceAllowed, isFalse);
      expect(GaussPpFormulaNetSArtifactManifestShaLockPolicy.directSolveFromCameraAllowed, isFalse);
    });

    test('passes only when manifest labels, 64-hex SHA, budgets, and review guards are intact', () {
      final result = GaussPpFormulaNetSArtifactManifestShaLockGate.evaluate(readyInput);

      expect(result.decision, GaussPpFormulaNetSArtifactManifestShaLockDecision.artifactManifestShaLockStaticReady);
      expect(result.artifactManifestShaLockStaticReady, isTrue);
      expect(result.requiredArtifactManifestFields, contains('expectedSha256'));
      expect(result.requiredArtifactManifestFields, contains('checksumMismatchBehavior'));
      expect(result.blockedUntilRealEvidence, contains('realPpFormulaNetSInferenceEvidence'));
      expect(result.realOcrRuntimeAdded, isFalse);
      expect(result.paddleRuntimeAdded, isFalse);
      expect(result.modelBinaryBundledInBaseApp, isFalse);
      expect(result.productionModelUrlBound, isFalse);
      expect(result.realNetworkDownloadWorkerImplemented, isFalse);
      expect(result.productionInferenceAllowed, isFalse);
      expect(result.editableMathLiveReviewRequired, isTrue);
      expect(result.userApprovalRequiredBeforeWorkspaceImport, isTrue);
      expect(result.canClaimArtifactShaLockedForProduction, isFalse);
      expect(result.canClaimModelDownloadPass, isFalse);
      expect(result.canClaimOcrPass, isFalse);
      expect(result.canRunPpFormulaNetSInference, isFalse);
      expect(result.canEnableProductionDownloadWithoutOfficialSha, isFalse);
      expect(result.canImportCameraOutputWithoutUserApproval, isFalse);
    });

    test('blocks missing manifest, labels, budgets, SHA, production download, unsafe binding, and review regressions', () {
      expect(
        GaussPpFormulaNetSArtifactManifestShaLockGate.evaluate(readyInput.copyForTest(officialArtifactManifestRecorded: false)).decision,
        GaussPpFormulaNetSArtifactManifestShaLockDecision.blockedMissingArtifactManifest,
      );
      expect(
        GaussPpFormulaNetSArtifactManifestShaLockGate.evaluate(readyInput.copyForTest(artifactSourceLabel: '')).decision,
        GaussPpFormulaNetSArtifactManifestShaLockDecision.blockedMissingSourceOrLicenseLabel,
      );
      expect(
        GaussPpFormulaNetSArtifactManifestShaLockGate.evaluate(readyInput.copyForTest(modelStorageSizeBytes: 0)).decision,
        GaussPpFormulaNetSArtifactManifestShaLockDecision.blockedMissingSizeOrRuntimeBudget,
      );
      expect(
        GaussPpFormulaNetSArtifactManifestShaLockGate.evaluate(readyInput.copyForTest(expectedSha256LockedFromOfficialArtifact: false)).decision,
        GaussPpFormulaNetSArtifactManifestShaLockDecision.blockedMissingExpectedSha256Lock,
      );
      expect(
        GaussPpFormulaNetSArtifactManifestShaLockGate.evaluate(readyInput.copyForTest(expectedSha256: 'not-a-sha')).decision,
        GaussPpFormulaNetSArtifactManifestShaLockDecision.blockedInvalidSha256Format,
      );
      expect(
        GaussPpFormulaNetSArtifactManifestShaLockGate.evaluate(readyInput.copyForTest(productionDownloadEnabled: true)).decision,
        GaussPpFormulaNetSArtifactManifestShaLockDecision.blockedProductionDownloadEnabled,
      );
      expect(
        GaussPpFormulaNetSArtifactManifestShaLockGate.evaluate(readyInput.copyForTest(noProductionModelUrlBound: false)).decision,
        GaussPpFormulaNetSArtifactManifestShaLockDecision.blockedUnsafeRuntimeBindingAttempt,
      );
      expect(
        GaussPpFormulaNetSArtifactManifestShaLockGate.evaluate(readyInput.copyForTest(mathLiveReviewAndUserApprovalRequired: false)).decision,
        GaussPpFormulaNetSArtifactManifestShaLockDecision.blockedMissingMathLiveReviewSafety,
      );
    });

    test('keeps dependencies, production runtime, and base APK clean', () {
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

extension on GaussPpFormulaNetSArtifactManifestShaLockInput {
  GaussPpFormulaNetSArtifactManifestShaLockInput copyForTest({
    bool? officialArtifactManifestRecorded,
    String? artifactSourceLabel,
    String? artifactVersionLabel,
    String? licenseLabel,
    int? modelStorageSizeBytes,
    String? expectedSha256,
    bool? expectedSha256LockedFromOfficialArtifact,
    bool? artifactSizeBudgetRecorded,
    bool? androidRuntimeFeasibilityBudgetRecorded,
    bool? latencyAndMemoryBudgetRecorded,
    bool? productionDownloadEnabled,
    bool? noProductionModelUrlBound,
    bool? noModelBinaryBundledInBaseApp,
    bool? noRealNetworkDownloadWorkerImplemented,
    bool? noPaddleRuntimeDependencyAdded,
    bool? noProductionInferenceAllowed,
    bool? checksumMismatchBlocksReadyState,
    bool? mathLiveReviewAndUserApprovalRequired,
    bool? noDirectSolveGraphSolutionHistoryFromCamera,
    String? lockLabel,
  }) {
    return GaussPpFormulaNetSArtifactManifestShaLockInput(
      officialArtifactManifestRecorded: officialArtifactManifestRecorded ?? this.officialArtifactManifestRecorded,
      artifactSourceLabel: artifactSourceLabel ?? this.artifactSourceLabel,
      artifactVersionLabel: artifactVersionLabel ?? this.artifactVersionLabel,
      licenseLabel: licenseLabel ?? this.licenseLabel,
      modelStorageSizeBytes: modelStorageSizeBytes ?? this.modelStorageSizeBytes,
      expectedSha256: expectedSha256 ?? this.expectedSha256,
      expectedSha256LockedFromOfficialArtifact: expectedSha256LockedFromOfficialArtifact ?? this.expectedSha256LockedFromOfficialArtifact,
      artifactSizeBudgetRecorded: artifactSizeBudgetRecorded ?? this.artifactSizeBudgetRecorded,
      androidRuntimeFeasibilityBudgetRecorded: androidRuntimeFeasibilityBudgetRecorded ?? this.androidRuntimeFeasibilityBudgetRecorded,
      latencyAndMemoryBudgetRecorded: latencyAndMemoryBudgetRecorded ?? this.latencyAndMemoryBudgetRecorded,
      productionDownloadEnabled: productionDownloadEnabled ?? this.productionDownloadEnabled,
      noProductionModelUrlBound: noProductionModelUrlBound ?? this.noProductionModelUrlBound,
      noModelBinaryBundledInBaseApp: noModelBinaryBundledInBaseApp ?? this.noModelBinaryBundledInBaseApp,
      noRealNetworkDownloadWorkerImplemented: noRealNetworkDownloadWorkerImplemented ?? this.noRealNetworkDownloadWorkerImplemented,
      noPaddleRuntimeDependencyAdded: noPaddleRuntimeDependencyAdded ?? this.noPaddleRuntimeDependencyAdded,
      noProductionInferenceAllowed: noProductionInferenceAllowed ?? this.noProductionInferenceAllowed,
      checksumMismatchBlocksReadyState: checksumMismatchBlocksReadyState ?? this.checksumMismatchBlocksReadyState,
      mathLiveReviewAndUserApprovalRequired: mathLiveReviewAndUserApprovalRequired ?? this.mathLiveReviewAndUserApprovalRequired,
      noDirectSolveGraphSolutionHistoryFromCamera: noDirectSolveGraphSolutionHistoryFromCamera ?? this.noDirectSolveGraphSolutionHistoryFromCamera,
      lockLabel: lockLabel ?? this.lockLabel,
    );
  }
}
