import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'v172_q344_binary_bundle_successor_test_helper.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_native_package_hash_evidence_capture_bundle_evidence_acceptance_q341.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_native_package_hash_evidence_capture_bundle_evidence_acceptance_q341_policy.dart';

const String q342SuccessorPhase = 'V172-Q342-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-PENDING-EVIDENCE-BLOCKED';

void main() {
  test('q341 manifest records native package evidence acceptance while preserving UI red lines', () {
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
    expect(<String>[GaussNativePackageHashEvidenceCaptureBundleEvidenceAcceptanceQ341Policy.phase, q342SuccessorPhase, 'V172-Q343-NATIVE-PACKAGE-HASH-EVIDENCE-FINAL-ACCEPTANCE-REAL-BUNDLE-UNLOCK-GATE', q344ActualBinaryBundlePhase, q345GradleAbiPackagingBuildTrialPhase, q346NativeLibraryLoadSmokePhase, q347PaddleLitePredictorInstantiateSmokePhase, q348OptimizedModelConversionModelLoaderEvidenceGatePhase, q349RealModelLoadSmokeEvidenceBlockedPhase, q350OptimizedModelArtifactConversionEvidenceIntakePhase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase, q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'], contains(manifest['cameraOcrLatestPhase']));
    expect(<String>[GaussNativePackageHashEvidenceCaptureBundleEvidenceAcceptanceQ341Policy.phase, q342SuccessorPhase, 'V172-Q343-NATIVE-PACKAGE-HASH-EVIDENCE-FINAL-ACCEPTANCE-REAL-BUNDLE-UNLOCK-GATE', q344ActualBinaryBundlePhase, q345GradleAbiPackagingBuildTrialPhase, q346NativeLibraryLoadSmokePhase, q347PaddleLitePredictorInstantiateSmokePhase, q348OptimizedModelConversionModelLoaderEvidenceGatePhase, q349RealModelLoadSmokeEvidenceBlockedPhase, q350OptimizedModelArtifactConversionEvidenceIntakePhase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase, q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'], contains(manifest['activeProductDevelopmentLatestPhase']));
    expect(manifest['nativePackageHashEvidenceCaptureBundleEvidenceAcceptanceLatestPhase'], GaussNativePackageHashEvidenceCaptureBundleEvidenceAcceptanceQ341Policy.phase);

    final q341 = manifest['v172Q341NativePackageHashEvidenceCaptureBundleEvidenceAcceptance'] as Map<String, dynamic>;
    expect(q341['phase'], GaussNativePackageHashEvidenceCaptureBundleEvidenceAcceptanceQ341Policy.phase);
    expect(q341['sourcePhase'], GaussNativePackageHashEvidenceCaptureBundleEvidenceAcceptanceQ341Policy.sourcePhase);
    expect(q341['method'], GaussNativePackageHashEvidenceCaptureBundleEvidenceAcceptanceQ341Policy.methodName);
    expect(q341['status'], GaussNativePackageHashEvidenceCaptureBundleEvidenceAcceptanceQ341Policy.status);
    expect(q341['uiProtectionStatus'], contains('UI_PROTECTED'));
    expect(q341['requiredNativePackageFiles'], contains('PaddlePredictor.jar'));
    expect(q341['plannedBundleTargets'], contains('android/app/libs/PaddlePredictor.jar'));

    for (final key in <String>[
      'q328NativePackageHashEvidenceJsonProvided',
      'q328NativePackageHashEvidenceJsonReviewed',
      'q328NativePackageHashEvidenceJsonAccepted',
      'explicitUserBinaryBundleApprovalProvided',
      'finalBundlePermissionGranted',
      'actualBinaryBundleAttempted',
      'actualBinaryBundleExecuted',
      'nativeLibraryBundled',
      'jarBundled',
      'jniLibsDirectoryCreated',
      'androidAppLibsDirectoryCreated',
      'gradleChanged',
      'pubspecChanged',
      'androidManifestChanged',
      'workspaceChanged',
      'keyboardChanged',
      'moreTemplateTrayChanged',
      'longPressChanged',
      'mathLiveProductionBridgeChanged',
      'graphChanged',
      'solutionChanged',
      'historyChanged',
      'splashChanged',
      'iconChanged',
      'systemLoadLibraryAdded',
      'paddleLiteInstantiated',
      'runtimeDependencyAdded',
      'modelLoaderAvailable',
      'realImageToLatexInferenceExecuted',
      'ocrPassClaimed',
      'androidRealDevicePassClaimed',
    ]) {
      expect(q341[key], isFalse, reason: 'Q341 $key must remain false');
    }
  });

  test('q341 static evaluator stays blocked and no native binaries are bundled', () {
    final result = GaussNativePackageHashEvidenceCaptureBundleEvidenceAcceptanceQ341.evaluate();
    expect(result.phase, GaussNativePackageHashEvidenceCaptureBundleEvidenceAcceptanceQ341Policy.phase);
    expect(result.status, contains('BLOCKED'));
    expect(result.actualBinaryBundleExecuted, isFalse);
    expect(result.nativeLibraryBundled, isFalse);
    expect(result.jarBundled, isFalse);
    expect(result.workspaceChanged, isFalse);
    expect(result.keyboardChanged, isFalse);
    expect(result.moreTemplateTrayChanged, isFalse);
    expect(result.longPressChanged, isFalse);
    expect(result.mathLiveProductionBridgeChanged, isFalse);
    expect(result.ocrPassClaimed, isFalse);

    final forbidden = <String>[];
    final androidApp = Directory('android/app');
    if (androidApp.existsSync()) {
      for (final entity in androidApp.listSync(recursive: true)) {
        if (entity is File && RegExp(r'\.(so|aar|jar)$', caseSensitive: false).hasMatch(entity.path)) {
          forbidden.add(entity.path);
        }
      }
    }
    expect(q344UnexpectedNativeBinaryPaths(forbidden), isEmpty);
    if (isQ344ActualBinaryBundleActive()) {
      expect(Directory('android/app/src/main/jniLibs').existsSync(), isTrue);
    } else {
      expect(Directory('android/app/src/main/jniLibs').existsSync(), isFalse);
    }
    if (isQ344ActualBinaryBundleActive()) {
      expect(Directory('android/app/libs').existsSync(), isTrue);
    } else {
      expect(Directory('android/app/libs').existsSync(), isFalse);
    }
  });
}
