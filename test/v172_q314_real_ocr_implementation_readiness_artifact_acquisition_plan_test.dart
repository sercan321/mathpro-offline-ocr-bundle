import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'v172_q344_binary_bundle_successor_test_helper.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_real_ocr_implementation_readiness_artifact_acquisition_plan_q314.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_real_ocr_implementation_readiness_artifact_acquisition_plan_q314_policy.dart';

const String q327SuccessorPhase = 'V172-Q327-NATIVE-LIBRARY-SOURCE-PACKAGE-APPROVAL-ABI-MATRIX-LOCK';
const String q328SuccessorPhase = 'V172-Q328-NATIVE-LIBRARY-PACKAGE-FILE-HASH-INTAKE-NO-BUNDLE-EVIDENCE-GATE';
const String q329SuccessorPhase = 'V172-Q329-NATIVE-PACKAGE-HASH-EVIDENCE-REVIEW-BINARY-BUNDLE-APPROVAL-GATE';
const String q330SuccessorPhase = 'V172-Q330-BINARY-BUNDLE-TRIAL-JNILIBS-PADDLEPREDICTOR-DEFAULT-OFF';
const String q331SuccessorPhase = 'V172-Q331-NATIVE-PACKAGE-HASH-EVIDENCE-ACCEPTANCE-BUNDLE-PERMISSION-GATE';
const String q332SuccessorPhase = 'V172-Q332-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-BLOCKED-GATE';
const String q333SuccessorPhase = 'V172-Q333-NATIVE-PACKAGE-HASH-EVIDENCE-INTAKE-REAL-BUNDLE-PERMISSION-REVIEW';
const String q334SuccessorPhase = 'V172-Q334-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-PENDING-EVIDENCE-BLOCKED-GATE';

const String q315SuccessorPhase =
    'V172-Q315-CONTROLLED-MODEL-ARTIFACT-DOWNLOAD-HASH-CAPTURE';
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
  test('q314 records real OCR implementation readiness without runtime claims', () {
    final result = GaussRealOcrImplementationReadinessArtifactAcquisitionPlanQ314.evaluate();

    expect(result.phase, GaussRealOcrImplementationReadinessArtifactAcquisitionPlanQ314Policy.phase);
    expect(result.sourcePhase, GaussRealOcrImplementationReadinessArtifactAcquisitionPlanQ314Policy.sourcePhase);
    expect(result.selectedEngineLabel, 'PP-FormulaNet-S');
    expect(result.implementationScope, contains('readiness'));
    expect(result.readinessState, contains('BLOCKED'));
    expect(result.primaryRepositoryLocator, 'hf://PaddlePaddle/PP-FormulaNet-S');
    expect(result.officialInferenceArtifactCandidate, contains('PP-FormulaNet-S_infer.tar'));
    expect(result.expectedSha256State, contains('PENDING_Q315'));
    expect(result.actualSha256State, 'NOT_DOWNLOADED_IN_Q314');
    expect(result.readinessQuestions, contains('capture-real-artifact-size-and-sha256-through-controlled-download'));
    expect(result.q315EntryCriteria, contains('downloaded-artifact-is-not-committed-into-project-zip'));
    expect(result.hardBlocksBeforeRuntime, contains('no-runtime-dependency-without-q315-real-sha-and-size-evidence'));
    expect(result.runtimeBehaviorChanged, isFalse);
    expect(result.cameraOcrRuntimeAdded, isFalse);
    expect(result.controlledDownloadPerformed, isFalse);
    expect(result.runtimeDependencyAdded, isFalse);
    expect(result.methodChannelBindingAdded, isFalse);
    expect(result.modelBinaryBundledInBaseApp, isFalse);
    expect(result.realImageToLatexInferenceExecuted, isFalse);
    expect(result.editableMathLiveReviewOpened, isFalse);
    expect(result.workspaceImportExecuted, isFalse);
    expect(result.ocrPassClaimed, isFalse);
  });

  test('q314 manifest advances active OCR track and preserves Q313R3 envelope', () {
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
    final q314 = manifest['v172Q314RealOcrImplementationReadinessArtifactAcquisitionPlan'] as Map<String, dynamic>;

    const allowedActivePhases = <String>[
      GaussRealOcrImplementationReadinessArtifactAcquisitionPlanQ314Policy.phase,
      q315SuccessorPhase,
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
    expect(manifest['realOcrImplementationReadinessArtifactAcquisitionPlanLatestPhase'], GaussRealOcrImplementationReadinessArtifactAcquisitionPlanQ314Policy.phase);
    if (manifest['cameraOcrLatestPhase'] == q315SuccessorPhase ||
        manifest['cameraOcrLatestPhase'] == q315R1SuccessorPhase) {
      expect(manifest['v172Q315ControlledModelArtifactDownloadHashCapture'], isA<Map<String, dynamic>>());
    }
    if (manifest['cameraOcrLatestPhase'] == q315R1SuccessorPhase ||
        manifest['cameraOcrLatestPhase'] == q316SuccessorPhase) {
      expect(manifest['v172Q315R1ControlledModelArtifactDownloadHashCaptureFlutterTestRepair'], isA<Map<String, dynamic>>());
    }
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
    expect(manifest['v172Q313R3FlutterTestSuccessorAwareHygieneRepair'], isA<Map<String, dynamic>>());
    expect(q314['sourcePhase'], GaussRealOcrImplementationReadinessArtifactAcquisitionPlanQ314Policy.sourcePhase);
    expect(q314['runtimeBehaviorChanged'], isFalse);
    expect(q314['runtimeDependencyAdded'], isFalse);
    expect(q314['methodChannelBindingAdded'], isFalse);
    expect(q314['modelBinaryBundledInBaseApp'], isFalse);
    expect(q314['ocrPassClaimed'], isFalse);
  });

  test('q314 changed-files disclosure excludes protected runtime surfaces from modified section', () {
    final changed = File('docs/audit/V172_Q314_CHANGED_FILES.md').readAsStringSync();
    final modifiedAndAddedSections = changed.split('## Protected Runtime Files Not Modified').first;
    final pubspec = File('pubspec.yaml').readAsStringSync();

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

    expect(pubspec.toLowerCase(), isNot(contains('paddleocr')));
    expect(pubspec.toLowerCase(), isNot(contains('paddle_lite')));
    expect(pubspec.toLowerCase(), isNot(contains('onnxruntime')));
    expect(pubspec.toLowerCase(), isNot(contains('tflite_flutter')));
  });
}
