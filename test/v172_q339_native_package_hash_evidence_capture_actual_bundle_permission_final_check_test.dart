import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'v172_q344_binary_bundle_successor_test_helper.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_native_package_hash_evidence_capture_actual_bundle_permission_final_check_q339.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_native_package_hash_evidence_capture_actual_bundle_permission_final_check_q339_policy.dart';

const String q340SuccessorPhase = 'V172-Q340-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-EVIDENCE-BLOCKED-GATE';
const String q341SuccessorPhase = 'V172-Q341-NATIVE-PACKAGE-HASH-EVIDENCE-CAPTURE-BUNDLE-EVIDENCE-ACCEPTANCE';
const String q342SuccessorPhase = 'V172-Q342-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-PENDING-EVIDENCE-BLOCKED';

void main() {
  test('q339 manifest records final binary bundle permission check while keeping UI protected', () {
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
    expect(<String>[GaussNativePackageHashEvidenceCaptureActualBundlePermissionFinalCheckQ339Policy.phase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase, 'V172-Q343-NATIVE-PACKAGE-HASH-EVIDENCE-FINAL-ACCEPTANCE-REAL-BUNDLE-UNLOCK-GATE', q344ActualBinaryBundlePhase, q345GradleAbiPackagingBuildTrialPhase, q346NativeLibraryLoadSmokePhase, q347PaddleLitePredictorInstantiateSmokePhase, q348OptimizedModelConversionModelLoaderEvidenceGatePhase, q349RealModelLoadSmokeEvidenceBlockedPhase, q350OptimizedModelArtifactConversionEvidenceIntakePhase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase, q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'], contains(manifest['cameraOcrLatestPhase']));
    expect(<String>[GaussNativePackageHashEvidenceCaptureActualBundlePermissionFinalCheckQ339Policy.phase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase, 'V172-Q343-NATIVE-PACKAGE-HASH-EVIDENCE-FINAL-ACCEPTANCE-REAL-BUNDLE-UNLOCK-GATE', q344ActualBinaryBundlePhase, q345GradleAbiPackagingBuildTrialPhase, q346NativeLibraryLoadSmokePhase, q347PaddleLitePredictorInstantiateSmokePhase, q348OptimizedModelConversionModelLoaderEvidenceGatePhase, q349RealModelLoadSmokeEvidenceBlockedPhase, q350OptimizedModelArtifactConversionEvidenceIntakePhase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase, q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'], contains(manifest['activeProductDevelopmentLatestPhase']));
    expect(manifest['nativePackageHashEvidenceCaptureActualBundlePermissionFinalCheckLatestPhase'], GaussNativePackageHashEvidenceCaptureActualBundlePermissionFinalCheckQ339Policy.phase);

    final q339 = manifest['v172Q339NativePackageHashEvidenceCaptureActualBundlePermissionFinalCheck'] as Map<String, dynamic>;
    expect(q339['phase'], GaussNativePackageHashEvidenceCaptureActualBundlePermissionFinalCheckQ339Policy.phase);
    expect(q339['sourcePhase'], GaussNativePackageHashEvidenceCaptureActualBundlePermissionFinalCheckQ339Policy.sourcePhase);
    expect(q339['method'], GaussNativePackageHashEvidenceCaptureActualBundlePermissionFinalCheckQ339Policy.methodName);
    expect(q339['status'], contains('BLOCKED_PENDING_Q328_JSON'));
    expect(q339['uiProtectionStatus'], contains('UI_PROTECTED'));
    expect(q339['requiredNativePackageFiles'], contains('PaddlePredictor.jar'));
    expect(q339['plannedBundleTargets'], contains('android/app/libs/PaddlePredictor.jar'));

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
      expect(q339[key], isFalse, reason: 'Q339 must keep $key false');
    }

    final result = GaussNativePackageHashEvidenceCaptureActualBundlePermissionFinalCheckQ339.evaluate();
    expect(result.phase, GaussNativePackageHashEvidenceCaptureActualBundlePermissionFinalCheckQ339Policy.phase);
    expect(result.methodName, GaussNativePackageHashEvidenceCaptureActualBundlePermissionFinalCheckQ339Policy.methodName);
    expect(result.finalBundlePermissionGranted, isFalse);
    expect(result.actualBinaryBundleExecuted, isFalse);
    expect(result.keyboardChanged, isFalse);
    expect(result.mathLiveProductionBridgeChanged, isFalse);
    expect(result.ocrPassClaimed, isFalse);
  });

  test('q339 package remains no-binary and protected UI files are present', () {
    final mainActivity = File('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt').readAsStringSync();
    expect(mainActivity, contains('private val q339Phase = "V172-Q339-NATIVE-PACKAGE-HASH-EVIDENCE-CAPTURE-ACTUAL-BUNDLE-PERMISSION-FINAL-CHECK"'));
    expect(mainActivity, contains('"nativePackageHashEvidenceCaptureActualBundlePermissionFinalCheck" -> result.success(q339NativePackageHashEvidenceCaptureActualBundlePermissionFinalCheck(call.method))'));
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
      expect(mainActivity.contains(forbidden), isFalse, reason: 'Q339 must not introduce runtime marker: $forbidden');
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
