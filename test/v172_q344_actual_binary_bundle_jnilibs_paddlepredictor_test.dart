import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_actual_binary_bundle_jnilibs_paddlepredictor_q344.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_actual_binary_bundle_jnilibs_paddlepredictor_q344_policy.dart';

import 'v172_q344_binary_bundle_successor_test_helper.dart';

void main() {
  test('q344 manifest records actual native binary bundle but no runtime execution', () {
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
    final q344 = manifest['v172Q344ActualBinaryBundleJniLibsPaddlePredictor'] as Map<String, dynamic>;

    expect(<String>[GaussActualBinaryBundleJniLibsPaddlePredictorQ344Policy.phase, q345GradleAbiPackagingBuildTrialPhase, q346NativeLibraryLoadSmokePhase, q347PaddleLitePredictorInstantiateSmokePhase, q348OptimizedModelConversionModelLoaderEvidenceGatePhase, q349RealModelLoadSmokeEvidenceBlockedPhase, q350OptimizedModelArtifactConversionEvidenceIntakePhase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase, q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'], contains(manifest['cameraOcrLatestPhase']));
    expect(<String>[GaussActualBinaryBundleJniLibsPaddlePredictorQ344Policy.phase, q345GradleAbiPackagingBuildTrialPhase, q346NativeLibraryLoadSmokePhase, q347PaddleLitePredictorInstantiateSmokePhase, q348OptimizedModelConversionModelLoaderEvidenceGatePhase, q349RealModelLoadSmokeEvidenceBlockedPhase, q350OptimizedModelArtifactConversionEvidenceIntakePhase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase, q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'], contains(manifest['activeProductDevelopmentLatestPhase']));
    expect(manifest['actualBinaryBundleJniLibsPaddlePredictorLatestPhase'], GaussActualBinaryBundleJniLibsPaddlePredictorQ344Policy.phase);
    expect(q344['phase'], GaussActualBinaryBundleJniLibsPaddlePredictorQ344Policy.phase);
    expect(q344['sourcePhase'], GaussActualBinaryBundleJniLibsPaddlePredictorQ344Policy.sourcePhase);
    expect(q344['q328NativePackageHashEvidenceJsonAccepted'], isTrue);
    expect(q344['explicitUserBinaryBundleApprovalProvided'], isTrue);
    expect(q344['q343R2FlutterAnalyzeTestCleanUserLogProvided'], isTrue);
    expect(q344['actualBinaryBundleExecuted'], isTrue);
    expect(q344['nativeLibraryBundled'], isTrue);
    expect(q344['jarBundled'], isTrue);
    expect(q344['jniLibsDirectoryCreated'], isTrue);
    expect(q344['androidAppLibsDirectoryCreated'], isTrue);

    for (final key in <String>[
      'gradleChanged',
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
      'ocrPassClaimed',
      'androidRealDevicePassClaimed',
    ]) {
      expect(q344[key], isFalse, reason: 'Q344 $key must remain false');
    }
  });

  test('q344 Dart contract exposes bundled files and keeps OCR runtime non-goals false', () {
    final result = GaussActualBinaryBundleJniLibsPaddlePredictorQ344.evaluate();

    expect(result.phase, GaussActualBinaryBundleJniLibsPaddlePredictorQ344Policy.phase);
    expect(result.sourcePhase, GaussActualBinaryBundleJniLibsPaddlePredictorQ344Policy.sourcePhase);
    expect(result.status, GaussActualBinaryBundleJniLibsPaddlePredictorQ344Policy.status);
    expect(result.requiredSourceNativePackageFiles, contains('PaddlePredictor.jar'));
    expect(result.bundledNativeTargets, contains('android/app/libs/PaddlePredictor.jar'));
    expect(result.expectedSha256ByTarget, contains('android/app/libs/PaddlePredictor.jar=81c8f73729123fd4b65b1b0d01ad58f9a0f0fe61274d49179910696cc68959f2'));
    expect(result.q328NativePackageHashEvidenceAccepted, isTrue);
    expect(result.explicitUserBinaryBundleApprovalProvided, isTrue);
    expect(result.actualBinaryBundleExecuted, isTrue);
    expect(result.nativeLibraryBundled, isTrue);
    expect(result.jarBundled, isTrue);
    expect(result.systemLoadLibraryAdded, isFalse);
    expect(result.paddleLiteInstantiated, isFalse);
    expect(result.realImageToLatexInferenceExecuted, isFalse);
    expect(result.ocrPassClaimed, isFalse);
  });

  test('q344 package contains exactly the approved native bundle files', () {
    expect(File('android/app/libs/PaddlePredictor.jar').existsSync(), isTrue);
    expect(File('android/app/src/main/jniLibs/arm64-v8a/libpaddle_lite_jni.so').existsSync(), isTrue);
    expect(File('android/app/src/main/jniLibs/armeabi-v7a/libpaddle_lite_jni.so').existsSync(), isTrue);
    expect(File('android/app/src/main/jniLibs/x86_64/libpaddle_lite_jni.so').existsSync(), isFalse);
    expectNoNativeBinariesOrOnlyQ344ActualBundle();
  });

  test('q344 does not introduce native loading or Paddle Lite runtime execution markers', () {
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
      expect(File(rel).existsSync(), isTrue, reason: 'Q344 protected file must still exist: $rel');
    }
  });
}
