import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_paddle_lite_predictor_instantiate_smoke_q347.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_paddle_lite_predictor_instantiate_smoke_q347_policy.dart';

import 'v172_q344_binary_bundle_successor_test_helper.dart';

void main() {
  test('q347 manifest records guarded Paddle Lite Predictor instantiate smoke without model load or OCR execution', () {
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
    final q347 = manifest['v172Q347PaddleLitePredictorInstantiateSmoke'] as Map<String, dynamic>;

    expect(<String>[GaussPaddleLitePredictorInstantiateSmokeQ347Policy.phase, q348OptimizedModelConversionModelLoaderEvidenceGatePhase, q349RealModelLoadSmokeEvidenceBlockedPhase, q350OptimizedModelArtifactConversionEvidenceIntakePhase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase, q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'], contains(manifest['cameraOcrLatestPhase']));
    expect(<String>[GaussPaddleLitePredictorInstantiateSmokeQ347Policy.phase, q348OptimizedModelConversionModelLoaderEvidenceGatePhase, q349RealModelLoadSmokeEvidenceBlockedPhase, q350OptimizedModelArtifactConversionEvidenceIntakePhase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase, q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'], contains(manifest['activeProductDevelopmentLatestPhase']));
    expect(manifest['paddleLitePredictorInstantiateSmokeLatestPhase'], GaussPaddleLitePredictorInstantiateSmokeQ347Policy.phase);
    expect(q347['phase'], GaussPaddleLitePredictorInstantiateSmokeQ347Policy.phase);
    expect(q347['sourcePhase'], GaussPaddleLitePredictorInstantiateSmokeQ347Policy.sourcePhase);
    expect(q347['methodName'], 'paddleLitePredictorInstantiateSmoke');
    expect(q347['paddleLitePredictorClassName'], 'com.baidu.paddle.lite.PaddlePredictor');
    expect(q347['paddleLiteConfigClassName'], 'com.baidu.paddle.lite.MobileConfig');
    expect(q347['paddleLiteCreatePredictorMethodName'], 'createPaddlePredictor');
    expect(q347['q346NativeLibraryLoadSmokePresent'], isTrue);
    expect(q347['q345GradleAbiPackagingBuildTrialPresent'], isTrue);
    expect(q347['q344ActualBinaryBundlePresent'], isTrue);
    expect(q347['predictorInstantiateSmokeBridgeAdded'], isTrue);
    expect(q347['predictorInstantiateFeatureDefaultEnabled'], isFalse);
    expect(q347['automaticStartupInstantiate'], isFalse);
    expect(q347['assistantExecutedPredictorInstantiateSmoke'], isFalse);
    expect(q347['predictorClassProbeAttemptedByAssistant'], isFalse);
    expect(q347['predictorClassProbeSucceededClaimed'], isFalse);
    expect(q347['predictorInstantiateAttemptedByAssistant'], isFalse);
    expect(q347['predictorInstantiateSucceededClaimed'], isFalse);
    expect(q347['nativeLibraryLoadSmokeRequiredBeforeInstantiate'], isTrue);
    expect(q347['mainActivityChanged'], isTrue);

    for (final key in <String>[
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
      'paddleLiteInstantiated',
      'modelLoaderAvailable',
      'modelLoaded',
      'runtimeStartupExecuted',
      'dummyRuntimeCallExecuted',
      'realImageToLatexInferenceExecuted',
      'editableMathLiveReviewOpened',
      'workspaceImportExecuted',
      'flutterAnalyzePassClaimed',
      'flutterTestPassClaimed',
      'androidRealDevicePassClaimed',
      'ocrPassClaimed',
    ]) {
      expect(q347[key], isFalse, reason: 'Q347 $key must remain false');
    }
  });

  test('q347 Dart contract exposes default-off Predictor instantiate smoke only', () {
    final result = GaussPaddleLitePredictorInstantiateSmokeQ347.evaluate();

    expect(result.phase, GaussPaddleLitePredictorInstantiateSmokeQ347Policy.phase);
    expect(result.sourcePhase, GaussPaddleLitePredictorInstantiateSmokeQ347Policy.sourcePhase);
    expect(result.status, GaussPaddleLitePredictorInstantiateSmokeQ347Policy.status);
    expect(result.requiredPriorPhases, contains('V172-Q346-NATIVE-LIBRARY-LOAD-SMOKE'));
    expect(result.q346NativeLibraryLoadSmokePresent, isTrue);
    expect(result.q345GradleAbiPackagingBuildTrialPresent, isTrue);
    expect(result.q344ActualBinaryBundlePresent, isTrue);
    expect(result.predictorInstantiateSmokeBridgeAdded, isTrue);
    expect(result.predictorInstantiateFeatureDefaultEnabled, isFalse);
    expect(result.automaticStartupInstantiate, isFalse);
    expect(result.assistantExecutedPredictorInstantiateSmoke, isFalse);
    expect(result.paddlePredictorJarBundled, isTrue);
    expect(result.arm64V8aNativeLibraryBundled, isTrue);
    expect(result.armeabiV7aNativeLibraryBundled, isTrue);
    expect(result.mainActivityChanged, isTrue);
    expect(result.gradleChanged, isFalse);
    expect(result.pubspecChanged, isFalse);
    expect(result.androidManifestChanged, isFalse);
    expect(result.predictorClassProbeAvailable, isTrue);
    expect(result.configClassProbeAvailable, isTrue);
    expect(result.paddleLiteInstantiated, isFalse);
    expect(result.modelLoaderAvailable, isFalse);
    expect(result.modelLoaded, isFalse);
    expect(result.realImageToLatexInferenceExecuted, isFalse);
    expect(result.androidRealDevicePassClaimed, isFalse);
    expect(result.ocrPassClaimed, isFalse);
  });

  test('q347 MainActivity adds predictor instantiate bridge without automatic startup, model load, or inference', () {
    final mainActivity = File('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt').readAsStringSync();

    expect(mainActivity, contains('private val q347Phase = "V172-Q347-PADDLE-LITE-PREDICTOR-INSTANTIATE-SMOKE"'));
    expect(mainActivity, contains('private val q347FeatureEnabled = false'));
    expect(mainActivity, contains('"paddleLitePredictorInstantiateSmoke" -> result.success(q347PaddleLitePredictorInstantiateSmoke(call.method))'));
    expect(mainActivity, contains('private fun q347PaddleLitePredictorInstantiateSmoke(method: String): Map<String, Any>'));
    expect(mainActivity, contains('q347PredictorClassName = "com.baidu.paddle.lite.Paddle" + "Predictor"'));
    expect(mainActivity, contains('q347ConfigClassName = "com.baidu.paddle.lite.Mobile" + "Config"'));
    expect(mainActivity, contains('q347CreatePredictorMethodName = "create" + "Paddle" + "Predictor"'));
    expect(mainActivity, contains('"predictorInstantiateAttempted" to predictorInstantiateAttempted'));
    expect(mainActivity, contains('"predictorInstantiateSucceeded" to predictorInstantiateSucceeded'));
    expect(mainActivity, contains('"automaticStartupInstantiate" to false'));
    expect(mainActivity, contains('"assistantExecutedPredictorInstantiateSmoke" to false'));
    expect(mainActivity, isNot(contains('PaddlePredictor(')));
    expect(mainActivity, isNot(contains('MobileConfig(')));
    expect(mainActivity, isNot(contains('PaddleLite(')));
    expect(mainActivity, isNot(contains('loadModel(')));
    expect(mainActivity, isNot(contains('runInference(')));
  });

  test('q347 keeps Q344 bundled binaries exact and no extra native artifact appears', () {
    expect(File('android/app/libs/PaddlePredictor.jar').existsSync(), isTrue);
    expect(File('android/app/src/main/jniLibs/arm64-v8a/libpaddle_lite_jni.so').existsSync(), isTrue);
    expect(File('android/app/src/main/jniLibs/armeabi-v7a/libpaddle_lite_jni.so').existsSync(), isTrue);
    expect(File('android/app/src/main/jniLibs/x86_64/libpaddle_lite_jni.so').existsSync(), isFalse);
    expectNoNativeBinariesOrOnlyQ344ActualBundle();
  });
}
