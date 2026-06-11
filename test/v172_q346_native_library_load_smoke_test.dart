import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_native_library_load_smoke_q346.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_native_library_load_smoke_q346_policy.dart';

import 'v172_q344_binary_bundle_successor_test_helper.dart';

void main() {
  test('q346 manifest records guarded native library load smoke without OCR runtime execution', () {
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
    final q346 = manifest['v172Q346NativeLibraryLoadSmoke'] as Map<String, dynamic>;

    expect(<String>[GaussNativeLibraryLoadSmokeQ346Policy.phase, q347PaddleLitePredictorInstantiateSmokePhase, q348OptimizedModelConversionModelLoaderEvidenceGatePhase, q349RealModelLoadSmokeEvidenceBlockedPhase, q350OptimizedModelArtifactConversionEvidenceIntakePhase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase, q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'], contains(manifest['cameraOcrLatestPhase']));
    expect(<String>[GaussNativeLibraryLoadSmokeQ346Policy.phase, q347PaddleLitePredictorInstantiateSmokePhase, q348OptimizedModelConversionModelLoaderEvidenceGatePhase, q349RealModelLoadSmokeEvidenceBlockedPhase, q350OptimizedModelArtifactConversionEvidenceIntakePhase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase, q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'], contains(manifest['activeProductDevelopmentLatestPhase']));
    expect(manifest['nativeLibraryLoadSmokeLatestPhase'], GaussNativeLibraryLoadSmokeQ346Policy.phase);
    expect(q346['phase'], GaussNativeLibraryLoadSmokeQ346Policy.phase);
    expect(q346['sourcePhase'], GaussNativeLibraryLoadSmokeQ346Policy.sourcePhase);
    expect(q346['methodName'], 'nativeLibraryLoadSmoke');
    expect(q346['paddleLiteNativeLibraryName'], 'paddle_lite_jni');
    expect(q346['q345GradleAbiPackagingBuildTrialPresent'], isTrue);
    expect(q346['q344ActualBinaryBundlePresent'], isTrue);
    expect(q346['nativeLibraryLoadSmokeBridgeAdded'], isTrue);
    expect(q346['nativeLibraryLoadFeatureDefaultEnabled'], isFalse);
    expect(q346['automaticStartupLoad'], isFalse);
    expect(q346['assistantExecutedNativeLoadSmoke'], isFalse);
    expect(q346['nativeLibraryLoadAttemptedByAssistant'], isFalse);
    expect(q346['nativeLibraryLoadSucceededClaimed'], isFalse);
    expect(q346['mainActivityChanged'], isTrue);

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
      expect(q346[key], isFalse, reason: 'Q346 $key must remain false');
    }
  });

  test('q346 Dart contract exposes default-off native load smoke only', () {
    final result = GaussNativeLibraryLoadSmokeQ346.evaluate();

    expect(result.phase, GaussNativeLibraryLoadSmokeQ346Policy.phase);
    expect(result.sourcePhase, GaussNativeLibraryLoadSmokeQ346Policy.sourcePhase);
    expect(result.status, GaussNativeLibraryLoadSmokeQ346Policy.status);
    expect(result.q345GradleAbiPackagingBuildTrialPresent, isTrue);
    expect(result.q344ActualBinaryBundlePresent, isTrue);
    expect(result.nativeLibraryLoadSmokeBridgeAdded, isTrue);
    expect(result.nativeLibraryLoadFeatureDefaultEnabled, isFalse);
    expect(result.automaticStartupLoad, isFalse);
    expect(result.assistantExecutedNativeLoadSmoke, isFalse);
    expect(result.paddlePredictorJarBundled, isTrue);
    expect(result.arm64V8aNativeLibraryBundled, isTrue);
    expect(result.armeabiV7aNativeLibraryBundled, isTrue);
    expect(result.x86_64NativeLibraryBundled, isFalse);
    expect(result.mainActivityChanged, isTrue);
    expect(result.gradleChanged, isFalse);
    expect(result.paddleLiteInstantiated, isFalse);
    expect(result.modelLoaderAvailable, isFalse);
    expect(result.realImageToLatexInferenceExecuted, isFalse);
    expect(result.androidRealDevicePassClaimed, isFalse);
    expect(result.ocrPassClaimed, isFalse);
  });

  test('q346 MainActivity adds nativeLibraryLoadSmoke bridge without automatic startup load or predictor instantiate', () {
    final mainActivity = File('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt').readAsStringSync();

    expect(mainActivity, contains('private val q346Phase = "V172-Q346-NATIVE-LIBRARY-LOAD-SMOKE"'));
    expect(mainActivity, contains('private val q346FeatureEnabled = false'));
    expect(mainActivity, contains('private val q346PaddleLiteNativeLibraryName = "paddle_lite_jni"'));
    expect(mainActivity, contains('"nativeLibraryLoadSmoke" -> result.success(q346NativeLibraryLoadSmoke(call.method))'));
    expect(mainActivity, contains('private fun q346NativeLibraryLoadSmoke(method: String): Map<String, Any>'));
    expect(mainActivity, contains('getDeclaredMethod("loadLibrary", String::class.java)'));
    expect(mainActivity, contains('"nativeLibraryLoadAttempted" to nativeLibraryLoadAttempted'));
    expect(mainActivity, contains('"nativeLibraryLoadSucceeded" to nativeLibraryLoadSucceeded'));
    expect(mainActivity, contains('"automaticStartupLoad" to false'));
    expect(mainActivity, contains('"assistantExecutedNativeLoadSmoke" to false'));
    expect(mainActivity, isNot(contains('PaddlePredictor(')));
    expect(mainActivity, isNot(contains('PaddleLite(')));
    expect(mainActivity, isNot(contains('loadModel(')));
    expect(mainActivity, isNot(contains('runInference(')));
  });

  test('q346 keeps Q344 bundled binaries exact and no extra native artifact appears', () {
    expect(File('android/app/libs/PaddlePredictor.jar').existsSync(), isTrue);
    expect(File('android/app/src/main/jniLibs/arm64-v8a/libpaddle_lite_jni.so').existsSync(), isTrue);
    expect(File('android/app/src/main/jniLibs/armeabi-v7a/libpaddle_lite_jni.so').existsSync(), isTrue);
    expect(File('android/app/src/main/jniLibs/x86_64/libpaddle_lite_jni.so').existsSync(), isFalse);
    expectNoNativeBinariesOrOnlyQ344ActualBundle();
  });
}
