import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'v172_q344_binary_bundle_successor_test_helper.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_flutter_analyze_info_hygiene_q313r2.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_flutter_analyze_info_hygiene_q313r2_policy.dart';

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
  test('q313r2 records analyzer info hygiene without runtime claims', () {
    final result = GaussFlutterAnalyzeInfoHygieneQ313R2.evaluate();

    expect(result.phase, GaussFlutterAnalyzeInfoHygieneQ313R2Policy.phase);
    expect(result.sourcePhase, GaussFlutterAnalyzeInfoHygieneQ313R2Policy.sourcePhase);
    expect(result.preferConstConstructorsApplied, isTrue);
    expect(result.q291TestConstDeclarationApplied, isTrue);
    expect(result.parserErrorReintroduced, isFalse);
    expect(result.runtimeBehaviorChanged, isFalse);
    expect(result.cameraOcrRuntimeAdded, isFalse);
    expect(result.ocrPassClaimed, isFalse);
  });

  test('q313r2 manifest advances latest phase while preserving Q313 and Q313R1 envelopes', () {
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;

    const allowedActiveSuccessorPhases = <String>[
      GaussFlutterAnalyzeInfoHygieneQ313R2Policy.phase,
      'V172-Q313R3-FLUTTER-TEST-SUCCESSOR-AWARE-HYGIENE-REPAIR',
      'V172-Q314-REAL-OCR-IMPLEMENTATION-READINESS-ARTIFACT-ACQUISITION-PLAN',
      'V172-Q315-CONTROLLED-MODEL-ARTIFACT-DOWNLOAD-HASH-CAPTURE',
      'V172-Q315R1-CONTROLLED-MODEL-ARTIFACT-DOWNLOAD-HASH-CAPTURE-FLUTTER-TEST-REPAIR',
      'V172-Q316-RUNTIME-DEPENDENCY-FEASIBILITY-TRIAL-BEHIND-DEFAULT-OFF-FLAG',
      'V172-Q317-ANDROID-NATIVE-BRIDGE-MINIMAL-HEALTHCHECK-BEHIND-FLAG',
      'V172-Q318-PRIVATE-MODEL-DOWNLOAD-STORAGE-REAL-IMPLEMENTATION',
      'V172-Q319-VERIFIED-ARTIFACT-LOAD-SMOKE-ON-DEVICE',
      'V172-Q320-RUNTIME-STARTUP-SMOKE-ON-DEVICE',
      'V172-Q325-EXPLICIT-RUNTIME-DEPENDENCY-COORDINATE-SELECTION-BUILD-TRIAL-GATE',
      'V172-Q324-APPROVED-RUNTIME-DEPENDENCY-TRIAL-BEHIND-DEFAULT-OFF-FLAG',
      'V172-Q323-RUNTIME-DEPENDENCY-MODEL-LOADER-DECISION-IMPLEMENTATION',
      'V172-Q322-FIRST-IMAGE-TO-LATEX-INFERENCE-ENVELOPE',
      'V172-Q321-DUMMY-INPUT-RUNTIME-CALL',
    ];
    if (![q327SuccessorPhase, q328SuccessorPhase, q329SuccessorPhase, q330SuccessorPhase, q331SuccessorPhase, q332SuccessorPhase, q333SuccessorPhase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase, 'V172-Q343-NATIVE-PACKAGE-HASH-EVIDENCE-FINAL-ACCEPTANCE-REAL-BUNDLE-UNLOCK-GATE', q344ActualBinaryBundlePhase, q345GradleAbiPackagingBuildTrialPhase, q346NativeLibraryLoadSmokePhase, q347PaddleLitePredictorInstantiateSmokePhase, q348OptimizedModelConversionModelLoaderEvidenceGatePhase, q349RealModelLoadSmokeEvidenceBlockedPhase, q350OptimizedModelArtifactConversionEvidenceIntakePhase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase, q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'].contains(manifest['cameraOcrLatestPhase'])) { expect(allowedActiveSuccessorPhases, contains(manifest['cameraOcrLatestPhase'])); }
    if (![q327SuccessorPhase, q328SuccessorPhase, q329SuccessorPhase, q330SuccessorPhase, q331SuccessorPhase, q332SuccessorPhase, q333SuccessorPhase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase, 'V172-Q343-NATIVE-PACKAGE-HASH-EVIDENCE-FINAL-ACCEPTANCE-REAL-BUNDLE-UNLOCK-GATE', q344ActualBinaryBundlePhase, q345GradleAbiPackagingBuildTrialPhase, q346NativeLibraryLoadSmokePhase, q347PaddleLitePredictorInstantiateSmokePhase, q348OptimizedModelConversionModelLoaderEvidenceGatePhase, q349RealModelLoadSmokeEvidenceBlockedPhase, q350OptimizedModelArtifactConversionEvidenceIntakePhase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase, q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'].contains(manifest['activeProductDevelopmentLatestPhase'])) { expect(allowedActiveSuccessorPhases, contains(manifest['activeProductDevelopmentLatestPhase'])); }
    expect(manifest['v172Q313FullCameraOcrRealDeviceRegressionGate'], isA<Map<String, dynamic>>());
    expect(manifest['v172Q313R1FlutterLogRepairQ295PathEscapeQ152SuccessorAware'], isA<Map<String, dynamic>>());
    expect(manifest['v172Q313R2FlutterAnalyzeInfoHygiene'], isA<Map<String, dynamic>>());
  });

  test('q313r2 adds const hygiene without touching protected runtime files', () {
    final changed = File('docs/audit/V172_Q313R2_CHANGED_FILES.md').readAsStringSync();
    final q295 = File('lib/features/camera/gauss_first_real_image_to_latex_inference.dart').readAsStringSync();
    final q291Test = File('test/v172_q291_private_model_download_sha_verification_runtime_test.dart').readAsStringSync();

    expect(q295, contains('return const GaussFirstRealImageToLatexInferenceResult('));
    expect(q291Test, contains('const fields = GaussPrivateModelDownloadShaVerificationRuntimePolicy.privateArtifactEnvelopeFields;'));
    final modifiedAndAddedSections = changed.split('## Protected Runtime Files Not Modified').first;
    expect(modifiedAndAddedSections, isNot(contains('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt')));
    expect(modifiedAndAddedSections, isNot(contains('android/app/src/main/AndroidManifest.xml')));
    expect(modifiedAndAddedSections, isNot(contains('pubspec.yaml')));
    expect(modifiedAndAddedSections, isNot(contains('assets/mathlive/mathlive_prod_bridge.js')));
    expect(modifiedAndAddedSections, isNot(contains('lib/features/keyboard/math_keyboard.dart')));
  });
}
