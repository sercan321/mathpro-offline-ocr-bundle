import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_real_model_load_smoke_evidence_blocked_q349.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_real_model_load_smoke_evidence_blocked_q349_policy.dart';

import 'v172_q344_binary_bundle_successor_test_helper.dart';

void main() {
  test('q349 manifest records real model load smoke as evidence-blocked without attempting model load', () {
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
    final q349 = manifest['v172Q349RealModelLoadSmokeEvidenceBlocked'] as Map<String, dynamic>;

    expect(<String>[GaussRealModelLoadSmokeEvidenceBlockedQ349Policy.phase, q350OptimizedModelArtifactConversionEvidenceIntakePhase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase, q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'], contains(manifest['cameraOcrLatestPhase']));
    expect(<String>[GaussRealModelLoadSmokeEvidenceBlockedQ349Policy.phase, q350OptimizedModelArtifactConversionEvidenceIntakePhase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase, q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'], contains(manifest['activeProductDevelopmentLatestPhase']));
    expect(manifest['realModelLoadSmokeEvidenceBlockedLatestPhase'], GaussRealModelLoadSmokeEvidenceBlockedQ349Policy.phase);
    expect(q349['phase'], GaussRealModelLoadSmokeEvidenceBlockedQ349Policy.phase);
    expect(q349['sourcePhase'], GaussRealModelLoadSmokeEvidenceBlockedQ349Policy.sourcePhase);
    expect(q349['q348EvidenceGatePresent'], isTrue);
    expect(q349['q347PredictorInstantiateSmokePresent'], isTrue);
    expect(q349['q346NativeLibraryLoadSmokePresent'], isTrue);
    expect(q349['q345GradleAbiPackagingBuildTrialPresent'], isTrue);
    expect(q349['q344ActualBinaryBundlePresent'], isTrue);
    expect(q349['knownUserArtifactFileName'], 'inference.pdiparams');
    expect(q349['knownUserArtifactSha256'], 'b6392296d16e2a9f414c0a751d7ccbd1bd9d8272b68aab72df1d3875f35a7489');
    expect(q349['knownUserArtifactSizeBytes'], 231675001);
    expect(q349['inferencePdiparamsAloneAcceptedForModelLoad'], isFalse);
    expect(q349['realModelLoadSmokeRequested'], isTrue);
    expect(q349['realModelLoadSmokeBlockedByMissingEvidence'], isTrue);
    expect(q349['blockedReasons'], contains('optimized-model-artifact-not-provided'));

    for (final key in <String>[
      'optimizedModelEvidenceProvided',
      'conversionLogProvided',
      'convertedModelSha256Provided',
      'modelLoaderPathApproved',
      'modelLoaderAvailable',
      'modelLoadAttempted',
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
      'workspaceChanged',
      'keyboardChanged',
      'moreTemplateTrayChanged',
      'longPressChanged',
      'mathLiveProductionBridgeChanged',
      'graphChanged',
      'solutionChanged',
      'historyChanged',
      'splashChanged',
      'iconChanged',
      'flutterAnalyzePassClaimed',
      'flutterTestPassClaimed',
      'androidRealDevicePassClaimed',
      'ocrPassClaimed',
    ]) {
      expect(q349[key], isFalse, reason: 'Q349 $key must remain false');
    }
  });

  test('q349 Dart contract exposes evidence-blocked real model load smoke only', () {
    final result = GaussRealModelLoadSmokeEvidenceBlockedQ349.evaluate();

    expect(result.phase, GaussRealModelLoadSmokeEvidenceBlockedQ349Policy.phase);
    expect(result.sourcePhase, GaussRealModelLoadSmokeEvidenceBlockedQ349Policy.sourcePhase);
    expect(result.q348EvidenceGatePresent, isTrue);
    expect(result.q347PredictorInstantiateSmokePresent, isTrue);
    expect(result.q346NativeLibraryLoadSmokePresent, isTrue);
    expect(result.q345GradleAbiPackagingBuildTrialPresent, isTrue);
    expect(result.q344ActualBinaryBundlePresent, isTrue);
    expect(result.paddlePredictorJarBundled, isTrue);
    expect(result.arm64V8aNativeLibraryBundled, isTrue);
    expect(result.armeabiV7aNativeLibraryBundled, isTrue);
    expect(result.inferencePdiparamsAloneAcceptedForModelLoad, isFalse);
    expect(result.realModelLoadSmokeRequested, isTrue);
    expect(result.realModelLoadSmokeBlockedByMissingEvidence, isTrue);
    expect(result.modelLoaderAvailable, isFalse);
    expect(result.modelLoadAttempted, isFalse);
    expect(result.modelLoaded, isFalse);
    expect(result.realImageToLatexInferenceExecuted, isFalse);
    expect(result.ocrPassClaimed, isFalse);
  });

  test('q349 does not mutate MainActivity, Gradle, AndroidManifest, UI, or bundle model artifacts', () {
    final mainActivity = File('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt').readAsStringSync();
    final gradle = File('android/app/build.gradle').readAsStringSync();
    final manifestXml = File('android/app/src/main/AndroidManifest.xml').readAsStringSync();

    expect(mainActivity, contains('private val q347Phase = "V172-Q347-PADDLE-LITE-PREDICTOR-INSTANTIATE-SMOKE"'));
    expect(mainActivity, isNot(contains('q349')));
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
    expect(File('android/app/libs/PaddlePredictor.jar').existsSync(), isTrue);
    expectNoNativeBinariesOrOnlyQ344ActualBundle();
  });
}
