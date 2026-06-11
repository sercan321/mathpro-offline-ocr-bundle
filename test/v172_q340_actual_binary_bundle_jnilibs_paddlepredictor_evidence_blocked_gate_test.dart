import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'v172_q344_binary_bundle_successor_test_helper.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_actual_binary_bundle_jnilibs_paddlepredictor_evidence_blocked_gate_q340.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_actual_binary_bundle_jnilibs_paddlepredictor_evidence_blocked_gate_q340_policy.dart';

const String q341SuccessorPhase = 'V172-Q341-NATIVE-PACKAGE-HASH-EVIDENCE-CAPTURE-BUNDLE-EVIDENCE-ACCEPTANCE';
const String q342SuccessorPhase = 'V172-Q342-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-PENDING-EVIDENCE-BLOCKED';

void main() {
  test('q340 manifest records actual binary bundle gate while preserving UI red lines', () {
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
    expect(<String>[GaussActualBinaryBundleJniLibsPaddlePredictorEvidenceBlockedGateQ340Policy.phase, q341SuccessorPhase, q342SuccessorPhase, 'V172-Q343-NATIVE-PACKAGE-HASH-EVIDENCE-FINAL-ACCEPTANCE-REAL-BUNDLE-UNLOCK-GATE', q344ActualBinaryBundlePhase, q345GradleAbiPackagingBuildTrialPhase, q346NativeLibraryLoadSmokePhase, q347PaddleLitePredictorInstantiateSmokePhase, q348OptimizedModelConversionModelLoaderEvidenceGatePhase, q349RealModelLoadSmokeEvidenceBlockedPhase, q350OptimizedModelArtifactConversionEvidenceIntakePhase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase, q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'], contains(manifest['cameraOcrLatestPhase']));
    expect(<String>[GaussActualBinaryBundleJniLibsPaddlePredictorEvidenceBlockedGateQ340Policy.phase, q341SuccessorPhase, q342SuccessorPhase, 'V172-Q343-NATIVE-PACKAGE-HASH-EVIDENCE-FINAL-ACCEPTANCE-REAL-BUNDLE-UNLOCK-GATE', q344ActualBinaryBundlePhase, q345GradleAbiPackagingBuildTrialPhase, q346NativeLibraryLoadSmokePhase, q347PaddleLitePredictorInstantiateSmokePhase, q348OptimizedModelConversionModelLoaderEvidenceGatePhase, q349RealModelLoadSmokeEvidenceBlockedPhase, q350OptimizedModelArtifactConversionEvidenceIntakePhase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase, q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'], contains(manifest['activeProductDevelopmentLatestPhase']));
    expect(manifest['actualBinaryBundleJniLibsPaddlePredictorEvidenceBlockedGateLatestPhase'], GaussActualBinaryBundleJniLibsPaddlePredictorEvidenceBlockedGateQ340Policy.phase);

    final q340 = manifest['v172Q340ActualBinaryBundleJniLibsPaddlePredictorEvidenceBlockedGate'] as Map<String, dynamic>;
    expect(q340['phase'], GaussActualBinaryBundleJniLibsPaddlePredictorEvidenceBlockedGateQ340Policy.phase);
    expect(q340['sourcePhase'], GaussActualBinaryBundleJniLibsPaddlePredictorEvidenceBlockedGateQ340Policy.sourcePhase);
    expect(q340['method'], GaussActualBinaryBundleJniLibsPaddlePredictorEvidenceBlockedGateQ340Policy.methodName);
    expect(q340['status'], GaussActualBinaryBundleJniLibsPaddlePredictorEvidenceBlockedGateQ340Policy.status);
    expect(q340['uiProtectionStatus'], contains('UI_PROTECTED'));
    expect(q340['requiredNativePackageFiles'], contains('PaddlePredictor.jar'));
    expect(q340['plannedBundleTargets'], contains('android/app/libs/PaddlePredictor.jar'));

    for (final key in <String>[
      'q328NativePackageHashEvidenceJsonProvided',
      'q328NativePackageHashEvidenceJsonAccepted',
      'explicitUserBinaryBundleApprovalProvided',
      'finalBundlePermissionGranted',
      'actualBinaryBundleAttempted',
      'actualBinaryBundleExecuted',
      'nativeLibraryBundled',
      'jarBundled',
      'jniLibsDirectoryCreated',
      'androidAppLibsDirectoryCreated',
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
      'systemLoadLibraryAdded',
      'paddleLiteInstantiated',
      'runtimeDependencyAdded',
      'modelLoaderAvailable',
      'realImageToLatexInferenceExecuted',
      'ocrPassClaimed',
    ]) {
      expect(q340[key], isFalse, reason: 'Q340 must keep $key false');
    }

    final result = GaussActualBinaryBundleJniLibsPaddlePredictorEvidenceBlockedGateQ340.evaluate();
    expect(result.phase, GaussActualBinaryBundleJniLibsPaddlePredictorEvidenceBlockedGateQ340Policy.phase);
    expect(result.methodName, GaussActualBinaryBundleJniLibsPaddlePredictorEvidenceBlockedGateQ340Policy.methodName);
    expect(result.finalBundlePermissionGranted, isFalse);
    expect(result.actualBinaryBundleExecuted, isFalse);
    expect(result.keyboardChanged, isFalse);
    expect(result.mathLiveProductionBridgeChanged, isFalse);
    expect(result.ocrPassClaimed, isFalse);
  });

  test('q340 package remains no-binary and protected UI files are present', () {
    final mainActivity = File('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt').readAsStringSync();
    expect(mainActivity, contains('private val q340Phase = "V172-Q340-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-EVIDENCE-BLOCKED-GATE"'));
    expect(mainActivity, contains('"actualBinaryBundleEvidenceBlockedGate" -> result.success(q340ActualBinaryBundleEvidenceBlockedGate(call.method))'));
    expect(mainActivity, contains('"q328NativePackageHashEvidenceJsonProvided" to false'));
    expect(mainActivity, contains('"explicitUserBinaryBundleApprovalProvided" to false'));
    expect(mainActivity, contains('"actualBinaryBundleExecuted" to false'));
    expect(mainActivity, contains('"keyboardChanged" to false'));
    expect(mainActivity, contains('"mathLiveProductionBridgeChanged" to false'));

    for (final forbidden in <String>[
      'PaddlePredictor(',
      'Predictor(',
      'PaddleLite(',
    ]) {
      expect(mainActivity.contains(forbidden), isFalse, reason: 'Q340 must not introduce runtime marker: $forbidden');
    }

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
    if (isQ344ActualBinaryBundleActive()) {
      expect(File('android/app/libs/PaddlePredictor.jar').existsSync(), isTrue);
    } else {
      expect(File('android/app/libs/PaddlePredictor.jar').existsSync(), isFalse);
    }
    expect(File('lib/features/workspace/workspace_panel.dart').existsSync(), isTrue);
    expect(File('lib/features/keyboard/math_keyboard.dart').existsSync(), isTrue);
    expect(File('assets/mathlive/mathlive_prod_bridge.js').existsSync(), isTrue);
    expect(File('lib/features/graph/graph_card.dart').existsSync(), isTrue);
    expect(File('lib/features/solution/solution_steps_panel.dart').existsSync(), isTrue);
    expect(File('lib/features/history/history_panel.dart').existsSync(), isTrue);
  });
}
