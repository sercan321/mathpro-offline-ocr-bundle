import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'v172_q344_binary_bundle_successor_test_helper.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_native_package_hash_evidence_capture_q328_json_intake_q336.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_native_package_hash_evidence_capture_q328_json_intake_q336_policy.dart';

const String q337SuccessorPhase = 'V172-Q337-NATIVE-PACKAGE-HASH-EVIDENCE-ACCEPTANCE-EXPLICIT-BUNDLE-APPROVAL-GATE';
const String q338SuccessorPhase = 'V172-Q338-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-NO-EVIDENCE-BLOCKED-GATE';
const String q339SuccessorPhase = 'V172-Q339-NATIVE-PACKAGE-HASH-EVIDENCE-CAPTURE-ACTUAL-BUNDLE-PERMISSION-FINAL-CHECK';
const String q340SuccessorPhase = 'V172-Q340-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-EVIDENCE-BLOCKED-GATE';
const String q341SuccessorPhase = 'V172-Q341-NATIVE-PACKAGE-HASH-EVIDENCE-CAPTURE-BUNDLE-EVIDENCE-ACCEPTANCE';
const String q342SuccessorPhase = 'V172-Q342-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-PENDING-EVIDENCE-BLOCKED';

void main() {
  test('q336 manifest and Dart policy record q328 native package hash evidence intake without bundle', () {
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
    expect(<String>[GaussNativePackageHashEvidenceCaptureQ328JsonIntakeQ336Policy.phase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, 'V172-Q343-NATIVE-PACKAGE-HASH-EVIDENCE-FINAL-ACCEPTANCE-REAL-BUNDLE-UNLOCK-GATE', q344ActualBinaryBundlePhase, q345GradleAbiPackagingBuildTrialPhase, q346NativeLibraryLoadSmokePhase, q347PaddleLitePredictorInstantiateSmokePhase, q348OptimizedModelConversionModelLoaderEvidenceGatePhase, q349RealModelLoadSmokeEvidenceBlockedPhase, q350OptimizedModelArtifactConversionEvidenceIntakePhase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase, q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'], contains(manifest['cameraOcrLatestPhase']));
    expect(<String>[GaussNativePackageHashEvidenceCaptureQ328JsonIntakeQ336Policy.phase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, 'V172-Q343-NATIVE-PACKAGE-HASH-EVIDENCE-FINAL-ACCEPTANCE-REAL-BUNDLE-UNLOCK-GATE', q344ActualBinaryBundlePhase, q345GradleAbiPackagingBuildTrialPhase, q346NativeLibraryLoadSmokePhase, q347PaddleLitePredictorInstantiateSmokePhase, q348OptimizedModelConversionModelLoaderEvidenceGatePhase, q349RealModelLoadSmokeEvidenceBlockedPhase, q350OptimizedModelArtifactConversionEvidenceIntakePhase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase, q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'], contains(manifest['activeProductDevelopmentLatestPhase']));
    final q336 = manifest['v172Q336NativePackageHashEvidenceCaptureQ328JsonIntake'] as Map<String, dynamic>;
    expect(q336['phase'], GaussNativePackageHashEvidenceCaptureQ328JsonIntakeQ336Policy.phase);
    expect(q336['sourcePhase'], GaussNativePackageHashEvidenceCaptureQ328JsonIntakeQ336Policy.sourcePhase);
    expect(q336['nativePackageHashEvidenceCaptureQ328JsonIntakeMethod'], 'nativePackageHashEvidenceCaptureQ328JsonIntake');
    expect(q336['nativePackageHashEvidenceCaptureQ328JsonIntakeStatus'], contains('BLOCKED_PENDING_USER_SIDE_NATIVE_PACKAGE_FILES'));
    expect(q336['externalNativePackageEvidencePolicy'], '../MathProOcrNativePackages/Paddle_Lite_Android');
    expect(q336['nativePackageEvidenceFileName'], 'q328_native_library_package_hash_evidence.json');
    expect(q336['q336EvidenceIntakeScript'], 'tool/intake_q328_native_package_hash_evidence_v172_q336.mjs');
    expect(q336['requiredNativePackageFiles'], contains('PaddlePredictor.jar'));
    expect(q336['requiredNativePackageFiles'], contains('arm64-v8a/libpaddle_lite_jni.so'));
    expect(q336['q328NativePackageHashEvidenceJsonProvided'], isFalse);
    expect(q336['nativePackageHashEvidenceAccepted'], isFalse);
    expect(q336['nativeLibraryBundled'], isFalse);
    expect(q336['jarBundled'], isFalse);
    expect(q336['jniLibsDirectoryCreated'], isFalse);
    expect(q336['androidAppLibsDirectoryCreated'], isFalse);
    expect(q336['gradleChanged'], isFalse);
    expect(q336['pubspecChanged'], isFalse);
    expect(q336['ocrPassClaimed'], isFalse);

    final result = GaussNativePackageHashEvidenceCaptureQ328JsonIntakeQ336.evaluate();
    expect(result.phase, GaussNativePackageHashEvidenceCaptureQ328JsonIntakeQ336Policy.phase);
    expect(result.methodName, 'nativePackageHashEvidenceCaptureQ328JsonIntake');
    expect(result.status, contains('BLOCKED_PENDING_USER_SIDE_NATIVE_PACKAGE_FILES'));
    expect(result.q328NativePackageHashEvidenceJsonProvided, isFalse);
    expect(result.requiredNativePackageFilesAllPresentInEvidence, isFalse);
    expect(result.nativeLibraryBundled, isFalse);
    expect(result.jarBundled, isFalse);
    expect(result.ocrPassClaimed, isFalse);
  });

  test('q336 bridge and package remain no-binary and no-runtime', () {
    final mainActivity = File('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt').readAsStringSync();
    expect(mainActivity, contains('private val q336Phase = "V172-Q336-NATIVE-PACKAGE-HASH-EVIDENCE-CAPTURE-Q328-JSON-INTAKE"'));
    expect(mainActivity, contains('"nativePackageHashEvidenceCaptureQ328JsonIntake" -> result.success(q336NativePackageHashEvidenceCaptureQ328JsonIntake(call.method))'));
    expect(mainActivity, contains('"q328NativePackageHashEvidenceJsonProvided" to false'));
    expect(mainActivity, contains('"requiredNativePackageFilesAllPresentInEvidence" to false'));
    expect(mainActivity, contains('"actualBinaryBundleExecuted" to false'));
    expect(mainActivity, contains('"nativeLibraryBundled" to false'));
    expect(mainActivity, contains('"jarBundled" to false'));

    for (final forbidden in <String>[
      'PaddlePredictor(',
      'Predictor(',
      'PaddleLite(',
    ]) {
      expect(mainActivity.contains(forbidden), isFalse, reason: 'Q336 must not introduce runtime marker: $forbidden');
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
    expect(File('tool/intake_q328_native_package_hash_evidence_v172_q336.mjs').existsSync(), isTrue);
  });
}
