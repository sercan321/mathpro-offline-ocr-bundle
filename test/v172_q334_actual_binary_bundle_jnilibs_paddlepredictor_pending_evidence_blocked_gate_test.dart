import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'v172_q344_binary_bundle_successor_test_helper.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_actual_binary_bundle_jnilibs_paddlepredictor_pending_evidence_blocked_gate_q334.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_actual_binary_bundle_jnilibs_paddlepredictor_pending_evidence_blocked_gate_q334_policy.dart';

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
  test('q334 manifest records actual binary bundle placement gate and keeps bundle blocked', () {
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
    expect(<String>[GaussActualBinaryBundleJniLibsPaddlePredictorPendingEvidenceBlockedGateQ334Policy.phase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, 'V172-Q343-NATIVE-PACKAGE-HASH-EVIDENCE-FINAL-ACCEPTANCE-REAL-BUNDLE-UNLOCK-GATE', q344ActualBinaryBundlePhase, q345GradleAbiPackagingBuildTrialPhase, q346NativeLibraryLoadSmokePhase, q347PaddleLitePredictorInstantiateSmokePhase, q348OptimizedModelConversionModelLoaderEvidenceGatePhase, q349RealModelLoadSmokeEvidenceBlockedPhase, q350OptimizedModelArtifactConversionEvidenceIntakePhase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase, q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'], contains(manifest['cameraOcrLatestPhase']));
    expect(<String>[GaussActualBinaryBundleJniLibsPaddlePredictorPendingEvidenceBlockedGateQ334Policy.phase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, 'V172-Q343-NATIVE-PACKAGE-HASH-EVIDENCE-FINAL-ACCEPTANCE-REAL-BUNDLE-UNLOCK-GATE', q344ActualBinaryBundlePhase, q345GradleAbiPackagingBuildTrialPhase, q346NativeLibraryLoadSmokePhase, q347PaddleLitePredictorInstantiateSmokePhase, q348OptimizedModelConversionModelLoaderEvidenceGatePhase, q349RealModelLoadSmokeEvidenceBlockedPhase, q350OptimizedModelArtifactConversionEvidenceIntakePhase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase, q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'],
        contains(manifest['activeProductDevelopmentLatestPhase']));
    expect(manifest['actualBinaryBundleJniLibsPaddlePredictorPendingEvidenceBlockedGateLatestPhase'],
        GaussActualBinaryBundleJniLibsPaddlePredictorPendingEvidenceBlockedGateQ334Policy.phase);
    expect(manifest['nativePackageHashEvidenceIntakeRealBundlePermissionReviewLatestPhase'],
        GaussActualBinaryBundleJniLibsPaddlePredictorPendingEvidenceBlockedGateQ334Policy.sourcePhase);

    final q334 = manifest['v172Q334ActualBinaryBundleJniLibsPaddlePredictorPendingEvidenceBlockedGate']
        as Map<String, dynamic>;
    expect(q334['phase'], GaussActualBinaryBundleJniLibsPaddlePredictorPendingEvidenceBlockedGateQ334Policy.phase);
    expect(q334['sourcePhase'], GaussActualBinaryBundleJniLibsPaddlePredictorPendingEvidenceBlockedGateQ334Policy.sourcePhase);
    expect(q334['actualBinaryBundlePlacementGateMethod'], 'actualBinaryBundlePlacementGate');
    expect(q334['actualBinaryBundlePlacementGateStatus'], contains('BLOCKED_PENDING_Q328_NATIVE_PACKAGE_HASH_EVIDENCE'));
    expect(q334['requiredNativePackageFiles'], contains('PaddlePredictor.jar'));
    expect(q334['plannedBundleTargets'], contains('android/app/libs/PaddlePredictor.jar'));
    expect(q334['plannedBundleTargets'], contains('android/app/src/main/jniLibs/arm64-v8a/libpaddle_lite_jni.so'));
    expect(q334['perFileSha256EvidenceProvidedToAssistant'], isFalse);
    expect(q334['nativePackageHashEvidenceReviewed'], isFalse);
    expect(q334['nativePackageHashEvidenceAccepted'], isFalse);
    expect(q334['explicitUserBinaryBundleApprovalProvided'], isFalse);
    expect(q334['binaryBundlePermissionGranted'], isFalse);
    expect(q334['actualBinaryBundlePlacementAttempted'], isFalse);
    expect(q334['actualBinaryBundleExecuted'], isFalse);
    expect(q334['nativeLibraryBundled'], isFalse);
    expect(q334['jarBundled'], isFalse);
    expect(q334['jniLibsDirectoryCreated'], isFalse);
    expect(q334['androidAppLibsDirectoryCreated'], isFalse);
    expect(q334['systemLoadLibraryAdded'], isFalse);
    expect(q334['paddleLiteInstantiated'], isFalse);
    expect(q334['runtimeDependencyAdded'], isFalse);
    expect(q334['realImageToLatexInferenceExecuted'], isFalse);
    expect(q334['ocrPassClaimed'], isFalse);
  });

  test('q334 policy/result blocks actual file placement until evidence and approval', () {
    final result = GaussActualBinaryBundleJniLibsPaddlePredictorPendingEvidenceBlockedGateQ334.evaluate();
    expect(result.phase, GaussActualBinaryBundleJniLibsPaddlePredictorPendingEvidenceBlockedGateQ334Policy.phase);
    expect(result.sourcePhase, GaussActualBinaryBundleJniLibsPaddlePredictorPendingEvidenceBlockedGateQ334Policy.sourcePhase);
    expect(result.actualBinaryBundlePlacementGateMethod, 'actualBinaryBundlePlacementGate');
    expect(result.actualBinaryBundlePlacementGateStatus, contains('BLOCKED_PENDING_Q328_NATIVE_PACKAGE_HASH_EVIDENCE'));
    expect(result.requiredNativePackageFiles, contains('PaddlePredictor.jar'));
    expect(result.plannedBundleTargets, contains('android/app/libs/PaddlePredictor.jar'));
    expect(result.placementRequirements, contains('explicit-user-approval-to-copy-binary-files-into-project'));
    expect(result.q334HardBlocks, contains('no-so-aar-jar-bundled-in-q334'));
    expect(result.q335EntryCriteria, contains('explicit-user-approval-to-bundle-required-native-files'));
    expect(result.perFileSha256EvidenceProvidedToAssistant, isFalse);
    expect(result.nativePackageHashEvidenceReviewed, isFalse);
    expect(result.nativePackageHashEvidenceAccepted, isFalse);
    expect(result.explicitUserBinaryBundleApprovalProvided, isFalse);
    expect(result.actualBinaryBundlePlacementAttempted, isFalse);
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

  test('q334 MainActivity has placement gate method but no binary/runtime mutation', () {
    final mainActivity = File('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt').readAsStringSync();
    expect(mainActivity, contains('private val q334Phase = "V172-Q334-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-PENDING-EVIDENCE-BLOCKED-GATE"'));
    expect(mainActivity, contains('private val q334ActualBinaryBundlePlacementGateFeatureEnabled = false'));
    expect(mainActivity, contains('"actualBinaryBundlePlacementGate" -> result.success(q334ActualBinaryBundlePlacementGate(call.method))'));
    expect(mainActivity, contains('private fun q334ActualBinaryBundlePlacementGate(method: String): Map<String, Any>'));
    expect(mainActivity, contains('"actualBinaryBundlePlacementAttempted" to false'));
    expect(mainActivity, contains('"actualBinaryBundleExecuted" to false'));
    expect(mainActivity, contains('"nativeLibraryBundled" to false'));
    expect(mainActivity, contains('"jarBundled" to false'));
    expect(mainActivity, contains('"systemLoadLibraryAdded" to false'));

    for (final forbidden in <String>['PaddlePredictor(', 'MobileConfig(', 'PaddleOCR(', 'OnnxRuntime(', 'loadModel(', 'runInference(']) {
      expect(mainActivity.contains(forbidden), isFalse, reason: 'Q334 must not introduce runtime marker: $forbidden');
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
