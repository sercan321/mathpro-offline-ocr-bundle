import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_optimized_model_evidence_acceptance_real_model_load_unlock_gate_q351.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_optimized_model_evidence_acceptance_real_model_load_unlock_gate_q351_policy.dart';

import 'v172_q344_binary_bundle_successor_test_helper.dart';

void main() {
  test('q351 manifest advances model evidence acceptance gate without model load or OCR', () {
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
    final q351 = manifest['v172Q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGate'] as Map<String, dynamic>;

    expect(<String>{
      GaussOptimizedModelEvidenceAcceptanceRealModelLoadUnlockGateQ351Policy.phase,
      q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'}, contains(manifest['cameraOcrLatestPhase']));
    expect(<String>{
      GaussOptimizedModelEvidenceAcceptanceRealModelLoadUnlockGateQ351Policy.phase,
      q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase,
    'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE',}, contains(manifest['activeProductDevelopmentLatestPhase']));
    expect(manifest['optimizedModelEvidenceAcceptanceRealModelLoadUnlockGateLatestPhase'], GaussOptimizedModelEvidenceAcceptanceRealModelLoadUnlockGateQ351Policy.phase);
    expect(q351['phase'], GaussOptimizedModelEvidenceAcceptanceRealModelLoadUnlockGateQ351Policy.phase);
    expect(q351['sourcePhase'], GaussOptimizedModelEvidenceAcceptanceRealModelLoadUnlockGateQ351Policy.sourcePhase);
    expect(q351['q350EvidenceIntakePresent'], isTrue);
    expect(q351['q349EvidenceBlockedPresent'], isTrue);
    expect(q351['q348EvidenceGatePresent'], isTrue);
    expect(q351['q347PredictorInstantiateSmokePresent'], isTrue);
    expect(q351['q346NativeLibraryLoadSmokePresent'], isTrue);
    expect(q351['q345GradleAbiPackagingBuildTrialPresent'], isTrue);
    expect(q351['q344ActualBinaryBundlePresent'], isTrue);
    expect(q351['q350OptimizedEvidenceJsonRequired'], isTrue);
    expect(q351['inferencePdiparamsAloneAcceptedForModelLoad'], isFalse);
    expect(q351['optimizedModelEvidenceAccepted'], isFalse);
    expect(q351['modelLoaderPathApproved'], isFalse);
    expect(q351['realModelLoadUnlockGranted'], isFalse);
    expect(q351['modelLoadAttempted'], isFalse);
    expect(q351['modelLoaded'], isFalse);
    expect(q351['realImageToLatexInferenceExecuted'], isFalse);
    expect(q351['ocrPassClaimed'], isFalse);
  });

  test('q351 Dart contract exposes real-model-load unlock as blocked', () {
    final result = GaussOptimizedModelEvidenceAcceptanceRealModelLoadUnlockGateQ351.evaluate();

    expect(result.phase, GaussOptimizedModelEvidenceAcceptanceRealModelLoadUnlockGateQ351Policy.phase);
    expect(result.sourcePhase, GaussOptimizedModelEvidenceAcceptanceRealModelLoadUnlockGateQ351Policy.sourcePhase);
    expect(result.q350EvidenceIntakePresent, isTrue);
    expect(result.q350OptimizedEvidenceJsonRequired, isTrue);
    expect(result.optimizedModelEvidenceAccepted, isFalse);
    expect(result.modelLoaderPathApproved, isFalse);
    expect(result.realModelLoadUnlockGranted, isFalse);
    expect(result.modelLoadAttempted, isFalse);
    expect(result.modelLoaded, isFalse);
    expect(result.runtimeStartupExecuted, isFalse);
    expect(result.realImageToLatexInferenceExecuted, isFalse);
    expect(result.ocrPassClaimed, isFalse);
  });

  test('q351 adds evidence intake review only and preserves runtime/UI surfaces', () {
    final mainActivity = File('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt').readAsStringSync();
    final gradle = File('android/app/build.gradle').readAsStringSync();
    final manifestXml = File('android/app/src/main/AndroidManifest.xml').readAsStringSync();

    expect(File('tool/intake_pp_formulanet_s_optimized_model_evidence_v172_q351.mjs').existsSync(), isTrue);
    expect(File('tool/prepare_pp_formulanet_s_optimized_model_intake_v172_q350.mjs').existsSync(), isTrue);
    expect(File('tool/capture_pp_formulanet_s_optimized_model_evidence_v172_q350.mjs').existsSync(), isTrue);
    expect(mainActivity, contains('private val q347Phase = "V172-Q347-PADDLE-LITE-PREDICTOR-INSTANTIATE-SMOKE"'));
    expect(mainActivity, isNot(contains('q351')));
    // Q387+ successor path may use Paddle Lite setModelFromFile only after the
    // .nb manifest/SHA/provenance gate marks q387R1NbArtifactReady. Older Q348-Q351
    // contracts must not fail merely because the later guarded .nb load path exists.
    if (mainActivity.contains('setModelFromFile')) {
      expect(mainActivity, contains('q387R1NbArtifactReady'));
      expect(mainActivity, contains('q387-paddle-lite-nb-model-required'));
      expect(mainActivity, contains('q387R1NbArtifactReady && supportsSetModelFromFile'));
    } else {
      expect(mainActivity, isNot(contains('setModelFromFile')));
    }
    expect(mainActivity, isNot(contains('loadModel(')));
    expect(mainActivity, isNot(contains('runInference(')));
    expect(gradle, contains("implementation files('libs/PaddlePredictor.jar')"));
    expect(manifestXml, isNot(contains('Paddle')));
    expectNoNativeBinariesOrOnlyQ344ActualBundle();
    final projectModelFiles = Directory.current
        .listSync(recursive: true, followLinks: false)
        .whereType<File>()
        .map((file) => file.path.replaceAll('\\', '/'))
        .where((path) => !path.startsWith('build/') && !path.contains('/build/'))
        .where((path) => !path.startsWith('.dart_tool/') && !path.contains('/.dart_tool/'))
        .where((path) => RegExp(r'\.(pdmodel|pdiparams|nb|onnx|tflite|pt|pth|pdparams|safetensors|bin)$', caseSensitive: false).hasMatch(path))
        .toList();
    expect(projectModelFiles, isEmpty);
  });
}
