import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'v172_q344_binary_bundle_successor_test_helper.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_approved_runtime_dependency_trial_q324.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_approved_runtime_dependency_trial_q324_policy.dart';

const String q327SuccessorPhase = 'V172-Q327-NATIVE-LIBRARY-SOURCE-PACKAGE-APPROVAL-ABI-MATRIX-LOCK';
const String q328SuccessorPhase = 'V172-Q328-NATIVE-LIBRARY-PACKAGE-FILE-HASH-INTAKE-NO-BUNDLE-EVIDENCE-GATE';
const String q329SuccessorPhase = 'V172-Q329-NATIVE-PACKAGE-HASH-EVIDENCE-REVIEW-BINARY-BUNDLE-APPROVAL-GATE';
const String q330SuccessorPhase = 'V172-Q330-BINARY-BUNDLE-TRIAL-JNILIBS-PADDLEPREDICTOR-DEFAULT-OFF';
const String q331SuccessorPhase = 'V172-Q331-NATIVE-PACKAGE-HASH-EVIDENCE-ACCEPTANCE-BUNDLE-PERMISSION-GATE';
const String q332SuccessorPhase = 'V172-Q332-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-BLOCKED-GATE';
const String q333SuccessorPhase = 'V172-Q333-NATIVE-PACKAGE-HASH-EVIDENCE-INTAKE-REAL-BUNDLE-PERMISSION-REVIEW';
const String q334SuccessorPhase = 'V172-Q334-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-PENDING-EVIDENCE-BLOCKED-GATE';

const q325SuccessorPhase = 'V172-Q325-EXPLICIT-RUNTIME-DEPENDENCY-COORDINATE-SELECTION-BUILD-TRIAL-GATE';
const q326SuccessorPhase = 'V172-Q326-NATIVE-LIBRARY-BUILD-TRIAL-APPROVAL-ABI-PACKAGING-PREFLIGHT';

const String q335SuccessorPhase = 'V172-Q335-NATIVE-PACKAGE-HASH-EVIDENCE-COLLECTION-USER-SIDE-NATIVE-PACKAGE-INTAKE';
const String q336SuccessorPhase = 'V172-Q336-NATIVE-PACKAGE-HASH-EVIDENCE-CAPTURE-Q328-JSON-INTAKE';
const String q337SuccessorPhase = 'V172-Q337-NATIVE-PACKAGE-HASH-EVIDENCE-ACCEPTANCE-EXPLICIT-BUNDLE-APPROVAL-GATE';
const String q338SuccessorPhase = 'V172-Q338-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-NO-EVIDENCE-BLOCKED-GATE';
const String q339SuccessorPhase = 'V172-Q339-NATIVE-PACKAGE-HASH-EVIDENCE-CAPTURE-ACTUAL-BUNDLE-PERMISSION-FINAL-CHECK';
const String q340SuccessorPhase = 'V172-Q340-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-EVIDENCE-BLOCKED-GATE';
const String q341SuccessorPhase = 'V172-Q341-NATIVE-PACKAGE-HASH-EVIDENCE-CAPTURE-BUNDLE-EVIDENCE-ACCEPTANCE';
const String q342SuccessorPhase = 'V172-Q342-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-PENDING-EVIDENCE-BLOCKED';

void main() {
  test('q324 manifest records approved runtime dependency trial as blocked default-off envelope only', () {
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
    if (![q327SuccessorPhase, q328SuccessorPhase, q329SuccessorPhase, q330SuccessorPhase, q331SuccessorPhase, q332SuccessorPhase, q333SuccessorPhase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase, 'V172-Q343-NATIVE-PACKAGE-HASH-EVIDENCE-FINAL-ACCEPTANCE-REAL-BUNDLE-UNLOCK-GATE', q344ActualBinaryBundlePhase, q345GradleAbiPackagingBuildTrialPhase, q346NativeLibraryLoadSmokePhase, q347PaddleLitePredictorInstantiateSmokePhase, q348OptimizedModelConversionModelLoaderEvidenceGatePhase, q349RealModelLoadSmokeEvidenceBlockedPhase, q350OptimizedModelArtifactConversionEvidenceIntakePhase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase, q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'].contains(manifest['cameraOcrLatestPhase'])) { expect(<String>[GaussApprovedRuntimeDependencyTrialQ324Policy.phase, q325SuccessorPhase, q326SuccessorPhase, 'V172-Q343-NATIVE-PACKAGE-HASH-EVIDENCE-FINAL-ACCEPTANCE-REAL-BUNDLE-UNLOCK-GATE', q344ActualBinaryBundlePhase, q345GradleAbiPackagingBuildTrialPhase, q346NativeLibraryLoadSmokePhase, q347PaddleLitePredictorInstantiateSmokePhase, q348OptimizedModelConversionModelLoaderEvidenceGatePhase, q349RealModelLoadSmokeEvidenceBlockedPhase, q350OptimizedModelArtifactConversionEvidenceIntakePhase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase, q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'], contains(manifest['cameraOcrLatestPhase'])); }
    if (![q327SuccessorPhase, q328SuccessorPhase, q329SuccessorPhase, q330SuccessorPhase, q331SuccessorPhase, q332SuccessorPhase, q333SuccessorPhase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase, 'V172-Q343-NATIVE-PACKAGE-HASH-EVIDENCE-FINAL-ACCEPTANCE-REAL-BUNDLE-UNLOCK-GATE', q344ActualBinaryBundlePhase, q345GradleAbiPackagingBuildTrialPhase, q346NativeLibraryLoadSmokePhase, q347PaddleLitePredictorInstantiateSmokePhase, q348OptimizedModelConversionModelLoaderEvidenceGatePhase, q349RealModelLoadSmokeEvidenceBlockedPhase, q350OptimizedModelArtifactConversionEvidenceIntakePhase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase, q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'].contains(manifest['activeProductDevelopmentLatestPhase'])) { expect(<String>[GaussApprovedRuntimeDependencyTrialQ324Policy.phase, q325SuccessorPhase, q326SuccessorPhase, 'V172-Q343-NATIVE-PACKAGE-HASH-EVIDENCE-FINAL-ACCEPTANCE-REAL-BUNDLE-UNLOCK-GATE', q344ActualBinaryBundlePhase, q345GradleAbiPackagingBuildTrialPhase, q346NativeLibraryLoadSmokePhase, q347PaddleLitePredictorInstantiateSmokePhase, q348OptimizedModelConversionModelLoaderEvidenceGatePhase, q349RealModelLoadSmokeEvidenceBlockedPhase, q350OptimizedModelArtifactConversionEvidenceIntakePhase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase, q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'], contains(manifest['activeProductDevelopmentLatestPhase'])); }
    expect(manifest['approvedRuntimeDependencyTrialLatestPhase'], GaussApprovedRuntimeDependencyTrialQ324Policy.phase);
    if (manifest['cameraOcrLatestPhase'] == q325SuccessorPhase) {
      expect(manifest['runtimeDependencyCoordinateSelectionBuildTrialGateLatestPhase'], q325SuccessorPhase);
      expect(manifest['v172Q325RuntimeDependencyCoordinateSelectionBuildTrialGate'], isA<Map<String, dynamic>>());
    }

    final q324 = manifest['v172Q324ApprovedRuntimeDependencyTrial'] as Map<String, dynamic>;
    expect(q324['phase'], GaussApprovedRuntimeDependencyTrialQ324Policy.phase);
    expect(q324['sourcePhase'], GaussApprovedRuntimeDependencyTrialQ324Policy.sourcePhase);
    expect(q324['nativeChannelName'], 'mathpro/ocr_runtime_bridge');
    expect(q324['approvedRuntimeDependencyTrialMethod'], 'approvedRuntimeDependencyTrial');
    expect(q324['approvedRuntimeDependencyTrialStatus'],
        'APPROVED_RUNTIME_DEPENDENCY_TRIAL_BLOCKED_PENDING_USER_Q323_FLUTTER_LOG_AND_RUNTIME_COORDINATE_EVIDENCE_DEFAULT_OFF');
    expect(q324['selectedRuntimeDependency'], 'UNSELECTED_PENDING_BUILD_COMPATIBLE_RUNTIME_COORDINATES');
    expect(q324['selectedModelLoader'], 'NONE_PENDING_APPROVED_RUNTIME_DEPENDENCY');
    expect(q324['approvedRuntimeDependencyTrialMethodAdded'], isTrue);
    expect(q324['mainActivityChanged'], isTrue);
    expect(q324['protectedMainActivityChangeDeclared'], isTrue);
    expect(q324['methodChannelBindingExtended'], isTrue);
    expect(q324['q315HashEvidenceProvidedToAssistant'], isTrue);
    expect(q324['q315Sha256MatchesExpected'], isTrue);
    expect(q324['featureFlagDefaultEnabled'], isFalse);
    expect(q324['pubspecChanged'], isFalse);
    expect(q324['gradleChanged'], isFalse);
    expect(q324['androidManifestChanged'], isFalse);
    expect(q324['runtimeDependencyAdded'], isFalse);
    expect(q324['approvedRuntimeDependencySelected'], isFalse);
    expect(q324['nativeModelLoaderAdded'], isFalse);
    expect(q324['modelLoaderAvailable'], isFalse);
    expect(q324['modelLoadAttempted'], isFalse);
    expect(q324['modelLoaded'], isFalse);
    expect(q324['runtimeStartupAttempted'], isFalse);
    expect(q324['runtimeStartupExecuted'], isFalse);
    expect(q324['dummyRuntimeCallExecuted'], isFalse);
    expect(q324['realImageToLatexInferenceExecuted'], isFalse);
    expect(q324['editableMathLiveReviewOpened'], isFalse);
    expect(q324['workspaceImportExecuted'], isFalse);
    expect(q324['ocrPassClaimed'], isFalse);
    expect(q324['androidRealDevicePassClaimed'], isFalse);
  });

  test('q324 Dart policy exposes const trial envelope', () {
    final result = GaussApprovedRuntimeDependencyTrialQ324.evaluate();
    expect(result.phase, GaussApprovedRuntimeDependencyTrialQ324Policy.phase);
    expect(result.sourcePhase, GaussApprovedRuntimeDependencyTrialQ324Policy.sourcePhase);
    expect(result.approvedRuntimeDependencyTrialMethod, 'approvedRuntimeDependencyTrial');
    expect(result.approvedRuntimeDependencyTrialStatus,
        'APPROVED_RUNTIME_DEPENDENCY_TRIAL_BLOCKED_PENDING_USER_Q323_FLUTTER_LOG_AND_RUNTIME_COORDINATE_EVIDENCE_DEFAULT_OFF');
    expect(result.trialEnvelopeFields, contains('dependencyTrialBlockedReason'));
    expect(result.trialEnvelopeFields, contains('approvedRuntimeDependencySelected'));
    expect(result.q324HardBlocks, contains('no-paddle-onnx-tflite-runtime-dependency-in-q324'));
    expect(result.q325EntryCriteria, contains('approved-runtime-dependency-coordinates-selected'));
    expect(result.runtimeDependencyAdded, isFalse);
    expect(result.approvedRuntimeDependencySelected, isFalse);
    expect(result.modelLoaderAvailable, isFalse);
    expect(result.modelLoadAttempted, isFalse);
    expect(result.modelLoaded, isFalse);
    expect(result.ocrPassClaimed, isFalse);
  });

  test('q324 MainActivity bridge adds approved trial method but no runtime dependency or model loader', () {
    final mainActivity = File('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt').readAsStringSync();
    expect(mainActivity,
        contains('private val q324Phase = "V172-Q324-APPROVED-RUNTIME-DEPENDENCY-TRIAL-BEHIND-DEFAULT-OFF-FLAG"'));
    expect(mainActivity, contains('private val q324ApprovedRuntimeDependencyTrialFeatureEnabled = false'));
    expect(mainActivity, contains('"approvedRuntimeDependencyTrial" -> result.success(q324ApprovedRuntimeDependencyTrial(call.method))'));
    expect(mainActivity, contains('private fun q324ApprovedRuntimeDependencyTrial(method: String): Map<String, Any>'));
    expect(mainActivity,
        contains('"status" to q324ApprovedRuntimeDependencyTrialStatus'));
    expect(mainActivity, contains('"dependencyTrialBlockedReason" to "q323-user-flutter-run-and-approved-runtime-coordinates-not-yet-provided-in-q324"'));
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

  test('q324 keeps runtime dependency surfaces locked', () {
    final changed = File('docs/audit/V172_Q324_CHANGED_FILES.md').readAsStringSync();
    expect(changed, contains('Protected Runtime File Intentionally Modified'));
    expect(changed, contains('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt'));
    expect(changed, contains('approved runtime dependency trial envelope method only'));
    expect(changed, contains('pubspec.yaml'));
    expect(changed, contains('AndroidManifest.xml'));

    final pubspec = File('pubspec.yaml').readAsStringSync().toLowerCase();
    expect(pubspec, isNot(contains('paddleocr')));
    expect(pubspec, isNot(contains('paddle_lite')));
    expect(pubspec, isNot(contains('onnxruntime')));
    expect(pubspec, isNot(contains('tflite_flutter')));
  });
}
