import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_paddle_lite_nb_flutter_test_stale_regression_repair_q387r7c.dart';

void main() {
  group('V172-Q387R7C Flutter test Q379 decoder marker repair', () {
    test('records the static repair without OCR or device PASS claims', () {
      expect(GaussPaddleLiteNbFlutterTestStaleRegressionRepairQ387R7CPolicy.phase, 'V172-Q387R7C-FLUTTER-TEST-Q379-DECODER-MARKER-REPAIR');
      expect(GaussPaddleLiteNbFlutterTestStaleRegressionRepairQ387R7CPolicy.q379DecodedCandidateLatexMarkerRestored, isTrue);
      expect(GaussPaddleLiteNbFlutterTestStaleRegressionRepairQ387R7CPolicy.q379OutputDecoderImplementedMarkerRestored, isTrue);
      expect(GaussPaddleLiteNbFlutterTestStaleRegressionRepairQ387R7CPolicy.q379DecoderDoesNotInventLatexPreserved, isTrue);
      expect(GaussPaddleLiteNbFlutterTestStaleRegressionRepairQ387R7CPolicy.q387ManifestGatePreserved, isTrue);
      expect(GaussPaddleLiteNbFlutterTestStaleRegressionRepairQ387R7CPolicy.modelBinaryBundledInBaseApp, isFalse);
      expect(GaussPaddleLiteNbFlutterTestStaleRegressionRepairQ387R7CPolicy.onnxRuntimeReintroducedInBaseApk, isFalse);
      expect(GaussPaddleLiteNbFlutterTestStaleRegressionRepairQ387R7CPolicy.productionInferencePassClaimedByQ387R7C, isFalse);
      expect(GaussPaddleLiteNbFlutterTestStaleRegressionRepairQ387R7CPolicy.androidRealDevicePassClaimedByQ387R7C, isFalse);
      expect(GaussPaddleLiteNbFlutterTestStaleRegressionRepairQ387R7CPolicy.keyboardQ382Touched, isFalse);
      expect(GaussPaddleLiteNbFlutterTestStaleRegressionRepairQ387R7CPolicy.graphHistorySolutionSolverTouched, isFalse);
    });

    test('native decoder source contains legacy Q379 stale-test markers', () {
      final mainActivity = File('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt').readAsStringSync();
      expect(mainActivity, contains('val decodedCandidateLatex = candidateLatex'));
      expect(mainActivity, contains('val outputDecoderImplemented = true'));
      expect(mainActivity, contains('"candidateLatex" to decodedCandidateLatex'));
      expect(mainActivity, contains('"outputDecodingImplemented" to outputDecoderImplemented'));
      expect(mainActivity, contains('"decoderDoesNotInventLatex" to true'));
    });
  });
}
