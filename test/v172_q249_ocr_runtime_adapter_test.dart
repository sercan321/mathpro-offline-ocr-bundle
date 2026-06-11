import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_deferred_model_download_runtime.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_ocr_runtime_adapter.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_ocr_runtime_adapter_policy.dart';

// Q249 dependency sentinels: camera: 0.10.6, camera_android: 0.10.9+3
void main() {
  group('V172-Q249 PP-FormulaNet-S OCR runtime adapter contract', () {
    const validHash = '0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef';

    const readyEvidence = GaussDeferredModelArtifactEvidence(
      status: GaussDeferredModelDownloadStatus.ready,
      expectedSha256: validHash,
      actualSha256: validHash,
      modelSizeBytes: 42 * 1024 * 1024,
      storedInPrivateAppStorage: true,
      offlineAfterInstall: true,
      mathLiveReviewRequired: true,
      directSolveAllowed: false,
      productionUrlBound: false,
      modelBinaryBundledInBaseApp: false,
    );

    test('records Q249 as a PP-FormulaNet-S review-only adapter contract', () {
      expect(GaussOcrRuntimeAdapterPolicy.phase, 'V172-Q249-OCR-RUNTIME-ADAPTER');
      expect(GaussOcrRuntimeAdapterPolicy.closesOverPhase, 'V172-Q248-DEFERRED-MODEL-DOWNLOAD-RUNTIME');
      expect(GaussOcrRuntimeAdapterPolicy.selectedEngineLabel, 'PP-FormulaNet-S');
      expect(GaussOcrRuntimeAdapterPolicy.adapterInputEnvelopeImplemented, isTrue);
      expect(GaussOcrRuntimeAdapterPolicy.adapterOutputEnvelopeImplemented, isTrue);
      expect(GaussOcrRuntimeAdapterPolicy.latexCandidateContractImplemented, isTrue);
      expect(GaussOcrRuntimeAdapterPolicy.mathLiveEditableReviewRequiredBeforeImport, isTrue);
      expect(GaussOcrRuntimeAdapterPolicy.productionInferenceAllowed, isFalse);
      expect(GaussOcrRuntimeAdapterPolicy.productionRuntimeBindingAllowed, isFalse);
      expect(GaussOcrRuntimeAdapterPolicy.directSolveFromCameraAllowed, isFalse);
      expect(GaussOcrRuntimeAdapter.realInferenceEnabledInQ249, isFalse);
    });

    test('blocks adapter review when Q248 model readiness is not satisfied', () {
      const notReadyEvidence = GaussDeferredModelArtifactEvidence(
        status: GaussDeferredModelDownloadStatus.verifying,
        expectedSha256: validHash,
        actualSha256: validHash,
        modelSizeBytes: 42 * 1024 * 1024,
        storedInPrivateAppStorage: true,
        offlineAfterInstall: true,
        mathLiveReviewRequired: true,
        directSolveAllowed: false,
        productionUrlBound: false,
        modelBinaryBundledInBaseApp: false,
      );

      final envelope = GaussOcrRuntimeAdapter.createReviewOnlyEnvelope(
        input: const GaussOcrRuntimeAdapterInput(
          capturePath: '/tmp/capture.png',
          cropFrameId: 'frame-1',
          rotationQuarterTurns: 0,
          modelEvidence: notReadyEvidence,
          preprocessProfile: 'q249-premium-crop-normalize',
          sourcePhase: GaussDeferredModelDownloadRuntime.phase,
        ),
      );

      expect(envelope.decision, GaussOcrRuntimeAdapterDecision.blockedByDeferredModelGate);
      expect(envelope.mayOpenMathLiveReviewOnly, isFalse);
      expect(envelope.productionInferenceAllowed, isFalse);
      expect(envelope.directSolveAllowed, isFalse);
    });

    test('allows only review envelope readiness, never direct solve or direct import', () {
      const candidate = GaussOcrRuntimeLatexCandidate(
        rank: 1,
        latex: r'\int_0^1 x^2\,dx',
        confidence: 0.88,
        engineLabel: 'PP-FormulaNet-S',
        warningCodes: <GaussOcrRuntimeWarningCode>[
          GaussOcrRuntimeWarningCode.possibleIntegralLimitAmbiguity,
        ],
        reviewOnly: true,
      );

      final envelope = GaussOcrRuntimeAdapter.createReviewOnlyEnvelope(
        input: const GaussOcrRuntimeAdapterInput(
          capturePath: '/tmp/capture.png',
          cropFrameId: 'frame-1',
          rotationQuarterTurns: 1,
          modelEvidence: readyEvidence,
          preprocessProfile: 'q249-premium-crop-normalize',
          sourcePhase: GaussDeferredModelDownloadRuntime.phase,
        ),
        primaryCandidate: candidate,
      );

      expect(envelope.decision, GaussOcrRuntimeAdapterDecision.reviewOnlyEnvelopeReady);
      expect(envelope.mayOpenMathLiveReviewOnly, isTrue);
      expect(envelope.primaryCandidate!.requiresEditableMathLiveReview, isTrue);
      expect(envelope.primaryCandidate!.directWorkspaceImportAllowed, isFalse);
      expect(envelope.primaryCandidate!.directSolveAllowed, isFalse);
      expect(envelope.graphAllowedBeforeReview, isFalse);
      expect(envelope.solutionAllowedBeforeReview, isFalse);
      expect(envelope.historyWriteAllowedBeforeReview, isFalse);
    });

    test('blocks unsafe candidate shapes before MathLive review', () {
      const candidate = GaussOcrRuntimeLatexCandidate(
        rank: 0,
        latex: '',
        confidence: 1.5,
        engineLabel: 'OtherEngine',
        warningCodes: <GaussOcrRuntimeWarningCode>[],
        reviewOnly: false,
      );

      final envelope = GaussOcrRuntimeAdapter.createReviewOnlyEnvelope(
        input: const GaussOcrRuntimeAdapterInput(
          capturePath: '/tmp/capture.png',
          cropFrameId: 'frame-1',
          rotationQuarterTurns: 0,
          modelEvidence: readyEvidence,
          preprocessProfile: 'q249-premium-crop-normalize',
          sourcePhase: GaussDeferredModelDownloadRuntime.phase,
        ),
        primaryCandidate: candidate,
      );

      expect(envelope.decision, GaussOcrRuntimeAdapterDecision.blockedUnsafeCandidate);
      expect(envelope.issues.length, greaterThanOrEqualTo(4));
      expect(envelope.mayOpenMathLiveReviewOnly, isFalse);
    });

    test('keeps dependencies, Android toolchain, and production runtime surfaces untouched', () {
      final pubspec = File('pubspec.yaml').readAsStringSync();
      final settings = File('android/settings.gradle').readAsStringSync();
      final manifest = File('android/app/src/main/AndroidManifest.xml').readAsStringSync();
      final bridge = File('assets/mathlive/mathlive_prod_bridge.js').readAsStringSync();

      expect(pubspec, contains(RegExp(r'^\s*camera\s*:\s*0\.10\.6\s*$', multiLine: true)));
      expect(pubspec, contains(RegExp(r'^\s*camera_android\s*:\s*0\.10\.9\+3\s*$', multiLine: true)));
      expect(pubspec, isNot(contains('camera_android_camerax')));
      expect(pubspec, isNot(contains('google_mlkit_text_recognition')));
      expect(pubspec, isNot(contains('paddleocr')));
      expect(pubspec, isNot(contains('onnxruntime')));
      expect(settings, contains("id 'org.jetbrains.kotlin.android' version '2.1.0' apply false"));
      expect(
        settings.contains("id 'com.android.application' version '8.3.2' apply false") ||
            settings.contains("id 'com.android.application' version '8.6.1' apply false"),
        isTrue,
      );
      expect(manifest, contains('android.permission.CAMERA'));
      expect(bridge, isNot(contains('runPpFormulaNetSInference')));
      expect(bridge, isNot(contains('setWorkspaceLatexWithoutReview')));
    });
  });
}
