import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'v172_q344_binary_bundle_successor_test_helper.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_q343_flutter_analyze_test_successor_aware_hygiene_repair.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_q343_flutter_analyze_test_successor_aware_hygiene_repair_policy.dart';

void main() {
  test('q343r1 records analyzer/test hygiene repair without advancing the blocked OCR runtime gate', () {
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
    final q343r1 = manifest['v172Q343R1FlutterAnalyzeTestSuccessorAwareHygieneRepair'] as Map<String, dynamic>;

    expect(q343r1['phase'], GaussQ343FlutterAnalyzeTestSuccessorAwareHygieneRepairPolicy.phase);
    expect(q343r1['sourcePhase'], GaussQ343FlutterAnalyzeTestSuccessorAwareHygieneRepairPolicy.sourcePhase);
    expect(q343r1['status'], GaussQ343FlutterAnalyzeTestSuccessorAwareHygieneRepairPolicy.status);
    expect(manifest['q343FlutterAnalyzeTestSuccessorAwareHygieneRepairLatestPhase'], GaussQ343FlutterAnalyzeTestSuccessorAwareHygieneRepairPolicy.phase);
    expect(<String>[GaussQ343FlutterAnalyzeTestSuccessorAwareHygieneRepairPolicy.preservedCameraOcrPhase, q344ActualBinaryBundlePhase, q345GradleAbiPackagingBuildTrialPhase, q346NativeLibraryLoadSmokePhase, q347PaddleLitePredictorInstantiateSmokePhase, q348OptimizedModelConversionModelLoaderEvidenceGatePhase, q349RealModelLoadSmokeEvidenceBlockedPhase, q350OptimizedModelArtifactConversionEvidenceIntakePhase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase, q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'], contains(manifest['cameraOcrLatestPhase']));
    expect(<String>[GaussQ343FlutterAnalyzeTestSuccessorAwareHygieneRepairPolicy.preservedCameraOcrPhase, q344ActualBinaryBundlePhase, q345GradleAbiPackagingBuildTrialPhase, q346NativeLibraryLoadSmokePhase, q347PaddleLitePredictorInstantiateSmokePhase, q348OptimizedModelConversionModelLoaderEvidenceGatePhase, q349RealModelLoadSmokeEvidenceBlockedPhase, q350OptimizedModelArtifactConversionEvidenceIntakePhase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase, q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'], contains(manifest['activeProductDevelopmentLatestPhase']));
    expect(q343r1['cameraOcrLatestPhaseAdvanced'], isFalse);
    expect(q343r1['mainActivityChanged'], isFalse);
    expect(q343r1['binaryBundleExecuted'], isFalse);
    expect(q343r1['uiRuntimeChanged'], isFalse);
    expect(q343r1['ocrPassClaimed'], isFalse);
  });

  test('q343r1 Dart contract is a test/analyzer repair only', () {
    final result = GaussQ343FlutterAnalyzeTestSuccessorAwareHygieneRepair.evaluate();

    expect(result.phase, GaussQ343FlutterAnalyzeTestSuccessorAwareHygieneRepairPolicy.phase);
    expect(result.sourcePhase, GaussQ343FlutterAnalyzeTestSuccessorAwareHygieneRepairPolicy.sourcePhase);
    expect(result.preservedCameraOcrPhase, GaussQ343FlutterAnalyzeTestSuccessorAwareHygieneRepairPolicy.preservedCameraOcrPhase);
    expect(result.repairedAnalyzerFiles, contains('test/v172_q342_actual_binary_bundle_jnilibs_paddlepredictor_pending_evidence_blocked_test.dart'));
    expect(result.successorAwarenessScope, contains('Q313R1-Q341 cameraOcrLatestPhase successor expectations now accept Q343'));
    expect(result.cameraOcrLatestPhaseAdvanced, isFalse);
    expect(result.mainActivityChanged, isFalse);
    expect(result.binaryBundleExecuted, isFalse);
    expect(result.jniLibsDirectoryCreated, isFalse);
    expect(result.androidAppLibsDirectoryCreated, isFalse);
    expect(result.gradleChanged, isFalse);
    expect(result.pubspecChanged, isFalse);
    expect(result.androidManifestChanged, isFalse);
    expect(result.uiRuntimeChanged, isFalse);
    expect(result.ocrPassClaimed, isFalse);
  });

  test('q343r1 repairs Q342/Q343 analyzer string composition findings', () {
    final q342Test = File('test/v172_q342_actual_binary_bundle_jnilibs_paddlepredictor_pending_evidence_blocked_test.dart').readAsStringSync();
    final q343Test = File('test/v172_q343_native_package_hash_evidence_final_acceptance_real_bundle_unlock_gate_test.dart').readAsStringSync();

    expect(q342Test, contains(r'private val q342Phase = "${GaussActualBinaryBundleJniLibsPaddlePredictorPendingEvidenceBlockedQ342Policy.phase}"'));
    expect(q342Test, isNot(contains("'private val q342Phase = \"' +")));
    expect(q342Test, isNot(contains('Policy.methodName +')));
    expect(q343Test, contains(r'private val q343Phase = "${GaussNativePackageHashEvidenceFinalAcceptanceRealBundleUnlockGateQ343Policy.phase}"'));
    expect(q343Test, isNot(contains("'private val q343Phase = \"' +")));
    expect(q343Test, isNot(contains('Policy.methodName +')));
  });

  test('q343r1 keeps native binaries and UI runtime surfaces untouched', () {
    if (isQ344ActualBinaryBundleActive()) {
      expect(Directory('android/app/src/main/jniLibs').existsSync(), isTrue);
    } else {
      expect(Directory('android/app/src/main/jniLibs').existsSync(), isFalse);
    }
    if (isQ344ActualBinaryBundleActive()) {
      expect(Directory('android/app/libs').existsSync(), isTrue);
    } else {
      expect(Directory('android/app/libs').existsSync(), isFalse);
    }

    final appFiles = Directory('android/app')
        .listSync(recursive: true, followLinks: false)
        .whereType<File>()
        .map((file) => file.path.replaceAll('\\', '/'))
        .toList();
    expect(q344UnexpectedNativeBinaryPaths(appFiles), isEmpty);

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
      expect(File(rel).existsSync(), isTrue, reason: 'Q343R1 protected file must still exist: $rel');
    }
  });
}
