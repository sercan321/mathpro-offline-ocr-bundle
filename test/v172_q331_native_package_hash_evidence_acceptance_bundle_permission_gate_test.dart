import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'v172_q344_binary_bundle_successor_test_helper.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_native_package_hash_evidence_acceptance_bundle_permission_gate_q331.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_native_package_hash_evidence_acceptance_bundle_permission_gate_q331_policy.dart';

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
  test('q331 manifest records hash evidence acceptance gate and keeps bundle blocked', () {
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
    expect(<String>[GaussNativePackageHashEvidenceAcceptanceBundlePermissionGateQ331Policy.phase, q332SuccessorPhase, q333SuccessorPhase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, 'V172-Q343-NATIVE-PACKAGE-HASH-EVIDENCE-FINAL-ACCEPTANCE-REAL-BUNDLE-UNLOCK-GATE', q344ActualBinaryBundlePhase, q345GradleAbiPackagingBuildTrialPhase, q346NativeLibraryLoadSmokePhase, q347PaddleLitePredictorInstantiateSmokePhase, q348OptimizedModelConversionModelLoaderEvidenceGatePhase, q349RealModelLoadSmokeEvidenceBlockedPhase, q350OptimizedModelArtifactConversionEvidenceIntakePhase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase, q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'], contains(manifest['cameraOcrLatestPhase']));
    expect(<String>[GaussNativePackageHashEvidenceAcceptanceBundlePermissionGateQ331Policy.phase, q332SuccessorPhase, q333SuccessorPhase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, 'V172-Q343-NATIVE-PACKAGE-HASH-EVIDENCE-FINAL-ACCEPTANCE-REAL-BUNDLE-UNLOCK-GATE', q344ActualBinaryBundlePhase, q345GradleAbiPackagingBuildTrialPhase, q346NativeLibraryLoadSmokePhase, q347PaddleLitePredictorInstantiateSmokePhase, q348OptimizedModelConversionModelLoaderEvidenceGatePhase, q349RealModelLoadSmokeEvidenceBlockedPhase, q350OptimizedModelArtifactConversionEvidenceIntakePhase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase, q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'],
        contains(manifest['activeProductDevelopmentLatestPhase']));
    expect(manifest['nativePackageHashEvidenceAcceptanceBundlePermissionGateLatestPhase'],
        GaussNativePackageHashEvidenceAcceptanceBundlePermissionGateQ331Policy.phase);
    expect(manifest['binaryBundleTrialJniLibsPaddlePredictorDefaultOffLatestPhase'],
        GaussNativePackageHashEvidenceAcceptanceBundlePermissionGateQ331Policy.sourcePhase);

    final q331 = manifest['v172Q331NativePackageHashEvidenceAcceptanceBundlePermissionGate']
        as Map<String, dynamic>;
    expect(q331['phase'], GaussNativePackageHashEvidenceAcceptanceBundlePermissionGateQ331Policy.phase);
    expect(q331['sourcePhase'], GaussNativePackageHashEvidenceAcceptanceBundlePermissionGateQ331Policy.sourcePhase);
    expect(q331['nativePackageHashEvidenceAcceptanceMethod'], 'nativePackageHashEvidenceAcceptance');
    expect(q331['nativePackageHashEvidenceAcceptanceStatus'], contains('BLOCKED_PENDING_USER_NATIVE_PACKAGE_HASH_EVIDENCE'));
    expect(q331['requiredNativePackageFiles'], contains('PaddlePredictor.jar'));
    expect(q331['plannedBundleTargets'], contains('android/app/libs/PaddlePredictor.jar'));
    expect(q331['plannedBundleTargets'], contains('android/app/src/main/jniLibs/arm64-v8a/libpaddle_lite_jni.so'));
    expect(q331['perFileSha256EvidenceProvidedToAssistant'], isFalse);
    expect(q331['requiredNativePackageHashEvidenceAccepted'], isFalse);
    expect(q331['nativePackageHashEvidenceAccepted'], isFalse);
    expect(q331['binaryBundlePermissionGranted'], isFalse);
    expect(q331['binaryBundleApproved'], isFalse);
    expect(q331['nativeLibraryBundled'], isFalse);
    expect(q331['jarBundled'], isFalse);
    expect(q331['jniLibsDirectoryCreated'], isFalse);
    expect(q331['androidAppLibsDirectoryCreated'], isFalse);
    expect(q331['systemLoadLibraryAdded'], isFalse);
    expect(q331['paddleLiteInstantiated'], isFalse);
    expect(q331['runtimeDependencyAdded'], isFalse);
    expect(q331['realImageToLatexInferenceExecuted'], isFalse);
    expect(q331['ocrPassClaimed'], isFalse);
  });

  test('q331 policy/result blocks bundle permission until evidence and approval', () {
    final result = GaussNativePackageHashEvidenceAcceptanceBundlePermissionGateQ331.evaluate();
    expect(result.phase, GaussNativePackageHashEvidenceAcceptanceBundlePermissionGateQ331Policy.phase);
    expect(result.sourcePhase, GaussNativePackageHashEvidenceAcceptanceBundlePermissionGateQ331Policy.sourcePhase);
    expect(result.nativePackageHashEvidenceAcceptanceMethod, 'nativePackageHashEvidenceAcceptance');
    expect(result.nativePackageHashEvidenceAcceptanceStatus, contains('BLOCKED_PENDING_USER_NATIVE_PACKAGE_HASH_EVIDENCE'));
    expect(result.requiredNativePackageFiles, contains('PaddlePredictor.jar'));
    expect(result.plannedBundleTargets, contains('android/app/libs/PaddlePredictor.jar'));
    expect(result.evidenceAcceptanceRequirements, contains('q328-native-package-hash-evidence-json-provided-from-outside-project-root'));
    expect(result.q331HardBlocks, contains('no-so-aar-jar-bundled-in-q331'));
    expect(result.q332EntryCriteria, contains('native-package-hash-evidence-json-provided-and-accepted'));
    expect(result.perFileSha256EvidenceProvidedToAssistant, isFalse);
    expect(result.nativePackageHashEvidenceAccepted, isFalse);
    expect(result.binaryBundlePermissionGranted, isFalse);
    expect(result.pubspecChanged, isFalse);
    expect(result.gradleChanged, isFalse);
    expect(result.nativeLibraryBundled, isFalse);
    expect(result.systemLoadLibraryAdded, isFalse);
    expect(result.paddleLiteInstantiated, isFalse);
    expect(result.runtimeDependencyAdded, isFalse);
    expect(result.realImageToLatexInferenceExecuted, isFalse);
    expect(result.ocrPassClaimed, isFalse);
  });

  test('q331 MainActivity has envelope method but no binary/runtime mutation', () {
    final mainActivity = File('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt').readAsStringSync();
    expect(mainActivity, contains('private val q331Phase = "V172-Q331-NATIVE-PACKAGE-HASH-EVIDENCE-ACCEPTANCE-BUNDLE-PERMISSION-GATE"'));
    expect(mainActivity, contains('private val q331NativePackageHashEvidenceAcceptanceFeatureEnabled = false'));
    expect(mainActivity, contains('"nativePackageHashEvidenceAcceptance" -> result.success(q331NativePackageHashEvidenceAcceptance(call.method))'));
    expect(mainActivity, contains('private fun q331NativePackageHashEvidenceAcceptance(method: String): Map<String, Any>'));
    expect(mainActivity, contains('"binaryBundlePermissionGranted" to false'));
    expect(mainActivity, contains('"nativeLibraryBundled" to false'));
    expect(mainActivity, contains('"jarBundled" to false'));
    expect(mainActivity, contains('"systemLoadLibraryAdded" to false'));

    for (final forbidden in <String>['PaddlePredictor(', 'MobileConfig(', 'PaddleOCR(', 'OnnxRuntime(', 'loadModel(', 'runInference(']) {
      expect(mainActivity.contains(forbidden), isFalse, reason: 'Q331 must not introduce runtime marker: $forbidden');
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
