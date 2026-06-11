import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'v172_q344_binary_bundle_successor_test_helper.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_native_library_build_trial_approval_abi_packaging_preflight_q326.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_native_library_build_trial_approval_abi_packaging_preflight_q326_policy.dart';

const String q327SuccessorPhase = 'V172-Q327-NATIVE-LIBRARY-SOURCE-PACKAGE-APPROVAL-ABI-MATRIX-LOCK';
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
  test('q326 manifest records native library build-trial ABI preflight without bundling binaries', () {
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
    expect(<String>[GaussNativeLibraryBuildTrialApprovalAbiPackagingPreflightQ326Policy.phase, q327SuccessorPhase, q328SuccessorPhase, q329SuccessorPhase, q330SuccessorPhase, q331SuccessorPhase, q332SuccessorPhase, q333SuccessorPhase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, 'V172-Q343-NATIVE-PACKAGE-HASH-EVIDENCE-FINAL-ACCEPTANCE-REAL-BUNDLE-UNLOCK-GATE', q344ActualBinaryBundlePhase, q345GradleAbiPackagingBuildTrialPhase, q346NativeLibraryLoadSmokePhase, q347PaddleLitePredictorInstantiateSmokePhase, q348OptimizedModelConversionModelLoaderEvidenceGatePhase, q349RealModelLoadSmokeEvidenceBlockedPhase, q350OptimizedModelArtifactConversionEvidenceIntakePhase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase, q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'], contains(manifest['cameraOcrLatestPhase']));
    expect(<String>[GaussNativeLibraryBuildTrialApprovalAbiPackagingPreflightQ326Policy.phase, q327SuccessorPhase, q328SuccessorPhase, q329SuccessorPhase, q330SuccessorPhase, q331SuccessorPhase, q332SuccessorPhase, q333SuccessorPhase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, 'V172-Q343-NATIVE-PACKAGE-HASH-EVIDENCE-FINAL-ACCEPTANCE-REAL-BUNDLE-UNLOCK-GATE', q344ActualBinaryBundlePhase, q345GradleAbiPackagingBuildTrialPhase, q346NativeLibraryLoadSmokePhase, q347PaddleLitePredictorInstantiateSmokePhase, q348OptimizedModelConversionModelLoaderEvidenceGatePhase, q349RealModelLoadSmokeEvidenceBlockedPhase, q350OptimizedModelArtifactConversionEvidenceIntakePhase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase, q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'],
        contains(manifest['activeProductDevelopmentLatestPhase']));
    expect(manifest['nativeLibraryBuildTrialApprovalAbiPackagingPreflightLatestPhase'],
        GaussNativeLibraryBuildTrialApprovalAbiPackagingPreflightQ326Policy.phase);

    final q326 = manifest['v172Q326NativeLibraryBuildTrialApprovalAbiPackagingPreflight'] as Map<String, dynamic>;
    expect(q326['phase'], GaussNativeLibraryBuildTrialApprovalAbiPackagingPreflightQ326Policy.phase);
    expect(q326['sourcePhase'], GaussNativeLibraryBuildTrialApprovalAbiPackagingPreflightQ326Policy.sourcePhase);
    expect(q326['nativeChannelName'], 'mathpro/ocr_runtime_bridge');
    expect(q326['nativeLibraryBuildTrialPreflightMethod'], 'nativeLibraryBuildTrialPreflight');
    expect(q326['nativeLibraryBuildTrialPreflightStatus'],
        'NATIVE_LIBRARY_BUILD_TRIAL_PREFLIGHT_BLOCKED_NO_NATIVE_LIBRARY_BUNDLE_DEFAULT_OFF');
    expect(q326['selectedRuntimeDependencyCandidate'], 'PADDLE_LITE_ANDROID_NATIVE_LIBRARY_MANUAL_TRIAL_PENDING');
    expect(q326['nativeLibrarySourceCandidate'],
        'PADDLE_LITE_ANDROID_INFERENCE_LIBRARY_DOWNLOAD_OR_BUILD_REQUIRED_NOT_BUNDLED');
    expect(q326['modelConversionCandidate'],
        'PADDLE_LITE_OPT_TOOL_CONVERSION_REQUIRED_BEFORE_MODEL_LOAD_NOT_EXECUTED');
    expect(q326['abiPackagingCandidates'], contains('arm64-v8a-required-candidate'));
    expect(q326['nativeLibraryCandidatePaths'],
        contains('android/app/src/main/jniLibs/arm64-v8a/libpaddle_lite_jni.so'));
    expect(q326['q315HashEvidenceProvidedToAssistant'], isTrue);
    expect(q326['q315Sha256MatchesExpected'], isTrue);
    expect(q326['runtimeDependencyCoordinateSelectionRecorded'], isTrue);
    expect(q326['nativeLibraryBuildTrialPreflightMethodAdded'], isTrue);
    expect(q326['mainActivityChanged'], isTrue);
    expect(q326['protectedMainActivityChangeDeclared'], isTrue);
    expect(q326['methodChannelBindingExtended'], isTrue);
    expect(q326['featureFlagDefaultEnabled'], isFalse);
    expect(q326['pubspecChanged'], isFalse);
    expect(q326['gradleChanged'], isFalse);
    expect(q326['androidManifestChanged'], isFalse);
    expect(q326['runtimeDependencyAdded'], isFalse);
    expect(q326['nativeLibraryBundled'], isFalse);
    expect(q326['aarBundled'], isFalse);
    expect(q326['jniLibsDirectoryCreated'], isFalse);
    expect(q326['abiPackagingTrialExecuted'], isFalse);
    expect(q326['buildTrialExecuted'], isFalse);
    expect(q326['modelConversionExecuted'], isFalse);
    expect(q326['nativeModelLoaderAdded'], isFalse);
    expect(q326['modelLoaderAvailable'], isFalse);
    expect(q326['runtimeStartupExecuted'], isFalse);
    expect(q326['modelLoaded'], isFalse);
    expect(q326['dummyRuntimeCallExecuted'], isFalse);
    expect(q326['realImageToLatexInferenceExecuted'], isFalse);
    expect(q326['editableMathLiveReviewOpened'], isFalse);
    expect(q326['workspaceImportExecuted'], isFalse);
    expect(q326['ocrPassClaimed'], isFalse);
    expect(q326['androidRealDevicePassClaimed'], isFalse);
  });

  test('q326 Dart policy exposes ABI packaging preflight as const blocked envelope', () {
    final result = GaussNativeLibraryBuildTrialApprovalAbiPackagingPreflightQ326.evaluate();
    expect(result.phase, GaussNativeLibraryBuildTrialApprovalAbiPackagingPreflightQ326Policy.phase);
    expect(result.sourcePhase, GaussNativeLibraryBuildTrialApprovalAbiPackagingPreflightQ326Policy.sourcePhase);
    expect(result.nativeLibraryBuildTrialPreflightMethod, 'nativeLibraryBuildTrialPreflight');
    expect(result.nativeLibraryBuildTrialPreflightStatus,
        'NATIVE_LIBRARY_BUILD_TRIAL_PREFLIGHT_BLOCKED_NO_NATIVE_LIBRARY_BUNDLE_DEFAULT_OFF');
    expect(result.nativeLibraryCandidatePaths,
        contains('android/app/src/main/jniLibs/arm64-v8a/libpaddle_lite_jni.so'));
    expect(result.preflightEnvelopeFields, contains('nativeLibraryBuildTrialBlockedReason'));
    expect(result.q326HardBlocks, contains('no-native-library-so-aar-or-jnilibs-directory-added-in-q326'));
    expect(result.q327EntryCriteria, contains('explicit-native-library-source-package-approved'));
    expect(result.pubspecChanged, isFalse);
    expect(result.gradleChanged, isFalse);
    expect(result.nativeLibraryBundled, isFalse);
    expect(result.abiPackagingTrialExecuted, isFalse);
    expect(result.runtimeDependencyAdded, isFalse);
    expect(result.runtimeStartupExecuted, isFalse);
    expect(result.realImageToLatexInferenceExecuted, isFalse);
    expect(result.ocrPassClaimed, isFalse);
  });

  test('q326 MainActivity bridge adds nativeLibraryBuildTrialPreflight but no native loader', () {
    final mainActivity = File('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt').readAsStringSync();
    expect(mainActivity,
        contains('private val q326Phase = "V172-Q326-NATIVE-LIBRARY-BUILD-TRIAL-APPROVAL-ABI-PACKAGING-PREFLIGHT"'));
    expect(mainActivity, contains('private val q326NativeLibraryBuildTrialPreflightFeatureEnabled = false'));
    expect(mainActivity,
        contains('"nativeLibraryBuildTrialPreflight" -> result.success(q326NativeLibraryBuildTrialPreflight(call.method))'));
    expect(mainActivity, contains('private fun q326NativeLibraryBuildTrialPreflight(method: String): Map<String, Any>'));
    expect(mainActivity, contains('"status" to q326NativeLibraryBuildTrialPreflightStatus'));
    expect(mainActivity, contains('"nativeLibraryBuildTrialBlockedReason" to "q326-records-abi-packaging-preflight-but-does-not-bundle-so-aar-or-mutate-gradle"'));
    expect(mainActivity, contains('"nativeLibraryBundled" to false'));
    expect(mainActivity, contains('"aarBundled" to false'));
    expect(mainActivity, contains('"jniLibsDirectoryCreated" to false'));
    expect(mainActivity, contains('"abiPackagingTrialExecuted" to false'));
    expect(mainActivity, contains('"modelConversionExecuted" to false'));
    expect(mainActivity, contains('"runtimeDependencyAdded" to false'));
    expect(mainActivity, contains('"realImageToLatexInferenceExecuted" to false'));
    expectNoRuntimeExecutionBeyondQ346NativeLoadSmoke(mainActivity);
    expect(mainActivity, isNot(contains('PaddleOCR(')));
    expect(mainActivity, isNot(contains('OnnxRuntime(')));
    expect(mainActivity, isNot(contains('loadModel(')));
    expect(mainActivity, isNot(contains('runInference(')));
  });

  test('q326 does not add binary runtime artifacts or mutate dependency surfaces', () {
    final pubspec = File('pubspec.yaml').readAsStringSync().toLowerCase();
    expect(pubspec, isNot(contains('paddleocr')));
    expect(pubspec, isNot(contains('paddle_lite')));
    expect(pubspec, isNot(contains('onnxruntime')));
    expect(pubspec, isNot(contains('tflite_flutter')));

    final androidRoot = Directory('android');
    final forbiddenBinaryArtifacts = androidRoot
        .listSync(recursive: true)
        .whereType<File>()
        .where((file) => file.path.endsWith('.so') || file.path.endsWith('.aar'))
        .toList();
    expect(q344UnexpectedNativeBinaryPaths(forbiddenBinaryArtifacts.map((file) => file.path)), isEmpty);
    if (isQ344ActualBinaryBundleActive()) {
      expect(Directory('android/app/src/main/jniLibs').existsSync(), isTrue);
    } else {
      expect(Directory('android/app/src/main/jniLibs').existsSync(), isFalse);
    }

    final changed = File('docs/audit/V172_Q326_CHANGED_FILES.md').readAsStringSync();
    expect(changed, contains('Protected Runtime File Intentionally Modified'));
    expect(changed, contains('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt'));
    expect(changed, contains('nativeLibraryBuildTrialPreflight'));
    expect(changed, contains('pubspec.yaml'));
    expect(changed, contains('AndroidManifest.xml'));
  });
}
