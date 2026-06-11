import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'v172_q344_binary_bundle_successor_test_helper.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_first_image_to_latex_inference_envelope_q322.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_first_image_to_latex_inference_envelope_q322_policy.dart';

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
  test('q322 manifest records first image-to-LaTeX inference as blocked default-off envelope only', () {
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
    const q323SuccessorPhase = 'V172-Q323-RUNTIME-DEPENDENCY-MODEL-LOADER-DECISION-IMPLEMENTATION';
const q324SuccessorPhase = 'V172-Q324-APPROVED-RUNTIME-DEPENDENCY-TRIAL-BEHIND-DEFAULT-OFF-FLAG';
const q325SuccessorPhase = 'V172-Q325-EXPLICIT-RUNTIME-DEPENDENCY-COORDINATE-SELECTION-BUILD-TRIAL-GATE';
const q326SuccessorPhase = 'V172-Q326-NATIVE-LIBRARY-BUILD-TRIAL-APPROVAL-ABI-PACKAGING-PREFLIGHT';
    final allowedActivePhases = <String>{
      GaussFirstImageToLatexInferenceEnvelopeQ322Policy.phase,
      q323SuccessorPhase,
      q324SuccessorPhase,
      q325SuccessorPhase,
      q326SuccessorPhase,
    };
    if (![q327SuccessorPhase, q328SuccessorPhase, q329SuccessorPhase, q330SuccessorPhase, q331SuccessorPhase, q332SuccessorPhase, q333SuccessorPhase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase, 'V172-Q343-NATIVE-PACKAGE-HASH-EVIDENCE-FINAL-ACCEPTANCE-REAL-BUNDLE-UNLOCK-GATE', q344ActualBinaryBundlePhase, q345GradleAbiPackagingBuildTrialPhase, q346NativeLibraryLoadSmokePhase, q347PaddleLitePredictorInstantiateSmokePhase, q348OptimizedModelConversionModelLoaderEvidenceGatePhase, q349RealModelLoadSmokeEvidenceBlockedPhase, q350OptimizedModelArtifactConversionEvidenceIntakePhase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase, q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'].contains(manifest['cameraOcrLatestPhase'])) { expect(allowedActivePhases, contains(manifest['cameraOcrLatestPhase'])); }
    if (![q327SuccessorPhase, q328SuccessorPhase, q329SuccessorPhase, q330SuccessorPhase, q331SuccessorPhase, q332SuccessorPhase, q333SuccessorPhase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase, 'V172-Q343-NATIVE-PACKAGE-HASH-EVIDENCE-FINAL-ACCEPTANCE-REAL-BUNDLE-UNLOCK-GATE', q344ActualBinaryBundlePhase, q345GradleAbiPackagingBuildTrialPhase, q346NativeLibraryLoadSmokePhase, q347PaddleLitePredictorInstantiateSmokePhase, q348OptimizedModelConversionModelLoaderEvidenceGatePhase, q349RealModelLoadSmokeEvidenceBlockedPhase, q350OptimizedModelArtifactConversionEvidenceIntakePhase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase, q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'].contains(manifest['activeProductDevelopmentLatestPhase'])) { expect(allowedActivePhases, contains(manifest['activeProductDevelopmentLatestPhase'])); }
    expect(manifest['firstImageToLatexInferenceLatestPhase'], GaussFirstImageToLatexInferenceEnvelopeQ322Policy.phase);
    if (<String>[q323SuccessorPhase, q324SuccessorPhase, q325SuccessorPhase, q326SuccessorPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'].contains(manifest['cameraOcrLatestPhase'])) {
      expect(manifest['runtimeDependencyModelLoaderDecisionLatestPhase'], q323SuccessorPhase);
      expect(manifest['v172Q323RuntimeDependencyModelLoaderDecision'], isA<Map<String, dynamic>>());
    }

    final q322 = manifest['v172Q322FirstImageToLatexInferenceEnvelope'] as Map<String, dynamic>;
    expect(q322['phase'], GaussFirstImageToLatexInferenceEnvelopeQ322Policy.phase);
    expect(q322['sourcePhase'], GaussFirstImageToLatexInferenceEnvelopeQ322Policy.sourcePhase);
    expect(q322['nativeChannelName'], 'mathpro/ocr_runtime_bridge');
    expect(q322['firstImageToLatexInferenceMethod'], 'firstImageToLatexInference');
    expect(q322['firstImageToLatexInferenceStatus'], 'FIRST_IMAGE_TO_LATEX_INFERENCE_BLOCKED_NO_RUNTIME_DEPENDENCY_DEFAULT_OFF');
    expect(q322['expectedInferencePdiparamsSha256'], GaussFirstImageToLatexInferenceEnvelopeQ322Policy.expectedInferencePdiparamsSha256);
    expect(q322['expectedInferencePdiparamsSizeBytes'], 231675001);
    expect(q322['q315HashEvidenceProvidedToAssistant'], isTrue);
    expect(q322['q315Sha256MatchesExpected'], isTrue);
    expect(q322['q321DummyRuntimeCallMethodAdded'], isTrue);
    expect(q322['firstImageToLatexInferenceMethodAdded'], isTrue);
    expect(q322['mainActivityChanged'], isTrue);
    expect(q322['protectedMainActivityChangeDeclared'], isTrue);
    expect(q322['methodChannelBindingExtended'], isTrue);
    expect(q322['featureFlagDefaultEnabled'], isFalse);
    expect(q322['pubspecChanged'], isFalse);
    expect(q322['gradleChanged'], isFalse);
    expect(q322['androidManifestChanged'], isFalse);
    expect(q322['runtimeDependencyAdded'], isFalse);
    expect(q322['paddleRuntimeDependencyAdded'], isFalse);
    expect(q322['paddleOcrDependencyAdded'], isFalse);
    expect(q322['onnxRuntimeDependencyAdded'], isFalse);
    expect(q322['tfliteRuntimeDependencyAdded'], isFalse);
    expect(q322['jniNativeHandlerAdded'], isFalse);
    expect(q322['nativeModelLoaderAdded'], isFalse);
    expect(q322['modelArtifactAcceptedForRuntime'], isFalse);
    expect(q322['runtimeStartupAttempted'], isFalse);
    expect(q322['runtimeStartupExecuted'], isFalse);
    expect(q322['dummyRuntimeCallAttempted'], isFalse);
    expect(q322['dummyRuntimeCallExecuted'], isFalse);
    expect(q322['imageInputAccepted'], isFalse);
    expect(q322['realImageToLatexInferenceAttempted'], isFalse);
    expect(q322['realImageToLatexInferenceExecuted'], isFalse);
    expect(q322['realImageToLatexInferencePassed'], isFalse);
    expect(q322['editableMathLiveReviewOpened'], isFalse);
    expect(q322['workspaceImportExecuted'], isFalse);
    expect(q322['ocrPassClaimed'], isFalse);
    expect(q322['androidRealDevicePassClaimed'], isFalse);
  });

  test('q322 Dart policy exposes a const first image-to-LaTeX envelope', () {
    final result = GaussFirstImageToLatexInferenceEnvelopeQ322.evaluate();
    expect(result.phase, GaussFirstImageToLatexInferenceEnvelopeQ322Policy.phase);
    expect(result.sourcePhase, GaussFirstImageToLatexInferenceEnvelopeQ322Policy.sourcePhase);
    expect(result.firstImageToLatexInferenceMethod, 'firstImageToLatexInference');
    expect(result.firstImageToLatexInferenceStatus, 'FIRST_IMAGE_TO_LATEX_INFERENCE_BLOCKED_NO_RUNTIME_DEPENDENCY_DEFAULT_OFF');
    expect(result.firstImageToLatexInferenceEnvelopeFields, contains('inferenceBlockedReason'));
    expect(result.firstImageToLatexInferenceEnvelopeFields, contains('candidateLatex'));
    expect(result.q322HardBlocks, contains('no-real-image-to-latex-execution-in-q322'));
    expect(result.q323EntryCriteria, contains('runtime-dependency-selection-approved-before-real-image-to-latex-execution'));
    expect(result.runtimeDependencyAdded, isFalse);
    expect(result.imageInputAccepted, isFalse);
    expect(result.realImageToLatexInferenceAttempted, isFalse);
    expect(result.realImageToLatexInferenceExecuted, isFalse);
    expect(result.ocrPassClaimed, isFalse);
  });

  test('q322 MainActivity bridge adds firstImageToLatexInference but no inference execution', () {
    final mainActivity = File('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt').readAsStringSync();
    expect(mainActivity, contains('private val q322Phase = "V172-Q322-FIRST-IMAGE-TO-LATEX-INFERENCE-ENVELOPE"'));
    expect(mainActivity, contains('private val q322FirstImageToLatexFeatureEnabled = false'));
    expect(mainActivity, contains('"firstImageToLatexInference" -> result.success(q322FirstImageToLatexInference(call.method))'));
    expect(mainActivity, contains('private fun q322FirstImageToLatexInference(method: String): Map<String, Any>'));
    expect(mainActivity, contains('"status" to "FIRST_IMAGE_TO_LATEX_INFERENCE_BLOCKED_NO_RUNTIME_DEPENDENCY_DEFAULT_OFF"'));
    expect(mainActivity, contains('"inferenceBlockedReason" to "no-runtime-dependency-bound-in-q322"'));
    expect(mainActivity, contains('"imageInputAccepted" to false'));
    expect(mainActivity, contains('"candidateLatex" to ""'));
    expect(mainActivity, contains('"realImageToLatexInferenceAttempted" to false'));
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

  test('q322 keeps protected runtime surfaces unchanged except declared MainActivity bridge extension', () {
    final changed = File('docs/audit/V172_Q322_CHANGED_FILES.md').readAsStringSync();
    expect(changed, contains('Protected Runtime File Intentionally Modified'));
    expect(changed, contains('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt'));
    expect(changed, contains('default-off first image-to-LaTeX inference envelope method only'));
    expect(changed, contains('pubspec.yaml'));
    expect(changed, contains('AndroidManifest.xml'));

    final pubspec = File('pubspec.yaml').readAsStringSync().toLowerCase();
    expect(pubspec, isNot(contains('paddleocr')));
    expect(pubspec, isNot(contains('paddle_lite')));
    expect(pubspec, isNot(contains('onnxruntime')));
    expect(pubspec, isNot(contains('tflite_flutter')));
  });
}
