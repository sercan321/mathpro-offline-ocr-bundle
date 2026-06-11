import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'v172_q344_binary_bundle_successor_test_helper.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_actual_binary_bundle_jnilibs_paddlepredictor_no_evidence_blocked_gate_q338.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_actual_binary_bundle_jnilibs_paddlepredictor_no_evidence_blocked_gate_q338_policy.dart';

const String q339SuccessorPhase = 'V172-Q339-NATIVE-PACKAGE-HASH-EVIDENCE-CAPTURE-ACTUAL-BUNDLE-PERMISSION-FINAL-CHECK';
const String q340SuccessorPhase = 'V172-Q340-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-EVIDENCE-BLOCKED-GATE';
const String q341SuccessorPhase = 'V172-Q341-NATIVE-PACKAGE-HASH-EVIDENCE-CAPTURE-BUNDLE-EVIDENCE-ACCEPTANCE';
const String q342SuccessorPhase = 'V172-Q342-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-PENDING-EVIDENCE-BLOCKED';

void main() {
  test('q338 manifest records actual binary bundle blocked gate with UI protections', () {
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
    expect(<String>[GaussActualBinaryBundleJniLibsPaddlePredictorNoEvidenceBlockedGateQ338Policy.phase, q339SuccessorPhase, 'V172-Q343-NATIVE-PACKAGE-HASH-EVIDENCE-FINAL-ACCEPTANCE-REAL-BUNDLE-UNLOCK-GATE', q344ActualBinaryBundlePhase, q345GradleAbiPackagingBuildTrialPhase, q346NativeLibraryLoadSmokePhase, q347PaddleLitePredictorInstantiateSmokePhase, q348OptimizedModelConversionModelLoaderEvidenceGatePhase, q349RealModelLoadSmokeEvidenceBlockedPhase, q350OptimizedModelArtifactConversionEvidenceIntakePhase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase, q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'], contains(manifest['cameraOcrLatestPhase']));
    expect(<String>[GaussActualBinaryBundleJniLibsPaddlePredictorNoEvidenceBlockedGateQ338Policy.phase, q339SuccessorPhase, 'V172-Q343-NATIVE-PACKAGE-HASH-EVIDENCE-FINAL-ACCEPTANCE-REAL-BUNDLE-UNLOCK-GATE', q344ActualBinaryBundlePhase, q345GradleAbiPackagingBuildTrialPhase, q346NativeLibraryLoadSmokePhase, q347PaddleLitePredictorInstantiateSmokePhase, q348OptimizedModelConversionModelLoaderEvidenceGatePhase, q349RealModelLoadSmokeEvidenceBlockedPhase, q350OptimizedModelArtifactConversionEvidenceIntakePhase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase, q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'], contains(manifest['activeProductDevelopmentLatestPhase']));
    expect(manifest['actualBinaryBundleNoEvidenceBlockedGateLatestPhase'], GaussActualBinaryBundleJniLibsPaddlePredictorNoEvidenceBlockedGateQ338Policy.phase);

    final q338 = manifest['v172Q338ActualBinaryBundleJniLibsPaddlePredictorNoEvidenceBlockedGate'] as Map<String, dynamic>;
    expect(q338['phase'], GaussActualBinaryBundleJniLibsPaddlePredictorNoEvidenceBlockedGateQ338Policy.phase);
    expect(q338['sourcePhase'], GaussActualBinaryBundleJniLibsPaddlePredictorNoEvidenceBlockedGateQ338Policy.sourcePhase);
    expect(q338['actualBinaryBundleNoEvidenceBlockedGateMethod'], 'actualBinaryBundleNoEvidenceBlockedGate');
    expect(q338['actualBinaryBundleNoEvidenceBlockedGateStatus'], contains('NO_Q328_NATIVE_HASH_EVIDENCE'));
    expect(q338['uiProtectionStatus'], contains('UI_PROTECTED'));
    expect(q338['requiredNativePackageFiles'], contains('PaddlePredictor.jar'));
    expect(q338['plannedBundleTargets'], contains('android/app/libs/PaddlePredictor.jar'));
    expect(q338['q328NativePackageHashEvidenceJsonProvided'], isFalse);
    expect(q338['explicitUserBinaryBundleApprovalProvided'], isFalse);
    expect(q338['binaryBundlePermissionGranted'], isFalse);
    expect(q338['actualBinaryBundleExecuted'], isFalse);
    expect(q338['nativeLibraryBundled'], isFalse);
    expect(q338['jarBundled'], isFalse);
    expect(q338['jniLibsDirectoryCreated'], isFalse);
    expect(q338['androidAppLibsDirectoryCreated'], isFalse);
    expect(q338['gradleChanged'], isFalse);
    expect(q338['pubspecChanged'], isFalse);
    expect(q338['androidManifestChanged'], isFalse);
    expect(q338['workspaceChanged'], isFalse);
    expect(q338['keyboardChanged'], isFalse);
    expect(q338['mathLiveProductionBridgeChanged'], isFalse);
    expect(q338['graphChanged'], isFalse);
    expect(q338['solutionChanged'], isFalse);
    expect(q338['historyChanged'], isFalse);
    expect(q338['splashChanged'], isFalse);
    expect(q338['ocrPassClaimed'], isFalse);

    final result = GaussActualBinaryBundleJniLibsPaddlePredictorNoEvidenceBlockedGateQ338.evaluate();
    expect(result.phase, GaussActualBinaryBundleJniLibsPaddlePredictorNoEvidenceBlockedGateQ338Policy.phase);
    expect(result.methodName, 'actualBinaryBundleNoEvidenceBlockedGate');
    expect(result.status, contains('NO_Q328_NATIVE_HASH_EVIDENCE'));
    expect(result.actualBinaryBundleExecuted, isFalse);
    expect(result.nativeLibraryBundled, isFalse);
    expect(result.jarBundled, isFalse);
    expect(result.workspaceChanged, isFalse);
    expect(result.keyboardChanged, isFalse);
    expect(result.mathLiveProductionBridgeChanged, isFalse);
    expect(result.ocrPassClaimed, isFalse);
  });

  test('q338 bridge and package remain no-binary no-runtime and no-ui-mutation', () {
    final mainActivity = File('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt').readAsStringSync();
    expect(mainActivity, contains('private val q338Phase = "V172-Q338-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-NO-EVIDENCE-BLOCKED-GATE"'));
    expect(mainActivity, contains('"actualBinaryBundleNoEvidenceBlockedGate" -> result.success(q338ActualBinaryBundleNoEvidenceBlockedGate(call.method))'));
    expect(mainActivity, contains('"q328NativePackageHashEvidenceJsonProvided" to false'));
    expect(mainActivity, contains('"explicitUserBinaryBundleApprovalProvided" to false'));
    expect(mainActivity, contains('"actualBinaryBundleExecuted" to false'));
    expect(mainActivity, contains('"workspaceChanged" to false'));
    expect(mainActivity, contains('"keyboardChanged" to false'));
    expect(mainActivity, contains('"mathLiveProductionBridgeChanged" to false'));

    for (final forbidden in <String>[
      'PaddlePredictor(',
      'Predictor(',
      'PaddleLite(',
    ]) {
      expect(mainActivity.contains(forbidden), isFalse, reason: 'Q338 must not introduce runtime marker: $forbidden');
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
  });
}
