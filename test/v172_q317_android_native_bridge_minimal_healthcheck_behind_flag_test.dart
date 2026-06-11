import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'v172_q344_binary_bundle_successor_test_helper.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_android_native_bridge_minimal_healthcheck_q317.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_android_native_bridge_minimal_healthcheck_q317_policy.dart';

const String q327SuccessorPhase = 'V172-Q327-NATIVE-LIBRARY-SOURCE-PACKAGE-APPROVAL-ABI-MATRIX-LOCK';
const String q328SuccessorPhase = 'V172-Q328-NATIVE-LIBRARY-PACKAGE-FILE-HASH-INTAKE-NO-BUNDLE-EVIDENCE-GATE';
const String q329SuccessorPhase = 'V172-Q329-NATIVE-PACKAGE-HASH-EVIDENCE-REVIEW-BINARY-BUNDLE-APPROVAL-GATE';
const String q330SuccessorPhase = 'V172-Q330-BINARY-BUNDLE-TRIAL-JNILIBS-PADDLEPREDICTOR-DEFAULT-OFF';
const String q331SuccessorPhase = 'V172-Q331-NATIVE-PACKAGE-HASH-EVIDENCE-ACCEPTANCE-BUNDLE-PERMISSION-GATE';
const String q332SuccessorPhase = 'V172-Q332-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-BLOCKED-GATE';
const String q333SuccessorPhase = 'V172-Q333-NATIVE-PACKAGE-HASH-EVIDENCE-INTAKE-REAL-BUNDLE-PERMISSION-REVIEW';
const String q334SuccessorPhase = 'V172-Q334-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-PENDING-EVIDENCE-BLOCKED-GATE';

const String q318SuccessorPhase = 'V172-Q318-PRIVATE-MODEL-DOWNLOAD-STORAGE-REAL-IMPLEMENTATION';
const String q319SuccessorPhase = 'V172-Q319-VERIFIED-ARTIFACT-LOAD-SMOKE-ON-DEVICE';
const String q320SuccessorPhase = 'V172-Q320-RUNTIME-STARTUP-SMOKE-ON-DEVICE';
const String q321SuccessorPhase = 'V172-Q321-DUMMY-INPUT-RUNTIME-CALL';
const String q322SuccessorPhase = 'V172-Q322-FIRST-IMAGE-TO-LATEX-INFERENCE-ENVELOPE';
const String q323SuccessorPhase = 'V172-Q323-RUNTIME-DEPENDENCY-MODEL-LOADER-DECISION-IMPLEMENTATION';
const String q324SuccessorPhase = 'V172-Q324-APPROVED-RUNTIME-DEPENDENCY-TRIAL-BEHIND-DEFAULT-OFF-FLAG';
const String q325SuccessorPhase = 'V172-Q325-EXPLICIT-RUNTIME-DEPENDENCY-COORDINATE-SELECTION-BUILD-TRIAL-GATE';

const String q335SuccessorPhase = 'V172-Q335-NATIVE-PACKAGE-HASH-EVIDENCE-COLLECTION-USER-SIDE-NATIVE-PACKAGE-INTAKE';
const String q336SuccessorPhase = 'V172-Q336-NATIVE-PACKAGE-HASH-EVIDENCE-CAPTURE-Q328-JSON-INTAKE';
const String q337SuccessorPhase = 'V172-Q337-NATIVE-PACKAGE-HASH-EVIDENCE-ACCEPTANCE-EXPLICIT-BUNDLE-APPROVAL-GATE';
const String q338SuccessorPhase = 'V172-Q338-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-NO-EVIDENCE-BLOCKED-GATE';
const String q339SuccessorPhase = 'V172-Q339-NATIVE-PACKAGE-HASH-EVIDENCE-CAPTURE-ACTUAL-BUNDLE-PERMISSION-FINAL-CHECK';
const String q340SuccessorPhase = 'V172-Q340-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-EVIDENCE-BLOCKED-GATE';
const String q341SuccessorPhase = 'V172-Q341-NATIVE-PACKAGE-HASH-EVIDENCE-CAPTURE-BUNDLE-EVIDENCE-ACCEPTANCE';
const String q342SuccessorPhase = 'V172-Q342-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-PENDING-EVIDENCE-BLOCKED';

void main() {
  test('q317 records native bridge healthcheck only and keeps OCR runtime disabled', () {
    final result = GaussAndroidNativeBridgeMinimalHealthcheckQ317.evaluate();

    expect(result.phase, GaussAndroidNativeBridgeMinimalHealthcheckQ317Policy.phase);
    expect(result.sourcePhase, GaussAndroidNativeBridgeMinimalHealthcheckQ317Policy.sourcePhase);
    expect(result.nativeChannelName, 'mathpro/ocr_runtime_bridge');
    expect(result.nativePingMethod, 'ping');
    expect(result.nativeHealthCheckMethod, 'healthCheck');
    expect(result.nativeHealthCheckStatus, 'NATIVE_BRIDGE_HEALTHCHECK_AVAILABLE_DEFAULT_OFF');
    expect(result.q315HashEvidenceProvidedToAssistant, isTrue);
    expect(result.q315Sha256MatchesExpected, isTrue);
    expect(result.q315ArtifactStoredOutsideProjectRoot, isTrue);
    expect(result.q315RuntimeAccepted, isFalse);
    expect(result.featureFlagDefaultEnabled, isFalse);
    expect(result.nativeBridgeHealthcheckDefaultOff, isTrue);
    expect(result.mainActivityChanged, isTrue);
    expect(result.protectedMainActivityChangeDeclared, isTrue);
    expect(result.methodChannelBindingAdded, isTrue);
    expect(result.runtimeDependencyAdded, isFalse);
    expect(result.paddleRuntimeDependencyAdded, isFalse);
    expect(result.paddleOcrDependencyAdded, isFalse);
    expect(result.jniNativeHandlerAdded, isFalse);
    expect(result.nativeModelLoaderAdded, isFalse);
    expect(result.modelBinaryBundledInBaseApp, isFalse);
    expect(result.modelArtifactAcceptedForRuntime, isFalse);
    expect(result.runtimeStartupExecuted, isFalse);
    expect(result.dummyRuntimeCallExecuted, isFalse);
    expect(result.realImageToLatexInferenceExecuted, isFalse);
    expect(result.editableMathLiveReviewOpened, isFalse);
    expect(result.workspaceImportExecuted, isFalse);
    expect(result.ocrPassClaimed, isFalse);
    expect(result.androidRealDevicePassClaimed, isFalse);
    expect(result.nativeHealthcheckEnvelopeFields, contains('expectedArtifactSha256'));
    expect(result.q317HardBlocks, contains('no-runtime-startup-in-q317'));
    expect(result.q317HardBlocks, contains('no-model-load-or-runtime-acceptance-in-q317'));
    expect(result.q318EntryCriteria, contains('q317-flutter-run-device-log-shows-native-bridge-healthcheck-if-runtime-work-continues'));
  });

  test('q317 manifest is active and preserves q315/q316 evidence boundaries', () {
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
    final q317 = manifest['v172Q317AndroidNativeBridgeMinimalHealthcheckBehindFlag'] as Map<String, dynamic>;

    if (![q327SuccessorPhase, q328SuccessorPhase, q329SuccessorPhase, q330SuccessorPhase, q331SuccessorPhase, q332SuccessorPhase, q333SuccessorPhase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase, 'V172-Q343-NATIVE-PACKAGE-HASH-EVIDENCE-FINAL-ACCEPTANCE-REAL-BUNDLE-UNLOCK-GATE', q344ActualBinaryBundlePhase, q345GradleAbiPackagingBuildTrialPhase, q346NativeLibraryLoadSmokePhase, q347PaddleLitePredictorInstantiateSmokePhase, q348OptimizedModelConversionModelLoaderEvidenceGatePhase, q349RealModelLoadSmokeEvidenceBlockedPhase, q350OptimizedModelArtifactConversionEvidenceIntakePhase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase, q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'].contains(manifest['cameraOcrLatestPhase'])) { expect(<String>[GaussAndroidNativeBridgeMinimalHealthcheckQ317Policy.phase, q318SuccessorPhase, q319SuccessorPhase, q320SuccessorPhase, q321SuccessorPhase, q322SuccessorPhase, q323SuccessorPhase, q324SuccessorPhase, q325SuccessorPhase, 'V172-Q343-NATIVE-PACKAGE-HASH-EVIDENCE-FINAL-ACCEPTANCE-REAL-BUNDLE-UNLOCK-GATE', q344ActualBinaryBundlePhase, q345GradleAbiPackagingBuildTrialPhase, q346NativeLibraryLoadSmokePhase, q347PaddleLitePredictorInstantiateSmokePhase, q348OptimizedModelConversionModelLoaderEvidenceGatePhase, q349RealModelLoadSmokeEvidenceBlockedPhase, q350OptimizedModelArtifactConversionEvidenceIntakePhase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase, q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'], contains(manifest['cameraOcrLatestPhase'])); }
    if (![q327SuccessorPhase, q328SuccessorPhase, q329SuccessorPhase, q330SuccessorPhase, q331SuccessorPhase, q332SuccessorPhase, q333SuccessorPhase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase, 'V172-Q343-NATIVE-PACKAGE-HASH-EVIDENCE-FINAL-ACCEPTANCE-REAL-BUNDLE-UNLOCK-GATE', q344ActualBinaryBundlePhase, q345GradleAbiPackagingBuildTrialPhase, q346NativeLibraryLoadSmokePhase, q347PaddleLitePredictorInstantiateSmokePhase, q348OptimizedModelConversionModelLoaderEvidenceGatePhase, q349RealModelLoadSmokeEvidenceBlockedPhase, q350OptimizedModelArtifactConversionEvidenceIntakePhase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase, q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'].contains(manifest['activeProductDevelopmentLatestPhase'])) { expect(<String>[GaussAndroidNativeBridgeMinimalHealthcheckQ317Policy.phase, q318SuccessorPhase, q319SuccessorPhase, q320SuccessorPhase, q321SuccessorPhase, q322SuccessorPhase, q323SuccessorPhase, q324SuccessorPhase, q325SuccessorPhase, 'V172-Q343-NATIVE-PACKAGE-HASH-EVIDENCE-FINAL-ACCEPTANCE-REAL-BUNDLE-UNLOCK-GATE', q344ActualBinaryBundlePhase, q345GradleAbiPackagingBuildTrialPhase, q346NativeLibraryLoadSmokePhase, q347PaddleLitePredictorInstantiateSmokePhase, q348OptimizedModelConversionModelLoaderEvidenceGatePhase, q349RealModelLoadSmokeEvidenceBlockedPhase, q350OptimizedModelArtifactConversionEvidenceIntakePhase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase, q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'], contains(manifest['activeProductDevelopmentLatestPhase'])); }
    expect(manifest['androidNativeBridgeMinimalHealthcheckLatestPhase'], GaussAndroidNativeBridgeMinimalHealthcheckQ317Policy.phase);
    if (manifest['cameraOcrLatestPhase'] == q318SuccessorPhase || manifest['cameraOcrLatestPhase'] == q319SuccessorPhase) {
      expect(manifest['v172Q318PrivateModelDownloadStorageRealImplementation'], isA<Map<String, dynamic>>());
    }
    if (manifest['cameraOcrLatestPhase'] == q319SuccessorPhase) {
      expect(manifest['v172Q319VerifiedArtifactLoadSmokeOnDevice'], isA<Map<String, dynamic>>());
    }
    expect(manifest['runtimeDependencyFeasibilityTrialDefaultOffLatestPhase'], GaussAndroidNativeBridgeMinimalHealthcheckQ317Policy.sourcePhase);
    expect(q317['phase'], GaussAndroidNativeBridgeMinimalHealthcheckQ317Policy.phase);
    expect(q317['sourcePhase'], GaussAndroidNativeBridgeMinimalHealthcheckQ317Policy.sourcePhase);
    expect(q317['q315Sha256MatchesExpected'], isTrue);
    expect(q317['q315RuntimeAccepted'], isFalse);
    expect(q317['nativeChannelName'], 'mathpro/ocr_runtime_bridge');
    expect(q317['featureFlagDefaultEnabled'], isFalse);
    expect(q317['mainActivityChanged'], isTrue);
    expect(q317['protectedMainActivityChangeDeclared'], isTrue);
    expect(q317['runtimeDependencyAdded'], isFalse);
    expect(q317['modelArtifactAcceptedForRuntime'], isFalse);
    expect(q317['ocrPassClaimed'], isFalse);
    expect(q317['androidRealDevicePassClaimed'], isFalse);
  });

  test('q317 MainActivity contains only default-off ping healthcheck bridge', () {
    final mainActivity = File('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt').readAsStringSync();

    expect(mainActivity, contains('private val ocrRuntimeBridgeChannelName = "mathpro/ocr_runtime_bridge"'));
    expect(mainActivity, contains('private val q317RuntimeBridgeFeatureEnabled = false'));
    expect(mainActivity, contains('"ping", "healthCheck" -> result.success(q317OcrRuntimeBridgeHealthcheck(call.method))'));
    expect(mainActivity, contains('"status" to "NATIVE_BRIDGE_HEALTHCHECK_AVAILABLE_DEFAULT_OFF"'));
    expect(mainActivity, contains('"runtimeDependencyAdded" to false'));
    expect(mainActivity, contains('"runtimeStartupExecuted" to false'));
    expect(mainActivity, contains('"modelArtifactAcceptedForRuntime" to false'));
    expect(mainActivity, contains('"imageToLatexInferenceExecuted" to false'));
    expect(mainActivity, contains('"ocrPassClaimed" to false'));
    expect(mainActivity, isNot(contains('PaddleOCR(')));
    expect(mainActivity, isNot(contains('loadModel')));
    expect(mainActivity, isNot(contains('runInference')));
  });

  test('q317 changed files declare protected MainActivity change and no forbidden runtime dependency', () {
    final changed = File('docs/audit/V172_Q317_CHANGED_FILES.md').readAsStringSync();
    final pubspec = File('pubspec.yaml').readAsStringSync().toLowerCase();
    final manifest = File('android/app/src/main/AndroidManifest.xml').readAsStringSync();

    expect(changed, contains('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt'));
    expect(changed, contains('Protected Runtime File Intentionally Modified'));
    expect(changed, contains('default-off OCR runtime bridge MethodChannel ping and healthCheck only'));
    expect(File('docs/audit/V172_Q317_ANDROID_NATIVE_BRIDGE_MINIMAL_HEALTHCHECK_BEHIND_FLAG_AUDIT.md').existsSync(), isTrue);
    expect(File('tool/verify_android_native_bridge_minimal_healthcheck_behind_flag_v172_q317.mjs').existsSync(), isTrue);
    for (final forbidden in <String>['paddleocr', 'paddle_lite', 'paddle-lite', 'onnxruntime', 'tflite_flutter', 'flutter_downloader', 'workmanager']) {
      expect(pubspec, isNot(contains(forbidden)));
    }
    expect(manifest, isNot(contains('READ_EXTERNAL_STORAGE')));
    expect(manifest, isNot(contains('MANAGE_EXTERNAL_STORAGE')));
  });
}
