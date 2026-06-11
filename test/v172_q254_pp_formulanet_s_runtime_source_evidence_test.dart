import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_pp_formulanet_s_runtime_source_evidence.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_pp_formulanet_s_runtime_source_evidence_policy.dart';

// Q254 dependency sentinels: camera: 0.10.6, camera_android: 0.10.9+3
void main() {
  group('V172-Q254 PP-FormulaNet-S runtime source evidence gate', () {
    const readyInput = GaussPpFormulaNetSRuntimeSourceEvidenceInput(
      officialPaddleOcrDocumentationVerified: true,
      officialPaddleXDocumentationVerified: true,
      officialModelRepositoryVerified: true,
      apache2LicenseEvidenceVerified: true,
      modelStorageSizeEvidenceVerified: true,
      expectedSha256Recorded: true,
      actualSha256VerifiedAfterDownload: true,
      androidRuntimeFeasibilityVerified: true,
      latencyAndMemoryBudgetRecorded: true,
      privateAppStoragePlanned: true,
      offlineAfterInstallPlanned: true,
      noPaddleRuntimeDependencyAdded: true,
      noModelBinaryBundledInBaseApp: true,
      noProductionModelUrlBound: true,
      noProductionInferenceAllowed: true,
      mathLiveReviewAndUserApprovalRequired: true,
      noDirectSolveGraphSolutionHistoryFromCamera: true,
      evidenceLabel: 'q254-official-source-evidence-gate',
    );

    test('records PP-FormulaNet-S source evidence gate without real runtime binding', () {
      expect(GaussPpFormulaNetSRuntimeSourceEvidencePolicy.phase, 'V172-Q254-PP-FORMULANET-S-RUNTIME-SOURCE-EVIDENCE-GATE');
      expect(GaussPpFormulaNetSRuntimeSourceEvidencePolicy.sourcePhase, 'V172-Q253-ANDROID-TOOLCHAIN-MODERNIZATION');
      expect(GaussPpFormulaNetSRuntimeSourceEvidencePolicy.selectedEngineLabel, 'PP-FormulaNet-S');
      expect(GaussPpFormulaNetSRuntimeSourceEvidencePolicy.fallbackEngineLabel, 'PP-FormulaNet_plus-L');
      expect(GaussPpFormulaNetSRuntimeSourceEvidencePolicy.officialPaddleOcrDocumentationRequired, isTrue);
      expect(GaussPpFormulaNetSRuntimeSourceEvidencePolicy.officialPaddleXDocumentationRequired, isTrue);
      expect(GaussPpFormulaNetSRuntimeSourceEvidencePolicy.officialModelRepositoryRequired, isTrue);
      expect(GaussPpFormulaNetSRuntimeSourceEvidencePolicy.apache2LicenseEvidenceRequired, isTrue);
      expect(GaussPpFormulaNetSRuntimeSourceEvidencePolicy.expectedSha256RequiredBeforeDownload, isTrue);
      expect(GaussPpFormulaNetSRuntimeSourceEvidencePolicy.realOcrRuntimeAdded, isFalse);
      expect(GaussPpFormulaNetSRuntimeSourceEvidencePolicy.paddleRuntimeAdded, isFalse);
      expect(GaussPpFormulaNetSRuntimeSourceEvidencePolicy.modelBinaryBundledInBaseApp, isFalse);
      expect(GaussPpFormulaNetSRuntimeSourceEvidencePolicy.productionInferenceAllowed, isFalse);
      expect(GaussPpFormulaNetSRuntimeSourceEvidencePolicy.directSolveFromCameraAllowed, isFalse);
    });

    test('passes only when official source, checksum, runtime feasibility, and review gates are intact', () {
      final result = GaussPpFormulaNetSRuntimeSourceEvidenceGate.evaluate(readyInput);

      expect(result.decision, GaussPpFormulaNetSRuntimeSourceEvidenceDecision.runtimeSourceEvidenceStaticReady);
      expect(result.runtimeSourceEvidenceStaticReady, isTrue);
      expect(result.realOcrRuntimeAdded, isFalse);
      expect(result.paddleRuntimeAdded, isFalse);
      expect(result.modelBinaryBundledInBaseApp, isFalse);
      expect(result.productionModelUrlBound, isFalse);
      expect(result.productionInferenceAllowed, isFalse);
      expect(result.editableMathLiveReviewRequired, isTrue);
      expect(result.userApprovalRequiredBeforeWorkspaceImport, isTrue);
      expect(result.canClaimOcrPass, isFalse);
      expect(result.canRunPpFormulaNetSInference, isFalse);
      expect(result.canSetProductionModelUrlWithoutSha256, isFalse);
      expect(result.canImportCameraOutputWithoutUserApproval, isFalse);
      expect(result.canSolveCameraOutputBeforeReviewApproval, isFalse);
    });

    test('blocks missing source, checksum, Android runtime, unsafe binding, and review regressions', () {
      expect(
        GaussPpFormulaNetSRuntimeSourceEvidenceGate.evaluate(
          const GaussPpFormulaNetSRuntimeSourceEvidenceInput(
            officialPaddleOcrDocumentationVerified: false,
            officialPaddleXDocumentationVerified: true,
            officialModelRepositoryVerified: true,
            apache2LicenseEvidenceVerified: true,
            modelStorageSizeEvidenceVerified: true,
            expectedSha256Recorded: true,
            actualSha256VerifiedAfterDownload: true,
            androidRuntimeFeasibilityVerified: true,
            latencyAndMemoryBudgetRecorded: true,
            privateAppStoragePlanned: true,
            offlineAfterInstallPlanned: true,
            noPaddleRuntimeDependencyAdded: true,
            noModelBinaryBundledInBaseApp: true,
            noProductionModelUrlBound: true,
            noProductionInferenceAllowed: true,
            mathLiveReviewAndUserApprovalRequired: true,
            noDirectSolveGraphSolutionHistoryFromCamera: true,
            evidenceLabel: 'missing-source',
          ),
        ).decision,
        GaussPpFormulaNetSRuntimeSourceEvidenceDecision.blockedMissingOfficialSourceEvidence,
      );

      expect(
        GaussPpFormulaNetSRuntimeSourceEvidenceGate.evaluate(
          const GaussPpFormulaNetSRuntimeSourceEvidenceInput(
            officialPaddleOcrDocumentationVerified: true,
            officialPaddleXDocumentationVerified: true,
            officialModelRepositoryVerified: true,
            apache2LicenseEvidenceVerified: true,
            modelStorageSizeEvidenceVerified: true,
            expectedSha256Recorded: false,
            actualSha256VerifiedAfterDownload: true,
            androidRuntimeFeasibilityVerified: true,
            latencyAndMemoryBudgetRecorded: true,
            privateAppStoragePlanned: true,
            offlineAfterInstallPlanned: true,
            noPaddleRuntimeDependencyAdded: true,
            noModelBinaryBundledInBaseApp: true,
            noProductionModelUrlBound: true,
            noProductionInferenceAllowed: true,
            mathLiveReviewAndUserApprovalRequired: true,
            noDirectSolveGraphSolutionHistoryFromCamera: true,
            evidenceLabel: 'missing-sha',
          ),
        ).decision,
        GaussPpFormulaNetSRuntimeSourceEvidenceDecision.blockedMissingChecksumEvidence,
      );

      expect(
        GaussPpFormulaNetSRuntimeSourceEvidenceGate.evaluate(
          const GaussPpFormulaNetSRuntimeSourceEvidenceInput(
            officialPaddleOcrDocumentationVerified: true,
            officialPaddleXDocumentationVerified: true,
            officialModelRepositoryVerified: true,
            apache2LicenseEvidenceVerified: true,
            modelStorageSizeEvidenceVerified: true,
            expectedSha256Recorded: true,
            actualSha256VerifiedAfterDownload: true,
            androidRuntimeFeasibilityVerified: false,
            latencyAndMemoryBudgetRecorded: true,
            privateAppStoragePlanned: true,
            offlineAfterInstallPlanned: true,
            noPaddleRuntimeDependencyAdded: true,
            noModelBinaryBundledInBaseApp: true,
            noProductionModelUrlBound: true,
            noProductionInferenceAllowed: true,
            mathLiveReviewAndUserApprovalRequired: true,
            noDirectSolveGraphSolutionHistoryFromCamera: true,
            evidenceLabel: 'missing-android-runtime',
          ),
        ).decision,
        GaussPpFormulaNetSRuntimeSourceEvidenceDecision.blockedMissingAndroidRuntimeEvidence,
      );

      expect(
        GaussPpFormulaNetSRuntimeSourceEvidenceGate.evaluate(
          const GaussPpFormulaNetSRuntimeSourceEvidenceInput(
            officialPaddleOcrDocumentationVerified: true,
            officialPaddleXDocumentationVerified: true,
            officialModelRepositoryVerified: true,
            apache2LicenseEvidenceVerified: true,
            modelStorageSizeEvidenceVerified: true,
            expectedSha256Recorded: true,
            actualSha256VerifiedAfterDownload: true,
            androidRuntimeFeasibilityVerified: true,
            latencyAndMemoryBudgetRecorded: true,
            privateAppStoragePlanned: true,
            offlineAfterInstallPlanned: true,
            noPaddleRuntimeDependencyAdded: false,
            noModelBinaryBundledInBaseApp: true,
            noProductionModelUrlBound: true,
            noProductionInferenceAllowed: true,
            mathLiveReviewAndUserApprovalRequired: true,
            noDirectSolveGraphSolutionHistoryFromCamera: true,
            evidenceLabel: 'unsafe-binding',
          ),
        ).decision,
        GaussPpFormulaNetSRuntimeSourceEvidenceDecision.blockedUnsafeRuntimeBindingAttempt,
      );

      expect(
        GaussPpFormulaNetSRuntimeSourceEvidenceGate.evaluate(
          const GaussPpFormulaNetSRuntimeSourceEvidenceInput(
            officialPaddleOcrDocumentationVerified: true,
            officialPaddleXDocumentationVerified: true,
            officialModelRepositoryVerified: true,
            apache2LicenseEvidenceVerified: true,
            modelStorageSizeEvidenceVerified: true,
            expectedSha256Recorded: true,
            actualSha256VerifiedAfterDownload: true,
            androidRuntimeFeasibilityVerified: true,
            latencyAndMemoryBudgetRecorded: true,
            privateAppStoragePlanned: true,
            offlineAfterInstallPlanned: true,
            noPaddleRuntimeDependencyAdded: true,
            noModelBinaryBundledInBaseApp: true,
            noProductionModelUrlBound: true,
            noProductionInferenceAllowed: true,
            mathLiveReviewAndUserApprovalRequired: false,
            noDirectSolveGraphSolutionHistoryFromCamera: true,
            evidenceLabel: 'missing-review',
          ),
        ).decision,
        GaussPpFormulaNetSRuntimeSourceEvidenceDecision.blockedMissingMathLiveReviewSafety,
      );
    });

    test('keeps app dependencies and production runtime surfaces clean', () {
      final pubspec = File('pubspec.yaml').readAsStringSync();
      final settings = File('android/settings.gradle').readAsStringSync();
      final manifest = File('android/app/src/main/AndroidManifest.xml').readAsStringSync();
      final bridge = File('assets/mathlive/mathlive_prod_bridge.js').readAsStringSync();
      final workspace = File('lib/features/workspace/workspace_panel.dart').readAsStringSync();

      expect(pubspec, contains(RegExp(r'^\s*camera\s*:\s*0\.10\.6\s*$', multiLine: true)));
      expect(pubspec, contains(RegExp(r'^\s*camera_android\s*:\s*0\.10\.9\+3\s*$', multiLine: true)));
      expect(pubspec, isNot(contains('camera_android_camerax')));
      expect(pubspec, isNot(contains('google_mlkit_text_recognition')));
      expect(pubspec.toLowerCase(), isNot(contains('paddleocr')));
      expect(pubspec.toLowerCase(), isNot(contains('paddle_flutter')));
      expect(pubspec.toLowerCase(), isNot(contains('onnxruntime')));
      expect(settings, contains("id 'com.android.application' version '8.6.1' apply false"));
      expect(settings, contains("id 'org.jetbrains.kotlin.android' version '2.1.0' apply false"));
      expect(manifest, contains('android.permission.CAMERA'));
      expect(manifest, isNot(contains('READ_MEDIA_IMAGES')));
      expect(bridge, isNot(contains('FormulaRecognition(')));
      expect(bridge, isNot(contains('runPpFormulaNetSInference')));
      expect(workspace, isNot(contains('setWorkspaceLatexWithoutUserApproval')));

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
