import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'v172_q344_binary_bundle_successor_test_helper.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_controlled_model_artifact_download_hash_capture_q315.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_controlled_model_artifact_download_hash_capture_q315_policy.dart';

const String q327SuccessorPhase = 'V172-Q327-NATIVE-LIBRARY-SOURCE-PACKAGE-APPROVAL-ABI-MATRIX-LOCK';
const String q328SuccessorPhase = 'V172-Q328-NATIVE-LIBRARY-PACKAGE-FILE-HASH-INTAKE-NO-BUNDLE-EVIDENCE-GATE';
const String q329SuccessorPhase = 'V172-Q329-NATIVE-PACKAGE-HASH-EVIDENCE-REVIEW-BINARY-BUNDLE-APPROVAL-GATE';
const String q330SuccessorPhase = 'V172-Q330-BINARY-BUNDLE-TRIAL-JNILIBS-PADDLEPREDICTOR-DEFAULT-OFF';
const String q331SuccessorPhase = 'V172-Q331-NATIVE-PACKAGE-HASH-EVIDENCE-ACCEPTANCE-BUNDLE-PERMISSION-GATE';
const String q332SuccessorPhase = 'V172-Q332-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-BLOCKED-GATE';
const String q333SuccessorPhase = 'V172-Q333-NATIVE-PACKAGE-HASH-EVIDENCE-INTAKE-REAL-BUNDLE-PERMISSION-REVIEW';
const String q334SuccessorPhase = 'V172-Q334-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-PENDING-EVIDENCE-BLOCKED-GATE';

const String q315R1SuccessorPhase =
    'V172-Q315R1-CONTROLLED-MODEL-ARTIFACT-DOWNLOAD-HASH-CAPTURE-FLUTTER-TEST-REPAIR';
const String q316SuccessorPhase = 'V172-Q316-RUNTIME-DEPENDENCY-FEASIBILITY-TRIAL-BEHIND-DEFAULT-OFF-FLAG';
const String q317SuccessorPhase = 'V172-Q317-ANDROID-NATIVE-BRIDGE-MINIMAL-HEALTHCHECK-BEHIND-FLAG';
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
  test('q315 records controlled artifact hash capture without fake local hash claim', () {
    final result = GaussControlledModelArtifactDownloadHashCaptureQ315.evaluate();

    expect(result.phase, GaussControlledModelArtifactDownloadHashCaptureQ315Policy.phase);
    expect(result.sourcePhase, GaussControlledModelArtifactDownloadHashCaptureQ315Policy.sourcePhase);
    expect(result.selectedEngineLabel, 'PP-FormulaNet-S');
    expect(result.implementationScope, contains('controlled-artifact-download-hash-capture'));
    expect(result.captureState, contains('BLOCKED_PENDING_USER_SIDE'));
    expect(result.nextRequiredPhase, contains('Q316'));
    expect(result.primaryRepositoryLocator, 'hf://PaddlePaddle/PP-FormulaNet-S');
    expect(result.primaryRepositoryLicense, 'apache-2.0');
    expect(result.primaryRepositoryTotalSizeLabel, '238 MB');
    expect(result.primaryRequiredArtifactFile, 'inference.pdiparams');
    expect(result.primaryRequiredArtifactSizeLabel, '232 MB');
    expect(result.publishedInferencePdiparamsSha256, hasLength(64));
    expect(
      result.publishedInferencePdiparamsSha256,
      'b6392296d16e2a9f414c0a751d7ccbd1bd9d8272b68aab72df1d3875f35a7489',
    );
    expect(result.officialResolveDownloadUrl, contains('hf-resolve://PaddlePaddle/PP-FormulaNet-S'));
    expect(result.controlledDownloadScript, 'tool/capture_pp_formulanet_s_artifact_hash_v172_q315.mjs');
    expect(result.artifactOutputDirectoryPolicy, '../MathProOcrArtifacts/PP-FormulaNet-S');
    expect(result.localArtifactSha256State, contains('NOT_COMPUTED_IN_ASSISTANT_CONTAINER'));
    expect(result.remoteHashEvidenceState, contains('HF_LARGE_FILE_POINTER_SHA_RECORDED'));
    expect(result.runtimeDecisionState, contains('Q316'));
    expect(result.requiredRepositoryFiles, contains('inference.pdiparams'));
    expect(result.controlledCaptureRequirements, contains('download-artifact-outside-project-root'));
    expect(result.controlledCaptureRequirements, contains('compute-sha256-from-local-downloaded-file'));
    expect(result.q316EntryCriteria, contains('local-artifact-sha256-equals-published-inference-pdiparams-sha256'));
    expect(result.hardBlocksBeforeRuntime, contains('no-runtime-dependency-before-local-hash-match-evidence'));
    expect(result.runtimeBehaviorChanged, isFalse);
    expect(result.cameraOcrRuntimeAdded, isFalse);
    expect(result.controlledDownloadPerformedByAssistant, isFalse);
    expect(result.assistantContainerNetworkBlocked, isTrue);
    expect(result.remoteRepositoryFileInventoryCaptured, isTrue);
    expect(result.remoteLargeFileSha256Recorded, isTrue);
    expect(result.localArtifactSha256Computed, isFalse);
    expect(result.localArtifactSha256MatchedPublishedHash, isFalse);
    expect(result.artifactAcceptedForRuntime, isFalse);
    expect(result.runtimeDependencyAdded, isFalse);
    expect(result.methodChannelBindingAdded, isFalse);
    expect(result.mainActivityChanged, isFalse);
    expect(result.androidManifestChanged, isFalse);
    expect(result.pubspecChanged, isFalse);
    expect(result.modelBinaryBundledInBaseApp, isFalse);
    expect(result.realImageToLatexInferenceExecuted, isFalse);
    expect(result.editableMathLiveReviewOpened, isFalse);
    expect(result.workspaceImportExecuted, isFalse);
    expect(result.ocrPassClaimed, isFalse);
  });

  test('q315 manifest advances active OCR track and preserves Q314 envelope', () {
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
    final q315 = manifest['v172Q315ControlledModelArtifactDownloadHashCapture'] as Map<String, dynamic>;

    const allowedActivePhases = <String>[
      GaussControlledModelArtifactDownloadHashCaptureQ315Policy.phase,
      q315R1SuccessorPhase,
      q316SuccessorPhase,
      q317SuccessorPhase,
      q318SuccessorPhase,
      q319SuccessorPhase,
      q320SuccessorPhase,
      q321SuccessorPhase,
      q322SuccessorPhase,
    ];
    if (![q327SuccessorPhase, q328SuccessorPhase, q329SuccessorPhase, q330SuccessorPhase, q331SuccessorPhase, q332SuccessorPhase, q333SuccessorPhase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase, 'V172-Q343-NATIVE-PACKAGE-HASH-EVIDENCE-FINAL-ACCEPTANCE-REAL-BUNDLE-UNLOCK-GATE', q344ActualBinaryBundlePhase, q345GradleAbiPackagingBuildTrialPhase, q346NativeLibraryLoadSmokePhase, q347PaddleLitePredictorInstantiateSmokePhase, q348OptimizedModelConversionModelLoaderEvidenceGatePhase, q349RealModelLoadSmokeEvidenceBlockedPhase, q350OptimizedModelArtifactConversionEvidenceIntakePhase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase, q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'].contains(manifest['cameraOcrLatestPhase'])) { expect(allowedActivePhases, contains(manifest['cameraOcrLatestPhase'])); }
    if (![q327SuccessorPhase, q328SuccessorPhase, q329SuccessorPhase, q330SuccessorPhase, q331SuccessorPhase, q332SuccessorPhase, q333SuccessorPhase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase, 'V172-Q343-NATIVE-PACKAGE-HASH-EVIDENCE-FINAL-ACCEPTANCE-REAL-BUNDLE-UNLOCK-GATE', q344ActualBinaryBundlePhase, q345GradleAbiPackagingBuildTrialPhase, q346NativeLibraryLoadSmokePhase, q347PaddleLitePredictorInstantiateSmokePhase, q348OptimizedModelConversionModelLoaderEvidenceGatePhase, q349RealModelLoadSmokeEvidenceBlockedPhase, q350OptimizedModelArtifactConversionEvidenceIntakePhase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase, q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'].contains(manifest['activeProductDevelopmentLatestPhase'])) { expect(allowedActivePhases, contains(manifest['activeProductDevelopmentLatestPhase'])); }
    expect(allowedActivePhases, contains(manifest['controlledModelArtifactDownloadHashCaptureLatestPhase']));
    if (manifest['cameraOcrLatestPhase'] == q315R1SuccessorPhase ||
        manifest['cameraOcrLatestPhase'] == q316SuccessorPhase) {
      expect(manifest['v172Q315R1ControlledModelArtifactDownloadHashCaptureFlutterTestRepair'], isA<Map<String, dynamic>>());
    }
    if (manifest['cameraOcrLatestPhase'] == q316SuccessorPhase ||
        manifest['cameraOcrLatestPhase'] == q317SuccessorPhase) {
      expect(manifest['v172Q316RuntimeDependencyFeasibilityTrialDefaultOff'], isA<Map<String, dynamic>>());
    }
    if (manifest['cameraOcrLatestPhase'] == q317SuccessorPhase || manifest['cameraOcrLatestPhase'] == q318SuccessorPhase || manifest['cameraOcrLatestPhase'] == q319SuccessorPhase) {
      expect(manifest['v172Q317AndroidNativeBridgeMinimalHealthcheckBehindFlag'], isA<Map<String, dynamic>>());
    }
    if (manifest['cameraOcrLatestPhase'] == q318SuccessorPhase || manifest['cameraOcrLatestPhase'] == q319SuccessorPhase) {
      expect(manifest['v172Q318PrivateModelDownloadStorageRealImplementation'], isA<Map<String, dynamic>>());
    }
    if (manifest['cameraOcrLatestPhase'] == q319SuccessorPhase) {
      expect(manifest['v172Q319VerifiedArtifactLoadSmokeOnDevice'], isA<Map<String, dynamic>>());
    }
    expect(manifest['v172Q314RealOcrImplementationReadinessArtifactAcquisitionPlan'], isA<Map<String, dynamic>>());
    expect(q315['sourcePhase'], GaussControlledModelArtifactDownloadHashCaptureQ315Policy.sourcePhase);
    expect(q315['publishedInferencePdiparamsSha256'], GaussControlledModelArtifactDownloadHashCaptureQ315Policy.publishedInferencePdiparamsSha256);
    expect(q315['controlledDownloadPerformedByAssistant'], isFalse);
    expect(q315['localArtifactSha256Computed'], isFalse);
    expect(q315['runtimeDependencyAdded'], isFalse);
    expect(q315['methodChannelBindingAdded'], isFalse);
    expect(q315['modelBinaryBundledInBaseApp'], isFalse);
    expect(q315['ocrPassClaimed'], isFalse);
  });

  test('q315 capture script exists and project zip does not contain model binary artifacts', () {
    final script = File('tool/capture_pp_formulanet_s_artifact_hash_v172_q315.mjs').readAsStringSync();
    final changed = File('docs/audit/V172_Q315_CHANGED_FILES.md').readAsStringSync();
    final modifiedAndAddedSections = changed.split('## Protected Runtime Files Not Modified').first;
    final pubspec = File('pubspec.yaml').readAsStringSync().toLowerCase();

    expect(script, contains('EXPECTED_SHA256'));
    expect(script, contains('PaddlePaddle/PP-FormulaNet-S'));
    expect(script, contains('../MathProOcrArtifacts/PP-FormulaNet-S'));
    expect(script, contains('sha256'));

    for (final protectedPath in <String>[
      'android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt',
      'android/app/src/main/AndroidManifest.xml',
      'pubspec.yaml',
      'assets/mathlive/mathlive_prod_bridge.js',
      'lib/features/mathlive/mathlive_production_editor_surface.dart',
      'lib/features/workspace/workspace_panel.dart',
      'lib/features/camera/gauss_camera_capture_shell.dart',
      'lib/features/keyboard/math_keyboard.dart',
      'lib/features/keyboard/long_press_popup.dart',
      'lib/features/graph/graph_card.dart',
      'lib/features/solution/solution_steps_panel.dart',
      'lib/features/history/history_panel.dart',
    ]) {
      expect(modifiedAndAddedSections, isNot(contains(protectedPath)));
    }

    for (final forbidden in <String>[
      'paddleocr',
      'paddle_lite',
      'paddle-lite',
      'onnxruntime',
      'tflite_flutter',
      'workmanager',
      'background_downloader',
      'flutter_downloader',
    ]) {
      expect(pubspec, isNot(contains(forbidden)));
    }

    for (final entity in Directory.current.listSync(recursive: true, followLinks: false)) {
      final path = entity.path.replaceAll('\\', '/');
      expect(path, isNot(contains('MathProOcrArtifacts')));
      expect(path, isNot(contains('inference.pdiparams')));
      expect(path, isNot(contains('PP-FormulaNet-S_infer.tar')));
    }
  });
}
