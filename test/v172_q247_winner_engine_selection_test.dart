import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_ocr_engine_benchmark_court.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_winner_engine_selection.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_winner_engine_selection_policy.dart';

// Q247 dependency sentinels: camera: 0.10.6, camera_android: 0.10.9+3
void main() {
  group('V172-Q247 winner engine selection gate', () {
    test('records Q247 as a selection gate without selecting or binding a runtime', () {
      expect(GaussWinnerEngineSelectionPolicy.phase, 'V172-Q247-WINNER-ENGINE-SELECTION');
      expect(
        GaussWinnerEngineSelectionPolicy.closesOverPhase,
        'V172-Q246-OCR-ENGINE-REAL-BENCHMARK-PACKAGE',
      );
      expect(GaussWinnerEngineSelectionPolicy.sourcePackageSha256, hasLength(64));
      expect(GaussWinnerEngineSelectionPolicy.winnerSelectionGateImplemented, isTrue);
      expect(GaussWinnerEngineSelectionPolicy.realBenchmarkEvidenceRequired, isTrue);
      expect(GaussWinnerEngineSelectionPolicy.noWinnerSelectedWithoutRealBenchmark, isTrue);
      expect(GaussWinnerEngineSelectionPolicy.benchmarkWinnerSelected, isFalse);
      expect(GaussWinnerEngineSelectionPolicy.selectedWinnerEngineLabel, 'none');
      expect(GaussWinnerEngineSelectionPolicy.realOcrRuntimeAdded, isFalse);
      expect(GaussWinnerEngineSelectionPolicy.modelBinaryBundledInBaseApp, isFalse);
      expect(GaussWinnerEngineSelection.canBindRuntimeInQ247, isFalse);
      expect(GaussWinnerEngineSelection.canBundleModelInBaseApkInQ247, isFalse);
    });

    test('keeps six candidate rules and keeps PP-FormulaNet_plus-L as a primary formula OCR candidate', () {
      expect(GaussWinnerEngineSelection.hasAllCandidateRules, isTrue);
      expect(GaussWinnerEngineSelection.formulaOcrPrimaryEngineOnly, isTrue);
      expect(GaussWinnerEngineSelection.candidateRules.map((rule) => rule.label), containsAll(<String>[
        'PP-FormulaNet-S',
        'PP-FormulaNet_plus-S',
        'Pix2Text MFR ONNX',
        'UniMERNet tiny',
        'TexTeller',
        'PP-FormulaNet_plus-L',
      ]));
      final ppFormulaNetPlusL = GaussWinnerEngineSelection.candidateRules.singleWhere(
        (rule) => rule.family == GaussOcrBenchmarkEngineFamily.ppFormulaNetPlusL,
      );
      expect(ppFormulaNetPlusL.mayBePrimaryFormulaRecognizer, isTrue);
      expect(ppFormulaNetPlusL.mayBeFallback, isFalse);
      for (final rule in GaussWinnerEngineSelection.candidateRules) {
        expect(rule.requiresEditableMathLiveReview, isTrue);
        expect(rule.directSolveAllowed, isFalse);
        expect(rule.baseApkModelBundlingAllowed, isFalse);
        expect(rule.mustProve, isNotEmpty);
        expect(rule.rejectionReasons, isNotEmpty);
      }
    });

    test('blocks selection without real benchmark evidence and unsafe evidence', () {
      final noReport = GaussWinnerEngineSelection.evaluateEvidence(
        const GaussWinnerEngineSelectionEvidence(
          hasRealBenchmarkReport: false,
          sampleCount: 0,
          mathLiveReviewRequired: true,
          directSolveAllowed: false,
          licenseClearedForDistribution: false,
          offlineAfterInstallProven: false,
          modelSizeBytes: 0,
          medianLatencyMs: 0,
          claimsPlainTextOcrFallbackAsPrimary: false,
        ),
      );
      expect(noReport.decision, GaussWinnerEngineSelectionDecision.blockedNoRealBenchmarkReport);
      expect(noReport.benchmarkWinnerSelected, isFalse);
      expect(noReport.productionRuntimeBindingAllowed, isFalse);

      final directSolve = GaussWinnerEngineSelection.evaluateEvidence(
        const GaussWinnerEngineSelectionEvidence(
          hasRealBenchmarkReport: true,
          sampleCount: 30,
          mathLiveReviewRequired: true,
          directSolveAllowed: true,
          licenseClearedForDistribution: true,
          offlineAfterInstallProven: true,
          modelSizeBytes: 1000000,
          medianLatencyMs: 400,
          claimsPlainTextOcrFallbackAsPrimary: false,
        ),
      );
      expect(directSolve.decision, GaussWinnerEngineSelectionDecision.blockedUnsafeDirectSolve);

      final textOcrFallbackPrimary = GaussWinnerEngineSelection.evaluateEvidence(
        const GaussWinnerEngineSelectionEvidence(
          hasRealBenchmarkReport: true,
          sampleCount: 30,
          mathLiveReviewRequired: true,
          directSolveAllowed: false,
          licenseClearedForDistribution: true,
          offlineAfterInstallProven: true,
          modelSizeBytes: 1000000,
          medianLatencyMs: 400,
          claimsPlainTextOcrFallbackAsPrimary: true,
        ),
      );
      expect(textOcrFallbackPrimary.decision, GaussWinnerEngineSelectionDecision.blockedPlainTextOcrFallbackPrimaryClaim);
    });

    test('allows only Q248 planning when all hard gates are proven', () {
      final result = GaussWinnerEngineSelection.evaluateEvidence(
        const GaussWinnerEngineSelectionEvidence(
          hasRealBenchmarkReport: true,
          sampleCount: 30,
          mathLiveReviewRequired: true,
          directSolveAllowed: false,
          licenseClearedForDistribution: true,
          offlineAfterInstallProven: true,
          modelSizeBytes: 40000000,
          medianLatencyMs: 900,
          claimsPlainTextOcrFallbackAsPrimary: false,
        ),
      );
      expect(result.decision, GaussWinnerEngineSelectionDecision.eligibleForQ248DeferredModelDownloadPlanning);
      expect(result.mayProceedToQ248PlanningOnly, isTrue);
      expect(result.benchmarkWinnerSelected, isFalse);
      expect(result.productionRuntimeBindingAllowed, isFalse);
    });

    test('preserves runtime dependencies and direct solve safety boundaries', () {
      final pubspec = File('pubspec.yaml').readAsStringSync();
      final settings = File('android/settings.gradle').readAsStringSync();
      final manifest = File('android/app/src/main/AndroidManifest.xml').readAsStringSync();

      expect(pubspec, contains(RegExp(r'^\s*camera\s*:\s*0\.10\.6\s*$', multiLine: true)));
      expect(pubspec, contains(RegExp(r'^\s*camera_android\s*:\s*0\.10\.9\+3\s*$', multiLine: true)));
      expect(pubspec, isNot(contains('camera_android_camerax')));
      expect(pubspec, isNot(contains('google_mlkit_text_recognition')));
      expect(pubspec, isNot(contains('onnxruntime')));
      expect(pubspec, isNot(contains('paddleocr')));
      expect(pubspec, isNot(contains('pix2text')));
      expect(settings, contains("id 'org.jetbrains.kotlin.android' version '2.1.0' apply false"));
      expect(
        settings.contains("id 'com.android.application' version '8.3.2' apply false") ||
            settings.contains("id 'com.android.application' version '8.6.1' apply false"),
        isTrue,
      );
      expect(manifest, contains('android.permission.CAMERA'));
      expect(manifest, contains('android.permission.INTERNET')); // Q384R1 download-only model installer requires user-tapped network access.
      expect(manifest, isNot(contains('READ_MEDIA_IMAGES')));

      expect(GaussWinnerEngineSelectionPolicy.cameraRuntimeShellChanged, isFalse);
      expect(GaussWinnerEngineSelectionPolicy.workspaceRuntimeChanged, isFalse);
      expect(GaussWinnerEngineSelectionPolicy.mathLiveProductionBridgeCalled, isFalse);
      expect(GaussWinnerEngineSelectionPolicy.directWorkspaceImportImplemented, isFalse);
      expect(GaussWinnerEngineSelectionPolicy.directSolveFromCameraAllowed, isFalse);
      expect(GaussWinnerEngineSelectionPolicy.directGraphFromCameraAllowed, isFalse);
      expect(GaussWinnerEngineSelectionPolicy.directSolutionFromCameraAllowed, isFalse);
      expect(GaussWinnerEngineSelectionPolicy.directHistoryFromCameraAllowed, isFalse);
    });
  });
}
