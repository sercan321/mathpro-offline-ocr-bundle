import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_paddle_lite_nb_flutter_test_legacy_successor_repair_q387r7d.dart';

void main() {
  test('Q387R7D makes legacy setModelFromFile tests successor-aware without weakening .nb guard', () {
    final mainActivity = File('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt').readAsStringSync();
    final legacyTests = <String>[
      'test/v172_q348_optimized_model_conversion_model_loader_evidence_gate_test.dart',
      'test/v172_q349_real_model_load_smoke_evidence_blocked_test.dart',
      'test/v172_q350_optimized_model_artifact_conversion_evidence_intake_test.dart',
      'test/v172_q351_optimized_model_evidence_acceptance_real_model_load_unlock_gate_test.dart',
      'test/v172_q351r2_flutter_run_kotlin_build_helper_repair_test.dart',
    ].map((path) => File(path).readAsStringSync()).join('\n---\n');

    expect(GaussPaddleLiteNbFlutterTestLegacySuccessorRepairQ387R7DPolicy.phase,
        'V172-Q387R7D-FLUTTER-TEST-LEGACY-SUCCESSOR-REPAIR');
    expect(GaussPaddleLiteNbFlutterTestLegacySuccessorRepairQ387R7DPolicy.productionInferencePassClaimedByQ387R7D, isFalse);
    expect(GaussPaddleLiteNbFlutterTestLegacySuccessorRepairQ387R7DPolicy.androidRealDevicePassClaimedByQ387R7D, isFalse);
    expect(GaussPaddleLiteNbFlutterTestLegacySuccessorRepairQ387R7DPolicy.fakeLatexCandidateAllowed, isFalse);

    expect(mainActivity, contains('q387R1NbArtifactReady && supportsSetModelFromFile'));
    expect(mainActivity, contains('q387-paddle-lite-nb-model-required'));
    expect(legacyTests, contains('q387R1NbArtifactReady && supportsSetModelFromFile'));
    expect(legacyTests, isNot(contains("expect(mainActivity, isNot(contains('setModelFromFile')));\n    expect(mainActivity, isNot(contains('loadModel(')))")));
  });

  test('Q387R7D scopes legacy ONNX checks to runtime dependencies and ignores historical comments', () {
    final q352 = File('test/v172_q352_onnx_conversion_evidence_acceptance_runtime_strategy_pivot_gate_test.dart').readAsStringSync();
    final q352r1 = File('test/v172_q352r1_legacy_verifier_successor_awareness_hygiene_repair_test.dart').readAsStringSync();
    final pubspec = File('pubspec.yaml').readAsStringSync();
    final pubspecRuntimeSection = pubspec
        .split('\n')
        .where((line) => !line.trimLeft().startsWith('#'))
        .join('\n')
        .toLowerCase();

    expect(q352, contains('pubspecRuntimeSection'));
    expect(q352r1, contains('pubspecRuntimeSection'));
    expect(q352, isNot(contains("expect(pubspec.toLowerCase(), isNot(contains('onnx')));")));
    expect(q352r1, isNot(contains("expect(pubspec.toLowerCase(), isNot(contains('onnx')));")));
    expect(pubspec.toLowerCase(), isNot(contains('onnx')));
    expect(pubspecRuntimeSection, isNot(contains('onnxruntime')));
    expect(pubspecRuntimeSection, isNot(contains('onnxruntime-android')));
    expect(pubspecRuntimeSection, isNot(contains('onnx:')));
  });
}
