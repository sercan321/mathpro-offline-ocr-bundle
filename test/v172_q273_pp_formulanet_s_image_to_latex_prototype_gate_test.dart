import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_pp_formulanet_s_image_to_latex_prototype_gate.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_pp_formulanet_s_image_to_latex_prototype_gate_policy.dart';

void main() {
  group('V172-Q273-PP-FORMULANET-S-IMAGE-TO-LATEX-PROTOTYPE-GATE', () {
    const approvedInput = GaussPpFormulaNetSImageToLatexPrototypeGateInput(
      q272FirstRuntimeSmokePrototypePresent: true,
      q272StillNoRuntimeNoInference: true,
      croppedImageInputEnvelopeDocumented: true,
      preprocessMetadataDocumented: true,
      runtimeCandidateResponseEnvelopeDocumented: true,
      primaryLatexCandidateFieldDocumented: true,
      alternativeLatexCandidatesFieldDocumented: true,
      confidenceFieldDocumented: true,
      warningsFieldDocumented: true,
      engineMetadataFieldDocumented: true,
      imageHashFieldDocumented: true,
      cropBoundsFieldDocumented: true,
      rotationAndOrientationFieldDocumented: true,
      lightingAndFocusHintsDocumented: true,
      timeoutCancellationPolicyDocumented: true,
      memoryPressurePolicyDocumented: true,
      latencyBudgetMs: 2500,
      peakMemoryBudgetMb: 256,
      featureFlagDefaultOffDocumented: true,
      noDefaultRuntimeEnablement: true,
      editableMathLiveReviewRequired: true,
      userApprovalRequiredBeforeWorkspaceImport: true,
      directSolveBlocked: true,
      directGraphSolutionHistoryBlocked: true,
      noPaddleRuntimeAdded: true,
      noPaddleOcrDependencyAdded: true,
      noNativeBridgeImplementationAdded: true,
      noJniBindingAdded: true,
      noMethodChannelRuntimeBindingAdded: true,
      noModelBinaryBundledInBaseApp: true,
      noProductionModelUrlBound: true,
      noRealNetworkDownloadWorkerImplemented: true,
      productionDownloadEnabled: false,
      noProductionInferenceAllowed: true,
      noRealImageToLatexInferenceExecuted: true,
      imageToLatexPassClaimed: false,
      ocrPassClaimed: false,
      prototypeLabel: 'Q273 ready for future image-to-latex prototype only',
    );

    test('gates image-to-LaTeX candidate envelope without real inference in Q273', () {
      final result = GaussPpFormulaNetSImageToLatexPrototypeGate.evaluate(approvedInput);
      expect(result.decision, GaussPpFormulaNetSImageToLatexPrototypeGateDecision.readyForFutureImageToLatexPrototypeOnly);
      expect(result.imageToLatexPrototypeStaticReady, isTrue);
      expect(result.phase, GaussPpFormulaNetSImageToLatexPrototypeGatePolicy.phase);
      expect(result.sourcePhase, GaussPpFormulaNetSImageToLatexPrototypeGatePolicy.sourcePhase);
      expect(result.selectedEngineLabel, 'PP-FormulaNet-S');
      expect(result.imageToLatexPrototypeMode, 'image-to-latex-prototype-gate-only-no-real-inference-no-production-runtime');
      expect(result.requiredPrototypeGates, contains('croppedImageInputEnvelopeDocumented'));
      expect(result.requiredPrototypeGates, contains('primaryLatexCandidateFieldDocumented'));
      expect(result.requiredPrototypeGates, contains('noRealImageToLatexInferenceInQ273'));
      expect(result.imageInputEnvelopeFields, contains('croppedImageSha256'));
      expect(result.imageInputEnvelopeFields, contains('reviewOnlyMode'));
      expect(result.latexCandidateEnvelopeFields, contains('primaryLatexCandidate'));
      expect(result.latexCandidateEnvelopeFields, contains('mathLiveReviewRequired'));
      expect(result.prototypeFailureCodes, contains('unsafeRuntimeInferenceAttempted'));
      expect(result.forbiddenActions, contains('runRealImageToLatexInQ273'));
      expect(result.realOcrRuntimeAdded, isFalse);
      expect(result.paddleRuntimeAdded, isFalse);
      expect(result.paddleOcrDependencyAdded, isFalse);
      expect(result.nativeBridgeImplementationAdded, isFalse);
      expect(result.jniBindingAdded, isFalse);
      expect(result.methodChannelRuntimeBindingAdded, isFalse);
      expect(result.modelBinaryBundledInBaseApp, isFalse);
      expect(result.productionDownloadEnabled, isFalse);
      expect(result.productionInferenceAllowed, isFalse);
      expect(result.runtimeFeatureFlagDefaultOff, isTrue);
      expect(result.realImageToLatexInferenceExecuted, isFalse);
      expect(result.imageToLatexPassClaimed, isFalse);
      expect(result.ocrPassClaimed, isFalse);
      expect(result.canRunRealImageToLatexInQ273, isFalse);
      expect(result.canClaimImageToLatexPassInQ273, isFalse);
      expect(result.canClaimOcrPassInQ273, isFalse);
      expect(result.canEnableRuntimeByDefaultInQ273, isFalse);
      expect(result.canImportCameraOutputWithoutUserApproval, isFalse);
    });

    test('rejects direct inference or unsafe OCR pass claims', () {
      final unsafe = GaussPpFormulaNetSImageToLatexPrototypeGate.evaluate(
        const GaussPpFormulaNetSImageToLatexPrototypeGateInput(
          q272FirstRuntimeSmokePrototypePresent: true,
          q272StillNoRuntimeNoInference: true,
          croppedImageInputEnvelopeDocumented: true,
          preprocessMetadataDocumented: true,
          runtimeCandidateResponseEnvelopeDocumented: true,
          primaryLatexCandidateFieldDocumented: true,
          alternativeLatexCandidatesFieldDocumented: true,
          confidenceFieldDocumented: true,
          warningsFieldDocumented: true,
          engineMetadataFieldDocumented: true,
          imageHashFieldDocumented: true,
          cropBoundsFieldDocumented: true,
          rotationAndOrientationFieldDocumented: true,
          lightingAndFocusHintsDocumented: true,
          timeoutCancellationPolicyDocumented: true,
          memoryPressurePolicyDocumented: true,
          latencyBudgetMs: 2500,
          peakMemoryBudgetMb: 256,
          featureFlagDefaultOffDocumented: true,
          noDefaultRuntimeEnablement: true,
          editableMathLiveReviewRequired: true,
          userApprovalRequiredBeforeWorkspaceImport: true,
          directSolveBlocked: true,
          directGraphSolutionHistoryBlocked: true,
          noPaddleRuntimeAdded: true,
          noPaddleOcrDependencyAdded: true,
          noNativeBridgeImplementationAdded: true,
          noJniBindingAdded: true,
          noMethodChannelRuntimeBindingAdded: true,
          noModelBinaryBundledInBaseApp: true,
          noProductionModelUrlBound: true,
          noRealNetworkDownloadWorkerImplemented: true,
          productionDownloadEnabled: false,
          noProductionInferenceAllowed: true,
          noRealImageToLatexInferenceExecuted: false,
          imageToLatexPassClaimed: true,
          ocrPassClaimed: true,
          prototypeLabel: 'unsafe direct inference claim',
        ),
      );
      expect(unsafe.decision, GaussPpFormulaNetSImageToLatexPrototypeGateDecision.blockedRealInferenceOrPassClaimedInQ273);
      expect(unsafe.imageToLatexPrototypeStaticReady, isFalse);
      expect(unsafe.canClaimOcrPassInQ273, isFalse);
    });

    test('keeps runtime dependency and production URL out of the package', () {
      final pubspec = String.fromCharCodes(File('pubspec.yaml').readAsBytesSync()).toLowerCase();
      for (final forbidden in <String>[
        'google_mlkit_text_recognition',
        'paddleocr',
        'paddle_flutter',
        'paddle_lite',
        'onnxruntime',
        'tesseract',
        'pix2text',
        'flutter_downloader',
        'background_downloader',
        'dio',
      ]) {
        expect(pubspec.contains(forbidden), isFalse, reason: 'Q273 must not add $forbidden');
      }
    });
  });
}
