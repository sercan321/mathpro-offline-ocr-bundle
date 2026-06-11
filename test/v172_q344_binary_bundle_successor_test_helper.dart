import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

const String q344ActualBinaryBundlePhase = 'V172-Q344-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR';
const String q345GradleAbiPackagingBuildTrialPhase = 'V172-Q345-GRADLE-ABI-PACKAGING-BUILD-TRIAL';
const String q346NativeLibraryLoadSmokePhase = 'V172-Q346-NATIVE-LIBRARY-LOAD-SMOKE';
const String q347PaddleLitePredictorInstantiateSmokePhase = 'V172-Q347-PADDLE-LITE-PREDICTOR-INSTANTIATE-SMOKE';
const String q348OptimizedModelConversionModelLoaderEvidenceGatePhase = 'V172-Q348-OPTIMIZED-MODEL-CONVERSION-MODEL-LOADER-EVIDENCE-GATE';
const String q349RealModelLoadSmokeEvidenceBlockedPhase = 'V172-Q349-REAL-MODEL-LOAD-SMOKE-EVIDENCE-BLOCKED';
const String q350OptimizedModelArtifactConversionEvidenceIntakePhase = 'V172-Q350-OPTIMIZED-MODEL-ARTIFACT-CONVERSION-EVIDENCE-INTAKE';
const String q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase = 'V172-Q351-OPTIMIZED-MODEL-EVIDENCE-ACCEPTANCE-REAL-MODEL-LOAD-UNLOCK-GATE';
const String q351R1FlutterTestSuccessorAwareHygieneRepairPhase = 'V172-Q351R1-FLUTTER-TEST-SUCCESSOR-AWARE-HYGIENE-REPAIR';
const String q351R2FlutterRunKotlinBuildHelperRepairPhase = 'V172-Q351R2-FLUTTER-RUN-KOTLIN-BUILD-HELPER-REPAIR';
const String q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase = 'V172-Q352-ONNX-CONVERSION-EVIDENCE-ACCEPTANCE-RUNTIME-STRATEGY-PIVOT-GATE';
const String q353OnnxRuntimeMobileDependencyFeasibilityGatePhase = 'V172-Q353-ONNX-RUNTIME-MOBILE-DEPENDENCY-FEASIBILITY-GATE';
const String q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase = 'V172-Q354-ONNX-RUNTIME-ANDROID-DEPENDENCY-ABI-BUILD-TRIAL';
const String q355OnnxModelPrivateStorageShaVerificationPhase = 'V172-Q355-ONNX-MODEL-PRIVATE-STORAGE-SHA-VERIFICATION';
const String q356OnnxRealModelLoadSmokeEvidenceBlockedPhase = 'V172-Q356-ONNX-REAL-MODEL-LOAD-SMOKE-EVIDENCE-BLOCKED';
const String q356R1OnnxRuntimeAndroidBuildEvidenceIntakeModelLoadUnlockGuardPhase = 'V172-Q356R1-ONNX-RUNTIME-ANDROID-BUILD-EVIDENCE-INTAKE-MODEL-LOAD-UNLOCK-GUARD';
const String q356R2OnnxRuntimeAndroidMissingBuildEvidenceQ357LockGuardPhase = 'V172-Q356R2-ONNX-RUNTIME-ANDROID-MISSING-BUILD-EVIDENCE-Q357-LOCK-GUARD';
const String q357OnnxRealModelLoadSmokeBridgePreflightExecutionPhase = 'V172-Q357-ONNX-REAL-MODEL-LOAD-SMOKE-BRIDGE-PREFLIGHT-EXECUTION';
const String q358OnnxDummyInputRuntimeCallGuardPreflightPhase = 'V172-Q358-ONNX-DUMMY-INPUT-RUNTIME-CALL-GUARD-PREFLIGHT';
const String q359FirstRealImageToLatexInferenceGuardCandidateEnvelopePreflightPhase = 'V172-Q359-FIRST-REAL-IMAGE-TO-LATEX-INFERENCE-GUARD-CANDIDATE-ENVELOPE-PREFLIGHT';
const String q360OcrReviewApprovedImportContractPhase = 'V172-Q360-OCR-REVIEW-APPROVED-IMPORT-CONTRACT';
const String q361CameraOcrRuntimeExecutionBridgePhase = 'V172-Q361-CAMERA-OCR-RUNTIME-EXECUTION-BRIDGE';
const String q362AccuracyPerformanceMultideviceQaGuardPhase = 'V172-Q362-ACCURACY-PERFORMANCE-MULTIDEVICE-QA-GUARD';
const String q363StorePrivacyFinalReleaseGatePhase = 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE';


const Set<String> q344OrLaterBundledBinaryActivePhases = <String>{
  q344ActualBinaryBundlePhase,
  q345GradleAbiPackagingBuildTrialPhase,
  q346NativeLibraryLoadSmokePhase,
  q347PaddleLitePredictorInstantiateSmokePhase,
  q348OptimizedModelConversionModelLoaderEvidenceGatePhase,
  q349RealModelLoadSmokeEvidenceBlockedPhase,
  q350OptimizedModelArtifactConversionEvidenceIntakePhase,
  q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase,
  q351R1FlutterTestSuccessorAwareHygieneRepairPhase,
  q351R2FlutterRunKotlinBuildHelperRepairPhase,
  q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase,
  q353OnnxRuntimeMobileDependencyFeasibilityGatePhase,
  q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase,
  q355OnnxModelPrivateStorageShaVerificationPhase,
  q356OnnxRealModelLoadSmokeEvidenceBlockedPhase,
  q356R1OnnxRuntimeAndroidBuildEvidenceIntakeModelLoadUnlockGuardPhase,
  q356R2OnnxRuntimeAndroidMissingBuildEvidenceQ357LockGuardPhase,
  q357OnnxRealModelLoadSmokeBridgePreflightExecutionPhase,
  q358OnnxDummyInputRuntimeCallGuardPreflightPhase,
  q359FirstRealImageToLatexInferenceGuardCandidateEnvelopePreflightPhase,
  q360OcrReviewApprovedImportContractPhase,
  q361CameraOcrRuntimeExecutionBridgePhase,
  q362AccuracyPerformanceMultideviceQaGuardPhase,
  q363StorePrivacyFinalReleaseGatePhase,
};

const Set<String> q344AllowedBundledBinaryPaths = <String>{
  'android/app/libs/PaddlePredictor.jar',
  'android/app/src/main/jniLibs/arm64-v8a/libpaddle_lite_jni.so',
  'android/app/src/main/jniLibs/armeabi-v7a/libpaddle_lite_jni.so',
};

Map<String, dynamic> q344ReadManifest() =>
    jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;


const Set<String> q347OrLaterPaddleLiteBridgeActivePhases = <String>{
  q347PaddleLitePredictorInstantiateSmokePhase,
  q348OptimizedModelConversionModelLoaderEvidenceGatePhase,
  q349RealModelLoadSmokeEvidenceBlockedPhase,
  q350OptimizedModelArtifactConversionEvidenceIntakePhase,
  q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase,
  q351R1FlutterTestSuccessorAwareHygieneRepairPhase,
  q351R2FlutterRunKotlinBuildHelperRepairPhase,
  q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase,
  q353OnnxRuntimeMobileDependencyFeasibilityGatePhase,
  q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase,
  q355OnnxModelPrivateStorageShaVerificationPhase,
  q356OnnxRealModelLoadSmokeEvidenceBlockedPhase,
  q356R1OnnxRuntimeAndroidBuildEvidenceIntakeModelLoadUnlockGuardPhase,
  q356R2OnnxRuntimeAndroidMissingBuildEvidenceQ357LockGuardPhase,
  q357OnnxRealModelLoadSmokeBridgePreflightExecutionPhase,
  q358OnnxDummyInputRuntimeCallGuardPreflightPhase,
  q359FirstRealImageToLatexInferenceGuardCandidateEnvelopePreflightPhase,
  q360OcrReviewApprovedImportContractPhase,
  q361CameraOcrRuntimeExecutionBridgePhase,
  q362AccuracyPerformanceMultideviceQaGuardPhase,
  q363StorePrivacyFinalReleaseGatePhase,
};

bool isQ347OrLaterPaddleLiteBridgeActive() {
  final manifest = q344ReadManifest();
  return q347OrLaterPaddleLiteBridgeActivePhases.contains(manifest['cameraOcrLatestPhase']) ||
      q347OrLaterPaddleLiteBridgeActivePhases.contains(manifest['activeProductDevelopmentLatestPhase']);
}

bool isQ344ActualBinaryBundleActive() {
  final manifest = q344ReadManifest();
  return q344OrLaterBundledBinaryActivePhases.contains(manifest['cameraOcrLatestPhase']) ||
      q344OrLaterBundledBinaryActivePhases.contains(manifest['activeProductDevelopmentLatestPhase']);
}

bool isQ346NativeLibraryLoadSmokeActive() {
  final manifest = q344ReadManifest();
  return manifest['cameraOcrLatestPhase'] == q346NativeLibraryLoadSmokePhase ||
      manifest['activeProductDevelopmentLatestPhase'] == q346NativeLibraryLoadSmokePhase;
}

bool isQ347PaddleLitePredictorInstantiateSmokeActive() {
  final manifest = q344ReadManifest();
  return manifest['cameraOcrLatestPhase'] == q347PaddleLitePredictorInstantiateSmokePhase ||
      manifest['activeProductDevelopmentLatestPhase'] == q347PaddleLitePredictorInstantiateSmokePhase;
}

void expectNoRuntimeExecutionBeyondQ346NativeLoadSmoke(String mainActivity) {
  if (isQ347PaddleLitePredictorInstantiateSmokeActive()) {
    expect(mainActivity, contains('private val q347Phase = "V172-Q347-PADDLE-LITE-PREDICTOR-INSTANTIATE-SMOKE"'));
    expect(mainActivity, contains('private val q347FeatureEnabled = false'));
    expect(mainActivity, contains('"paddleLitePredictorInstantiateSmoke" -> result.success(q347PaddleLitePredictorInstantiateSmoke(call.method))'));
    expect(mainActivity, contains('private fun q347PaddleLitePredictorInstantiateSmoke(method: String): Map<String, Any>'));
    expect(mainActivity, contains('"predictorInstantiateAttempted" to predictorInstantiateAttempted'));
    expect(mainActivity, contains('"automaticStartupInstantiate" to false'));
    expect(mainActivity, contains('"assistantExecutedPredictorInstantiateSmoke" to false'));
  } else if (isQ346NativeLibraryLoadSmokeActive()) {
    expect(mainActivity, contains('private val q346Phase = "V172-Q346-NATIVE-LIBRARY-LOAD-SMOKE"'));
    expect(mainActivity, contains('private val q346FeatureEnabled = false'));
    expect(mainActivity, contains('"nativeLibraryLoadSmoke" -> result.success(q346NativeLibraryLoadSmoke(call.method))'));
    expect(mainActivity, contains('private fun q346NativeLibraryLoadSmoke(method: String): Map<String, Any>'));
    expect(mainActivity, contains('"nativeLibraryLoadAttempted" to nativeLibraryLoadAttempted'));
    expect(mainActivity, contains('"automaticStartupLoad" to false'));
    expect(mainActivity, contains('"assistantExecutedNativeLoadSmoke" to false'));
  }
  expect(mainActivity, isNot(contains('PaddlePredictor(')));
  expect(mainActivity, isNot(contains('PaddleLite(')));
  expect(mainActivity, isNot(contains('loadModel(')));
  expect(mainActivity, isNot(contains('runInference(')));
}

String q344NormalizePath(String path) => path.replaceAll('\\', '/');

String q344ProjectRelativePath(String path) {
  final normalized = q344NormalizePath(path);
  const marker = '/MathProFlutterPhase17/';
  final markerIndex = normalized.indexOf(marker);
  if (markerIndex >= 0) {
    return normalized.substring(markerIndex + marker.length);
  }
  final androidIndex = normalized.indexOf('android/app/');
  if (androidIndex >= 0) {
    return normalized.substring(androidIndex);
  }
  return normalized;
}

List<String> q344UnexpectedNativeBinaryPaths(Iterable<String> paths) {
  final binaries = paths
      .map(q344ProjectRelativePath)
      .where((path) => path.endsWith('.so') || path.endsWith('.jar') || path.endsWith('.aar'))
      .toList();
  if (!isQ344ActualBinaryBundleActive()) {
    return binaries;
  }
  return binaries.where((path) => !q344AllowedBundledBinaryPaths.contains(path)).toList();
}

void expectNoNativeBinariesOrOnlyQ344ActualBundle() {
  final androidApp = Directory('android/app');
  final appFiles = androidApp.existsSync()
      ? androidApp
          .listSync(recursive: true, followLinks: false)
          .whereType<File>()
          .map((file) => file.path)
          .toList()
      : <String>[];
  expect(q344UnexpectedNativeBinaryPaths(appFiles), isEmpty);
  if (isQ344ActualBinaryBundleActive()) {
    expect(File('android/app/libs/PaddlePredictor.jar').existsSync(), isTrue);
    expect(File('android/app/src/main/jniLibs/arm64-v8a/libpaddle_lite_jni.so').existsSync(), isTrue);
    expect(File('android/app/src/main/jniLibs/armeabi-v7a/libpaddle_lite_jni.so').existsSync(), isTrue);
  } else {
    expect(Directory('android/app/src/main/jniLibs').existsSync(), isFalse);
    expect(Directory('android/app/libs').existsSync(), isFalse);
  }
}
