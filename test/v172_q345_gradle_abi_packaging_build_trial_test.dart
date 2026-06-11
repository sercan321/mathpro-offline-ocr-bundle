import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_gradle_abi_packaging_build_trial_q345.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_gradle_abi_packaging_build_trial_q345_policy.dart';

import 'v172_q344_binary_bundle_successor_test_helper.dart';

void main() {
  test('q345 manifest records Gradle ABI packaging build trial gate without runtime execution', () {
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
    final q345 = manifest['v172Q345GradleAbiPackagingBuildTrial'] as Map<String, dynamic>;

    expect(<String>[GaussGradleAbiPackagingBuildTrialQ345Policy.phase, q346NativeLibraryLoadSmokePhase, q347PaddleLitePredictorInstantiateSmokePhase, q348OptimizedModelConversionModelLoaderEvidenceGatePhase, q349RealModelLoadSmokeEvidenceBlockedPhase, q350OptimizedModelArtifactConversionEvidenceIntakePhase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase, q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'], contains(manifest['cameraOcrLatestPhase']));
    expect(<String>[GaussGradleAbiPackagingBuildTrialQ345Policy.phase, q346NativeLibraryLoadSmokePhase, q347PaddleLitePredictorInstantiateSmokePhase, q348OptimizedModelConversionModelLoaderEvidenceGatePhase, q349RealModelLoadSmokeEvidenceBlockedPhase, q350OptimizedModelArtifactConversionEvidenceIntakePhase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase, q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'], contains(manifest['activeProductDevelopmentLatestPhase']));
    expect(manifest['gradleAbiPackagingBuildTrialLatestPhase'], GaussGradleAbiPackagingBuildTrialQ345Policy.phase);
    expect(q345['phase'], GaussGradleAbiPackagingBuildTrialQ345Policy.phase);
    expect(q345['sourcePhase'], GaussGradleAbiPackagingBuildTrialQ345Policy.sourcePhase);
    expect(q345['q344ActualBinaryBundlePresent'], isTrue);
    expect(q345['paddlePredictorJarDependencyDeclared'], isTrue);
    expect(q345['jniLibsAbiSourceSetPresent'], isTrue);
    expect(q345['nativeLibraryPackagingByAndroidGradlePluginDefaultSourceSet'], isTrue);
    expect(q345['gradleChanged'], isTrue);

    for (final key in <String>[
      'pubspecChanged',
      'androidManifestChanged',
      'mainActivityChanged',
      'systemLoadLibraryAdded',
      'paddleLiteInstantiated',
      'modelLoaderAvailable',
      'runtimeStartupExecuted',
      'dummyRuntimeCallExecuted',
      'realImageToLatexInferenceExecuted',
      'editableMathLiveReviewOpened',
      'workspaceImportExecuted',
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
      'buildTrialExecutedByAssistant',
      'flutterAnalyzePassClaimed',
      'flutterTestPassClaimed',
      'androidRealDevicePassClaimed',
      'ocrPassClaimed',
    ]) {
      expect(q345[key], isFalse, reason: 'Q345 $key must remain false');
    }
  });

  test('q345 Dart contract exposes packaging signals and no OCR runtime execution', () {
    final result = GaussGradleAbiPackagingBuildTrialQ345.evaluate();

    expect(result.phase, GaussGradleAbiPackagingBuildTrialQ345Policy.phase);
    expect(result.sourcePhase, GaussGradleAbiPackagingBuildTrialQ345Policy.sourcePhase);
    expect(result.status, GaussGradleAbiPackagingBuildTrialQ345Policy.status);
    expect(result.q344ActualBinaryBundlePresent, isTrue);
    expect(result.paddlePredictorJarDependencyDeclared, isTrue);
    expect(result.jniLibsAbiSourceSetPresent, isTrue);
    expect(result.arm64V8aNativeLibraryPresent, isTrue);
    expect(result.armeabiV7aNativeLibraryPresent, isTrue);
    expect(result.x86_64NativeLibraryPresent, isFalse);
    expect(result.gradleChanged, isTrue);
    expect(result.mainActivityChanged, isFalse);
    expect(result.systemLoadLibraryAdded, isFalse);
    expect(result.paddleLiteInstantiated, isFalse);
    expect(result.realImageToLatexInferenceExecuted, isFalse);
    expect(result.androidRealDevicePassClaimed, isFalse);
    expect(result.ocrPassClaimed, isFalse);
  });

  test('q345 build.gradle declares local PaddlePredictor jar while jniLibs files stay exact Q344 bundle', () {
    final appGradle = File('android/app/build.gradle').readAsStringSync();
    expect(appGradle, contains("implementation files('libs/PaddlePredictor.jar')"));
    expect(File('android/app/libs/PaddlePredictor.jar').existsSync(), isTrue);
    expect(File('android/app/src/main/jniLibs/arm64-v8a/libpaddle_lite_jni.so').existsSync(), isTrue);
    expect(File('android/app/src/main/jniLibs/armeabi-v7a/libpaddle_lite_jni.so').existsSync(), isTrue);
    expect(File('android/app/src/main/jniLibs/x86_64/libpaddle_lite_jni.so').existsSync(), isFalse);
    expectNoNativeBinariesOrOnlyQ344ActualBundle();
  });

  test('q345 keeps native runtime loading and protected UI surfaces untouched', () {
    final mainActivity = File('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt').readAsStringSync();
    expectNoRuntimeExecutionBeyondQ346NativeLoadSmoke(mainActivity);
    expect(mainActivity.contains('PaddlePredictor('), isFalse);
    expect(mainActivity.contains('PaddleLite('), isFalse);
    expect(mainActivity.contains('loadModel('), isFalse);
    expect(mainActivity.contains('runInference('), isFalse);

    for (final rel in <String>[
      'lib/features/workspace/workspace_panel.dart',
      'lib/features/keyboard/key_config.dart',
      'lib/features/keyboard/math_keyboard.dart',
      'lib/features/keyboard/bottom_dock.dart',
      'lib/features/keyboard/long_press_popup.dart',
      'lib/features/workspace/template_tray.dart',
      'assets/mathlive/mathlive_prod_bridge.js',
      'lib/features/mathlive/mathlive_production_editor_surface.dart',
      'lib/features/graph/graph_card.dart',
      'lib/features/solution/solution_steps_panel.dart',
      'lib/features/history/history_panel.dart',
      'lib/app/gauss_splash_screen.dart',
    ]) {
      expect(File(rel).existsSync(), isTrue, reason: 'Q345 protected file must still exist: $rel');
    }
  });
}
