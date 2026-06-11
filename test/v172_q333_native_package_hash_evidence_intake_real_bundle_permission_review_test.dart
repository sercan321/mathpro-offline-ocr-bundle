import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'v172_q344_binary_bundle_successor_test_helper.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_native_package_hash_evidence_intake_real_bundle_permission_review_q333.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_native_package_hash_evidence_intake_real_bundle_permission_review_q333_policy.dart';

const String q334SuccessorPhase = 'V172-Q334-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-PENDING-EVIDENCE-BLOCKED-GATE';

const String q332SuccessorPhase = 'V172-Q332-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-BLOCKED-GATE';
const String q333SuccessorPhase = 'V172-Q333-NATIVE-PACKAGE-HASH-EVIDENCE-INTAKE-REAL-BUNDLE-PERMISSION-REVIEW';
const String q335SuccessorPhase = 'V172-Q335-NATIVE-PACKAGE-HASH-EVIDENCE-COLLECTION-USER-SIDE-NATIVE-PACKAGE-INTAKE';
const String q336SuccessorPhase = 'V172-Q336-NATIVE-PACKAGE-HASH-EVIDENCE-CAPTURE-Q328-JSON-INTAKE';
const String q337SuccessorPhase = 'V172-Q337-NATIVE-PACKAGE-HASH-EVIDENCE-ACCEPTANCE-EXPLICIT-BUNDLE-APPROVAL-GATE';
const String q338SuccessorPhase = 'V172-Q338-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-NO-EVIDENCE-BLOCKED-GATE';
const String q339SuccessorPhase = 'V172-Q339-NATIVE-PACKAGE-HASH-EVIDENCE-CAPTURE-ACTUAL-BUNDLE-PERMISSION-FINAL-CHECK';
const String q340SuccessorPhase = 'V172-Q340-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-EVIDENCE-BLOCKED-GATE';
const String q341SuccessorPhase = 'V172-Q341-NATIVE-PACKAGE-HASH-EVIDENCE-CAPTURE-BUNDLE-EVIDENCE-ACCEPTANCE';
const String q342SuccessorPhase = 'V172-Q342-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-PENDING-EVIDENCE-BLOCKED';

void main() {
  test('q333 manifest records native package hash evidence intake review and keeps binary bundle blocked', () {
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
    expect(<String>[GaussNativePackageHashEvidenceIntakeRealBundlePermissionReviewQ333Policy.phase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, 'V172-Q343-NATIVE-PACKAGE-HASH-EVIDENCE-FINAL-ACCEPTANCE-REAL-BUNDLE-UNLOCK-GATE', q344ActualBinaryBundlePhase, q345GradleAbiPackagingBuildTrialPhase, q346NativeLibraryLoadSmokePhase, q347PaddleLitePredictorInstantiateSmokePhase, q348OptimizedModelConversionModelLoaderEvidenceGatePhase, q349RealModelLoadSmokeEvidenceBlockedPhase, q350OptimizedModelArtifactConversionEvidenceIntakePhase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase, q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'], contains(manifest['cameraOcrLatestPhase']));
    expect(<String>[GaussNativePackageHashEvidenceIntakeRealBundlePermissionReviewQ333Policy.phase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, 'V172-Q343-NATIVE-PACKAGE-HASH-EVIDENCE-FINAL-ACCEPTANCE-REAL-BUNDLE-UNLOCK-GATE', q344ActualBinaryBundlePhase, q345GradleAbiPackagingBuildTrialPhase, q346NativeLibraryLoadSmokePhase, q347PaddleLitePredictorInstantiateSmokePhase, q348OptimizedModelConversionModelLoaderEvidenceGatePhase, q349RealModelLoadSmokeEvidenceBlockedPhase, q350OptimizedModelArtifactConversionEvidenceIntakePhase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase, q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'],
        contains(manifest['activeProductDevelopmentLatestPhase']));
    expect(manifest['nativePackageHashEvidenceIntakeRealBundlePermissionReviewLatestPhase'],
        GaussNativePackageHashEvidenceIntakeRealBundlePermissionReviewQ333Policy.phase);
    expect(manifest['actualBinaryBundleJniLibsPaddlePredictorBlockedGateLatestPhase'],
        GaussNativePackageHashEvidenceIntakeRealBundlePermissionReviewQ333Policy.sourcePhase);

    final q333 = manifest['v172Q333NativePackageHashEvidenceIntakeRealBundlePermissionReview']
        as Map<String, dynamic>;
    expect(q333['phase'], GaussNativePackageHashEvidenceIntakeRealBundlePermissionReviewQ333Policy.phase);
    expect(q333['sourcePhase'], GaussNativePackageHashEvidenceIntakeRealBundlePermissionReviewQ333Policy.sourcePhase);
    expect(q333['nativePackageHashEvidenceIntakeReviewMethod'], 'nativePackageHashEvidenceIntakeReview');
    expect(q333['nativePackageHashEvidenceIntakeReviewStatus'], contains('BLOCKED_PENDING_Q328_EVIDENCE_JSON'));
    expect(q333['requiredNativePackageFiles'], contains('PaddlePredictor.jar'));
    expect(q333['plannedBundleTargets'], contains('android/app/libs/PaddlePredictor.jar'));
    expect(q333['plannedBundleTargets'], contains('android/app/src/main/jniLibs/arm64-v8a/libpaddle_lite_jni.so'));
    expect(q333['perFileSha256EvidenceProvidedToAssistant'], isFalse);
    expect(q333['nativePackageHashEvidenceReviewed'], isFalse);
    expect(q333['nativePackageHashEvidenceAccepted'], isFalse);
    expect(q333['explicitUserBinaryBundleApprovalProvided'], isFalse);
    expect(q333['binaryBundlePermissionGranted'], isFalse);
    expect(q333['actualBinaryBundleExecuted'], isFalse);
    expect(q333['nativeLibraryBundled'], isFalse);
    expect(q333['jarBundled'], isFalse);
    expect(q333['jniLibsDirectoryCreated'], isFalse);
    expect(q333['androidAppLibsDirectoryCreated'], isFalse);
    expect(q333['systemLoadLibraryAdded'], isFalse);
    expect(q333['paddleLiteInstantiated'], isFalse);
    expect(q333['runtimeDependencyAdded'], isFalse);
    expect(q333['realImageToLatexInferenceExecuted'], isFalse);
    expect(q333['ocrPassClaimed'], isFalse);
  });

  test('q333 policy/result blocks bundle until evidence review and explicit approval', () {
    final result = GaussNativePackageHashEvidenceIntakeRealBundlePermissionReviewQ333.evaluate();
    expect(result.phase, GaussNativePackageHashEvidenceIntakeRealBundlePermissionReviewQ333Policy.phase);
    expect(result.sourcePhase, GaussNativePackageHashEvidenceIntakeRealBundlePermissionReviewQ333Policy.sourcePhase);
    expect(result.nativePackageHashEvidenceIntakeReviewMethod, 'nativePackageHashEvidenceIntakeReview');
    expect(result.nativePackageHashEvidenceIntakeReviewStatus, contains('BLOCKED_PENDING_Q328_EVIDENCE_JSON'));
    expect(result.requiredNativePackageFiles, contains('PaddlePredictor.jar'));
    expect(result.plannedBundleTargets, contains('android/app/libs/PaddlePredictor.jar'));
    expect(result.evidenceReviewRequirements, contains('q328-native-package-hash-evidence-json-provided-from-outside-project-root'));
    expect(result.q333HardBlocks, contains('no-so-aar-jar-bundled-in-q333'));
    expect(result.q334EntryCriteria, contains('explicit-user-approval-to-bundle-required-native-files'));
    expect(result.perFileSha256EvidenceProvidedToAssistant, isFalse);
    expect(result.nativePackageHashEvidenceReviewed, isFalse);
    expect(result.nativePackageHashEvidenceAccepted, isFalse);
    expect(result.explicitUserBinaryBundleApprovalProvided, isFalse);
    expect(result.actualBinaryBundleExecuted, isFalse);
    expect(result.pubspecChanged, isFalse);
    expect(result.gradleChanged, isFalse);
    expect(result.nativeLibraryBundled, isFalse);
    expect(result.systemLoadLibraryAdded, isFalse);
    expect(result.paddleLiteInstantiated, isFalse);
    expect(result.runtimeDependencyAdded, isFalse);
    expect(result.realImageToLatexInferenceExecuted, isFalse);
    expect(result.ocrPassClaimed, isFalse);
  });

  test('q333 MainActivity has envelope method but no binary/runtime mutation', () {
    final mainActivity = File('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt').readAsStringSync();
    expect(mainActivity, contains('private val q333Phase = "V172-Q333-NATIVE-PACKAGE-HASH-EVIDENCE-INTAKE-REAL-BUNDLE-PERMISSION-REVIEW"'));
    expect(mainActivity, contains('private val q333NativePackageHashEvidenceIntakeReviewFeatureEnabled = false'));
    expect(mainActivity, contains('"nativePackageHashEvidenceIntakeReview" -> result.success(q333NativePackageHashEvidenceIntakeReview(call.method))'));
    expect(mainActivity, contains('private fun q333NativePackageHashEvidenceIntakeReview(method: String): Map<String, Any>'));
    expect(mainActivity, contains('"nativePackageHashEvidenceReviewed" to false'));
    expect(mainActivity, contains('"binaryBundlePermissionGranted" to false'));
    expect(mainActivity, contains('"nativeLibraryBundled" to false'));
    expect(mainActivity, contains('"jarBundled" to false'));
    expect(mainActivity, contains('"systemLoadLibraryAdded" to false'));

    for (final forbidden in <String>['PaddlePredictor(', 'MobileConfig(', 'PaddleOCR(', 'OnnxRuntime(', 'loadModel(', 'runInference(']) {
      expect(mainActivity.contains(forbidden), isFalse, reason: 'Q333 must not introduce runtime marker: $forbidden');
    }

    final pubspec = File('pubspec.yaml').readAsStringSync().toLowerCase();
    expect(pubspec, isNot(contains('paddleocr')));
    expect(pubspec, isNot(contains('paddle_lite')));
    expect(pubspec, isNot(contains('onnxruntime')));
    expect(pubspec, isNot(contains('tflite_flutter')));

    final androidRoot = Directory('android/app');
    final forbiddenBinaryArtifacts = androidRoot
        .listSync(recursive: true)
        .whereType<File>()
        .where((file) => file.path.endsWith('.so') || file.path.endsWith('.aar') || file.path.endsWith('.jar'))
        .toList();
    expect(q344UnexpectedNativeBinaryPaths(forbiddenBinaryArtifacts.map((file) => file.path)), isEmpty);
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
  });
}
