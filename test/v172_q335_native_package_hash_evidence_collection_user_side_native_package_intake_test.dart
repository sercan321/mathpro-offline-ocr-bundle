import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'v172_q344_binary_bundle_successor_test_helper.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_native_package_hash_evidence_collection_user_side_native_package_intake_q335.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_native_package_hash_evidence_collection_user_side_native_package_intake_q335_policy.dart';

const String q336SuccessorPhase = 'V172-Q336-NATIVE-PACKAGE-HASH-EVIDENCE-CAPTURE-Q328-JSON-INTAKE';
const String q337SuccessorPhase = 'V172-Q337-NATIVE-PACKAGE-HASH-EVIDENCE-ACCEPTANCE-EXPLICIT-BUNDLE-APPROVAL-GATE';
const String q338SuccessorPhase = 'V172-Q338-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-NO-EVIDENCE-BLOCKED-GATE';
const String q339SuccessorPhase = 'V172-Q339-NATIVE-PACKAGE-HASH-EVIDENCE-CAPTURE-ACTUAL-BUNDLE-PERMISSION-FINAL-CHECK';
const String q340SuccessorPhase = 'V172-Q340-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-EVIDENCE-BLOCKED-GATE';
const String q341SuccessorPhase = 'V172-Q341-NATIVE-PACKAGE-HASH-EVIDENCE-CAPTURE-BUNDLE-EVIDENCE-ACCEPTANCE';
const String q342SuccessorPhase = 'V172-Q342-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-PENDING-EVIDENCE-BLOCKED';

void main() {
  test('q335 manifest and Dart policy record native package evidence collection without bundle', () {
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
    expect(<String>[GaussNativePackageHashEvidenceCollectionUserSideNativePackageIntakeQ335Policy.phase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, 'V172-Q343-NATIVE-PACKAGE-HASH-EVIDENCE-FINAL-ACCEPTANCE-REAL-BUNDLE-UNLOCK-GATE', q344ActualBinaryBundlePhase, q345GradleAbiPackagingBuildTrialPhase, q346NativeLibraryLoadSmokePhase, q347PaddleLitePredictorInstantiateSmokePhase, q348OptimizedModelConversionModelLoaderEvidenceGatePhase, q349RealModelLoadSmokeEvidenceBlockedPhase, q350OptimizedModelArtifactConversionEvidenceIntakePhase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase, q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'], contains(manifest['cameraOcrLatestPhase']));
    expect(<String>[GaussNativePackageHashEvidenceCollectionUserSideNativePackageIntakeQ335Policy.phase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, 'V172-Q343-NATIVE-PACKAGE-HASH-EVIDENCE-FINAL-ACCEPTANCE-REAL-BUNDLE-UNLOCK-GATE', q344ActualBinaryBundlePhase, q345GradleAbiPackagingBuildTrialPhase, q346NativeLibraryLoadSmokePhase, q347PaddleLitePredictorInstantiateSmokePhase, q348OptimizedModelConversionModelLoaderEvidenceGatePhase, q349RealModelLoadSmokeEvidenceBlockedPhase, q350OptimizedModelArtifactConversionEvidenceIntakePhase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase, q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'], contains(manifest['activeProductDevelopmentLatestPhase']));
    final q335 = manifest['v172Q335NativePackageHashEvidenceCollectionUserSideNativePackageIntake'] as Map<String, dynamic>;
    expect(q335['phase'], GaussNativePackageHashEvidenceCollectionUserSideNativePackageIntakeQ335Policy.phase);
    expect(q335['sourcePhase'], GaussNativePackageHashEvidenceCollectionUserSideNativePackageIntakeQ335Policy.sourcePhase);
    expect(q335['nativePackageHashEvidenceCollectionIntakeMethod'], 'nativePackageHashEvidenceCollectionIntake');
    expect(q335['nativePackageHashEvidenceCollectionIntakeStatus'], contains('BLOCKED_PENDING_USER_SIDE_NATIVE_PACKAGE_FILES'));
    expect(q335['externalNativePackageEvidencePolicy'], '../MathProOcrNativePackages/Paddle_Lite_Android');
    expect(q335['requiredNativePackageFiles'], contains('PaddlePredictor.jar'));
    expect(q335['requiredNativePackageFiles'], contains('arm64-v8a/libpaddle_lite_jni.so'));
    expect(q335['nativeLibraryBundled'], isFalse);
    expect(q335['jarBundled'], isFalse);
    expect(q335['jniLibsDirectoryCreated'], isFalse);
    expect(q335['androidAppLibsDirectoryCreated'], isFalse);
    expect(q335['gradleChanged'], isFalse);
    expect(q335['pubspecChanged'], isFalse);
    expect(q335['ocrPassClaimed'], isFalse);

    final result = GaussNativePackageHashEvidenceCollectionUserSideNativePackageIntakeQ335.evaluate();
    expect(result.phase, GaussNativePackageHashEvidenceCollectionUserSideNativePackageIntakeQ335Policy.phase);
    expect(result.methodName, 'nativePackageHashEvidenceCollectionIntake');
    expect(result.status, contains('BLOCKED_PENDING_USER_SIDE_NATIVE_PACKAGE_FILES'));
    expect(result.userSideNativePackageFilesProvided, isFalse);
    expect(result.q328NativePackageHashEvidenceJsonProvided, isFalse);
    expect(result.nativeLibraryBundled, isFalse);
    expect(result.jarBundled, isFalse);
    expect(result.ocrPassClaimed, isFalse);
  });

  test('q335 bridge and package remain no-binary and no-runtime', () {
    final mainActivity = File('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt').readAsStringSync();
    expect(mainActivity, contains('private val q335Phase = "V172-Q335-NATIVE-PACKAGE-HASH-EVIDENCE-COLLECTION-USER-SIDE-NATIVE-PACKAGE-INTAKE"'));
    expect(mainActivity, contains('"nativePackageHashEvidenceCollectionIntake" -> result.success(q335NativePackageHashEvidenceCollectionIntake(call.method))'));
    expect(mainActivity, contains('"userSideNativePackageFilesProvided" to false'));
    expect(mainActivity, contains('"q328NativePackageHashEvidenceJsonProvided" to false'));
    expect(mainActivity, contains('"actualBinaryBundleExecuted" to false'));
    expect(mainActivity, contains('"nativeLibraryBundled" to false'));
    expect(mainActivity, contains('"jarBundled" to false'));

    final forbiddenMarkers = isQ347OrLaterPaddleLiteBridgeActive()
        ? <String>[
            'PaddlePredictor(',
            'Predictor(',
          ]
        : <String>[
            'PaddlePredictor(',
            'Predictor(',
            'PaddleLite',
          ];
    for (final forbidden in forbiddenMarkers) {
      expect(mainActivity.contains(forbidden), isFalse, reason: 'Q335 must not introduce forbidden runtime marker: $forbidden');
    }
    if (isQ347OrLaterPaddleLiteBridgeActive()) {
      expect(mainActivity, contains('private val q347Phase = "V172-Q347-PADDLE-LITE-PREDICTOR-INSTANTIATE-SMOKE"'));
      expect(mainActivity, contains('private val q347FeatureEnabled = false'));
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
    expect(File('tool/prepare_paddle_lite_native_package_intake_v172_q335.mjs').existsSync(), isTrue);
  });
}
