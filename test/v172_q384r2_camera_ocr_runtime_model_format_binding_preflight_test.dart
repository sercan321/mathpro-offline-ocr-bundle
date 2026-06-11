import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_camera_ocr_runtime_model_format_binding_q384r2.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_deferred_math_ocr_model_manager.dart';

void main() {
  group('V172-Q384R2 camera OCR runtime/model-format binding preflight', () {
    test('policy aligns Q384R1 downloaded Paddle artifact without claiming OCR inference', () {
      expect(
        GaussCameraOcrRuntimeModelFormatBindingQ384R2Policy.phase,
        'V172-Q384R2-CAMERA-OCR-RUNTIME-MODEL-FORMAT-BINDING-PREFLIGHT',
      );
      expect(
        GaussCameraOcrRuntimeModelFormatBindingQ384R2Policy.sourcePhase,
        'V172-Q384R1-CAMERA-OCR-DEFERRED-MODEL-DOWNLOAD-ACTIVATION',
      );
      expect(GaussCameraOcrRuntimeModelFormatBindingQ384R2Policy.artifactFormat, 'paddle-inference-directory');
      expect(GaussCameraOcrRuntimeModelFormatBindingQ384R2Policy.primaryModelFileName, 'inference.pdiparams');
      expect(
        GaussCameraOcrRuntimeModelFormatBindingQ384R2Policy.expectedPrimarySha256,
        'b6392296d16e2a9f414c0a751d7ccbd1bd9d8272b68aab72df1d3875f35a7489',
      );
      expect(GaussCameraOcrRuntimeModelFormatBindingQ384R2Policy.q384r1InstallPathPassedToNativeBridge, isTrue);
      expect(GaussCameraOcrRuntimeModelFormatBindingQ384R2Policy.paddleInferenceDirectoryPreflightImplemented, isTrue);
      expect(GaussCameraOcrRuntimeModelFormatBindingQ384R2Policy.onnxMissingReasonRetiredForQ384R2ReviewFlow, isTrue);
      expect(GaussCameraOcrRuntimeModelFormatBindingQ384R2Policy.productionInferenceClaimedByQ384R2, isFalse);
      expect(GaussCameraOcrRuntimeModelFormatBindingQ384R2Policy.fakeLatexCandidateAllowed, isFalse);
      expect(GaussCameraOcrRuntimeModelFormatBindingQ384R2Policy.workspaceAutoImportAllowed, isFalse);
      expect(GaussCameraOcrRuntimeModelFormatBindingQ384R2Policy.solveGraphSolutionHistoryTouched, isFalse);
    });

    test('manifest and manager stay download-only and Paddle-format aligned', () {
      expect(GaussCameraOcrRuntimeModelFormatBindingQ384R2Policy.requiredArtifactFiles, containsAll(<String>[
        'config.json',
        'inference.json',
        'inference.yml',
        'inference.pdiparams',
      ]));
      expect(GaussDeferredMathOcrModelManifest.modelName, contains('PP-FormulaNet'));
      expect(GaussDeferredMathOcrModelManifest.modelName, contains('plus'));
      expect(GaussDeferredMathOcrModelManifest.androidRuntimeRequiredArtifactKind, contains('nb'));
      expect(GaussDeferredMathOcrModelManifest.productionPaddleLiteNbAcquiredForAndroidRuntime, isFalse);
      expect(GaussDeferredMathOcrModelManifest.productionDownloadUrlBound, isTrue);
      expect(GaussDeferredMathOcrModelManifest.modelBinaryBundledInBaseApp, isFalse);
      expect(GaussDeferredMathOcrModelManifest.directSolveAllowed, isFalse);
    });
  });
}
