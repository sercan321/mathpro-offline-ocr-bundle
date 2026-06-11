import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'v172_q344_binary_bundle_successor_test_helper.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_controlled_model_artifact_download_hash_capture_flutter_test_repair_q315r1.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_controlled_model_artifact_download_hash_capture_flutter_test_repair_q315r1_policy.dart';

const String q327SuccessorPhase = 'V172-Q327-NATIVE-LIBRARY-SOURCE-PACKAGE-APPROVAL-ABI-MATRIX-LOCK';
const String q328SuccessorPhase = 'V172-Q328-NATIVE-LIBRARY-PACKAGE-FILE-HASH-INTAKE-NO-BUNDLE-EVIDENCE-GATE';
const String q329SuccessorPhase = 'V172-Q329-NATIVE-PACKAGE-HASH-EVIDENCE-REVIEW-BINARY-BUNDLE-APPROVAL-GATE';
const String q330SuccessorPhase = 'V172-Q330-BINARY-BUNDLE-TRIAL-JNILIBS-PADDLEPREDICTOR-DEFAULT-OFF';
const String q331SuccessorPhase = 'V172-Q331-NATIVE-PACKAGE-HASH-EVIDENCE-ACCEPTANCE-BUNDLE-PERMISSION-GATE';
const String q332SuccessorPhase = 'V172-Q332-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-BLOCKED-GATE';
const String q333SuccessorPhase = 'V172-Q333-NATIVE-PACKAGE-HASH-EVIDENCE-INTAKE-REAL-BUNDLE-PERMISSION-REVIEW';
const String q334SuccessorPhase = 'V172-Q334-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-PENDING-EVIDENCE-BLOCKED-GATE';

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
const String q343SuccessorPhase = 'V172-Q343-NATIVE-PACKAGE-HASH-EVIDENCE-FINAL-ACCEPTANCE-REAL-BUNDLE-UNLOCK-GATE';

void main() {
  test('q315r1 records flutter test repair without OCR runtime claims', () {
    final result = GaussControlledModelArtifactDownloadHashCaptureFlutterTestRepairQ315R1.evaluate();

    expect(result.phase, GaussControlledModelArtifactDownloadHashCaptureFlutterTestRepairQ315R1Policy.phase);
    expect(result.sourcePhase, GaussControlledModelArtifactDownloadHashCaptureFlutterTestRepairQ315R1Policy.sourcePhase);
    expect(result.repairScope, 'flutter-test-literal-path-policy-repair-only');
    expect(result.failureObservedInUserFlutterTest, isTrue);
    expect(result.failureTestFile, 'test/v172_q315_controlled_model_artifact_download_hash_capture_test.dart');
    expect(result.failurePlainName, contains('q315 capture script exists'));
    expect(result.failureCause, contains('literal'));
    expect(result.scriptDefaultOutputDirPolicyLiteral, '../MathProOcrArtifacts/PP-FormulaNet-S');
    expect(result.captureScriptPath, 'tool/capture_pp_formulanet_s_artifact_hash_v172_q315.mjs');
    expect(result.nextRequiredPhase, contains('Q316'));
    expect(result.q315EnvelopePreserved, isTrue);
    expect(result.runtimeBehaviorChanged, isFalse);
    expect(result.cameraOcrRuntimeAdded, isFalse);
    expect(result.controlledDownloadPerformedByAssistant, isFalse);
    expect(result.localArtifactSha256Computed, isFalse);
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
    expect(result.cameraOcrRuntimePassClaimed, isFalse);
    expect(result.androidRealDevicePassClaimed, isFalse);
  });

  test('q315r1 manifest advances repair phase while preserving q315 envelope', () {
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
    final q315r1 = manifest['v172Q315R1ControlledModelArtifactDownloadHashCaptureFlutterTestRepair'] as Map<String, dynamic>;

    expect(<String>[
      GaussControlledModelArtifactDownloadHashCaptureFlutterTestRepairQ315R1Policy.phase,
      q316SuccessorPhase,
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
      GaussControlledModelArtifactDownloadHashCaptureFlutterTestRepairQ315R1Policy.phase,
      q316SuccessorPhase,
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
    expect(manifest['controlledModelArtifactDownloadHashCaptureLatestPhase'], GaussControlledModelArtifactDownloadHashCaptureFlutterTestRepairQ315R1Policy.phase);
    expect(manifest['v172Q315ControlledModelArtifactDownloadHashCapture'], isA<Map<String, dynamic>>());
    expect(q315r1['sourcePhase'], GaussControlledModelArtifactDownloadHashCaptureFlutterTestRepairQ315R1Policy.sourcePhase);
    expect(q315r1['scriptDefaultOutputDirPolicyLiteral'], '../MathProOcrArtifacts/PP-FormulaNet-S');
    expect(q315r1['runtimeDependencyAdded'], isFalse);
    expect(q315r1['methodChannelBindingAdded'], isFalse);
    expect(q315r1['modelBinaryBundledInBaseApp'], isFalse);
    expect(q315r1['ocrPassClaimed'], isFalse);
    if (manifest['cameraOcrLatestPhase'] == q316SuccessorPhase ||
        manifest['cameraOcrLatestPhase'] == q317SuccessorPhase) {
      expect(manifest['v172Q316RuntimeDependencyFeasibilityTrialDefaultOff'], isA<Map<String, dynamic>>());
    }
    if (manifest['cameraOcrLatestPhase'] == q317SuccessorPhase || manifest['cameraOcrLatestPhase'] == q318SuccessorPhase) {
      expect(manifest['v172Q317AndroidNativeBridgeMinimalHealthcheckBehindFlag'], isA<Map<String, dynamic>>());
    }
    if (manifest['cameraOcrLatestPhase'] == q318SuccessorPhase || manifest['cameraOcrLatestPhase'] == q319SuccessorPhase) {
      expect(manifest['v172Q318PrivateModelDownloadStorageRealImplementation'], isA<Map<String, dynamic>>());
    }
    if (manifest['cameraOcrLatestPhase'] == q319SuccessorPhase) {
      expect(manifest['v172Q319VerifiedArtifactLoadSmokeOnDevice'], isA<Map<String, dynamic>>());
    }
  });

  test('q315r1 capture script exposes explicit artifact output policy literal', () {
    final script = File('tool/capture_pp_formulanet_s_artifact_hash_v172_q315.mjs').readAsStringSync();
    final changed = File('docs/audit/V172_Q315R1_CHANGED_FILES.md').readAsStringSync();
    final modifiedAndAddedSections = changed.split('## Protected Runtime Files Not Modified').first;

    expect(script, contains("const DEFAULT_OUTPUT_DIR_POLICY = '../MathProOcrArtifacts/PP-FormulaNet-S';"));
    expect(script, contains('path.resolve(projectRoot, DEFAULT_OUTPUT_DIR_POLICY)'));
    expect(script, contains('artifactStoredOutsideProjectRoot'));
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
  });
}
