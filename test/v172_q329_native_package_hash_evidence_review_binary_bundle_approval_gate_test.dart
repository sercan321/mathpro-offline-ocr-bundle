import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'v172_q344_binary_bundle_successor_test_helper.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_native_package_hash_evidence_review_binary_bundle_approval_gate_q329.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_native_package_hash_evidence_review_binary_bundle_approval_gate_q329_policy.dart';

const String q330SuccessorPhase = 'V172-Q330-BINARY-BUNDLE-TRIAL-JNILIBS-PADDLEPREDICTOR-DEFAULT-OFF';
const String q331SuccessorPhase = 'V172-Q331-NATIVE-PACKAGE-HASH-EVIDENCE-ACCEPTANCE-BUNDLE-PERMISSION-GATE';
const String q332SuccessorPhase = 'V172-Q332-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-BLOCKED-GATE';
const String q333SuccessorPhase = 'V172-Q333-NATIVE-PACKAGE-HASH-EVIDENCE-INTAKE-REAL-BUNDLE-PERMISSION-REVIEW';
const String q334SuccessorPhase = 'V172-Q334-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-PENDING-EVIDENCE-BLOCKED-GATE';

const String q335SuccessorPhase = 'V172-Q335-NATIVE-PACKAGE-HASH-EVIDENCE-COLLECTION-USER-SIDE-NATIVE-PACKAGE-INTAKE';
const String q336SuccessorPhase = 'V172-Q336-NATIVE-PACKAGE-HASH-EVIDENCE-CAPTURE-Q328-JSON-INTAKE';
const String q337SuccessorPhase = 'V172-Q337-NATIVE-PACKAGE-HASH-EVIDENCE-ACCEPTANCE-EXPLICIT-BUNDLE-APPROVAL-GATE';
const String q338SuccessorPhase = 'V172-Q338-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-NO-EVIDENCE-BLOCKED-GATE';
const String q339SuccessorPhase = 'V172-Q339-NATIVE-PACKAGE-HASH-EVIDENCE-CAPTURE-ACTUAL-BUNDLE-PERMISSION-FINAL-CHECK';
const String q340SuccessorPhase = 'V172-Q340-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-EVIDENCE-BLOCKED-GATE';
const String q341SuccessorPhase = 'V172-Q341-NATIVE-PACKAGE-HASH-EVIDENCE-CAPTURE-BUNDLE-EVIDENCE-ACCEPTANCE';
const String q342SuccessorPhase = 'V172-Q342-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-PENDING-EVIDENCE-BLOCKED';

void main() {
  test('q329 manifest records native package hash review and blocks binary bundle', () {
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
    expect(<String>[GaussNativePackageHashEvidenceReviewBinaryBundleApprovalGateQ329Policy.phase, q330SuccessorPhase, q331SuccessorPhase, q332SuccessorPhase, q333SuccessorPhase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, 'V172-Q343-NATIVE-PACKAGE-HASH-EVIDENCE-FINAL-ACCEPTANCE-REAL-BUNDLE-UNLOCK-GATE', q344ActualBinaryBundlePhase, q345GradleAbiPackagingBuildTrialPhase, q346NativeLibraryLoadSmokePhase, q347PaddleLitePredictorInstantiateSmokePhase, q348OptimizedModelConversionModelLoaderEvidenceGatePhase, q349RealModelLoadSmokeEvidenceBlockedPhase, q350OptimizedModelArtifactConversionEvidenceIntakePhase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase, q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'], contains(manifest['cameraOcrLatestPhase']));
    expect(<String>[GaussNativePackageHashEvidenceReviewBinaryBundleApprovalGateQ329Policy.phase, q330SuccessorPhase, q331SuccessorPhase, q332SuccessorPhase, q333SuccessorPhase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, 'V172-Q343-NATIVE-PACKAGE-HASH-EVIDENCE-FINAL-ACCEPTANCE-REAL-BUNDLE-UNLOCK-GATE', q344ActualBinaryBundlePhase, q345GradleAbiPackagingBuildTrialPhase, q346NativeLibraryLoadSmokePhase, q347PaddleLitePredictorInstantiateSmokePhase, q348OptimizedModelConversionModelLoaderEvidenceGatePhase, q349RealModelLoadSmokeEvidenceBlockedPhase, q350OptimizedModelArtifactConversionEvidenceIntakePhase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase, q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'],
        contains(manifest['activeProductDevelopmentLatestPhase']));
    expect(manifest['nativePackageHashEvidenceReviewBinaryBundleApprovalGateLatestPhase'],
        GaussNativePackageHashEvidenceReviewBinaryBundleApprovalGateQ329Policy.phase);
    if (manifest['cameraOcrLatestPhase'] == q330SuccessorPhase) {
      expect(manifest['v172Q330BinaryBundleTrialJniLibsPaddlePredictorDefaultOff'], isA<Map<String, dynamic>>());
    }
    expect(manifest['nativeLibraryPackageFileHashIntakeNoBundleEvidenceGateLatestPhase'],
        GaussNativePackageHashEvidenceReviewBinaryBundleApprovalGateQ329Policy.sourcePhase);

    final q329 = manifest['v172Q329NativePackageHashEvidenceReviewBinaryBundleApprovalGate']
        as Map<String, dynamic>;
    expect(q329['phase'], GaussNativePackageHashEvidenceReviewBinaryBundleApprovalGateQ329Policy.phase);
    expect(q329['sourcePhase'], GaussNativePackageHashEvidenceReviewBinaryBundleApprovalGateQ329Policy.sourcePhase);
    expect(q329['nativeChannelName'], GaussNativePackageHashEvidenceReviewBinaryBundleApprovalGateQ329Policy.nativeChannelName);
    expect(q329['nativePackageHashEvidenceReviewMethod'],
        GaussNativePackageHashEvidenceReviewBinaryBundleApprovalGateQ329Policy.nativePackageHashEvidenceReviewMethod);
    expect(q329['nativePackageHashEvidenceReviewStatus'],
        GaussNativePackageHashEvidenceReviewBinaryBundleApprovalGateQ329Policy.nativePackageHashEvidenceReviewStatus);
    expect(q329['externalNativePackageEvidencePolicy'], '../MathProOcrNativePackages/Paddle_Lite_Android');
    expect(q329['nativePackageEvidenceFileName'], 'q328_native_library_package_hash_evidence.json');
    expect(q329['requiredNativePackageFiles'], contains('PaddlePredictor.jar'));
    expect(q329['requiredNativePackageFiles'], contains('arm64-v8a/libpaddle_lite_jni.so'));
    expect(q329['perFileSha256EvidenceProvidedToAssistant'], isFalse);
    expect(q329['nativePackageHashEvidenceAccepted'], isFalse);
    expect(q329['binaryBundleApproved'], isFalse);
    expect(q329['nativeLibraryBundled'], isFalse);
    expect(q329['jarBundled'], isFalse);
    expect(q329['jniLibsDirectoryCreated'], isFalse);
    expect(q329['runtimeDependencyAdded'], isFalse);
    expect(q329['realImageToLatexInferenceExecuted'], isFalse);
    expect(q329['ocrPassClaimed'], isFalse);
  });

  test('q329 policy/result keeps binary bundle blocked until evidence and approval', () {
    final result = GaussNativePackageHashEvidenceReviewBinaryBundleApprovalGateQ329.evaluate();
    expect(result.phase, GaussNativePackageHashEvidenceReviewBinaryBundleApprovalGateQ329Policy.phase);
    expect(result.sourcePhase, GaussNativePackageHashEvidenceReviewBinaryBundleApprovalGateQ329Policy.sourcePhase);
    expect(result.nativePackageHashEvidenceReviewMethod, 'nativePackageHashEvidenceReview');
    expect(result.nativePackageHashEvidenceReviewStatus, contains('BLOCKED_PENDING_USER_NATIVE_PACKAGE_HASH_EVIDENCE'));
    expect(result.requiredNativePackageFiles, contains('PaddlePredictor.jar'));
    expect(result.evidenceReviewRequirements, contains('verify-required-jar-and-arm64-so-sha256-values-before-bundling'));
    expect(result.q329HardBlocks, contains('no-so-aar-jar-bundled-in-q329'));
    expect(result.q330EntryCriteria, contains('explicit-user-approval-for-binary-bundle-trial'));
    expect(result.perFileSha256EvidenceProvidedToAssistant, isFalse);
    expect(result.nativePackageHashEvidenceAccepted, isFalse);
    expect(result.binaryBundleApproved, isFalse);
    expect(result.pubspecChanged, isFalse);
    expect(result.gradleChanged, isFalse);
    expect(result.nativeLibraryBundled, isFalse);
    expect(result.runtimeDependencyAdded, isFalse);
    expect(result.realImageToLatexInferenceExecuted, isFalse);
    expect(result.ocrPassClaimed, isFalse);
  });

  test('q329 MainActivity has envelope method but no native binary/runtime mutation', () {
    final mainActivity = File('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt').readAsStringSync();
    expect(mainActivity, contains('private val q329Phase = "V172-Q329-NATIVE-PACKAGE-HASH-EVIDENCE-REVIEW-BINARY-BUNDLE-APPROVAL-GATE"'));
    expect(mainActivity, contains('private val q329NativePackageHashEvidenceReviewFeatureEnabled = false'));
    expect(mainActivity, contains('"nativePackageHashEvidenceReview" -> result.success(q329NativePackageHashEvidenceReview(call.method))'));
    expect(mainActivity, contains('private fun q329NativePackageHashEvidenceReview(method: String): Map<String, Any>'));
    expect(mainActivity, contains('"binaryBundleApproved" to false'));
    expect(mainActivity, contains('"perFileSha256EvidenceProvidedToAssistant" to false'));
    expect(mainActivity, contains('"nativePackageHashEvidenceAccepted" to false'));
    expect(mainActivity, contains('"nativePackageHashEvidenceReviewBlockedReason" to "q329-requires-user-provided-native-package-hash-evidence-before-binary-bundle-approval"'));

    for (final forbidden in <String>['PaddlePredictor(', 'MobileConfig(', 'PaddleOCR(', 'OnnxRuntime(', 'loadModel(', 'runInference(']) {
      expect(mainActivity.contains(forbidden), isFalse, reason: 'Q329 must not introduce runtime marker: $forbidden');
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
