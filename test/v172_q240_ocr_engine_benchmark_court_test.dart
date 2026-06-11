import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_ocr_engine_benchmark_court.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_ocr_engine_benchmark_court_policy.dart';

void main() {
  group('V172-Q240 OCR engine benchmark court foundation', () {
    test('policy locks benchmark-only scope without runtime/model/direct solve', () {
      expect(GaussOcrEngineBenchmarkCourtPolicy.phase, 'V172-Q240');
      expect(GaussOcrEngineBenchmarkCourtPolicy.fullPhase, 'V172-Q240-OCR-ENGINE-BENCHMARK-COURT-FOUNDATION');
      expect(GaussOcrEngineBenchmarkCourtPolicy.q239eMathLiveReviewSurfacePreserved, isTrue);
      expect(GaussOcrEngineBenchmarkCourtPolicy.q239dDeferredModelManagerPreserved, isTrue);
      expect(GaussOcrEngineBenchmarkCourtPolicy.benchmarkCourtContractImplemented, isTrue);
      expect(GaussOcrEngineBenchmarkCourtPolicy.candidateEngineRegistryImplemented, isTrue);
      expect(GaussOcrEngineBenchmarkCourtPolicy.benchmarkCaseTaxonomyImplemented, isTrue);
      expect(GaussOcrEngineBenchmarkCourtPolicy.scoringRubricContractImplemented, isTrue);
      expect(GaussOcrEngineBenchmarkCourtPolicy.winnerSelectionContractImplemented, isTrue);
      expect(GaussOcrEngineBenchmarkCourtPolicy.appRuntimeIsolationRequired, isTrue);
      expect(GaussOcrEngineBenchmarkCourtPolicy.desktopOrLabBenchmarkOnly, isTrue);
      expect(GaussOcrEngineBenchmarkCourtPolicy.mathLiveEditableReviewRemainsRequired, isTrue);
      expect(GaussOcrEngineBenchmarkCourtPolicy.realOcrEngineAdded, isFalse);
      expect(GaussOcrEngineBenchmarkCourtPolicy.textOcrFallbackAdded, isFalse);
      expect(GaussOcrEngineBenchmarkCourtPolicy.paddleRuntimeAdded, isFalse);
      expect(GaussOcrEngineBenchmarkCourtPolicy.pix2TextRuntimeAdded, isFalse);
      expect(GaussOcrEngineBenchmarkCourtPolicy.texTellerRuntimeAdded, isFalse);
      expect(GaussOcrEngineBenchmarkCourtPolicy.uniMerNetRuntimeAdded, isFalse);
      expect(GaussOcrEngineBenchmarkCourtPolicy.onnxRuntimeAdded, isFalse);
      expect(GaussOcrEngineBenchmarkCourtPolicy.modelBinaryBundledInBaseApp, isFalse);
      expect(GaussOcrEngineBenchmarkCourtPolicy.productionModelUrlBound, isFalse);
      expect(GaussOcrEngineBenchmarkCourtPolicy.backgroundDownloadWorkerImplemented, isFalse);
      expect(GaussOcrEngineBenchmarkCourtPolicy.productionMathLiveBridgeCalled, isFalse);
      expect(GaussOcrEngineBenchmarkCourtPolicy.directWorkspaceImportImplemented, isFalse);
      expect(GaussOcrEngineBenchmarkCourtPolicy.directSolveFromCameraAllowed, isFalse);
      expect(GaussOcrEngineBenchmarkCourtPolicy.benchmarkWinnerSelected, isFalse);
      expect(GaussOcrEngineBenchmarkCourtPolicy.cameraShellRuntimeMutationAllowed, isFalse);
      expect(GaussOcrEngineBenchmarkCourtPolicy.keyboardMutationAllowed, isFalse);
      expect(GaussOcrEngineBenchmarkCourtPolicy.mathLiveProductionMutationAllowed, isFalse);
      expect(GaussOcrEngineBenchmarkCourtPolicy.flutterRunPassClaimedByAssistant, isFalse);
      expect(GaussOcrEngineBenchmarkCourtPolicy.androidRealDeviceBenchmarkPassClaimedByAssistant, isFalse);
      expect(GaussOcrEngineBenchmarkCourtPolicy.importContract, contains('MathLive editable review'));
    });

    test('candidate registry covers primary, fallback, and research engines without bundling runtimes', () {
      expect(GaussOcrEngineBenchmarkCourt.phase, GaussOcrEngineBenchmarkCourtPolicy.fullPhase);
      expect(GaussOcrEngineBenchmarkCourt.appRuntimeIsolationRequired, isTrue);
      expect(GaussOcrEngineBenchmarkCourt.winnerSelectionRequiredBeforeRuntimeBinding, isTrue);
      expect(GaussOcrEngineBenchmarkCourt.mathLiveReviewRequiredAfterRecognition, isTrue);
      expect(GaussOcrEngineBenchmarkCourt.directSolveAllowed, isFalse);
      expect(GaussOcrEngineBenchmarkCourt.hasPrimaryAndFallbackCandidates, isTrue);

      final families = GaussOcrEngineBenchmarkCourt.candidateEngines.map((engine) => engine.family).toSet();
      expect(families, contains(GaussOcrBenchmarkEngineFamily.ppFormulaNetS));
      expect(families, contains(GaussOcrBenchmarkEngineFamily.ppFormulaNetPlusS));
      expect(families, contains(GaussOcrBenchmarkEngineFamily.pix2TextMfrOnnx));
      expect(families, contains(GaussOcrBenchmarkEngineFamily.uniMerNetTiny));
      expect(families, contains(GaussOcrBenchmarkEngineFamily.texTeller));
      expect(families, contains(GaussOcrBenchmarkEngineFamily.ppFormulaNetPlusL));

      for (final engine in GaussOcrEngineBenchmarkCourt.candidateEngines) {
        expect(engine.baseAppRuntimeBundled, isFalse, reason: engine.label);
        expect(engine.productionReadyInQ240, isFalse, reason: engine.label);
        expect(engine.directSolveAllowed, isFalse, reason: engine.label);
        expect(engine.requiresMathLiveReview, isTrue, reason: engine.label);
      }
    });

    test('benchmark case taxonomy covers calculus, structure, handwriting, and capture robustness', () {
      expect(GaussOcrEngineBenchmarkCourt.hasEnoughCaseCoverage, isTrue);
      final kinds = GaussOcrEngineBenchmarkCourt.requiredCases.map((item) => item.kind).toSet();
      expect(kinds, contains(GaussOcrBenchmarkCaseKind.definiteIntegral));
      expect(kinds, contains(GaussOcrBenchmarkCaseKind.indefiniteIntegral));
      expect(kinds, contains(GaussOcrBenchmarkCaseKind.derivativePrimeNotation));
      expect(kinds, contains(GaussOcrBenchmarkCaseKind.derivativeLeibnizNotation));
      expect(kinds, contains(GaussOcrBenchmarkCaseKind.fraction));
      expect(kinds, contains(GaussOcrBenchmarkCaseKind.squareRoot));
      expect(kinds, contains(GaussOcrBenchmarkCaseKind.sigma));
      expect(kinds, contains(GaussOcrBenchmarkCaseKind.matrix));
      expect(kinds, contains(GaussOcrBenchmarkCaseKind.simpleHandwriting));
      expect(kinds, contains(GaussOcrBenchmarkCaseKind.lowLightCapture));
      expect(kinds, contains(GaussOcrBenchmarkCaseKind.skewedCapture));
      expect(kinds, contains(GaussOcrBenchmarkCaseKind.blurredCapture));
      expect(GaussOcrEngineBenchmarkCourt.scoringDimensions, contains('latexExactness'));
      expect(GaussOcrEngineBenchmarkCourt.scoringDimensions, contains('integralLimitPlacement'));
      expect(GaussOcrEngineBenchmarkCourt.scoringDimensions, contains('derivativeNotationFidelity'));
      expect(GaussOcrEngineBenchmarkCourt.scoringDimensions, contains('androidRuntimeBindingRisk'));
    });

    test('Q240 remains isolated from app runtime dependencies and production mutation paths', () {
      final benchmarkCourt = File('lib/features/camera/gauss_ocr_engine_benchmark_court.dart').readAsStringSync();
      final policy = File('lib/features/camera/gauss_ocr_engine_benchmark_court_policy.dart').readAsStringSync();
      final cameraShell = File('lib/features/camera/gauss_camera_capture_shell.dart').readAsStringSync();
      final reviewSurface = File('lib/features/camera/gauss_mathlive_ocr_review_surface.dart').readAsStringSync();
      final pubspec = File('pubspec.yaml').readAsStringSync();
      final androidManifest = File('android/app/src/main/AndroidManifest.xml').readAsStringSync();
      final combined = '$benchmarkCourt\n$policy\n$cameraShell\n$reviewSurface';

      expect(combined, contains('PP-FormulaNet-S'));
      expect(combined, contains('Pix2Text MFR ONNX'));
      expect(combined, contains('PP-FormulaNet_plus-L'));
      expect(combined, contains('MathLive editable review'));
      expect(combined, isNot(contains('evaluateFromCamera')));
      expect(combined, isNot(contains('solveFromCamera')));
      expect(combined, isNot(contains('setLatex')));
      expect(pubspec, contains(RegExp(r'^\s*camera\s*:\s*(0\.11\.0|0\.10\.6)\s*$', multiLine: true)));
      expect(pubspec, isNot(contains('camera_android_camerax')));
      expect(pubspec, contains(RegExp(r'^\s*shared_preferences:\s*\^2\.5\.5\s*$', multiLine: true)));
      expect(pubspec, isNot(contains(RegExp(r'^\s*google_mlkit_text_recognition\s*:', multiLine: true))));
      expect(pubspec, isNot(contains(RegExp(r'^\s*onnxruntime\s*:', multiLine: true))));
      expect(pubspec, isNot(contains(RegExp(r'^\s*workmanager\s*:', multiLine: true))));
      expect(androidManifest, contains('<uses-permission android:name="android.permission.CAMERA" />'));
      expect(androidManifest, isNot(contains('READ_MEDIA_IMAGES')));
      expect(androidManifest, isNot(contains('READ_EXTERNAL_STORAGE')));
    });
  });
}
