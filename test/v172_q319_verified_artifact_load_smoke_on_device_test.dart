import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'v172_q344_binary_bundle_successor_test_helper.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_verified_artifact_load_smoke_on_device_q319.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_verified_artifact_load_smoke_on_device_q319_policy.dart';

const String q327SuccessorPhase = 'V172-Q327-NATIVE-LIBRARY-SOURCE-PACKAGE-APPROVAL-ABI-MATRIX-LOCK';
const String q328SuccessorPhase = 'V172-Q328-NATIVE-LIBRARY-PACKAGE-FILE-HASH-INTAKE-NO-BUNDLE-EVIDENCE-GATE';
const String q329SuccessorPhase = 'V172-Q329-NATIVE-PACKAGE-HASH-EVIDENCE-REVIEW-BINARY-BUNDLE-APPROVAL-GATE';
const String q330SuccessorPhase = 'V172-Q330-BINARY-BUNDLE-TRIAL-JNILIBS-PADDLEPREDICTOR-DEFAULT-OFF';
const String q331SuccessorPhase = 'V172-Q331-NATIVE-PACKAGE-HASH-EVIDENCE-ACCEPTANCE-BUNDLE-PERMISSION-GATE';
const String q332SuccessorPhase = 'V172-Q332-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-BLOCKED-GATE';
const String q333SuccessorPhase = 'V172-Q333-NATIVE-PACKAGE-HASH-EVIDENCE-INTAKE-REAL-BUNDLE-PERMISSION-REVIEW';
const String q334SuccessorPhase = 'V172-Q334-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-PENDING-EVIDENCE-BLOCKED-GATE';

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
  test('q319 records verified artifact load smoke only and keeps OCR runtime disabled', () {
    final result = GaussVerifiedArtifactLoadSmokeOnDeviceQ319.evaluate();

    expect(result.phase, GaussVerifiedArtifactLoadSmokeOnDeviceQ319Policy.phase);
    expect(result.sourcePhase, GaussVerifiedArtifactLoadSmokeOnDeviceQ319Policy.sourcePhase);
    expect(result.selectedEngineLabel, 'PP-FormulaNet-S');
    expect(result.nativeChannelName, 'mathpro/ocr_runtime_bridge');
    expect(result.verifiedArtifactLoadSmokeMethod, 'verifiedArtifactLoadSmoke');
    expect(result.verifiedArtifactLoadSmokeStatus, 'VERIFIED_ARTIFACT_LOAD_SMOKE_AVAILABLE_DEFAULT_OFF');
    expect(result.modelDirectoryName, 'ocr_models/PP-FormulaNet-S');
    expect(result.artifactFileName, 'inference.pdiparams');
    expect(result.expectedInferencePdiparamsSha256, 'b6392296d16e2a9f414c0a751d7ccbd1bd9d8272b68aab72df1d3875f35a7489');
    expect(result.expectedInferencePdiparamsSizeBytes, 231675001);
    expect(result.q315Sha256MatchesExpected, isTrue);
    expect(result.q315RuntimeAccepted, isFalse);
    expect(result.q318PrivateStorageHealthcheckAdded, isTrue);
    expect(result.verifiedArtifactLoadSmokeMethodAdded, isTrue);
    expect(result.featureFlagDefaultEnabled, isFalse);
    expect(result.mainActivityChanged, isTrue);
    expect(result.protectedMainActivityChangeDeclared, isTrue);
    expect(result.pubspecChanged, isFalse);
    expect(result.gradleChanged, isFalse);
    expect(result.androidManifestChanged, isFalse);
    expect(result.runtimeDependencyAdded, isFalse);
    expect(result.paddleRuntimeDependencyAdded, isFalse);
    expect(result.paddleOcrDependencyAdded, isFalse);
    expect(result.downloadDependencyAdded, isFalse);
    expect(result.jniNativeHandlerAdded, isFalse);
    expect(result.nativeModelLoaderAdded, isFalse);
    expect(result.modelBinaryBundledInBaseApp, isFalse);
    expect(result.projectZipContainsModelArtifact, isFalse);
    expect(result.modelArtifactAcceptedForRuntime, isFalse);
    expect(result.runtimeStartupExecuted, isFalse);
    expect(result.dummyRuntimeCallExecuted, isFalse);
    expect(result.realImageToLatexInferenceExecuted, isFalse);
    expect(result.editableMathLiveReviewOpened, isFalse);
    expect(result.workspaceImportExecuted, isFalse);
    expect(result.ocrPassClaimed, isFalse);
    expect(result.androidRealDevicePassClaimed, isFalse);
    expect(result.verifiedArtifactLoadSmokeEnvelopeFields, contains('verifiedArtifactLoadSmokePassed'));
    expect(result.verifiedArtifactLoadSmokeEnvelopeFields, contains('artifactOpenedForRead'));
    expect(result.q319HardBlocks, contains('no-native-model-loader-or-runtime-acceptance-in-q319'));
    expect(result.q319HardBlocks, contains('no-runtime-startup-dummy-call-or-image-to-latex-in-q319'));
    expect(result.q320EntryCriteria, contains('q319-flutter-run-device-log-shows-verified-artifact-load-smoke'));
  });

  test('q319 manifest is active and preserves q318/q315 evidence boundaries', () {
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
    final q319 = manifest['v172Q319VerifiedArtifactLoadSmokeOnDevice'] as Map<String, dynamic>;

    if (![q327SuccessorPhase, q328SuccessorPhase, q329SuccessorPhase, q330SuccessorPhase, q331SuccessorPhase, q332SuccessorPhase, q333SuccessorPhase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase, 'V172-Q343-NATIVE-PACKAGE-HASH-EVIDENCE-FINAL-ACCEPTANCE-REAL-BUNDLE-UNLOCK-GATE', q344ActualBinaryBundlePhase, q345GradleAbiPackagingBuildTrialPhase, q346NativeLibraryLoadSmokePhase, q347PaddleLitePredictorInstantiateSmokePhase, q348OptimizedModelConversionModelLoaderEvidenceGatePhase, q349RealModelLoadSmokeEvidenceBlockedPhase, q350OptimizedModelArtifactConversionEvidenceIntakePhase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase, q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'].contains(manifest['cameraOcrLatestPhase'])) { expect(<String>[GaussVerifiedArtifactLoadSmokeOnDeviceQ319Policy.phase, q320SuccessorPhase, q321SuccessorPhase, q322SuccessorPhase, q323SuccessorPhase, q324SuccessorPhase, q325SuccessorPhase, 'V172-Q343-NATIVE-PACKAGE-HASH-EVIDENCE-FINAL-ACCEPTANCE-REAL-BUNDLE-UNLOCK-GATE', q344ActualBinaryBundlePhase, q345GradleAbiPackagingBuildTrialPhase, q346NativeLibraryLoadSmokePhase, q347PaddleLitePredictorInstantiateSmokePhase, q348OptimizedModelConversionModelLoaderEvidenceGatePhase, q349RealModelLoadSmokeEvidenceBlockedPhase, q350OptimizedModelArtifactConversionEvidenceIntakePhase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase, q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'], contains(manifest['cameraOcrLatestPhase'])); }
    if (![q327SuccessorPhase, q328SuccessorPhase, q329SuccessorPhase, q330SuccessorPhase, q331SuccessorPhase, q332SuccessorPhase, q333SuccessorPhase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase, 'V172-Q343-NATIVE-PACKAGE-HASH-EVIDENCE-FINAL-ACCEPTANCE-REAL-BUNDLE-UNLOCK-GATE', q344ActualBinaryBundlePhase, q345GradleAbiPackagingBuildTrialPhase, q346NativeLibraryLoadSmokePhase, q347PaddleLitePredictorInstantiateSmokePhase, q348OptimizedModelConversionModelLoaderEvidenceGatePhase, q349RealModelLoadSmokeEvidenceBlockedPhase, q350OptimizedModelArtifactConversionEvidenceIntakePhase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase, q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'].contains(manifest['activeProductDevelopmentLatestPhase'])) { expect(<String>[GaussVerifiedArtifactLoadSmokeOnDeviceQ319Policy.phase, q320SuccessorPhase, q321SuccessorPhase, q322SuccessorPhase, q323SuccessorPhase, q324SuccessorPhase, q325SuccessorPhase, 'V172-Q343-NATIVE-PACKAGE-HASH-EVIDENCE-FINAL-ACCEPTANCE-REAL-BUNDLE-UNLOCK-GATE', q344ActualBinaryBundlePhase, q345GradleAbiPackagingBuildTrialPhase, q346NativeLibraryLoadSmokePhase, q347PaddleLitePredictorInstantiateSmokePhase, q348OptimizedModelConversionModelLoaderEvidenceGatePhase, q349RealModelLoadSmokeEvidenceBlockedPhase, q350OptimizedModelArtifactConversionEvidenceIntakePhase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase, q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'], contains(manifest['activeProductDevelopmentLatestPhase'])); }
    expect(manifest['verifiedArtifactLoadSmokeOnDeviceLatestPhase'], GaussVerifiedArtifactLoadSmokeOnDeviceQ319Policy.phase);
    expect(manifest['privateModelDownloadStorageRealImplementationLatestPhase'], GaussVerifiedArtifactLoadSmokeOnDeviceQ319Policy.sourcePhase);
    expect(manifest['v172Q318PrivateModelDownloadStorageRealImplementation'], isA<Map<String, dynamic>>());
    if (manifest['cameraOcrLatestPhase'] == q320SuccessorPhase) {
      expect(manifest['v172Q320RuntimeStartupSmokeOnDevice'], isA<Map<String, dynamic>>());
    }
    expect(q319['phase'], GaussVerifiedArtifactLoadSmokeOnDeviceQ319Policy.phase);
    expect(q319['sourcePhase'], GaussVerifiedArtifactLoadSmokeOnDeviceQ319Policy.sourcePhase);
    expect(q319['q315Sha256MatchesExpected'], isTrue);
    expect(q319['q315RuntimeAccepted'], isFalse);
    expect(q319['q318PrivateStorageHealthcheckAdded'], isTrue);
    expect(q319['verifiedArtifactLoadSmokeMethodAdded'], isTrue);
    expect(q319['runtimeDependencyAdded'], isFalse);
    expect(q319['modelArtifactAcceptedForRuntime'], isFalse);
    expect(q319['runtimeStartupExecuted'], isFalse);
    expect(q319['ocrPassClaimed'], isFalse);
    expect(q319['androidRealDevicePassClaimed'], isFalse);
  });

  test('q319 MainActivity exposes only verified artifact load smoke method', () {
    final mainActivity = File('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt').readAsStringSync();

    expect(mainActivity, contains('private val q319Phase = "V172-Q319-VERIFIED-ARTIFACT-LOAD-SMOKE-ON-DEVICE"'));
    expect(mainActivity, contains('private val q319VerifiedArtifactLoadSmokeFeatureEnabled = false'));
    expect(mainActivity, contains('"verifiedArtifactLoadSmoke" -> result.success(q319VerifiedArtifactLoadSmoke(call.method))'));
    expect(mainActivity, contains('"status" to "VERIFIED_ARTIFACT_LOAD_SMOKE_AVAILABLE_DEFAULT_OFF"'));
    expect(mainActivity, contains('"verifiedArtifactLoadSmokePassed" to verifiedArtifactLoadSmokePassed'));
    expect(mainActivity, contains('"artifactOpenedForRead" to artifactOpenedForRead'));
    expect(mainActivity, contains('"artifactReadSmokeBytes" to artifactReadSmokeBytes'));
    expect(mainActivity, contains('"artifactSmokeError" to artifactSmokeError'));
    expect(mainActivity, contains('"modelArtifactAcceptedForRuntime" to false'));
    expect(mainActivity, contains('"runtimeStartupExecuted" to false'));
    expect(mainActivity, contains('"imageToLatexInferenceExecuted" to false'));
    expect(mainActivity, isNot(contains('PaddleOCR(')));
    if (!isQ347OrLaterPaddleLiteBridgeActive()) {
      expect(mainActivity, isNot(contains('PaddleLite(')));
    } else {
      expect(mainActivity, contains('private val q347Phase = "V172-Q347-PADDLE-LITE-PREDICTOR-INSTANTIATE-SMOKE"'));
      expect(mainActivity, contains('private val q347FeatureEnabled = false'));
    }
    expect(mainActivity, isNot(contains('loadModel(')));
    expect(mainActivity, isNot(contains('runInference(')));
    expect(mainActivity, isNot(contains('imageToLatex(')));
  });

  test('q319 changed files declare protected MainActivity change and no model artifact committed', () {
    final changed = File('docs/audit/V172_Q319_CHANGED_FILES.md').readAsStringSync();
    final pubspec = File('pubspec.yaml').readAsStringSync().toLowerCase();
    final manifest = File('android/app/src/main/AndroidManifest.xml').readAsStringSync();

    expect(changed, contains('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt'));
    expect(changed, contains('Protected Runtime File Intentionally Modified'));
    expect(changed, contains('verified artifact file open/read/SHA smoke method only'));
    expect(File('docs/audit/V172_Q319_VERIFIED_ARTIFACT_LOAD_SMOKE_ON_DEVICE_AUDIT.md').existsSync(), isTrue);
    expect(File('tool/verify_verified_artifact_load_smoke_on_device_v172_q319.mjs').existsSync(), isTrue);
    for (final forbidden in <String>['paddleocr', 'paddle_lite', 'paddle-lite', 'onnxruntime', 'tflite_flutter', 'flutter_downloader', 'workmanager', 'dio']) {
      expect(pubspec, isNot(contains(forbidden)));
    }
    expect(manifest, isNot(contains('READ_EXTERNAL_STORAGE')));
    expect(manifest, isNot(contains('MANAGE_EXTERNAL_STORAGE')));

    final committedModelFiles = Directory.current
        .listSync(recursive: true)
        .whereType<File>()
        .map((file) => file.path.replaceAll('\\', '/'))
        .where((path) => path.endsWith('/inference.pdiparams') || path.toLowerCase().contains('mathproocrartifacts'))
        .toList();
    expect(committedModelFiles, isEmpty);
  });
}
