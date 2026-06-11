import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'v172_q344_binary_bundle_successor_test_helper.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_q343r1_flutter_analyze_test_syntax_hygiene_repair.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_q343r1_flutter_analyze_test_syntax_hygiene_repair_policy.dart';

void main() {
  test('q343r2 records Q343R1 Dart syntax hygiene repair without advancing OCR runtime gate', () {
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
    final q343r2 = manifest['v172Q343R2FlutterAnalyzeTestSyntaxHygieneRepair'] as Map<String, dynamic>;

    expect(q343r2['phase'], GaussQ343R1FlutterAnalyzeTestSyntaxHygieneRepairPolicy.phase);
    expect(q343r2['sourcePhase'], GaussQ343R1FlutterAnalyzeTestSyntaxHygieneRepairPolicy.sourcePhase);
    expect(q343r2['status'], GaussQ343R1FlutterAnalyzeTestSyntaxHygieneRepairPolicy.status);
    expect(manifest['q343R1FlutterAnalyzeTestSyntaxHygieneRepairLatestPhase'], GaussQ343R1FlutterAnalyzeTestSyntaxHygieneRepairPolicy.phase);
    expect(<String>[GaussQ343R1FlutterAnalyzeTestSyntaxHygieneRepairPolicy.preservedCameraOcrPhase, q344ActualBinaryBundlePhase, q345GradleAbiPackagingBuildTrialPhase, q346NativeLibraryLoadSmokePhase, q347PaddleLitePredictorInstantiateSmokePhase, q348OptimizedModelConversionModelLoaderEvidenceGatePhase, q349RealModelLoadSmokeEvidenceBlockedPhase, q350OptimizedModelArtifactConversionEvidenceIntakePhase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase, q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'], contains(manifest['cameraOcrLatestPhase']));
    expect(<String>[GaussQ343R1FlutterAnalyzeTestSyntaxHygieneRepairPolicy.preservedCameraOcrPhase, q344ActualBinaryBundlePhase, q345GradleAbiPackagingBuildTrialPhase, q346NativeLibraryLoadSmokePhase, q347PaddleLitePredictorInstantiateSmokePhase, q348OptimizedModelConversionModelLoaderEvidenceGatePhase, q349RealModelLoadSmokeEvidenceBlockedPhase, q350OptimizedModelArtifactConversionEvidenceIntakePhase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase, q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'], contains(manifest['activeProductDevelopmentLatestPhase']));
    expect(q343r2['cameraOcrLatestPhaseAdvanced'], isFalse);
    expect(q343r2['mainActivityChanged'], isFalse);
    expect(q343r2['binaryBundleExecuted'], isFalse);
    expect(q343r2['uiRuntimeChanged'], isFalse);
    expect(q343r2['ocrPassClaimed'], isFalse);
  });

  test('q343r2 Dart contract is syntax hygiene only', () {
    final result = GaussQ343R1FlutterAnalyzeTestSyntaxHygieneRepair.evaluate();

    expect(result.phase, GaussQ343R1FlutterAnalyzeTestSyntaxHygieneRepairPolicy.phase);
    expect(result.sourcePhase, GaussQ343R1FlutterAnalyzeTestSyntaxHygieneRepairPolicy.sourcePhase);
    expect(result.preservedCameraOcrPhase, GaussQ343R1FlutterAnalyzeTestSyntaxHygieneRepairPolicy.preservedCameraOcrPhase);
    expect(result.repairedSyntaxFiles, contains('test/v172_q315r1_controlled_model_artifact_download_hash_capture_flutter_test_repair_test.dart'));
    expect(result.repairedSyntaxFiles, contains('test/v172_q316_runtime_dependency_feasibility_trial_default_off_test.dart'));
    expect(result.syntaxRepairScope, contains('remove malformed leading-comma Q343 successor list entries'));
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

  test('q343r2 removes malformed leading-comma successor entries from Q315R1 and Q316 tests', () {
    for (final rel in <String>[
      'test/v172_q315r1_controlled_model_artifact_download_hash_capture_flutter_test_repair_test.dart',
      'test/v172_q316_runtime_dependency_feasibility_trial_default_off_test.dart',
    ]) {
      final text = File(rel).readAsStringSync();
      expect(text, contains("const String q343SuccessorPhase = 'V172-Q343-NATIVE-PACKAGE-HASH-EVIDENCE-FINAL-ACCEPTANCE-REAL-BUNDLE-UNLOCK-GATE';"));
      expect(text, contains('q343SuccessorPhase, q344ActualBinaryBundlePhase, q345GradleAbiPackagingBuildTrialPhase,'));
      expect(text, isNot(contains("\n    , 'V172-Q343-NATIVE-PACKAGE-HASH-EVIDENCE-FINAL-ACCEPTANCE-REAL-BUNDLE-UNLOCK-GATE', q344ActualBinaryBundlePhase, q345GradleAbiPackagingBuildTrialPhase, q346NativeLibraryLoadSmokePhase]")));
      expect(text, isNot(contains("\n    , 'V172-Q343")));
    }
  });

  test('q343r2 keeps native binaries and UI runtime surfaces untouched', () {
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
      expect(File(rel).existsSync(), isTrue, reason: 'Q343R2 protected file must still exist: $rel');
    }
  });
}
