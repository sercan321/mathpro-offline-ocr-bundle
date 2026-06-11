import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_paddle_lite_nb_flutter_test_stale_regression_repair_q387r7b.dart';

void main() {
  group('V172-Q387R7B Flutter test stale regression repair', () {
    test('records the static repair without OCR or device PASS claims', () {
      expect(GaussPaddleLiteNbFlutterTestStaleRegressionRepairQ387R7BPolicy.phase, 'V172-Q387R7B-FLUTTER-TEST-STALE-REGRESSION-REPAIR');
      expect(GaussPaddleLiteNbFlutterTestStaleRegressionRepairQ387R7BPolicy.q387R4ConstConstructorInfoRepaired, isTrue);
      expect(GaussPaddleLiteNbFlutterTestStaleRegressionRepairQ387R7BPolicy.q380PrivateStorageEvidenceCompatibilityAliasRestored, isTrue);
      expect(GaussPaddleLiteNbFlutterTestStaleRegressionRepairQ387R7BPolicy.q385R4QueuedCopyLegacySubstringRestored, isTrue);
      expect(GaussPaddleLiteNbFlutterTestStaleRegressionRepairQ387R7BPolicy.q387ManifestGatePreserved, isTrue);
      expect(GaussPaddleLiteNbFlutterTestStaleRegressionRepairQ387R7BPolicy.modelBinaryBundledInBaseApp, isFalse);
      expect(GaussPaddleLiteNbFlutterTestStaleRegressionRepairQ387R7BPolicy.onnxRuntimeReintroducedInBaseApk, isFalse);
      expect(GaussPaddleLiteNbFlutterTestStaleRegressionRepairQ387R7BPolicy.productionInferencePassClaimedByQ387R7B, isFalse);
      expect(GaussPaddleLiteNbFlutterTestStaleRegressionRepairQ387R7BPolicy.androidRealDevicePassClaimedByQ387R7B, isFalse);
      expect(GaussPaddleLiteNbFlutterTestStaleRegressionRepairQ387R7BPolicy.keyboardQ382Touched, isFalse);
      expect(GaussPaddleLiteNbFlutterTestStaleRegressionRepairQ387R7BPolicy.graphHistorySolutionSolverTouched, isFalse);
    });

    test('native and model manager files contain repaired successor markers', () {
      final manager = File('lib/features/camera/gauss_deferred_math_ocr_model_manager.dart').readAsStringSync();
      final mainActivity = File('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt').readAsStringSync();
      final q387r4Test = File('test/v172_q387r4_paddle_lite_nb_production_source_binding_test.dart').readAsStringSync();

      expect(manager, contains('Model doğrulanmadan OCR çalıştırılmayacak'));
      expect(mainActivity, contains('privateStorageActivationEvidence'));
      expect(q387r4Test, contains('input: const GaussQ387R4PaddleLiteNbProductionSourceBindingInput'));
      expect(q387r4Test, contains('q387r4-placeholder-domain-rejected'));
    });
  });
}
