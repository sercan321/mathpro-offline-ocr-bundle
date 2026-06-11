import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_ocr_engine_real_benchmark_package.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_ocr_engine_real_benchmark_package_policy.dart';

void main() {
  group('V172-Q246 OCR engine real benchmark package', () {
    test('defines a real benchmark package without selecting or binding an OCR runtime', () {
      expect(
        GaussOcrEngineRealBenchmarkPackagePolicy.phase,
        'V172-Q246-OCR-ENGINE-REAL-BENCHMARK-PACKAGE',
      );
      expect(
        GaussOcrEngineRealBenchmarkPackagePolicy.closesOverPhase,
        'V172-Q245-CAMERA-REAL-DEVICE-EVIDENCE-CLOSURE',
      );
      expect(GaussOcrEngineRealBenchmarkPackagePolicy.sourcePackageSha256, hasLength(64));
      expect(GaussOcrEngineRealBenchmarkPackagePolicy.packageIsBenchmarkProtocolOnly, isTrue);
      expect(GaussOcrEngineRealBenchmarkPackagePolicy.benchmarkWinnerSelected, isFalse);
      expect(GaussOcrEngineRealBenchmarkPackagePolicy.realOcrRuntimeAdded, isFalse);
      expect(GaussOcrEngineRealBenchmarkPackagePolicy.modelBinaryBundledInBaseApp, isFalse);
      expect(GaussOcrEngineRealBenchmarkPackagePolicy.productionInferenceAllowed, isFalse);
      expect(GaussOcrEngineRealBenchmarkPackagePolicy.mathLiveEditableReviewRequiredBeforeImport, isTrue);
      expect(GaussOcrEngineRealBenchmarkPackage.canSelectWinnerInQ246, isFalse);
    });

    test('keeps all six candidate families and requires real-image evidence before Q247', () {
      expect(GaussOcrEngineRealBenchmarkPackage.hasAllCandidateFamilies, isTrue);
      expect(GaussOcrEngineRealBenchmarkPackage.candidateProbes.map((probe) => probe.label), containsAll(<String>[
        'PP-FormulaNet-S',
        'PP-FormulaNet_plus-S',
        'Pix2Text MFR ONNX',
        'UniMERNet tiny',
        'TexTeller',
        'PP-FormulaNet_plus-L',
      ]));
      for (final probe in GaussOcrEngineRealBenchmarkPackage.candidateProbes) {
        expect(probe.baseAppRuntimeBundled, isFalse);
        expect(probe.productionBindingAllowedInQ246, isFalse);
        expect(probe.canWinWithoutRealImages, isFalse);
        expect(probe.requiresMathLiveEditableReview, isTrue);
        expect(probe.requiredEvidence, isNotEmpty);
        expect(probe.rejectionTriggers, isNotEmpty);
      }
    });

    test('covers integral, derivative, fraction, radical, limit, sigma, matrix, handwriting, and poor capture cases', () {
      expect(GaussOcrEngineRealBenchmarkPackage.hasEnoughRealImageCases, isTrue);
      final joined = GaussOcrEngineRealBenchmarkPackage.requiredImageCases
          .map((item) => '${item.id} ${item.expectedLatex} ${item.captureCondition} ${item.structuralFocus}')
          .join('\n');
      for (final marker in <String>[
        r'\frac{x+1}{x-1}',
        r'\sqrt{x+1}',
        r'\int x^2\,dx',
        r'\int_0^1 x^2\,dx',
        r"y''+3y'+2y=0",
        r'\frac{d}{dx}\sin x',
        r'\lim_{x\to0}\frac{\sin x}{x}',
        r'\sum_{n=1}^{10}n^2',
        r'\begin{bmatrix}1&2\\3&4\end{bmatrix}',
        'simple handwriting',
        'low light',
        'skewed camera angle',
        'mild blur',
      ]) {
        expect(joined, contains(marker));
      }
      expect(GaussOcrEngineRealBenchmarkPackage.hasHardGatesForMobileSelection, isTrue);
    });

    test('preserves app runtime, dependency, and direct solve safety gates', () {
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

      expect(GaussOcrEngineRealBenchmarkPackagePolicy.cameraRuntimeShellChanged, isFalse);
      expect(GaussOcrEngineRealBenchmarkPackagePolicy.workspaceRuntimeChanged, isFalse);
      expect(GaussOcrEngineRealBenchmarkPackagePolicy.mathLiveProductionBridgeCalled, isFalse);
      expect(GaussOcrEngineRealBenchmarkPackagePolicy.directWorkspaceImportImplemented, isFalse);
      expect(GaussOcrEngineRealBenchmarkPackagePolicy.directSolveFromCameraAllowed, isFalse);
      expect(GaussOcrEngineRealBenchmarkPackagePolicy.directGraphFromCameraAllowed, isFalse);
      expect(GaussOcrEngineRealBenchmarkPackagePolicy.directSolutionFromCameraAllowed, isFalse);
      expect(GaussOcrEngineRealBenchmarkPackagePolicy.directHistoryFromCameraAllowed, isFalse);
    });
  });
}
