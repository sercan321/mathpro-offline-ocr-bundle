import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'v172_q344_binary_bundle_successor_test_helper.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_actual_binary_bundle_jnilibs_paddlepredictor_pending_evidence_blocked_q342.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_actual_binary_bundle_jnilibs_paddlepredictor_pending_evidence_blocked_q342_policy.dart';

void main() {
  test('q342 blocks actual binary bundle until evidence approval and preserves red-line UI files', () {
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
    expect(<String>[
        GaussActualBinaryBundleJniLibsPaddlePredictorPendingEvidenceBlockedQ342Policy.phase,
        'V172-Q343-NATIVE-PACKAGE-HASH-EVIDENCE-FINAL-ACCEPTANCE-REAL-BUNDLE-UNLOCK-GATE',
        q344ActualBinaryBundlePhase,
        q345GradleAbiPackagingBuildTrialPhase,
        q346NativeLibraryLoadSmokePhase,
        q347PaddleLitePredictorInstantiateSmokePhase,
        q348OptimizedModelConversionModelLoaderEvidenceGatePhase,
        q349RealModelLoadSmokeEvidenceBlockedPhase,
        q350OptimizedModelArtifactConversionEvidenceIntakePhase,
        q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase,
        'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE',
      ], contains(manifest['cameraOcrLatestPhase']));
    expect(
      <String>[
        GaussActualBinaryBundleJniLibsPaddlePredictorPendingEvidenceBlockedQ342Policy.phase,
        'V172-Q343-NATIVE-PACKAGE-HASH-EVIDENCE-FINAL-ACCEPTANCE-REAL-BUNDLE-UNLOCK-GATE',
        q344ActualBinaryBundlePhase,
        q345GradleAbiPackagingBuildTrialPhase,
        q346NativeLibraryLoadSmokePhase,
        q347PaddleLitePredictorInstantiateSmokePhase,
        q348OptimizedModelConversionModelLoaderEvidenceGatePhase,
        q349RealModelLoadSmokeEvidenceBlockedPhase,
        q350OptimizedModelArtifactConversionEvidenceIntakePhase,
        q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase,
        'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE',
      ],
      contains(manifest['activeProductDevelopmentLatestPhase']),
    );
    expect(manifest['actualBinaryBundleJniLibsPaddlePredictorPendingEvidenceBlockedLatestPhase'], GaussActualBinaryBundleJniLibsPaddlePredictorPendingEvidenceBlockedQ342Policy.phase);

    final q342 = manifest['v172Q342ActualBinaryBundleJniLibsPaddlePredictorPendingEvidenceBlocked'] as Map<String, dynamic>;
    expect(q342['phase'], GaussActualBinaryBundleJniLibsPaddlePredictorPendingEvidenceBlockedQ342Policy.phase);
    expect(q342['sourcePhase'], GaussActualBinaryBundleJniLibsPaddlePredictorPendingEvidenceBlockedQ342Policy.sourcePhase);
    expect(q342['method'], GaussActualBinaryBundleJniLibsPaddlePredictorPendingEvidenceBlockedQ342Policy.methodName);
    expect(q342['status'], GaussActualBinaryBundleJniLibsPaddlePredictorPendingEvidenceBlockedQ342Policy.status);
    expect(q342['bundlePermissionStatus'], GaussActualBinaryBundleJniLibsPaddlePredictorPendingEvidenceBlockedQ342Policy.bundlePermissionStatus);
    expect(q342['uiProtectionStatus'], GaussActualBinaryBundleJniLibsPaddlePredictorPendingEvidenceBlockedQ342Policy.uiProtectionStatus);
    expect(q342['requiredNativePackageFiles'], contains('PaddlePredictor.jar'));
    expect(q342['requiredNativePackageFiles'], contains('arm64-v8a/libpaddle_lite_jni.so'));
    expect(q342['actualBinaryBundleExecuted'], isFalse);
    expect(q342['nativeLibraryBundled'], isFalse);
    expect(q342['jarBundled'], isFalse);
    expect(q342['jniLibsDirectoryCreated'], isFalse);
    expect(q342['androidAppLibsDirectoryCreated'], isFalse);
    expect(q342['gradleChanged'], isFalse);
    expect(q342['pubspecChanged'], isFalse);
    expect(q342['androidManifestChanged'], isFalse);
    expect(q342['workspaceChanged'], isFalse);
    expect(q342['keyboardChanged'], isFalse);
    expect(q342['mathLiveProductionBridgeChanged'], isFalse);
    expect(q342['graphChanged'], isFalse);
    expect(q342['solutionChanged'], isFalse);
    expect(q342['historyChanged'], isFalse);
    expect(q342['ocrPassClaimed'], isFalse);
  });

  test('q342 dart contract keeps actual binary bundle blocked', () {
    final result = GaussActualBinaryBundleJniLibsPaddlePredictorPendingEvidenceBlockedQ342.evaluate();
    expect(result.phase, GaussActualBinaryBundleJniLibsPaddlePredictorPendingEvidenceBlockedQ342Policy.phase);
    expect(result.methodName, GaussActualBinaryBundleJniLibsPaddlePredictorPendingEvidenceBlockedQ342Policy.methodName);
    expect(result.status, GaussActualBinaryBundleJniLibsPaddlePredictorPendingEvidenceBlockedQ342Policy.status);
    expect(result.requiredNativePackageFiles, contains('PaddlePredictor.jar'));
    expect(result.plannedBundleTargets, contains('android/app/libs/PaddlePredictor.jar'));
    expect(result.q328NativePackageHashEvidenceJsonAccepted, isFalse);
    expect(result.explicitUserBinaryBundleApprovalProvided, isFalse);
    expect(result.q341OrNewerUserFlutterLogClean, isFalse);
    expect(result.actualBinaryBundleAttempted, isFalse);
    expect(result.actualBinaryBundleExecuted, isFalse);
    expect(result.nativeLibraryBundled, isFalse);
    expect(result.jarBundled, isFalse);
    expect(result.systemLoadLibraryAdded, isFalse);
    expect(result.paddleLiteInstantiated, isFalse);
    expect(result.realImageToLatexInferenceExecuted, isFalse);
    expect(result.ocrPassClaimed, isFalse);
  });

  test('q342 project contains no app-bundled native binaries and no UI red-line modifications are declared', () {
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
    expect(mainActivity, contains('private val q342Phase = "${GaussActualBinaryBundleJniLibsPaddlePredictorPendingEvidenceBlockedQ342Policy.phase}"'));
    expect(mainActivity, contains('"${GaussActualBinaryBundleJniLibsPaddlePredictorPendingEvidenceBlockedQ342Policy.methodName}" -> result.success(q342ActualBinaryBundlePendingEvidenceBlocked(call.method))'));
    expect(mainActivity, contains('"actualBinaryBundleExecuted" to false'));
    expect(mainActivity, contains('"workspaceChanged" to false'));
    expect(mainActivity, contains('"keyboardChanged" to false'));
    expect(mainActivity, contains('"mathLiveProductionBridgeChanged" to false'));
    expectNoRuntimeExecutionBeyondQ346NativeLoadSmoke(mainActivity);
    expect(mainActivity.contains('PaddlePredictor('), isFalse);
  });
}
