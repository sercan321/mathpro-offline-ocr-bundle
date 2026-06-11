import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_paddle_lite_nb_model_format_decision_gate_q387.dart';

void main() {
  group('V172-Q387 Paddle Lite .nb model format decision gate', () {
    test('policy records .nb as required Android artifact without claiming OCR pass', () {
      expect(GaussPaddleLiteNbModelFormatDecisionQ387Policy.phase, 'V172-Q387-PADDLE-LITE-NB-MODEL-FORMAT-DECISION-GATE');
      expect(GaussPaddleLiteNbModelFormatDecisionQ387Policy.sourcePhase, 'V172-Q386-REAL-PADDLE-OCR-INFERENCE-BRIDGE');
      expect(GaussPaddleLiteNbModelFormatDecisionQ387Policy.currentDownloadedArtifactFormat, 'paddle-inference-directory');
      expect(GaussPaddleLiteNbModelFormatDecisionQ387Policy.requiredAndroidArtifactFormat, 'paddle-lite-optimized-nb');
      expect(GaussPaddleLiteNbModelFormatDecisionQ387Policy.requiredModelFileExtension, '.nb');
      expect(GaussPaddleLiteNbModelFormatDecisionQ387Policy.selectedFutureLoadMethod, 'MobileConfig.setModelFromFile(.nb)');
      expect(GaussPaddleLiteNbModelFormatDecisionQ387Policy.setModelDirClaimedAvailableByPackage, isFalse);
      expect(GaussPaddleLiteNbModelFormatDecisionQ387Policy.inferenceDirectoryAcceptedForAndroidRuntime, isFalse);
      expect(GaussPaddleLiteNbModelFormatDecisionQ387Policy.nbModelBundledInBaseApp, isFalse);
      expect(GaussPaddleLiteNbModelFormatDecisionQ387Policy.onnxRuntimeReintroducedInBaseApk, isFalse);
      expect(GaussPaddleLiteNbModelFormatDecisionQ387Policy.productionInferencePassClaimedByQ387, isFalse);
      expect(GaussPaddleLiteNbModelFormatDecisionQ387Policy.androidRealDevicePassClaimedByQ387, isFalse);
      expect(GaussPaddleLiteNbModelFormatDecisionQ387Policy.fakeLatexCandidateAllowed, isFalse);
      expect(GaussPaddleLiteNbModelFormatDecisionQ387Policy.keyboardQ382Touched, isFalse);
      expect(GaussPaddleLiteNbModelFormatDecisionQ387Policy.graphHistorySolutionSolverTouched, isFalse);
    });

    test('gate blocks current inference-directory when setModelDir is not available', () {
      final result = GaussPaddleLiteNbModelFormatDecisionQ387Gate.evaluate(
        supportsSetModelFromFile: true,
        supportsSetModelFromBuffer: true,
        supportsSetModelDir: false,
        paddleLiteNbModelAvailable: false,
        downloadedArtifactIsPaddleInferenceDirectory: true,
      );
      expect(result.canAttemptModelLoad, isFalse);
      expect(result.blockedReason, GaussPaddleLiteNbModelFormatDecisionQ387Policy.nbModelRequiredBlockedReason);
      expect(result.selectedModelLoadStrategy, 'q387-blocked-nb-model-required-current-jar-has-no-setModelDir');
    });

    test('gate permits only verified .nb path through setModelFromFile strategy', () {
      final result = GaussPaddleLiteNbModelFormatDecisionQ387Gate.evaluate(
        supportsSetModelFromFile: true,
        supportsSetModelFromBuffer: true,
        supportsSetModelDir: false,
        paddleLiteNbModelAvailable: true,
        downloadedArtifactIsPaddleInferenceDirectory: false,
      );
      expect(result.canAttemptModelLoad, isTrue);
      expect(result.blockedReason, isEmpty);
      expect(result.selectedModelLoadStrategy, 'q387-setModelFromFile-paddle-lite-nb');
    });

    test('native bridge adds Q387 evidence and avoids blind inference.pdiparams model load', () {
      final mainActivity = File('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt').readAsStringSync();
      expect(mainActivity, contains('q387Phase = "V172-Q387-PADDLE-LITE-NB-MODEL-FORMAT-DECISION-GATE"'));
      expect(mainActivity, contains('q387RequiredAndroidArtifactFormat = "paddle-lite-optimized-nb"'));
      expect(mainActivity, contains('q387SetModelDirMethodName = "setModelDir"'));
      expect(mainActivity, contains('q387CollectMobileConfigApiEvidence'));
      expect(mainActivity, contains('supportsSetModelDir'));
      expect(mainActivity, contains('q387FindPaddleLiteNbModelFile'));
      expect(mainActivity, contains('q387-blocked-nb-model-required-current-jar-has-no-setModelDir'));
      expect(mainActivity, contains('q387ModelLoadBlockedBeforeAttempt'));
      expect(mainActivity, contains('q387PaddleLiteNbModelReady'));
      expect(mainActivity, contains('q387ProductionInferencePassClaimed" to q387ProductionInferencePassClaimed'));
      expect(mainActivity, contains('if (nbModelFile != null && q387IsPaddleLiteNbModelFile(nbModelFile) && q387R1NbArtifactReady && supportsSetModelFromFile)'));
    });

    test('manifest records Q387 decision without bundling model or ONNX runtime', () {
      final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
      expect(manifest['cameraOcrPaddleLiteNbModelFormatDecisionLatestPhase'], GaussPaddleLiteNbModelFormatDecisionQ387Policy.phase);
      final q387 = manifest['v172Q387PaddleLiteNbModelFormatDecisionGate'] as Map<String, dynamic>;
      expect(q387['phase'], GaussPaddleLiteNbModelFormatDecisionQ387Policy.phase);
      expect(q387['currentDownloadedArtifactFormat'], 'paddle-inference-directory');
      expect(q387['requiredAndroidArtifactFormat'], 'paddle-lite-optimized-nb');
      expect(q387['requiredModelFileExtension'], '.nb');
      expect(q387['setModelDirClaimedAvailableByPackage'], isFalse);
      expect(q387['inferenceDirectoryAcceptedForAndroidRuntime'], isFalse);
      expect(q387['nbModelBundledInBaseApp'], isFalse);
      expect(q387['onnxRuntimeReintroducedInBaseApk'], isFalse);
      expect(q387['productionInferencePassClaimedByQ387'], isFalse);
      expect(q387['androidRealDevicePassClaimedByQ387'], isFalse);
    });
  });
}
