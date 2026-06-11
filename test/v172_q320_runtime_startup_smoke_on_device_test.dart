import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'v172_q344_binary_bundle_successor_test_helper.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_runtime_startup_smoke_on_device_q320.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_runtime_startup_smoke_on_device_q320_policy.dart';

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
  test('q320 manifest records runtime startup smoke as blocked default-off preflight only', () {
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
    const q321SuccessorPhase = 'V172-Q321-DUMMY-INPUT-RUNTIME-CALL';
    const q322SuccessorPhase = 'V172-Q322-FIRST-IMAGE-TO-LATEX-INFERENCE-ENVELOPE';
    const q323SuccessorPhase = 'V172-Q323-RUNTIME-DEPENDENCY-MODEL-LOADER-DECISION-IMPLEMENTATION';
const q324SuccessorPhase = 'V172-Q324-APPROVED-RUNTIME-DEPENDENCY-TRIAL-BEHIND-DEFAULT-OFF-FLAG';
const q325SuccessorPhase = 'V172-Q325-EXPLICIT-RUNTIME-DEPENDENCY-COORDINATE-SELECTION-BUILD-TRIAL-GATE';
    if (![q327SuccessorPhase, q328SuccessorPhase, q329SuccessorPhase, q330SuccessorPhase, q331SuccessorPhase, q332SuccessorPhase, q333SuccessorPhase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase, 'V172-Q343-NATIVE-PACKAGE-HASH-EVIDENCE-FINAL-ACCEPTANCE-REAL-BUNDLE-UNLOCK-GATE', q344ActualBinaryBundlePhase, q345GradleAbiPackagingBuildTrialPhase, q346NativeLibraryLoadSmokePhase, q347PaddleLitePredictorInstantiateSmokePhase, q348OptimizedModelConversionModelLoaderEvidenceGatePhase, q349RealModelLoadSmokeEvidenceBlockedPhase, q350OptimizedModelArtifactConversionEvidenceIntakePhase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase, q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'].contains(manifest['cameraOcrLatestPhase'])) { expect(<String>{GaussRuntimeStartupSmokeOnDeviceQ320Policy.phase, q321SuccessorPhase, q322SuccessorPhase, q323SuccessorPhase, q324SuccessorPhase, q325SuccessorPhase, 'V172-Q343-NATIVE-PACKAGE-HASH-EVIDENCE-FINAL-ACCEPTANCE-REAL-BUNDLE-UNLOCK-GATE', q344ActualBinaryBundlePhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'}, contains(manifest['cameraOcrLatestPhase'])); }
    if (![q327SuccessorPhase, q328SuccessorPhase, q329SuccessorPhase, q330SuccessorPhase, q331SuccessorPhase, q332SuccessorPhase, q333SuccessorPhase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase, 'V172-Q343-NATIVE-PACKAGE-HASH-EVIDENCE-FINAL-ACCEPTANCE-REAL-BUNDLE-UNLOCK-GATE', q344ActualBinaryBundlePhase, q345GradleAbiPackagingBuildTrialPhase, q346NativeLibraryLoadSmokePhase, q347PaddleLitePredictorInstantiateSmokePhase, q348OptimizedModelConversionModelLoaderEvidenceGatePhase, q349RealModelLoadSmokeEvidenceBlockedPhase, q350OptimizedModelArtifactConversionEvidenceIntakePhase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase, q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'].contains(manifest['activeProductDevelopmentLatestPhase'])) { expect(<String>{GaussRuntimeStartupSmokeOnDeviceQ320Policy.phase, q321SuccessorPhase, q322SuccessorPhase, q323SuccessorPhase, q324SuccessorPhase, q325SuccessorPhase, 'V172-Q343-NATIVE-PACKAGE-HASH-EVIDENCE-FINAL-ACCEPTANCE-REAL-BUNDLE-UNLOCK-GATE', q344ActualBinaryBundlePhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'}, contains(manifest['activeProductDevelopmentLatestPhase'])); }
    expect(manifest['runtimeStartupSmokeOnDeviceLatestPhase'], GaussRuntimeStartupSmokeOnDeviceQ320Policy.phase);
    expect(manifest['v172Q321DummyInputRuntimeCall'], isNotNull);

    final q320 = manifest['v172Q320RuntimeStartupSmokeOnDevice'] as Map<String, dynamic>;
    expect(q320['phase'], GaussRuntimeStartupSmokeOnDeviceQ320Policy.phase);
    expect(q320['sourcePhase'], GaussRuntimeStartupSmokeOnDeviceQ320Policy.sourcePhase);
    expect(q320['nativeChannelName'], 'mathpro/ocr_runtime_bridge');
    expect(q320['runtimeStartupSmokeMethod'], 'runtimeStartupSmoke');
    expect(q320['runtimeStartupSmokeStatus'], 'RUNTIME_STARTUP_SMOKE_BLOCKED_NO_RUNTIME_DEPENDENCY_DEFAULT_OFF');
    expect(q320['expectedInferencePdiparamsSha256'], GaussRuntimeStartupSmokeOnDeviceQ320Policy.expectedInferencePdiparamsSha256);
    expect(q320['expectedInferencePdiparamsSizeBytes'], 231675001);
    expect(q320['q315HashEvidenceProvidedToAssistant'], isTrue);
    expect(q320['q315Sha256MatchesExpected'], isTrue);
    expect(q320['q319VerifiedArtifactLoadSmokeAdded'], isTrue);
    expect(q320['runtimeStartupSmokeMethodAdded'], isTrue);
    expect(q320['mainActivityChanged'], isTrue);
    expect(q320['protectedMainActivityChangeDeclared'], isTrue);
    expect(q320['methodChannelBindingExtended'], isTrue);
    expect(q320['featureFlagDefaultEnabled'], isFalse);
    expect(q320['pubspecChanged'], isFalse);
    expect(q320['gradleChanged'], isFalse);
    expect(q320['androidManifestChanged'], isFalse);
    expect(q320['runtimeDependencyAdded'], isFalse);
    expect(q320['paddleRuntimeDependencyAdded'], isFalse);
    expect(q320['paddleOcrDependencyAdded'], isFalse);
    expect(q320['onnxRuntimeDependencyAdded'], isFalse);
    expect(q320['tfliteRuntimeDependencyAdded'], isFalse);
    expect(q320['jniNativeHandlerAdded'], isFalse);
    expect(q320['nativeModelLoaderAdded'], isFalse);
    expect(q320['modelBinaryBundledInBaseApp'], isFalse);
    expect(q320['modelArtifactAcceptedForRuntime'], isFalse);
    expect(q320['runtimeStartupAttempted'], isFalse);
    expect(q320['runtimeStartupExecuted'], isFalse);
    expect(q320['runtimeStartupSmokePassed'], isFalse);
    expect(q320['dummyRuntimeCallExecuted'], isFalse);
    expect(q320['realImageToLatexInferenceExecuted'], isFalse);
    expect(q320['editableMathLiveReviewOpened'], isFalse);
    expect(q320['workspaceImportExecuted'], isFalse);
    expect(q320['ocrPassClaimed'], isFalse);
    expect(q320['androidRealDevicePassClaimed'], isFalse);
  });

  test('q320 Dart policy exposes a const runtime startup smoke envelope', () {
    final result = GaussRuntimeStartupSmokeOnDeviceQ320.evaluate();
    expect(result.phase, GaussRuntimeStartupSmokeOnDeviceQ320Policy.phase);
    expect(result.sourcePhase, GaussRuntimeStartupSmokeOnDeviceQ320Policy.sourcePhase);
    expect(result.runtimeStartupSmokeMethod, 'runtimeStartupSmoke');
    expect(result.runtimeStartupSmokeStatus, 'RUNTIME_STARTUP_SMOKE_BLOCKED_NO_RUNTIME_DEPENDENCY_DEFAULT_OFF');
    expect(result.runtimeStartupSmokeEnvelopeFields, contains('runtimeStartupBlockedReason'));
    expect(result.runtimeStartupSmokeEnvelopeFields, contains('runtimeStartupExecuted'));
    expect(result.q320HardBlocks, contains('no-paddle-onnx-tflite-runtime-dependency-in-q320'));
    expect(result.q321EntryCriteria, contains('runtime-dependency-selection-approved-before-dummy-runtime-call'));
    expect(result.runtimeDependencyAdded, isFalse);
    expect(result.runtimeStartupAttempted, isFalse);
    expect(result.runtimeStartupExecuted, isFalse);
    expect(result.runtimeStartupSmokePassed, isFalse);
    expect(result.ocrPassClaimed, isFalse);
  });

  test('q320 MainActivity bridge adds runtimeStartupSmoke but no runtime loader', () {
    final mainActivity = File('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt').readAsStringSync();
    expect(mainActivity, contains('private val q320Phase = "V172-Q320-RUNTIME-STARTUP-SMOKE-ON-DEVICE"'));
    expect(mainActivity, contains('private val q320RuntimeStartupSmokeFeatureEnabled = false'));
    expect(mainActivity, contains('"runtimeStartupSmoke" -> result.success(q320RuntimeStartupSmoke(call.method))'));
    expect(mainActivity, contains('private fun q320RuntimeStartupSmoke(method: String): Map<String, Any>'));
    expect(mainActivity, contains('"status" to "RUNTIME_STARTUP_SMOKE_BLOCKED_NO_RUNTIME_DEPENDENCY_DEFAULT_OFF"'));
    expect(mainActivity, contains('"runtimeStartupBlockedReason" to "no-runtime-dependency-bound-in-q320"'));
    expect(mainActivity, contains('"runtimeStartupAttempted" to false'));
    expect(mainActivity, contains('"runtimeStartupExecuted" to false'));
    expect(mainActivity, contains('"runtimeStartupSmokePassed" to false'));
    expect(mainActivity, contains('"modelLoaderAvailable" to false'));
    expect(mainActivity, isNot(contains('PaddleOCR(')));
    if (!isQ347OrLaterPaddleLiteBridgeActive()) {
      expect(mainActivity, isNot(contains('PaddleLite(')));
    } else {
      expect(mainActivity, contains('private val q347Phase = "V172-Q347-PADDLE-LITE-PREDICTOR-INSTANTIATE-SMOKE"'));
      expect(mainActivity, contains('private val q347FeatureEnabled = false'));
    }
    expect(mainActivity, isNot(contains('loadModel(')));
    expect(mainActivity, isNot(contains('runInference(')));
    expect(mainActivity, isNot(contains('imageToLatex(')));
    expect(mainActivity, isNot(contains('JNIEnv')));
  });
}
