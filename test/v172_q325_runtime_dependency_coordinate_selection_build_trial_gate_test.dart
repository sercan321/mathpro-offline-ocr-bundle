import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'v172_q344_binary_bundle_successor_test_helper.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_runtime_dependency_coordinate_selection_build_trial_gate_q325.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_runtime_dependency_coordinate_selection_build_trial_gate_q325_policy.dart';

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
  test('q325 manifest records explicit runtime coordinate candidate without dependency mutation', () {
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
    const q326SuccessorPhase = 'V172-Q326-NATIVE-LIBRARY-BUILD-TRIAL-APPROVAL-ABI-PACKAGING-PREFLIGHT';
    const allowedActivePhases = <String>[
      GaussRuntimeDependencyCoordinateSelectionBuildTrialGateQ325Policy.phase,
      q326SuccessorPhase,
    ];
    if (![q327SuccessorPhase, q328SuccessorPhase, q329SuccessorPhase, q330SuccessorPhase, q331SuccessorPhase, q332SuccessorPhase, q333SuccessorPhase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase, 'V172-Q343-NATIVE-PACKAGE-HASH-EVIDENCE-FINAL-ACCEPTANCE-REAL-BUNDLE-UNLOCK-GATE', q344ActualBinaryBundlePhase, q345GradleAbiPackagingBuildTrialPhase, q346NativeLibraryLoadSmokePhase, q347PaddleLitePredictorInstantiateSmokePhase, q348OptimizedModelConversionModelLoaderEvidenceGatePhase, q349RealModelLoadSmokeEvidenceBlockedPhase, q350OptimizedModelArtifactConversionEvidenceIntakePhase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase, q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'].contains(manifest['cameraOcrLatestPhase'])) { expect(allowedActivePhases, contains(manifest['cameraOcrLatestPhase'])); }
    if (![q327SuccessorPhase, q328SuccessorPhase, q329SuccessorPhase, q330SuccessorPhase, q331SuccessorPhase, q332SuccessorPhase, q333SuccessorPhase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase, 'V172-Q343-NATIVE-PACKAGE-HASH-EVIDENCE-FINAL-ACCEPTANCE-REAL-BUNDLE-UNLOCK-GATE', q344ActualBinaryBundlePhase, q345GradleAbiPackagingBuildTrialPhase, q346NativeLibraryLoadSmokePhase, q347PaddleLitePredictorInstantiateSmokePhase, q348OptimizedModelConversionModelLoaderEvidenceGatePhase, q349RealModelLoadSmokeEvidenceBlockedPhase, q350OptimizedModelArtifactConversionEvidenceIntakePhase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase, q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'].contains(manifest['activeProductDevelopmentLatestPhase'])) { expect(allowedActivePhases, contains(manifest['activeProductDevelopmentLatestPhase'])); }
    expect(manifest['runtimeDependencyCoordinateSelectionBuildTrialGateLatestPhase'],
        GaussRuntimeDependencyCoordinateSelectionBuildTrialGateQ325Policy.phase);
    if (manifest['cameraOcrLatestPhase'] == q326SuccessorPhase) {
      expect(manifest['nativeLibraryBuildTrialApprovalAbiPackagingPreflightLatestPhase'], q326SuccessorPhase);
      expect(manifest['v172Q326NativeLibraryBuildTrialApprovalAbiPackagingPreflight'], isA<Map<String, dynamic>>());
    }

    final q325 = manifest['v172Q325RuntimeDependencyCoordinateSelectionBuildTrialGate'] as Map<String, dynamic>;
    expect(q325['phase'], GaussRuntimeDependencyCoordinateSelectionBuildTrialGateQ325Policy.phase);
    expect(q325['sourcePhase'], GaussRuntimeDependencyCoordinateSelectionBuildTrialGateQ325Policy.sourcePhase);
    expect(q325['nativeChannelName'], 'mathpro/ocr_runtime_bridge');
    expect(q325['runtimeDependencyCoordinateSelectionMethod'], 'runtimeDependencyCoordinateSelection');
    expect(q325['runtimeDependencyCoordinateSelectionStatus'],
        'RUNTIME_DEPENDENCY_COORDINATE_SELECTION_RECORDED_BUILD_TRIAL_BLOCKED_NO_GRADLE_MUTATION_DEFAULT_OFF');
    expect(q325['selectedRuntimeDependencyCandidate'], 'PADDLE_LITE_ANDROID_NATIVE_LIBRARY_MANUAL_TRIAL_PENDING');
    expect(q325['selectedModelLoaderCandidate'],
        'PADDLE_LITE_OPTIMIZED_PADDLE_INFERENCE_MODEL_LOADER_PENDING_CONVERSION_EVIDENCE');
    expect(q325['selectedRuntimeDependencyCoordinate'],
        'NO_MAVEN_COORDINATE_SELECTED_MANUAL_NATIVE_LIBRARY_TRIAL_REQUIRED');
    expect(q325['runtimeDependencyCoordinateSelectionMethodAdded'], isTrue);
    expect(q325['mainActivityChanged'], isTrue);
    expect(q325['protectedMainActivityChangeDeclared'], isTrue);
    expect(q325['methodChannelBindingExtended'], isTrue);
    expect(q325['q315HashEvidenceProvidedToAssistant'], isTrue);
    expect(q325['q315Sha256MatchesExpected'], isTrue);
    expect(q325['featureFlagDefaultEnabled'], isFalse);
    expect(q325['pubspecChanged'], isFalse);
    expect(q325['gradleChanged'], isFalse);
    expect(q325['androidManifestChanged'], isFalse);
    expect(q325['runtimeDependencyAdded'], isFalse);
    expect(q325['runtimeDependencyCoordinateSelected'], isTrue);
    expect(q325['approvedRuntimeDependencySelected'], isFalse);
    expect(q325['nativeLibraryBundled'], isFalse);
    expect(q325['buildTrialExecuted'], isFalse);
    expect(q325['buildTrialPassed'], isFalse);
    expect(q325['nativeModelLoaderAdded'], isFalse);
    expect(q325['modelLoaderAvailable'], isFalse);
    expect(q325['modelLoadAttempted'], isFalse);
    expect(q325['modelLoaded'], isFalse);
    expect(q325['runtimeStartupAttempted'], isFalse);
    expect(q325['runtimeStartupExecuted'], isFalse);
    expect(q325['dummyRuntimeCallExecuted'], isFalse);
    expect(q325['realImageToLatexInferenceExecuted'], isFalse);
    expect(q325['editableMathLiveReviewOpened'], isFalse);
    expect(q325['workspaceImportExecuted'], isFalse);
    expect(q325['ocrPassClaimed'], isFalse);
    expect(q325['androidRealDevicePassClaimed'], isFalse);
  });

  test('q325 Dart policy exposes const coordinate selection envelope', () {
    final result = GaussRuntimeDependencyCoordinateSelectionBuildTrialGateQ325.evaluate();
    expect(result.phase, GaussRuntimeDependencyCoordinateSelectionBuildTrialGateQ325Policy.phase);
    expect(result.sourcePhase, GaussRuntimeDependencyCoordinateSelectionBuildTrialGateQ325Policy.sourcePhase);
    expect(result.runtimeDependencyCoordinateSelectionMethod, 'runtimeDependencyCoordinateSelection');
    expect(result.runtimeDependencyCoordinateSelectionStatus,
        'RUNTIME_DEPENDENCY_COORDINATE_SELECTION_RECORDED_BUILD_TRIAL_BLOCKED_NO_GRADLE_MUTATION_DEFAULT_OFF');
    expect(result.selectedRuntimeDependencyCandidate, 'PADDLE_LITE_ANDROID_NATIVE_LIBRARY_MANUAL_TRIAL_PENDING');
    expect(result.selectedRuntimeDependencyCoordinate,
        'NO_MAVEN_COORDINATE_SELECTED_MANUAL_NATIVE_LIBRARY_TRIAL_REQUIRED');
    expect(result.candidateRuntimePaths, contains('paddle-lite-native-android-library-manual-integration-candidate'));
    expect(result.buildTrialEnvelopeFields, contains('buildTrialBlockedReason'));
    expect(result.q325HardBlocks, contains('no-pubspec-gradle-androidmanifest-mutation-in-q325'));
    expect(result.q326EntryCriteria, contains('explicit-native-library-build-trial-approved-by-user'));
    expect(result.runtimeDependencyAdded, isFalse);
    expect(result.runtimeDependencyCoordinateSelected, isTrue);
    expect(result.buildTrialExecuted, isFalse);
    expect(result.nativeLibraryBundled, isFalse);
    expect(result.modelLoaderAvailable, isFalse);
    expect(result.ocrPassClaimed, isFalse);
  });

  test('q325 MainActivity bridge adds coordinate selection method but no dependency or loader', () {
    final mainActivity = File('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt').readAsStringSync();
    expect(mainActivity,
        contains('private val q325Phase = "V172-Q325-EXPLICIT-RUNTIME-DEPENDENCY-COORDINATE-SELECTION-BUILD-TRIAL-GATE"'));
    expect(mainActivity, contains('private val q325RuntimeDependencyCoordinateSelectionFeatureEnabled = false'));
    expect(mainActivity,
        contains('"runtimeDependencyCoordinateSelection" -> result.success(q325RuntimeDependencyCoordinateSelection(call.method))'));
    expect(mainActivity, contains('private fun q325RuntimeDependencyCoordinateSelection(method: String): Map<String, Any>'));
    expect(mainActivity, contains('"status" to q325RuntimeDependencyCoordinateSelectionStatus'));
    expect(mainActivity, contains('"buildTrialBlockedReason" to "q325-records-explicit-candidate-but-does-not-mutate-gradle-or-bundle-native-library"'));
    expect(mainActivity, contains('"runtimeDependencyAdded" to false'));
    expect(mainActivity, contains('"runtimeDependencyCoordinateSelected" to true'));
    expect(mainActivity, contains('"nativeLibraryBundled" to false'));
    expect(mainActivity, contains('"buildTrialExecuted" to false'));
    expect(mainActivity, contains('"modelLoaderAvailable" to false'));
    expect(mainActivity, contains('"realImageToLatexInferenceExecuted" to false'));
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

  test('q325 keeps runtime dependency surfaces locked', () {
    final pubspec = File('pubspec.yaml').readAsStringSync().toLowerCase();
    expect(pubspec, isNot(contains('paddleocr')));
    expect(pubspec, isNot(contains('paddle_lite')));
    expect(pubspec, isNot(contains('onnxruntime')));
    expect(pubspec, isNot(contains('tflite_flutter')));

    final changed = File('docs/audit/V172_Q325_CHANGED_FILES.md').readAsStringSync();
    expect(changed, contains('Protected Runtime File Intentionally Modified'));
    expect(changed, contains('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt'));
    expect(changed, contains('runtimeDependencyCoordinateSelection'));
  });
}
