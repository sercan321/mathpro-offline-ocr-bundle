import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_optimized_model_artifact_conversion_evidence_intake_q350.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_optimized_model_artifact_conversion_evidence_intake_q350_policy.dart';

import 'v172_q344_binary_bundle_successor_test_helper.dart';

void main() {
  test('q350 manifest advances model-conversion evidence intake without model load or OCR', () {
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
    final q350 = manifest['v172Q350OptimizedModelArtifactConversionEvidenceIntake'] as Map<String, dynamic>;

    expect(<String>[GaussOptimizedModelArtifactConversionEvidenceIntakeQ350Policy.phase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase, q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'], contains(manifest['cameraOcrLatestPhase']));
    expect(<String>[GaussOptimizedModelArtifactConversionEvidenceIntakeQ350Policy.phase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase, q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'], contains(manifest['activeProductDevelopmentLatestPhase']));
    expect(manifest['optimizedModelArtifactConversionEvidenceIntakeLatestPhase'], GaussOptimizedModelArtifactConversionEvidenceIntakeQ350Policy.phase);
    expect(q350['phase'], GaussOptimizedModelArtifactConversionEvidenceIntakeQ350Policy.phase);
    expect(q350['sourcePhase'], GaussOptimizedModelArtifactConversionEvidenceIntakeQ350Policy.sourcePhase);
    expect(q350['q349EvidenceBlockedPresent'], isTrue);
    expect(q350['q348EvidenceGatePresent'], isTrue);
    expect(q350['q347PredictorInstantiateSmokePresent'], isTrue);
    expect(q350['q346NativeLibraryLoadSmokePresent'], isTrue);
    expect(q350['q345GradleAbiPackagingBuildTrialPresent'], isTrue);
    expect(q350['q344ActualBinaryBundlePresent'], isTrue);
    expect(q350['knownUserArtifactFileName'], 'inference.pdiparams');
    expect(q350['knownUserArtifactSha256'], 'b6392296d16e2a9f414c0a751d7ccbd1bd9d8272b68aab72df1d3875f35a7489');
    expect(q350['knownUserArtifactSizeBytes'], 231675001);
    expect(q350['inferencePdiparamsAloneAcceptedForModelLoad'], isFalse);
    expect(q350['optimizedModelEvidenceIntakeReady'], isTrue);
    expect(q350['optimizedModelEvidenceProvided'], isFalse);
    expect(q350['modelLoadAttempted'], isFalse);
    expect(q350['modelLoaded'], isFalse);
    expect(q350['realImageToLatexInferenceExecuted'], isFalse);
    expect(q350['ocrPassClaimed'], isFalse);
  });

  test('q350 Dart contract exposes evidence intake only', () {
    final result = GaussOptimizedModelArtifactConversionEvidenceIntakeQ350.evaluate();

    expect(result.phase, GaussOptimizedModelArtifactConversionEvidenceIntakeQ350Policy.phase);
    expect(result.sourcePhase, GaussOptimizedModelArtifactConversionEvidenceIntakeQ350Policy.sourcePhase);
    expect(result.q349EvidenceBlockedPresent, isTrue);
    expect(result.optimizedModelEvidenceIntakeReady, isTrue);
    expect(result.optimizedModelEvidenceProvided, isFalse);
    expect(result.modelLoadAttempted, isFalse);
    expect(result.modelLoaded, isFalse);
    expect(result.runtimeStartupExecuted, isFalse);
    expect(result.realImageToLatexInferenceExecuted, isFalse);
    expect(result.ocrPassClaimed, isFalse);
  });

  test('q350 adds evidence scripts but does not mutate runtime/UI or bundle model artifacts', () {
    final mainActivity = File('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt').readAsStringSync();
    final gradle = File('android/app/build.gradle').readAsStringSync();
    final manifestXml = File('android/app/src/main/AndroidManifest.xml').readAsStringSync();

    expect(File('tool/prepare_pp_formulanet_s_optimized_model_intake_v172_q350.mjs').existsSync(), isTrue);
    expect(File('tool/capture_pp_formulanet_s_optimized_model_evidence_v172_q350.mjs').existsSync(), isTrue);
    expect(mainActivity, contains('private val q347Phase = "V172-Q347-PADDLE-LITE-PREDICTOR-INSTANTIATE-SMOKE"'));
    expect(mainActivity, isNot(contains('q350')));
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
    expect(mainActivity, isNot(contains('inference.pdmodel')));
    // Q387+ successor path may mention .nb in native source only as a guarded
    // Paddle Lite artifact format; the base project must still contain no .nb file.
    if (mainActivity.contains('.nb')) {
      expect(mainActivity, contains('q387RequiredModelFileExtension'));
      expect(mainActivity, contains('q387R1NbArtifactReady'));
      expect(mainActivity, contains('q387-paddle-lite-nb-model-required'));
    } else {
      expect(mainActivity, isNot(contains('.nb')));
    }
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
