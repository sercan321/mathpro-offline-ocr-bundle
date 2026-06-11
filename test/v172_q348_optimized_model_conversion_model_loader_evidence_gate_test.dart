import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_optimized_model_conversion_model_loader_evidence_gate_q348.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_optimized_model_conversion_model_loader_evidence_gate_q348_policy.dart';

import 'v172_q344_binary_bundle_successor_test_helper.dart';

void main() {
  test('q348 manifest records optimized model conversion/model-loader evidence gate without model load or OCR execution', () {
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
    final q348 = manifest['v172Q348OptimizedModelConversionModelLoaderEvidenceGate'] as Map<String, dynamic>;

    expect(<String>[GaussOptimizedModelConversionModelLoaderEvidenceGateQ348Policy.phase, q349RealModelLoadSmokeEvidenceBlockedPhase, q350OptimizedModelArtifactConversionEvidenceIntakePhase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase, q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'], contains(manifest['cameraOcrLatestPhase']));
    expect(<String>[GaussOptimizedModelConversionModelLoaderEvidenceGateQ348Policy.phase, q349RealModelLoadSmokeEvidenceBlockedPhase, q350OptimizedModelArtifactConversionEvidenceIntakePhase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase, q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'], contains(manifest['activeProductDevelopmentLatestPhase']));
    expect(manifest['optimizedModelConversionModelLoaderEvidenceGateLatestPhase'], GaussOptimizedModelConversionModelLoaderEvidenceGateQ348Policy.phase);
    expect(q348['phase'], GaussOptimizedModelConversionModelLoaderEvidenceGateQ348Policy.phase);
    expect(q348['sourcePhase'], GaussOptimizedModelConversionModelLoaderEvidenceGateQ348Policy.sourcePhase);
    expect(q348['q347PredictorInstantiateSmokePresent'], isTrue);
    expect(q348['q346NativeLibraryLoadSmokePresent'], isTrue);
    expect(q348['q345GradleAbiPackagingBuildTrialPresent'], isTrue);
    expect(q348['q344ActualBinaryBundlePresent'], isTrue);
    expect(q348['knownUserArtifactFileName'], 'inference.pdiparams');
    expect(q348['knownUserArtifactSha256'], GaussOptimizedModelConversionModelLoaderEvidenceGateQ348Policy.knownUserArtifactSha256);
    expect(q348['knownUserArtifactSizeBytes'], GaussOptimizedModelConversionModelLoaderEvidenceGateQ348Policy.knownUserArtifactSizeBytes);
    expect(q348['inferencePdiparamsAloneAcceptedForModelLoad'], isFalse);
    expect(q348['externalConversionEvidencePolicy'], GaussOptimizedModelConversionModelLoaderEvidenceGateQ348Policy.externalConversionEvidencePolicy);
    expect(q348['requiredModelConversionEvidence'], contains('conversion command and log are provided'));
    expect(q348['blockedUntilEvidence'], contains('q349-real-model-load-blocked-until-q348-evidence-accepted'));

    for (final key in <String>[
      'optimizedModelEvidenceProvided',
      'inferencePdmodelEvidenceProvided',
      'optimizedNbModelEvidenceProvided',
      'conversionLogProvided',
      'convertedModelSha256Provided',
      'modelLoaderPathApproved',
      'modelLoaderAvailable',
      'modelLoaded',
      'runtimeStartupExecuted',
      'dummyRuntimeCallExecuted',
      'realImageToLatexInferenceExecuted',
      'editableMathLiveReviewOpened',
      'workspaceImportExecuted',
      'mainActivityChanged',
      'gradleChanged',
      'pubspecChanged',
      'androidManifestChanged',
      'flutterAnalyzePassClaimed',
      'flutterTestPassClaimed',
      'androidRealDevicePassClaimed',
      'ocrPassClaimed',
    ]) {
      expect(q348[key], isFalse, reason: 'Q348 $key must remain false');
    }
  });

  test('q348 Dart contract exposes evidence gate only and blocks model loader path', () {
    final result = GaussOptimizedModelConversionModelLoaderEvidenceGateQ348.evaluate();

    expect(result.phase, GaussOptimizedModelConversionModelLoaderEvidenceGateQ348Policy.phase);
    expect(result.sourcePhase, GaussOptimizedModelConversionModelLoaderEvidenceGateQ348Policy.sourcePhase);
    expect(result.q347PredictorInstantiateSmokePresent, isTrue);
    expect(result.q346NativeLibraryLoadSmokePresent, isTrue);
    expect(result.q345GradleAbiPackagingBuildTrialPresent, isTrue);
    expect(result.q344ActualBinaryBundlePresent, isTrue);
    expect(result.paddlePredictorJarBundled, isTrue);
    expect(result.arm64V8aNativeLibraryBundled, isTrue);
    expect(result.armeabiV7aNativeLibraryBundled, isTrue);
    expect(result.knownInferencePdiparamsHashEvidencePresent, isTrue);
    expect(result.inferencePdiparamsAloneAcceptedForModelLoad, isFalse);
    expect(result.optimizedModelEvidenceProvided, isFalse);
    expect(result.modelLoaderPathApproved, isFalse);
    expect(result.modelLoaderAvailable, isFalse);
    expect(result.modelLoaded, isFalse);
    expect(result.realImageToLatexInferenceExecuted, isFalse);
    expect(result.ocrPassClaimed, isFalse);
  });

  test('q348 keeps runtime/UI surfaces unchanged while preserving Q344 binaries', () {
    final mainActivity = File('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt').readAsStringSync();
    final gradle = File('android/app/build.gradle').readAsStringSync();
    final manifestXml = File('android/app/src/main/AndroidManifest.xml').readAsStringSync();

    expect(mainActivity, contains('private val q347Phase = "V172-Q347-PADDLE-LITE-PREDICTOR-INSTANTIATE-SMOKE"'));
    expect(mainActivity, isNot(contains('q348')));
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
  });
}
