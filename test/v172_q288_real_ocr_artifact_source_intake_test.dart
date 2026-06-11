import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_real_ocr_artifact_source_intake.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_real_ocr_artifact_source_intake_policy.dart';

void main() {
  group('V172-Q288 Real OCR Artifact Source Intake', () {
    test('records official PP-FormulaNet-S source candidates without accepting runtime', () {
      final result = GaussRealOcrArtifactSourceIntake.evaluate();

      expect(result.phase, GaussRealOcrArtifactSourceIntakePolicy.phase);
      expect(result.sourcePhase, 'V172-Q287R2-STORE-READINESS-CAMERA-OCR-RELEASE-AUDIT-TEST-DOC-SECTION-REPAIR');
      expect(result.selectedEngineLabel, 'PP-FormulaNet-S');
      expect(result.primaryOfficialSourceLocator, contains('PaddlePaddle/PP-FormulaNet-S'));
      expect(result.officialMirrorInferenceArtifactLocator, contains('PP-FormulaNet-S_infer.tar'));
      expect(result.recordedLicense, 'apache-2.0');
      expect(result.expectedSha256, 'PENDING_DOWNLOAD_AND_HASH_VERIFICATION');
      expect(result.decision, GaussRealOcrArtifactSourceIntakeDecision.sourceCandidateRecordedButShaPending);
      expect(result.artifactSha256Verified, isFalse);
      expect(result.artifactAcceptedForRuntime, isFalse);
      expect(result.realOcrRuntimeAdded, isFalse);
      expect(result.modelBinaryBundledInBaseApp, isFalse);
      expect(result.productionDownloadEnabled, isFalse);
      expect(result.ocrPassClaimed, isFalse);
    });

    test('keeps camera/OCR artifact intake behind review-first and no-direct-solve boundaries', () {
      expect(GaussRealOcrArtifactSourceIntakePolicy.sourceCandidateRecorded, isTrue);
      expect(GaussRealOcrArtifactSourceIntakePolicy.licenseEvidenceRecorded, isTrue);
      expect(GaussRealOcrArtifactSourceIntakePolicy.modelSizeEvidenceRecorded, isTrue);
      expect(GaussRealOcrArtifactSourceIntakePolicy.modelFormatEvidenceRecorded, isTrue);
      expect(GaussRealOcrArtifactSourceIntakePolicy.artifactSha256Verified, isFalse);
      expect(GaussRealOcrArtifactSourceIntakePolicy.productionModelUrlBound, isFalse);
      expect(GaussRealOcrArtifactSourceIntakePolicy.officialDownloadEnabled, isFalse);
      expect(GaussRealOcrArtifactSourceIntakePolicy.directWorkspaceImportEnabled, isFalse);
      expect(GaussRealOcrArtifactSourceIntakePolicy.directSolveGraphSolutionHistoryEnabled, isFalse);
      expect(
        GaussRealOcrArtifactSourceIntakePolicy.artifactAcceptanceRequirements,
        contains('keep-editable-mathlive-review-and-explicit-user-approval-mandatory'),
      );
      expect(
        GaussRealOcrArtifactSourceIntakePolicy.artifactAcceptanceRequirements,
        contains('keep-direct-solve-graph-solution-history-blocked-for-camera-output'),
      );
    });

    test('does not add runtime dependencies, model binaries, or protected runtime mutations', () {
      final pubspec = File('pubspec.yaml').readAsStringSync();
      final changed = File('docs/audit/V172_Q288_CHANGED_FILES.md').readAsStringSync();

      for (final forbidden in <String>[
        'paddleocr',
        'paddle_ocr',
        'paddle_flutter',
        'paddle_lite',
        'google_mlkit_text_recognition',
        'onnxruntime',
        'tesseract',
        'pix2text',
        'flutter_downloader',
        'background_downloader',
        'dio',
      ]) {
        expect(pubspec, isNot(contains(forbidden)));
      }

      expect(pubspec, contains('camera: 0.10.6'));
      expect(pubspec, contains('camera_android: 0.10.9+3'));
      expect(pubspec, isNot(contains('camera_android_camerax')));
      expect(changed, isNot(contains('- `lib/features/keyboard/key_config.dart`')));
      expect(changed, isNot(contains('- `assets/mathlive/mathlive_prod_bridge.js`')));
      expect(changed, isNot(contains('- `lib/features/mathlive/mathlive_production_editor_surface.dart`')));
    });
  });
}
