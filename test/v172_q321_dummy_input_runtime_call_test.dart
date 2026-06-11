import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'v172_q344_binary_bundle_successor_test_helper.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_dummy_input_runtime_call_q321.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_dummy_input_runtime_call_q321_policy.dart';

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
  test('q321 manifest records dummy runtime call as blocked default-off envelope only', () {
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
    const allowedActivePhases = <String>{
      GaussDummyInputRuntimeCallQ321Policy.phase,
      'V172-Q322-FIRST-IMAGE-TO-LATEX-INFERENCE-ENVELOPE',
      'V172-Q323-RUNTIME-DEPENDENCY-MODEL-LOADER-DECISION-IMPLEMENTATION',
      'V172-Q325-EXPLICIT-RUNTIME-DEPENDENCY-COORDINATE-SELECTION-BUILD-TRIAL-GATE',
      'V172-Q326-NATIVE-LIBRARY-BUILD-TRIAL-APPROVAL-ABI-PACKAGING-PREFLIGHT',
      'V172-Q324-APPROVED-RUNTIME-DEPENDENCY-TRIAL-BEHIND-DEFAULT-OFF-FLAG',
    };
    if (![q327SuccessorPhase, q328SuccessorPhase, q329SuccessorPhase, q330SuccessorPhase, q331SuccessorPhase, q332SuccessorPhase, q333SuccessorPhase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase, 'V172-Q343-NATIVE-PACKAGE-HASH-EVIDENCE-FINAL-ACCEPTANCE-REAL-BUNDLE-UNLOCK-GATE', q344ActualBinaryBundlePhase, q345GradleAbiPackagingBuildTrialPhase, q346NativeLibraryLoadSmokePhase, q347PaddleLitePredictorInstantiateSmokePhase, q348OptimizedModelConversionModelLoaderEvidenceGatePhase, q349RealModelLoadSmokeEvidenceBlockedPhase, q350OptimizedModelArtifactConversionEvidenceIntakePhase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase, q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'].contains(manifest['cameraOcrLatestPhase'])) { expect(allowedActivePhases, contains(manifest['cameraOcrLatestPhase'])); }
    if (![q327SuccessorPhase, q328SuccessorPhase, q329SuccessorPhase, q330SuccessorPhase, q331SuccessorPhase, q332SuccessorPhase, q333SuccessorPhase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase, 'V172-Q343-NATIVE-PACKAGE-HASH-EVIDENCE-FINAL-ACCEPTANCE-REAL-BUNDLE-UNLOCK-GATE', q344ActualBinaryBundlePhase, q345GradleAbiPackagingBuildTrialPhase, q346NativeLibraryLoadSmokePhase, q347PaddleLitePredictorInstantiateSmokePhase, q348OptimizedModelConversionModelLoaderEvidenceGatePhase, q349RealModelLoadSmokeEvidenceBlockedPhase, q350OptimizedModelArtifactConversionEvidenceIntakePhase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase, q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'].contains(manifest['activeProductDevelopmentLatestPhase'])) { expect(allowedActivePhases, contains(manifest['activeProductDevelopmentLatestPhase'])); }
    expect(manifest['dummyInputRuntimeCallLatestPhase'], GaussDummyInputRuntimeCallQ321Policy.phase);

    final q321 = manifest['v172Q321DummyInputRuntimeCall'] as Map<String, dynamic>;
    expect(q321['phase'], GaussDummyInputRuntimeCallQ321Policy.phase);
    expect(q321['sourcePhase'], GaussDummyInputRuntimeCallQ321Policy.sourcePhase);
    expect(q321['nativeChannelName'], 'mathpro/ocr_runtime_bridge');
    expect(q321['dummyRuntimeCallMethod'], 'dummyRuntimeCall');
    expect(q321['dummyRuntimeCallStatus'], 'DUMMY_RUNTIME_CALL_BLOCKED_NO_RUNTIME_DEPENDENCY_DEFAULT_OFF');
    expect(q321['expectedInferencePdiparamsSha256'], GaussDummyInputRuntimeCallQ321Policy.expectedInferencePdiparamsSha256);
    expect(q321['expectedInferencePdiparamsSizeBytes'], 231675001);
    expect(q321['q315HashEvidenceProvidedToAssistant'], isTrue);
    expect(q321['q315Sha256MatchesExpected'], isTrue);
    expect(q321['q319VerifiedArtifactLoadSmokeAdded'], isTrue);
    expect(q321['q320RuntimeStartupSmokeAdded'], isTrue);
    expect(q321['dummyRuntimeCallMethodAdded'], isTrue);
    expect(q321['mainActivityChanged'], isTrue);
    expect(q321['protectedMainActivityChangeDeclared'], isTrue);
    expect(q321['methodChannelBindingExtended'], isTrue);
    expect(q321['featureFlagDefaultEnabled'], isFalse);
    expect(q321['pubspecChanged'], isFalse);
    expect(q321['gradleChanged'], isFalse);
    expect(q321['androidManifestChanged'], isFalse);
    expect(q321['runtimeDependencyAdded'], isFalse);
    expect(q321['paddleRuntimeDependencyAdded'], isFalse);
    expect(q321['paddleOcrDependencyAdded'], isFalse);
    expect(q321['onnxRuntimeDependencyAdded'], isFalse);
    expect(q321['tfliteRuntimeDependencyAdded'], isFalse);
    expect(q321['jniNativeHandlerAdded'], isFalse);
    expect(q321['nativeModelLoaderAdded'], isFalse);
    expect(q321['modelBinaryBundledInBaseApp'], isFalse);
    expect(q321['modelArtifactAcceptedForRuntime'], isFalse);
    expect(q321['runtimeStartupAttempted'], isFalse);
    expect(q321['runtimeStartupExecuted'], isFalse);
    expect(q321['runtimeStartupSmokePassed'], isFalse);
    expect(q321['dummyRuntimeCallAttempted'], isFalse);
    expect(q321['dummyRuntimeCallExecuted'], isFalse);
    expect(q321['dummyRuntimeCallPassed'], isFalse);
    expect(q321['realImageToLatexInferenceExecuted'], isFalse);
    expect(q321['editableMathLiveReviewOpened'], isFalse);
    expect(q321['workspaceImportExecuted'], isFalse);
    expect(q321['ocrPassClaimed'], isFalse);
    expect(q321['androidRealDevicePassClaimed'], isFalse);
  });

  test('q321 Dart policy exposes a const dummy runtime call envelope', () {
    final result = GaussDummyInputRuntimeCallQ321.evaluate();
    expect(result.phase, GaussDummyInputRuntimeCallQ321Policy.phase);
    expect(result.sourcePhase, GaussDummyInputRuntimeCallQ321Policy.sourcePhase);
    expect(result.dummyRuntimeCallMethod, 'dummyRuntimeCall');
    expect(result.dummyRuntimeCallStatus, 'DUMMY_RUNTIME_CALL_BLOCKED_NO_RUNTIME_DEPENDENCY_DEFAULT_OFF');
    expect(result.dummyRuntimeCallEnvelopeFields, contains('dummyRuntimeCallBlockedReason'));
    expect(result.dummyRuntimeCallEnvelopeFields, contains('dummyRuntimeCallExecuted'));
    expect(result.q321HardBlocks, contains('no-paddle-onnx-tflite-runtime-dependency-in-q321'));
    expect(result.q322EntryCriteria, contains('runtime-dependency-selection-approved-before-first-image-to-latex'));
    expect(result.runtimeDependencyAdded, isFalse);
    expect(result.dummyRuntimeCallAttempted, isFalse);
    expect(result.dummyRuntimeCallExecuted, isFalse);
    expect(result.dummyRuntimeCallPassed, isFalse);
    expect(result.ocrPassClaimed, isFalse);
  });

  test('q321 MainActivity bridge adds dummyRuntimeCall but no runtime execution', () {
    final mainActivity = File('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt').readAsStringSync();
    expect(mainActivity, contains('private val q321Phase = "V172-Q321-DUMMY-INPUT-RUNTIME-CALL"'));
    expect(mainActivity, contains('private val q321DummyRuntimeCallFeatureEnabled = false'));
    expect(mainActivity, contains('"dummyRuntimeCall" -> result.success(q321DummyRuntimeCall(call.method))'));
    expect(mainActivity, contains('private fun q321DummyRuntimeCall(method: String): Map<String, Any>'));
    expect(mainActivity, contains('"status" to "DUMMY_RUNTIME_CALL_BLOCKED_NO_RUNTIME_DEPENDENCY_DEFAULT_OFF"'));
    expect(mainActivity, contains('"dummyRuntimeCallBlockedReason" to "no-runtime-dependency-bound-in-q321"'));
    expect(mainActivity, contains('"dummyRuntimeCallAttempted" to false'));
    expect(mainActivity, contains('"dummyRuntimeCallExecuted" to false'));
    expect(mainActivity, contains('"dummyRuntimeCallPassed" to false'));
    expect(mainActivity, contains('"realImageToLatexInferenceExecuted" to false'));
    expect(mainActivity, isNot(contains('runInference(')));
    expect(mainActivity, isNot(contains('PaddleOCR(')));
    if (!isQ347OrLaterPaddleLiteBridgeActive()) {
      expect(mainActivity, isNot(contains('PaddleLite(')));
    } else {
      expect(mainActivity, contains('private val q347Phase = "V172-Q347-PADDLE-LITE-PREDICTOR-INSTANTIATE-SMOKE"'));
      expect(mainActivity, contains('private val q347FeatureEnabled = false'));
    }
  });

  test('q321 keeps protected runtime surfaces unchanged except declared MainActivity bridge extension', () {
    final changed = File('docs/audit/V172_Q321_CHANGED_FILES.md').readAsStringSync();
    expect(changed, contains('Protected Runtime File Intentionally Modified'));
    expect(changed, contains('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt'));
    expect(changed, contains('default-off dummy runtime call envelope method only'));
    expect(changed, contains('pubspec.yaml'));
    expect(changed, contains('AndroidManifest.xml'));

    final pubspec = File('pubspec.yaml').readAsStringSync().toLowerCase();
    expect(pubspec, isNot(contains('paddleocr')));
    expect(pubspec, isNot(contains('paddle_lite')));
    expect(pubspec, isNot(contains('onnxruntime')));
    expect(pubspec, isNot(contains('tflite_flutter')));
  });
}
