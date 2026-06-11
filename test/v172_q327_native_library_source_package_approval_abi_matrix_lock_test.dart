import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'v172_q344_binary_bundle_successor_test_helper.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_native_library_source_package_approval_abi_matrix_lock_q327.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_native_library_source_package_approval_abi_matrix_lock_q327_policy.dart';

const String q328SuccessorPhase = 'V172-Q328-NATIVE-LIBRARY-PACKAGE-FILE-HASH-INTAKE-NO-BUNDLE-EVIDENCE-GATE';
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
  test('q327 manifest records native library source package and ABI matrix lock without binary bundle', () {
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
    expect(<String>[GaussNativeLibrarySourcePackageApprovalAbiMatrixLockQ327Policy.phase, q328SuccessorPhase, q329SuccessorPhase, q330SuccessorPhase, q331SuccessorPhase, q332SuccessorPhase, q333SuccessorPhase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, 'V172-Q343-NATIVE-PACKAGE-HASH-EVIDENCE-FINAL-ACCEPTANCE-REAL-BUNDLE-UNLOCK-GATE', q344ActualBinaryBundlePhase, q345GradleAbiPackagingBuildTrialPhase, q346NativeLibraryLoadSmokePhase, q347PaddleLitePredictorInstantiateSmokePhase, q348OptimizedModelConversionModelLoaderEvidenceGatePhase, q349RealModelLoadSmokeEvidenceBlockedPhase, q350OptimizedModelArtifactConversionEvidenceIntakePhase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase, q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'], contains(manifest['cameraOcrLatestPhase']));
    expect(<String>[GaussNativeLibrarySourcePackageApprovalAbiMatrixLockQ327Policy.phase, q328SuccessorPhase, q329SuccessorPhase, q330SuccessorPhase, q331SuccessorPhase, q332SuccessorPhase, q333SuccessorPhase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, 'V172-Q343-NATIVE-PACKAGE-HASH-EVIDENCE-FINAL-ACCEPTANCE-REAL-BUNDLE-UNLOCK-GATE', q344ActualBinaryBundlePhase, q345GradleAbiPackagingBuildTrialPhase, q346NativeLibraryLoadSmokePhase, q347PaddleLitePredictorInstantiateSmokePhase, q348OptimizedModelConversionModelLoaderEvidenceGatePhase, q349RealModelLoadSmokeEvidenceBlockedPhase, q350OptimizedModelArtifactConversionEvidenceIntakePhase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase, q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'], contains(manifest['activeProductDevelopmentLatestPhase']));
    expect(manifest['nativeLibrarySourcePackageApprovalAbiMatrixLockLatestPhase'],
        GaussNativeLibrarySourcePackageApprovalAbiMatrixLockQ327Policy.phase);
    expect(manifest['nativeLibraryBuildTrialApprovalAbiPackagingPreflightLatestPhase'],
        GaussNativeLibrarySourcePackageApprovalAbiMatrixLockQ327Policy.sourcePhase);

    final q327 = manifest['v172Q327NativeLibrarySourcePackageApprovalAbiMatrixLock'] as Map<String, dynamic>;
    expect(q327['phase'], GaussNativeLibrarySourcePackageApprovalAbiMatrixLockQ327Policy.phase);
    expect(q327['sourcePhase'], GaussNativeLibrarySourcePackageApprovalAbiMatrixLockQ327Policy.sourcePhase);
    expect(q327['nativeChannelName'], GaussNativeLibrarySourcePackageApprovalAbiMatrixLockQ327Policy.nativeChannelName);
    expect(q327['nativeLibrarySourcePackageApprovalMethod'],
        GaussNativeLibrarySourcePackageApprovalAbiMatrixLockQ327Policy.nativeLibrarySourcePackageApprovalMethod);
    expect(q327['nativeLibrarySourcePackageApprovalStatus'],
        GaussNativeLibrarySourcePackageApprovalAbiMatrixLockQ327Policy.nativeLibrarySourcePackageApprovalStatus);
    expect(q327['approvedNativeLibrarySourcePackage'],
        GaussNativeLibrarySourcePackageApprovalAbiMatrixLockQ327Policy.approvedNativeLibrarySourcePackage);
    expect(q327['requiredNativeLibraryFiles'], contains('PaddlePredictor.jar'));
    expect(q327['requiredNativeLibraryFiles'], contains('arm64-v8a/libpaddle_lite_jni.so'));
    expect(q327['abiMatrix'], contains('arm64-v8a-required'));
    expect(q327['nativeLibraryCandidatePaths'],
        contains('android/app/src/main/jniLibs/arm64-v8a/libpaddle_lite_jni.so'));
    expect(q327['jarCandidatePath'], 'android/app/libs/PaddlePredictor.jar');
    expect(q327['q315Sha256MatchesExpected'], isTrue);
    expect(q327['abiMatrixLocked'], isTrue);
    expect(q327['mainActivityChanged'], isTrue);
    expect(q327['protectedMainActivityChangeDeclared'], isTrue);
    expect(q327['featureFlagDefaultEnabled'], isFalse);
    expect(q327['pubspecChanged'], isFalse);
    expect(q327['gradleChanged'], isFalse);
    expect(q327['androidManifestChanged'], isFalse);
    expect(q327['runtimeDependencyAdded'], isFalse);
    expect(q327['nativeLibraryBundled'], isFalse);
    expect(q327['aarBundled'], isFalse);
    expect(q327['jarBundled'], isFalse);
    expect(q327['jniLibsDirectoryCreated'], isFalse);
    expect(q327['androidAppLibsDirectoryCreated'], isFalse);
    expect(q327['abiPackagingTrialExecuted'], isFalse);
    expect(q327['modelConversionExecuted'], isFalse);
    expect(q327['runtimeStartupExecuted'], isFalse);
    expect(q327['realImageToLatexInferenceExecuted'], isFalse);
    expect(q327['editableMathLiveReviewOpened'], isFalse);
    expect(q327['workspaceImportExecuted'], isFalse);
    expect(q327['ocrPassClaimed'], isFalse);
  });

  test('q327 policy/result is blocked and source-evidence oriented', () {
    final result = GaussNativeLibrarySourcePackageApprovalAbiMatrixLockQ327.evaluate();
    expect(result.phase, GaussNativeLibrarySourcePackageApprovalAbiMatrixLockQ327Policy.phase);
    expect(result.sourcePhase, GaussNativeLibrarySourcePackageApprovalAbiMatrixLockQ327Policy.sourcePhase);
    expect(result.nativeLibrarySourcePackageApprovalMethod, 'nativeLibrarySourcePackageApproval');
    expect(result.nativeLibrarySourcePackageApprovalStatus,
        contains('ABI_MATRIX_LOCKED_NO_BINARY_BUNDLE_DEFAULT_OFF'));
    expect(result.requiredNativeLibraryFiles, contains('PaddlePredictor.jar'));
    expect(result.abiMatrix, contains('arm64-v8a-required'));
    expect(result.sourcePackageEvidenceRequirements, contains('per-file-sha256-for-jar-and-each-so-before-commit'));
    expect(result.q327HardBlocks, contains('no-so-aar-jar-bundled-in-q327'));
    expect(result.q328EntryCriteria, contains('per-file-sha256-captured-for-jar-and-so-files'));
    expect(result.pubspecChanged, isFalse);
    expect(result.gradleChanged, isFalse);
    expect(result.nativeLibraryBundled, isFalse);
    expect(result.jarBundled, isFalse);
    expect(result.abiPackagingTrialExecuted, isFalse);
    expect(result.runtimeDependencyAdded, isFalse);
    expect(result.runtimeStartupExecuted, isFalse);
    expect(result.realImageToLatexInferenceExecuted, isFalse);
    expect(result.ocrPassClaimed, isFalse);
  });

  test('q327 MainActivity bridge adds source package approval but no native loader', () {
    final mainActivity = File('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt').readAsStringSync();
    expect(mainActivity,
        contains('private val q327Phase = "V172-Q327-NATIVE-LIBRARY-SOURCE-PACKAGE-APPROVAL-ABI-MATRIX-LOCK"'));
    expect(mainActivity, contains('private val q327NativeLibrarySourcePackageApprovalFeatureEnabled = false'));
    expect(mainActivity,
        contains('"nativeLibrarySourcePackageApproval" -> result.success(q327NativeLibrarySourcePackageApproval(call.method))'));
    expect(mainActivity, contains('private fun q327NativeLibrarySourcePackageApproval(method: String): Map<String, Any>'));
    expect(mainActivity, contains('"status" to q327NativeLibrarySourcePackageApprovalStatus'));
    expect(mainActivity,
        contains('"nativeLibrarySourcePackageApprovalBlockedReason" to "q327-locks-source-package-and-abi-matrix-but-does-not-bundle-so-aar-jar-or-mutate-gradle"'));
    expect(mainActivity, contains('"PaddlePredictor.jar"'));
    expect(mainActivity, contains('"arm64-v8a/libpaddle_lite_jni.so"'));
    expect(mainActivity, contains('"abiMatrixLocked" to true'));
    expect(mainActivity, contains('"jarBundled" to false'));
    expect(mainActivity, contains('"nativeLibraryBundled" to false'));
    expect(mainActivity, contains('"runtimeDependencyAdded" to false'));
    expect(mainActivity, contains('"realImageToLatexInferenceExecuted" to false'));
    expectNoRuntimeExecutionBeyondQ346NativeLoadSmoke(mainActivity);
    expect(mainActivity, isNot(contains('PaddlePredictor(')));
    expect(mainActivity, isNot(contains('MobileConfig(')));
    expect(mainActivity, isNot(contains('loadModel(')));
    expect(mainActivity, isNot(contains('runInference(')));
  });

  test('q327 does not add binary package files or dependency mutations', () {
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

    final changed = File('docs/audit/V172_Q327_CHANGED_FILES.md').readAsStringSync();
    expect(changed, contains('Protected Runtime File Intentionally Modified'));
    expect(changed, contains('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt'));
    expect(changed, contains('nativeLibrarySourcePackageApproval'));
    expect(changed, contains('pubspec.yaml'));
    expect(changed, contains('AndroidManifest.xml'));
  });
}
