import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_q351_flutter_run_kotlin_build_helper_repair_q351r2.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_q351_flutter_run_kotlin_build_helper_repair_q351r2_policy.dart';

import 'v172_q344_binary_bundle_successor_test_helper.dart';

void main() {
  test('q351r2 records Kotlin build helper repair while preserving active Q351 product gate', () {
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
    final q351r2 = manifest['v172Q351R2FlutterRunKotlinBuildHelperRepair'] as Map<String, dynamic>;

    expect(manifest['q351R2FlutterRunKotlinBuildHelperRepairLatestPhase'],
        GaussQ351FlutterRunKotlinBuildHelperRepairQ351R2Policy.phase);
    expect(<String>{
      q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase,
      q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'}, contains(manifest['cameraOcrLatestPhase']));
    expect(<String>{
      q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase,
      q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase,
    'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE',}, contains(manifest['activeProductDevelopmentLatestPhase']));
    expect(q351r2['phase'], GaussQ351FlutterRunKotlinBuildHelperRepairQ351R2Policy.phase);
    expect(q351r2['sourcePhase'], GaussQ351FlutterRunKotlinBuildHelperRepairQ351R2Policy.sourcePhase);
    expect(q351r2['kotlinBuildHelperRepair'], isTrue);
    expect(q351r2['mainActivityChanged'], isTrue);
    expect(q351r2['gradleChanged'], isFalse);
    expect(q351r2['androidManifestChanged'], isFalse);
    expect(q351r2['modelLoadAttempted'], isFalse);
    expect(q351r2['ocrPassClaimed'], isFalse);
  });

  test('q351r2 restores q318 private storage helper functions used by later OCR bridge envelopes', () {
    final mainActivity = File('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt').readAsStringSync();
    expect(mainActivity, contains('private fun q318PrivateModelStorageRoot(): File'));
    expect(mainActivity, contains('private fun q318PrivateModelArtifactFile(): File'));
    expect(mainActivity, contains('File(filesDir, q318PrivateModelDirectoryName)'));
    expect(mainActivity, contains('File(q318PrivateModelStorageRoot(), q318PrivateModelArtifactFileName)'));
    expect(mainActivity, contains('private val q347Phase = "V172-Q347-PADDLE-LITE-PREDICTOR-INSTANTIATE-SMOKE"'));
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
    expect(mainActivity, isNot(contains('runInference(')));
  });

  test('q351r2 Dart contract exposes build repair only', () {
    final result = GaussQ351FlutterRunKotlinBuildHelperRepairQ351R2.evaluate();
    expect(result.phase, GaussQ351FlutterRunKotlinBuildHelperRepairQ351R2Policy.phase);
    expect(result.sourcePhase, GaussQ351FlutterRunKotlinBuildHelperRepairQ351R2Policy.sourcePhase);
    expect(result.preservedCameraOcrLatestPhase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase);
    expect(result.kotlinBuildHelperRepair, isTrue);
    expect(result.mainActivityChanged, isTrue);
    expect(result.gradleChanged, isFalse);
    expect(result.systemLoadLibraryAdded, isFalse);
    expect(result.paddleLiteInstantiated, isFalse);
    expect(result.modelLoadAttempted, isFalse);
    expect(result.ocrPassClaimed, isFalse);
    expectNoNativeBinariesOrOnlyQ344ActualBundle();
  });
}
