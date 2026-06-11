import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'v172_q344_binary_bundle_successor_test_helper.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_native_package_hash_evidence_final_acceptance_real_bundle_unlock_gate_q343.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_native_package_hash_evidence_final_acceptance_real_bundle_unlock_gate_q343_policy.dart';

void main() {
  test('q343 keeps real bundle unlock blocked until native package evidence, user approval, and clean Flutter logs exist', () {
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
    expect(<String>[GaussNativePackageHashEvidenceFinalAcceptanceRealBundleUnlockGateQ343Policy.phase, q344ActualBinaryBundlePhase, q345GradleAbiPackagingBuildTrialPhase, q346NativeLibraryLoadSmokePhase, q347PaddleLitePredictorInstantiateSmokePhase, q348OptimizedModelConversionModelLoaderEvidenceGatePhase, q349RealModelLoadSmokeEvidenceBlockedPhase, q350OptimizedModelArtifactConversionEvidenceIntakePhase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase, q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'], contains(manifest['cameraOcrLatestPhase']));
    expect(<String>[GaussNativePackageHashEvidenceFinalAcceptanceRealBundleUnlockGateQ343Policy.phase, q344ActualBinaryBundlePhase, q345GradleAbiPackagingBuildTrialPhase, q346NativeLibraryLoadSmokePhase, q347PaddleLitePredictorInstantiateSmokePhase, q348OptimizedModelConversionModelLoaderEvidenceGatePhase, q349RealModelLoadSmokeEvidenceBlockedPhase, q350OptimizedModelArtifactConversionEvidenceIntakePhase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase, q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'], contains(manifest['activeProductDevelopmentLatestPhase']));
    expect(manifest['nativePackageHashEvidenceFinalAcceptanceRealBundleUnlockGateLatestPhase'], GaussNativePackageHashEvidenceFinalAcceptanceRealBundleUnlockGateQ343Policy.phase);

    final q343 = manifest['v172Q343NativePackageHashEvidenceFinalAcceptanceRealBundleUnlockGate'] as Map<String, dynamic>;
    expect(q343['phase'], GaussNativePackageHashEvidenceFinalAcceptanceRealBundleUnlockGateQ343Policy.phase);
    expect(q343['sourcePhase'], GaussNativePackageHashEvidenceFinalAcceptanceRealBundleUnlockGateQ343Policy.sourcePhase);
    expect(q343['method'], GaussNativePackageHashEvidenceFinalAcceptanceRealBundleUnlockGateQ343Policy.methodName);
    expect(q343['status'], GaussNativePackageHashEvidenceFinalAcceptanceRealBundleUnlockGateQ343Policy.status);
    expect(q343['bundleUnlockStatus'], GaussNativePackageHashEvidenceFinalAcceptanceRealBundleUnlockGateQ343Policy.bundleUnlockStatus);
    expect(q343['uiProtectionStatus'], GaussNativePackageHashEvidenceFinalAcceptanceRealBundleUnlockGateQ343Policy.uiProtectionStatus);
    expect(q343['requiredNativePackageFiles'], contains('PaddlePredictor.jar'));
    expect(q343['requiredNativePackageFiles'], contains('arm64-v8a/libpaddle_lite_jni.so'));
    expect(q343['q328NativePackageHashEvidenceJsonAccepted'], isFalse);
    expect(q343['explicitUserBinaryBundleApprovalProvided'], isFalse);
    expect(q343['q342OrNewerUserFlutterLogClean'], isFalse);
    expect(q343['realBundleUnlockGranted'], isFalse);
    expect(q343['actualBinaryBundleExecuted'], isFalse);
    expect(q343['nativeLibraryBundled'], isFalse);
    expect(q343['jarBundled'], isFalse);
    expect(q343['jniLibsDirectoryCreated'], isFalse);
    expect(q343['androidAppLibsDirectoryCreated'], isFalse);
    expect(q343['gradleChanged'], isFalse);
    expect(q343['pubspecChanged'], isFalse);
    expect(q343['androidManifestChanged'], isFalse);
    expect(q343['workspaceChanged'], isFalse);
    expect(q343['keyboardChanged'], isFalse);
    expect(q343['mathLiveProductionBridgeChanged'], isFalse);
    expect(q343['graphChanged'], isFalse);
    expect(q343['solutionChanged'], isFalse);
    expect(q343['historyChanged'], isFalse);
    expect(q343['ocrPassClaimed'], isFalse);
  });

  test('q343 dart contract does not unlock or bundle Paddle Lite binaries', () {
    final result = GaussNativePackageHashEvidenceFinalAcceptanceRealBundleUnlockGateQ343.evaluate();
    expect(result.phase, GaussNativePackageHashEvidenceFinalAcceptanceRealBundleUnlockGateQ343Policy.phase);
    expect(result.methodName, GaussNativePackageHashEvidenceFinalAcceptanceRealBundleUnlockGateQ343Policy.methodName);
    expect(result.status, GaussNativePackageHashEvidenceFinalAcceptanceRealBundleUnlockGateQ343Policy.status);
    expect(result.requiredNativePackageFiles, contains('PaddlePredictor.jar'));
    expect(result.plannedBundleTargets, contains('android/app/libs/PaddlePredictor.jar'));
    expect(result.q328NativePackageHashEvidenceJsonAccepted, isFalse);
    expect(result.explicitUserBinaryBundleApprovalProvided, isFalse);
    expect(result.q342OrNewerUserFlutterLogClean, isFalse);
    expect(result.realBundleUnlockGranted, isFalse);
    expect(result.actualBinaryBundleAttempted, isFalse);
    expect(result.actualBinaryBundleExecuted, isFalse);
    expect(result.nativeLibraryBundled, isFalse);
    expect(result.jarBundled, isFalse);
    expect(result.systemLoadLibraryAdded, isFalse);
    expect(result.paddleLiteInstantiated, isFalse);
    expect(result.realImageToLatexInferenceExecuted, isFalse);
    expect(result.ocrPassClaimed, isFalse);
  });

  test('q343 contains no app-bundled native binaries and keeps UI red-line surfaces untouched by declaration', () {
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

    final mainActivity = File('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt').readAsStringSync();
    expect(mainActivity, contains('private val q343Phase = "${GaussNativePackageHashEvidenceFinalAcceptanceRealBundleUnlockGateQ343Policy.phase}"'));
    expect(mainActivity, contains('"${GaussNativePackageHashEvidenceFinalAcceptanceRealBundleUnlockGateQ343Policy.methodName}" -> result.success(q343NativePackageHashEvidenceFinalAcceptanceRealBundleUnlockGate(call.method))'));
    expect(mainActivity, contains('"realBundleUnlockGranted" to false'));
    expect(mainActivity, contains('"actualBinaryBundleExecuted" to false'));
    expect(mainActivity, contains('"workspaceChanged" to false'));
    expect(mainActivity, contains('"keyboardChanged" to false'));
    expect(mainActivity, contains('"mathLiveProductionBridgeChanged" to false'));
    expectNoRuntimeExecutionBeyondQ346NativeLoadSmoke(mainActivity);
    expect(mainActivity.contains('PaddlePredictor('), isFalse);
  });
}
