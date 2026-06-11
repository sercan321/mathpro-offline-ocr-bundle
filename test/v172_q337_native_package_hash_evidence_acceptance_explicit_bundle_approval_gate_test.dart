import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'v172_q344_binary_bundle_successor_test_helper.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_native_package_hash_evidence_acceptance_explicit_bundle_approval_gate_q337.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_native_package_hash_evidence_acceptance_explicit_bundle_approval_gate_q337_policy.dart';

const String q338SuccessorPhase = 'V172-Q338-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-NO-EVIDENCE-BLOCKED-GATE';
const String q339SuccessorPhase = 'V172-Q339-NATIVE-PACKAGE-HASH-EVIDENCE-CAPTURE-ACTUAL-BUNDLE-PERMISSION-FINAL-CHECK';
const String q340SuccessorPhase = 'V172-Q340-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-EVIDENCE-BLOCKED-GATE';
const String q341SuccessorPhase = 'V172-Q341-NATIVE-PACKAGE-HASH-EVIDENCE-CAPTURE-BUNDLE-EVIDENCE-ACCEPTANCE';
const String q342SuccessorPhase = 'V172-Q342-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-PENDING-EVIDENCE-BLOCKED';

void main() {
  test('q337 manifest records explicit bundle approval gate without native binary bundle', () {
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
    expect(<String>[GaussNativePackageHashEvidenceAcceptanceExplicitBundleApprovalGateQ337Policy.phase, q338SuccessorPhase, q339SuccessorPhase, 'V172-Q343-NATIVE-PACKAGE-HASH-EVIDENCE-FINAL-ACCEPTANCE-REAL-BUNDLE-UNLOCK-GATE', q344ActualBinaryBundlePhase, q345GradleAbiPackagingBuildTrialPhase, q346NativeLibraryLoadSmokePhase, q347PaddleLitePredictorInstantiateSmokePhase, q348OptimizedModelConversionModelLoaderEvidenceGatePhase, q349RealModelLoadSmokeEvidenceBlockedPhase, q350OptimizedModelArtifactConversionEvidenceIntakePhase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase, q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'], contains(manifest['cameraOcrLatestPhase']));
    expect(<String>[GaussNativePackageHashEvidenceAcceptanceExplicitBundleApprovalGateQ337Policy.phase, q338SuccessorPhase, q339SuccessorPhase, 'V172-Q343-NATIVE-PACKAGE-HASH-EVIDENCE-FINAL-ACCEPTANCE-REAL-BUNDLE-UNLOCK-GATE', q344ActualBinaryBundlePhase, q345GradleAbiPackagingBuildTrialPhase, q346NativeLibraryLoadSmokePhase, q347PaddleLitePredictorInstantiateSmokePhase, q348OptimizedModelConversionModelLoaderEvidenceGatePhase, q349RealModelLoadSmokeEvidenceBlockedPhase, q350OptimizedModelArtifactConversionEvidenceIntakePhase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase, q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'], contains(manifest['activeProductDevelopmentLatestPhase']));
    expect(manifest['nativePackageHashEvidenceAcceptanceExplicitBundleApprovalGateLatestPhase'], GaussNativePackageHashEvidenceAcceptanceExplicitBundleApprovalGateQ337Policy.phase);

    final q337 = manifest['v172Q337NativePackageHashEvidenceAcceptanceExplicitBundleApprovalGate'] as Map<String, dynamic>;
    expect(q337['phase'], GaussNativePackageHashEvidenceAcceptanceExplicitBundleApprovalGateQ337Policy.phase);
    expect(q337['sourcePhase'], GaussNativePackageHashEvidenceAcceptanceExplicitBundleApprovalGateQ337Policy.sourcePhase);
    expect(q337['nativePackageHashEvidenceAcceptanceExplicitBundleApprovalMethod'], 'nativePackageHashEvidenceAcceptanceExplicitBundleApproval');
    expect(q337['nativePackageHashEvidenceAcceptanceExplicitBundleApprovalStatus'], contains('BLOCKED_PENDING_Q328_JSON_AND_USER_APPROVAL'));
    expect(q337['bundlePermissionStatus'], contains('EXPLICITLY_APPROVES_BINARY_BUNDLE'));
    expect(q337['requiredNativePackageFiles'], contains('PaddlePredictor.jar'));
    expect(q337['requiredNativePackageFiles'], contains('arm64-v8a/libpaddle_lite_jni.so'));
    expect(q337['q328NativePackageHashEvidenceJsonProvided'], isFalse);
    expect(q337['nativePackageHashEvidenceAccepted'], isFalse);
    expect(q337['explicitUserBinaryBundleApprovalProvided'], isFalse);
    expect(q337['binaryBundlePermissionGranted'], isFalse);
    expect(q337['nativeLibraryBundled'], isFalse);
    expect(q337['jarBundled'], isFalse);
    expect(q337['jniLibsDirectoryCreated'], isFalse);
    expect(q337['androidAppLibsDirectoryCreated'], isFalse);
    expect(q337['gradleChanged'], isFalse);
    expect(q337['pubspecChanged'], isFalse);
    expect(q337['ocrPassClaimed'], isFalse);

    final result = GaussNativePackageHashEvidenceAcceptanceExplicitBundleApprovalGateQ337.evaluate();
    expect(result.phase, GaussNativePackageHashEvidenceAcceptanceExplicitBundleApprovalGateQ337Policy.phase);
    expect(result.methodName, 'nativePackageHashEvidenceAcceptanceExplicitBundleApproval');
    expect(result.status, contains('BLOCKED_PENDING_Q328_JSON_AND_USER_APPROVAL'));
    expect(result.q328NativePackageHashEvidenceJsonProvided, isFalse);
    expect(result.perFileSha256EvidenceAccepted, isFalse);
    expect(result.explicitUserBinaryBundleApprovalProvided, isFalse);
    expect(result.nativeLibraryBundled, isFalse);
    expect(result.jarBundled, isFalse);
    expect(result.ocrPassClaimed, isFalse);
  });

  test('q337 bridge and package remain no-binary and no-runtime', () {
    final mainActivity = File('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt').readAsStringSync();
    expect(mainActivity, contains('private val q337Phase = "V172-Q337-NATIVE-PACKAGE-HASH-EVIDENCE-ACCEPTANCE-EXPLICIT-BUNDLE-APPROVAL-GATE"'));
    expect(mainActivity, contains('"nativePackageHashEvidenceAcceptanceExplicitBundleApproval" -> result.success(q337NativePackageHashEvidenceAcceptanceExplicitBundleApproval(call.method))'));
    expect(mainActivity, contains('"q328NativePackageHashEvidenceJsonProvided" to false'));
    expect(mainActivity, contains('"explicitUserBinaryBundleApprovalProvided" to false'));
    expect(mainActivity, contains('"actualBinaryBundleExecuted" to false'));
    expect(mainActivity, contains('"nativeLibraryBundled" to false'));
    expect(mainActivity, contains('"jarBundled" to false'));

    for (final forbidden in <String>[
      'PaddlePredictor(',
      'Predictor(',
      'PaddleLite(',
    ]) {
      expect(mainActivity.contains(forbidden), isFalse, reason: 'Q337 must not introduce runtime marker: $forbidden');
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
  });
}
