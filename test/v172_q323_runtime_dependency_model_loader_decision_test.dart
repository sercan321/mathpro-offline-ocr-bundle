import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'v172_q344_binary_bundle_successor_test_helper.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_runtime_dependency_model_loader_decision_q323.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_runtime_dependency_model_loader_decision_q323_policy.dart';

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
  test('q323 manifest records runtime dependency and model loader decision as blocked default-off envelope only', () {
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
    const q324SuccessorPhase = 'V172-Q324-APPROVED-RUNTIME-DEPENDENCY-TRIAL-BEHIND-DEFAULT-OFF-FLAG';
const q325SuccessorPhase = 'V172-Q325-EXPLICIT-RUNTIME-DEPENDENCY-COORDINATE-SELECTION-BUILD-TRIAL-GATE';
const q326SuccessorPhase = 'V172-Q326-NATIVE-LIBRARY-BUILD-TRIAL-APPROVAL-ABI-PACKAGING-PREFLIGHT';
    if (![q327SuccessorPhase, q328SuccessorPhase, q329SuccessorPhase, q330SuccessorPhase, q331SuccessorPhase, q332SuccessorPhase, q333SuccessorPhase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase, 'V172-Q343-NATIVE-PACKAGE-HASH-EVIDENCE-FINAL-ACCEPTANCE-REAL-BUNDLE-UNLOCK-GATE', q344ActualBinaryBundlePhase, q345GradleAbiPackagingBuildTrialPhase, q346NativeLibraryLoadSmokePhase, q347PaddleLitePredictorInstantiateSmokePhase, q348OptimizedModelConversionModelLoaderEvidenceGatePhase, q349RealModelLoadSmokeEvidenceBlockedPhase, q350OptimizedModelArtifactConversionEvidenceIntakePhase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase, q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'].contains(manifest['cameraOcrLatestPhase'])) { expect(<String>[GaussRuntimeDependencyModelLoaderDecisionQ323Policy.phase, q324SuccessorPhase, q325SuccessorPhase, q326SuccessorPhase, 'V172-Q343-NATIVE-PACKAGE-HASH-EVIDENCE-FINAL-ACCEPTANCE-REAL-BUNDLE-UNLOCK-GATE', q344ActualBinaryBundlePhase, q345GradleAbiPackagingBuildTrialPhase, q346NativeLibraryLoadSmokePhase, q347PaddleLitePredictorInstantiateSmokePhase, q348OptimizedModelConversionModelLoaderEvidenceGatePhase, q349RealModelLoadSmokeEvidenceBlockedPhase, q350OptimizedModelArtifactConversionEvidenceIntakePhase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase, q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'], contains(manifest['cameraOcrLatestPhase'])); }
    if (![q327SuccessorPhase, q328SuccessorPhase, q329SuccessorPhase, q330SuccessorPhase, q331SuccessorPhase, q332SuccessorPhase, q333SuccessorPhase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase, 'V172-Q343-NATIVE-PACKAGE-HASH-EVIDENCE-FINAL-ACCEPTANCE-REAL-BUNDLE-UNLOCK-GATE', q344ActualBinaryBundlePhase, q345GradleAbiPackagingBuildTrialPhase, q346NativeLibraryLoadSmokePhase, q347PaddleLitePredictorInstantiateSmokePhase, q348OptimizedModelConversionModelLoaderEvidenceGatePhase, q349RealModelLoadSmokeEvidenceBlockedPhase, q350OptimizedModelArtifactConversionEvidenceIntakePhase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase, q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'].contains(manifest['activeProductDevelopmentLatestPhase'])) { expect(<String>[GaussRuntimeDependencyModelLoaderDecisionQ323Policy.phase, q324SuccessorPhase, q325SuccessorPhase, q326SuccessorPhase, 'V172-Q343-NATIVE-PACKAGE-HASH-EVIDENCE-FINAL-ACCEPTANCE-REAL-BUNDLE-UNLOCK-GATE', q344ActualBinaryBundlePhase, q345GradleAbiPackagingBuildTrialPhase, q346NativeLibraryLoadSmokePhase, q347PaddleLitePredictorInstantiateSmokePhase, q348OptimizedModelConversionModelLoaderEvidenceGatePhase, q349RealModelLoadSmokeEvidenceBlockedPhase, q350OptimizedModelArtifactConversionEvidenceIntakePhase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase, q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'], contains(manifest['activeProductDevelopmentLatestPhase'])); }
    expect(manifest['runtimeDependencyModelLoaderDecisionLatestPhase'], GaussRuntimeDependencyModelLoaderDecisionQ323Policy.phase);
    if (<String>[q324SuccessorPhase, q325SuccessorPhase, q326SuccessorPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'].contains(manifest['cameraOcrLatestPhase'])) {
      expect(manifest['approvedRuntimeDependencyTrialLatestPhase'], q324SuccessorPhase);
      expect(manifest['v172Q324ApprovedRuntimeDependencyTrial'], isA<Map<String, dynamic>>());
    }

    final q323 = manifest['v172Q323RuntimeDependencyModelLoaderDecision'] as Map<String, dynamic>;
    expect(q323['phase'], GaussRuntimeDependencyModelLoaderDecisionQ323Policy.phase);
    expect(q323['sourcePhase'], GaussRuntimeDependencyModelLoaderDecisionQ323Policy.sourcePhase);
    expect(q323['nativeChannelName'], 'mathpro/ocr_runtime_bridge');
    expect(q323['runtimeDependencyModelLoaderDecisionMethod'], 'runtimeDependencyModelLoaderDecision');
    expect(q323['runtimeDependencyModelLoaderDecisionStatus'],
        'RUNTIME_DEPENDENCY_MODEL_LOADER_DECISION_BLOCKED_PENDING_APPROVED_RUNTIME_EVIDENCE_DEFAULT_OFF');
    expect(q323['selectedRuntimeDependency'], 'UNSELECTED_PENDING_APPROVED_ANDROID_COMPATIBLE_RUNTIME_EVIDENCE');
    expect(q323['selectedModelLoader'], 'NONE_PENDING_APPROVED_RUNTIME_DEPENDENCY');
    expect(q323['runtimeDependencyModelLoaderDecisionMethodAdded'], isTrue);
    expect(q323['mainActivityChanged'], isTrue);
    expect(q323['protectedMainActivityChangeDeclared'], isTrue);
    expect(q323['methodChannelBindingExtended'], isTrue);
    expect(q323['featureFlagDefaultEnabled'], isFalse);
    expect(q323['pubspecChanged'], isFalse);
    expect(q323['gradleChanged'], isFalse);
    expect(q323['androidManifestChanged'], isFalse);
    expect(q323['runtimeDependencyAdded'], isFalse);
    expect(q323['approvedRuntimeDependencySelected'], isFalse);
    expect(q323['nativeModelLoaderAdded'], isFalse);
    expect(q323['modelLoaderAvailable'], isFalse);
    expect(q323['modelLoadAttempted'], isFalse);
    expect(q323['modelLoaded'], isFalse);
    expect(q323['runtimeStartupAttempted'], isFalse);
    expect(q323['runtimeStartupExecuted'], isFalse);
    expect(q323['dummyRuntimeCallExecuted'], isFalse);
    expect(q323['realImageToLatexInferenceExecuted'], isFalse);
    expect(q323['editableMathLiveReviewOpened'], isFalse);
    expect(q323['workspaceImportExecuted'], isFalse);
    expect(q323['ocrPassClaimed'], isFalse);
    expect(q323['androidRealDevicePassClaimed'], isFalse);
  });

  test('q323 Dart policy exposes const dependency decision envelope', () {
    final result = GaussRuntimeDependencyModelLoaderDecisionQ323.evaluate();
    expect(result.phase, GaussRuntimeDependencyModelLoaderDecisionQ323Policy.phase);
    expect(result.sourcePhase, GaussRuntimeDependencyModelLoaderDecisionQ323Policy.sourcePhase);
    expect(result.runtimeDependencyModelLoaderDecisionMethod, 'runtimeDependencyModelLoaderDecision');
    expect(result.runtimeDependencyModelLoaderDecisionStatus,
        'RUNTIME_DEPENDENCY_MODEL_LOADER_DECISION_BLOCKED_PENDING_APPROVED_RUNTIME_EVIDENCE_DEFAULT_OFF');
    expect(result.decisionEnvelopeFields, contains('dependencyDecisionBlockedReason'));
    expect(result.decisionEnvelopeFields, contains('approvedRuntimeDependencySelected'));
    expect(result.q323HardBlocks, contains('no-paddle-onnx-tflite-runtime-dependency-in-q323'));
    expect(result.q324EntryCriteria, contains('approved-android-compatible-runtime-dependency-before-pubspec-or-gradle-mutation'));
    expect(result.runtimeDependencyAdded, isFalse);
    expect(result.approvedRuntimeDependencySelected, isFalse);
    expect(result.modelLoaderAvailable, isFalse);
    expect(result.modelLoadAttempted, isFalse);
    expect(result.modelLoaded, isFalse);
    expect(result.ocrPassClaimed, isFalse);
  });

  test('q323 MainActivity bridge adds decision method but no runtime dependency or model loader', () {
    final mainActivity = File('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt').readAsStringSync();
    expect(mainActivity, contains('private val q323Phase = "V172-Q323-RUNTIME-DEPENDENCY-MODEL-LOADER-DECISION-IMPLEMENTATION"'));
    expect(mainActivity, contains('private val q323RuntimeDependencyDecisionFeatureEnabled = false'));
    expect(mainActivity, contains('"runtimeDependencyModelLoaderDecision" -> result.success(q323RuntimeDependencyModelLoaderDecision(call.method))'));
    expect(mainActivity, contains('private fun q323RuntimeDependencyModelLoaderDecision(method: String): Map<String, Any>'));
    expect(mainActivity, contains('"status" to "RUNTIME_DEPENDENCY_MODEL_LOADER_DECISION_BLOCKED_PENDING_APPROVED_RUNTIME_EVIDENCE_DEFAULT_OFF"'));
    expect(mainActivity, contains('"dependencyDecisionBlockedReason" to "approved-android-compatible-runtime-dependency-not-yet-selected-in-q323"'));
    expect(mainActivity, contains('"runtimeDependencyAdded" to false'));
    expect(mainActivity, contains('"approvedRuntimeDependencySelected" to false'));
    expect(mainActivity, contains('"modelLoaderAvailable" to false'));
    expect(mainActivity, contains('"modelLoadAttempted" to false'));
    expect(mainActivity, contains('"modelLoaded" to false'));
    expect(mainActivity, isNot(contains('PaddleOCR(')));
    if (!isQ347OrLaterPaddleLiteBridgeActive()) {
      expect(mainActivity, isNot(contains('PaddleLite(')));
    } else {
      expect(mainActivity, contains('private val q347Phase = "V172-Q347-PADDLE-LITE-PREDICTOR-INSTANTIATE-SMOKE"'));
      expect(mainActivity, contains('private val q347FeatureEnabled = false'));
    }
    expect(mainActivity, isNot(contains('OnnxRuntime(')));
    expect(mainActivity, isNot(contains('loadModel(')));
    expect(mainActivity, isNot(contains('runInference(')));
  });

  test('q323 keeps runtime dependency surfaces locked', () {
    final changed = File('docs/audit/V172_Q323_CHANGED_FILES.md').readAsStringSync();
    expect(changed, contains('Protected Runtime File Intentionally Modified'));
    expect(changed, contains('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt'));
    expect(changed, contains('runtime dependency/model loader decision envelope method only'));
    expect(changed, contains('pubspec.yaml'));
    expect(changed, contains('AndroidManifest.xml'));

    final pubspec = File('pubspec.yaml').readAsStringSync().toLowerCase();
    expect(pubspec, isNot(contains('paddleocr')));
    expect(pubspec, isNot(contains('paddle_lite')));
    expect(pubspec, isNot(contains('onnxruntime')));
    expect(pubspec, isNot(contains('tflite_flutter')));
  });
}
