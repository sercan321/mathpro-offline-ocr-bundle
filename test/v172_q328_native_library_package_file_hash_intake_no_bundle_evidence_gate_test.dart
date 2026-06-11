import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'v172_q344_binary_bundle_successor_test_helper.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_native_library_package_file_hash_intake_no_bundle_evidence_gate_q328.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_native_library_package_file_hash_intake_no_bundle_evidence_gate_q328_policy.dart';

const String q329SuccessorPhase = 'V172-Q329-NATIVE-PACKAGE-HASH-EVIDENCE-REVIEW-BINARY-BUNDLE-APPROVAL-GATE';
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
  test('q328 manifest records native package hash intake gate without binary bundle', () {
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
    expect(<String>[GaussNativeLibraryPackageFileHashIntakeNoBundleEvidenceGateQ328Policy.phase, q329SuccessorPhase, q330SuccessorPhase, q331SuccessorPhase, q332SuccessorPhase, q333SuccessorPhase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, 'V172-Q343-NATIVE-PACKAGE-HASH-EVIDENCE-FINAL-ACCEPTANCE-REAL-BUNDLE-UNLOCK-GATE', q344ActualBinaryBundlePhase, q345GradleAbiPackagingBuildTrialPhase, q346NativeLibraryLoadSmokePhase, q347PaddleLitePredictorInstantiateSmokePhase, q348OptimizedModelConversionModelLoaderEvidenceGatePhase, q349RealModelLoadSmokeEvidenceBlockedPhase, q350OptimizedModelArtifactConversionEvidenceIntakePhase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase, q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'], contains(manifest['cameraOcrLatestPhase']));
    expect(<String>[GaussNativeLibraryPackageFileHashIntakeNoBundleEvidenceGateQ328Policy.phase, q329SuccessorPhase, q330SuccessorPhase, q331SuccessorPhase, q332SuccessorPhase, q333SuccessorPhase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, 'V172-Q343-NATIVE-PACKAGE-HASH-EVIDENCE-FINAL-ACCEPTANCE-REAL-BUNDLE-UNLOCK-GATE', q344ActualBinaryBundlePhase, q345GradleAbiPackagingBuildTrialPhase, q346NativeLibraryLoadSmokePhase, q347PaddleLitePredictorInstantiateSmokePhase, q348OptimizedModelConversionModelLoaderEvidenceGatePhase, q349RealModelLoadSmokeEvidenceBlockedPhase, q350OptimizedModelArtifactConversionEvidenceIntakePhase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase, q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'],
        contains(manifest['activeProductDevelopmentLatestPhase']));
    expect(manifest['nativeLibraryPackageFileHashIntakeNoBundleEvidenceGateLatestPhase'],
        GaussNativeLibraryPackageFileHashIntakeNoBundleEvidenceGateQ328Policy.phase);
    expect(manifest['nativeLibrarySourcePackageApprovalAbiMatrixLockLatestPhase'],
        GaussNativeLibraryPackageFileHashIntakeNoBundleEvidenceGateQ328Policy.sourcePhase);
    if (manifest['cameraOcrLatestPhase'] == q329SuccessorPhase) {
      expect(manifest['v172Q329NativePackageHashEvidenceReviewBinaryBundleApprovalGate'], isNotNull);
    }

    final q328 = manifest['v172Q328NativeLibraryPackageFileHashIntakeNoBundleEvidenceGate']
        as Map<String, dynamic>;
    expect(q328['phase'], GaussNativeLibraryPackageFileHashIntakeNoBundleEvidenceGateQ328Policy.phase);
    expect(q328['sourcePhase'],
        GaussNativeLibraryPackageFileHashIntakeNoBundleEvidenceGateQ328Policy.sourcePhase);
    expect(q328['nativeChannelName'],
        GaussNativeLibraryPackageFileHashIntakeNoBundleEvidenceGateQ328Policy.nativeChannelName);
    expect(q328['nativeLibraryPackageFileHashIntakeMethod'],
        GaussNativeLibraryPackageFileHashIntakeNoBundleEvidenceGateQ328Policy.nativeLibraryPackageFileHashIntakeMethod);
    expect(q328['nativeLibraryPackageFileHashIntakeStatus'],
        GaussNativeLibraryPackageFileHashIntakeNoBundleEvidenceGateQ328Policy.nativeLibraryPackageFileHashIntakeStatus);
    expect(q328['externalNativePackageEvidencePolicy'], '../MathProOcrNativePackages/Paddle_Lite_Android');
    expect(q328['nativePackageEvidenceFileName'], 'q328_native_library_package_hash_evidence.json');
    expect(q328['requiredNativePackageFiles'], contains('PaddlePredictor.jar'));
    expect(q328['requiredNativePackageFiles'], contains('arm64-v8a/libpaddle_lite_jni.so'));
    expect(q328['perFileSha256EvidenceCaptured'], isFalse);
    expect(q328['nativePackageHashEvidenceAccepted'], isFalse);
    expect(q328['nativePackageFilesProvidedToProject'], isFalse);
    expect(q328['nativeLibraryBundled'], isFalse);
    expect(q328['jarBundled'], isFalse);
    expect(q328['runtimeDependencyAdded'], isFalse);
    expect(q328['realImageToLatexInferenceExecuted'], isFalse);
    expect(q328['ocrPassClaimed'], isFalse);
  });

  test('q328 policy/result blocks binary package mutation and runtime claims', () {
    final result = GaussNativeLibraryPackageFileHashIntakeNoBundleEvidenceGateQ328.evaluate();
    expect(result.phase, GaussNativeLibraryPackageFileHashIntakeNoBundleEvidenceGateQ328Policy.phase);
    expect(result.sourcePhase,
        GaussNativeLibraryPackageFileHashIntakeNoBundleEvidenceGateQ328Policy.sourcePhase);
    expect(result.nativeLibraryPackageFileHashIntakeMethod, 'nativeLibraryPackageFileHashIntake');
    expect(result.externalNativePackageEvidencePolicy, '../MathProOcrNativePackages/Paddle_Lite_Android');
    expect(result.requiredNativePackageFiles, contains('PaddlePredictor.jar'));
    expect(result.requiredNativePackageFiles, contains('arm64-v8a/libpaddle_lite_jni.so'));
    expect(result.nativePackageHashEvidenceRequirements,
        contains('capture-sha256-for-PaddlePredictor-jar-and-each-required-so'));
    expect(result.pubspecChanged, isFalse);
    expect(result.gradleChanged, isFalse);
    expect(result.androidManifestChanged, isFalse);
    expect(result.nativeLibraryBundled, isFalse);
    expect(result.aarBundled, isFalse);
    expect(result.jarBundled, isFalse);
    expect(result.jniLibsDirectoryCreated, isFalse);
    expect(result.androidAppLibsDirectoryCreated, isFalse);
    expect(result.perFileSha256EvidenceCaptured, isFalse);
    expect(result.nativePackageHashEvidenceAccepted, isFalse);
    expect(result.runtimeDependencyAdded, isFalse);
    expect(result.runtimeStartupExecuted, isFalse);
    expect(result.realImageToLatexInferenceExecuted, isFalse);
    expect(result.ocrPassClaimed, isFalse);
  });

  test('q328 main activity adds hash-intake envelope only', () {
    final mainActivity = File('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt').readAsStringSync();
    expect(mainActivity, contains('private val q328Phase = "V172-Q328-NATIVE-LIBRARY-PACKAGE-FILE-HASH-INTAKE-NO-BUNDLE-EVIDENCE-GATE"'));
    expect(mainActivity, contains('private val q328NativeLibraryPackageFileHashIntakeFeatureEnabled = false'));
    expect(mainActivity, contains('"nativeLibraryPackageFileHashIntake" -> result.success(q328NativeLibraryPackageFileHashIntake(call.method))'));
    expect(mainActivity, contains('private fun q328NativeLibraryPackageFileHashIntake(method: String): Map<String, Any>'));
    expect(mainActivity, contains('"nativeLibraryPackageFileHashIntakeBlockedReason" to "q328-requires-external-native-package-file-hashes-before-any-so-jar-aar-or-gradle-bundle"'));
    expect(mainActivity, contains('"externalNativePackageEvidencePolicy" to q328ExternalNativePackageEvidencePolicy'));
    expect(mainActivity, contains('"perFileSha256EvidenceCaptured" to false'));
    expect(mainActivity, contains('"nativePackageHashEvidenceAccepted" to false'));
    expect(mainActivity, contains('"nativePackageFilesBundled" to false'));
    expect(mainActivity, contains('"PaddlePredictor.jar"'));
    expect(mainActivity, contains('"arm64-v8a/libpaddle_lite_jni.so"'));
    expectNoRuntimeExecutionBeyondQ346NativeLoadSmoke(mainActivity);
    expect(mainActivity, isNot(contains('PaddlePredictor(')));
    expect(mainActivity, isNot(contains('MobileConfig(')));
    expect(mainActivity, isNot(contains('loadModel(')));
    expect(mainActivity, isNot(contains('runInference(')));
  });

  test('q328 capture script exists and project does not contain native package binaries', () {
    final script = File('tool/capture_paddle_lite_native_package_hashes_v172_q328.mjs').readAsStringSync();
    expect(script, contains('../MathProOcrNativePackages/Paddle_Lite_Android'));
    expect(script, contains('PaddlePredictor.jar'));
    expect(script, contains('arm64-v8a/libpaddle_lite_jni.so'));
    expect(script, contains('q328_native_library_package_hash_evidence.json'));
    expect(script, contains('refusing to read/write native package evidence inside project root'));

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
