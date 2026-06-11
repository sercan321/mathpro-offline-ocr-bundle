import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'v172_q344_binary_bundle_successor_test_helper.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_runtime_dependency_feasibility_trial_default_off_q316.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_runtime_dependency_feasibility_trial_default_off_q316_policy.dart';

const String q327SuccessorPhase = 'V172-Q327-NATIVE-LIBRARY-SOURCE-PACKAGE-APPROVAL-ABI-MATRIX-LOCK';
const String q328SuccessorPhase = 'V172-Q328-NATIVE-LIBRARY-PACKAGE-FILE-HASH-INTAKE-NO-BUNDLE-EVIDENCE-GATE';
const String q329SuccessorPhase = 'V172-Q329-NATIVE-PACKAGE-HASH-EVIDENCE-REVIEW-BINARY-BUNDLE-APPROVAL-GATE';
const String q330SuccessorPhase = 'V172-Q330-BINARY-BUNDLE-TRIAL-JNILIBS-PADDLEPREDICTOR-DEFAULT-OFF';
const String q331SuccessorPhase = 'V172-Q331-NATIVE-PACKAGE-HASH-EVIDENCE-ACCEPTANCE-BUNDLE-PERMISSION-GATE';
const String q332SuccessorPhase = 'V172-Q332-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-BLOCKED-GATE';
const String q333SuccessorPhase = 'V172-Q333-NATIVE-PACKAGE-HASH-EVIDENCE-INTAKE-REAL-BUNDLE-PERMISSION-REVIEW';
const String q334SuccessorPhase = 'V172-Q334-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-PENDING-EVIDENCE-BLOCKED-GATE';

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
const String q343SuccessorPhase = 'V172-Q343-NATIVE-PACKAGE-HASH-EVIDENCE-FINAL-ACCEPTANCE-REAL-BUNDLE-UNLOCK-GATE';

void main() {
  test('q316 records default-off runtime dependency feasibility gate without adding runtime', () {
    final result = GaussRuntimeDependencyFeasibilityTrialDefaultOffQ316.evaluate();

    expect(result.phase, GaussRuntimeDependencyFeasibilityTrialDefaultOffQ316Policy.phase);
    expect(result.sourcePhase, GaussRuntimeDependencyFeasibilityTrialDefaultOffQ316Policy.sourcePhase);
    expect(result.selectedEngineLabel, 'PP-FormulaNet-S');
    expect(result.implementationScope, 'runtime-dependency-feasibility-preflight-only-default-off');
    expect(result.dependencyTrialState, contains('BLOCKED_PENDING_Q315_LOCAL_HASH_EVIDENCE'));
    expect(result.featureFlagName, 'gauss.ppFormulaNetS.runtimeDependencyTrial.defaultOff');
    expect(result.runtimeDependencyDecision, contains('NO_RUNTIME_DEPENDENCY_ADDED'));
    expect(result.q315RequiredEvidenceScript, contains('capture_pp_formulanet_s_artifact_hash'));
    expect(result.q315ExpectedArtifactPathPolicy, contains('../MathProOcrArtifacts/PP-FormulaNet-S'));
    expect(result.expectedInferencePdiparamsSha256.length, 64);
    expect(result.q315UserSideFlutterAnalyzePassed, isTrue);
    expect(result.q315UserSideFlutterTestPassed, isTrue);
    expect(result.q315LocalArtifactHashEvidenceProvidedToAssistant, isFalse);
    expect(result.explicitRuntimeDependencyApprovalProvided, isFalse);
    expect(result.runtimeDependencyTrialDefaultOff, isTrue);
    expect(result.runtimeFeatureFlagDefaultEnabled, isFalse);
    expect(result.rollbackRequiredBeforeTrial, isTrue);
    expect(result.pubspecChanged, isFalse);
    expect(result.gradleChanged, isFalse);
    expect(result.androidManifestChanged, isFalse);
    expect(result.mainActivityChanged, isFalse);
    expect(result.paddleRuntimeDependencyAdded, isFalse);
    expect(result.paddleOcrDependencyAdded, isFalse);
    expect(result.onnxRuntimeDependencyAdded, isFalse);
    expect(result.tfliteRuntimeDependencyAdded, isFalse);
    expect(result.downloadDependencyAdded, isFalse);
    expect(result.methodChannelBindingAdded, isFalse);
    expect(result.jniNativeHandlerAdded, isFalse);
    expect(result.modelBinaryBundledInBaseApp, isFalse);
    expect(result.modelArtifactAcceptedForRuntime, isFalse);
    expect(result.runtimeStartupExecuted, isFalse);
    expect(result.dummyRuntimeCallExecuted, isFalse);
    expect(result.realImageToLatexInferenceExecuted, isFalse);
    expect(result.editableMathLiveReviewOpened, isFalse);
    expect(result.workspaceImportExecuted, isFalse);
    expect(result.ocrPassClaimed, isFalse);
    expect(result.cameraOcrRuntimePassClaimed, isFalse);
    expect(result.androidRealDevicePassClaimed, isFalse);

    expect(result.candidateRuntimePaths, contains(contains('paddle')));
    expect(result.q316DependencyTrialPreconditions, contains('q315-local-artifact-sha256-evidence-matches-published-hash'));
    expect(result.q316HardBlocks, contains('no-pubspec-change-without-q315-hash-evidence'));
    expect(result.q317EntryCriteria, contains('feature-flag-default-off-remains-enforced'));
  });

  test('q316 manifest advances latest phase while preserving q315/q315r1 envelopes', () {
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
    final q316 = manifest['v172Q316RuntimeDependencyFeasibilityTrialDefaultOff'] as Map<String, dynamic>;

    expect(<String>[
      GaussRuntimeDependencyFeasibilityTrialDefaultOffQ316Policy.phase,
      q317SuccessorPhase,
      q318SuccessorPhase,
      q319SuccessorPhase,
      q320SuccessorPhase,
      q321SuccessorPhase,
      q322SuccessorPhase,
      q323SuccessorPhase,
      q327SuccessorPhase,
      q343SuccessorPhase, q344ActualBinaryBundlePhase, q345GradleAbiPackagingBuildTrialPhase, q346NativeLibraryLoadSmokePhase, q347PaddleLitePredictorInstantiateSmokePhase, q348OptimizedModelConversionModelLoaderEvidenceGatePhase, q349RealModelLoadSmokeEvidenceBlockedPhase, q350OptimizedModelArtifactConversionEvidenceIntakePhase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'], contains(manifest['cameraOcrLatestPhase']));
    expect(<String>[
      GaussRuntimeDependencyFeasibilityTrialDefaultOffQ316Policy.phase,
      q317SuccessorPhase,
      q318SuccessorPhase,
      q319SuccessorPhase,
      q320SuccessorPhase,
      q321SuccessorPhase,
      q322SuccessorPhase,
      q323SuccessorPhase,
      q327SuccessorPhase,
      q343SuccessorPhase, q344ActualBinaryBundlePhase, q345GradleAbiPackagingBuildTrialPhase, q346NativeLibraryLoadSmokePhase, q347PaddleLitePredictorInstantiateSmokePhase, q348OptimizedModelConversionModelLoaderEvidenceGatePhase, q349RealModelLoadSmokeEvidenceBlockedPhase, q350OptimizedModelArtifactConversionEvidenceIntakePhase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase,
    'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE',], contains(manifest['activeProductDevelopmentLatestPhase']));
    expect(manifest['runtimeDependencyFeasibilityTrialDefaultOffLatestPhase'], GaussRuntimeDependencyFeasibilityTrialDefaultOffQ316Policy.phase);
    expect(manifest['controlledModelArtifactDownloadHashCaptureLatestPhase'], contains('Q315R1'));
    expect(manifest['v172Q315ControlledModelArtifactDownloadHashCapture'], isA<Map<String, dynamic>>());
    expect(manifest['v172Q315R1ControlledModelArtifactDownloadHashCaptureFlutterTestRepair'], isA<Map<String, dynamic>>());
    expect(q316['sourcePhase'], GaussRuntimeDependencyFeasibilityTrialDefaultOffQ316Policy.sourcePhase);
    if (manifest['cameraOcrLatestPhase'] == q317SuccessorPhase || manifest['cameraOcrLatestPhase'] == q318SuccessorPhase) {
      expect(manifest['v172Q317AndroidNativeBridgeMinimalHealthcheckBehindFlag'], isA<Map<String, dynamic>>());
    }
    if (manifest['cameraOcrLatestPhase'] == q318SuccessorPhase || manifest['cameraOcrLatestPhase'] == q319SuccessorPhase) {
      expect(manifest['v172Q318PrivateModelDownloadStorageRealImplementation'], isA<Map<String, dynamic>>());
    }
    if (manifest['cameraOcrLatestPhase'] == q319SuccessorPhase) {
      expect(manifest['v172Q319VerifiedArtifactLoadSmokeOnDevice'], isA<Map<String, dynamic>>());
    }
    expect(q316['dependencyTrialState'], contains('BLOCKED_PENDING_Q315_LOCAL_HASH_EVIDENCE'));
    expect(q316['runtimeDependencyTrialDefaultOff'], isTrue);
    expect(q316['runtimeFeatureFlagDefaultEnabled'], isFalse);
    expect(q316['pubspecChanged'], isFalse);
    expect(q316['gradleChanged'], isFalse);
    expect(q316['mainActivityChanged'], isFalse);
    expect(q316['androidManifestChanged'], isFalse);
    expect(q316['methodChannelBindingAdded'], isFalse);
    expect(q316['modelBinaryBundledInBaseApp'], isFalse);
    expect(q316['ocrPassClaimed'], isFalse);
  });

  test('q316 files and changed manifest protect runtime surfaces and dependencies', () {
    final changed = File('docs/audit/V172_Q316_CHANGED_FILES.md').readAsStringSync();
    final modifiedAndAddedSections = changed.split('## Protected Runtime Files Not Modified').first;
    final pubspec = File('pubspec.yaml').readAsStringSync().toLowerCase();
    final verifier = File('tool/verify_runtime_dependency_feasibility_trial_default_off_v172_q316.mjs').readAsStringSync();

    expect(File('lib/features/camera/gauss_runtime_dependency_feasibility_trial_default_off_q316_policy.dart').existsSync(), isTrue);
    expect(File('lib/features/camera/gauss_runtime_dependency_feasibility_trial_default_off_q316.dart').existsSync(), isTrue);
    expect(File('docs/audit/V172_Q316_RUNTIME_DEPENDENCY_FEASIBILITY_TRIAL_DEFAULT_OFF_AUDIT.md').existsSync(), isTrue);
    expect(verifier, contains('q315-local-artifact-sha256-evidence-matches-published-hash'));
    expect(verifier, contains('NO_RUNTIME_DEPENDENCY_ADDED_IN_Q316_STATIC_PREFLIGHT'));

    for (final forbidden in <String>[
      'paddleocr',
      'paddle_lite',
      'paddle-lite',
      'onnxruntime',
      'tflite_flutter',
      'workmanager',
      'background_downloader',
      'dio',
      'flutter_downloader',
    ]) {
      expect(pubspec, isNot(contains(forbidden)));
    }

    for (final protectedPath in <String>[
      'pubspec.yaml',
      'android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt',
      'android/app/src/main/AndroidManifest.xml',
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
  });
}
