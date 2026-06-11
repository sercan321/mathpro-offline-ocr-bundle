import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_deferred_model_download_runtime.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_deferred_model_download_runtime_policy.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_pp_formulanet_s_user_selection.dart';

// Q248 dependency sentinels: camera: 0.10.6, camera_android: 0.10.9+3
void main() {
  group('V172-Q248 PP-FormulaNet-S deferred model download runtime', () {
    test('records Q248 as a PP-FormulaNet-S deferred model guard, not OCR inference', () {
      expect(GaussDeferredModelDownloadRuntimePolicy.phase, 'V172-Q248-DEFERRED-MODEL-DOWNLOAD-RUNTIME');
      expect(GaussDeferredModelDownloadRuntimePolicy.closesOverPhase, 'V172-Q247R1-PP_FORMULANET_S_USER_SELECTION_LOCK');
      expect(GaussDeferredModelDownloadRuntimePolicy.selectedEngineLabel, 'PP-FormulaNet-S');
      expect(GaussDeferredModelDownloadRuntimePolicy.fallbackEngineLabel, 'PP-FormulaNet_plus-L');
      expect(GaussDeferredModelDownloadRuntimePolicy.deferredModelStateMachineImplemented, isTrue);
      expect(GaussDeferredModelDownloadRuntimePolicy.modelIntegrityGateImplemented, isTrue);
      expect(GaussDeferredModelDownloadRuntimePolicy.sha256VerificationRequiredBeforeReady, isTrue);
      expect(GaussDeferredModelDownloadRuntimePolicy.privateAppStorageRequiredBeforeReady, isTrue);
      expect(GaussDeferredModelDownloadRuntimePolicy.offlineAfterInstallRequiredBeforeInference, isTrue);
      expect(GaussDeferredModelDownloadRuntimePolicy.realOcrRuntimeAdded, isFalse);
      expect(GaussDeferredModelDownloadRuntimePolicy.productionInferenceAllowed, isFalse);
      expect(GaussDeferredModelDownloadRuntime.canRunInferenceNow, isFalse);
    });

    test('preserves PP-FormulaNet-S user selection and all deferred install states', () {
      expect(GaussDeferredModelDownloadRuntime.selectedEngineLabel, GaussPpFormulaNetSUserSelection.selectedEngineLabel);
      expect(GaussDeferredModelDownloadRuntime.q247R1UserSelectionPreserved, isTrue);
      expect(GaussPpFormulaNetSDeferredModelManifest.modelPackId, 'gauss_pp_formulanet_s_optional_math_ocr_pack');
      expect(GaussPpFormulaNetSDeferredModelManifest.modelBinaryBundledInBaseApp, isFalse);
      expect(GaussPpFormulaNetSDeferredModelManifest.productionModelUrlBound, isFalse);
      expect(GaussPpFormulaNetSDeferredModelManifest.productionDownloadWorkerImplemented, isFalse);
      expect(GaussPpFormulaNetSDeferredModelManifest.installStates, containsAll(<GaussDeferredModelDownloadStatus>[
        GaussDeferredModelDownloadStatus.notInstalled,
        GaussDeferredModelDownloadStatus.queued,
        GaussDeferredModelDownloadStatus.downloading,
        GaussDeferredModelDownloadStatus.verifying,
        GaussDeferredModelDownloadStatus.ready,
        GaussDeferredModelDownloadStatus.failed,
        GaussDeferredModelDownloadStatus.updateAvailable,
        GaussDeferredModelDownloadStatus.disabledByUser,
      ]));
    });

    test('blocks unverified, mismatched, oversized, unsafe, and direct-solve artifacts', () {
      const validHash = '0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef';
      final notReady = GaussDeferredModelDownloadRuntime.evaluateReadiness(
        const GaussDeferredModelArtifactEvidence(
          status: GaussDeferredModelDownloadStatus.downloading,
          expectedSha256: validHash,
          actualSha256: validHash,
          modelSizeBytes: 1024,
          storedInPrivateAppStorage: true,
          offlineAfterInstall: true,
          mathLiveReviewRequired: true,
          directSolveAllowed: false,
          productionUrlBound: false,
          modelBinaryBundledInBaseApp: false,
        ),
      );
      expect(notReady.decision, GaussDeferredModelReadinessDecision.blockedNoVerifiedArtifact);
      expect(notReady.canRunInferenceNow, isFalse);

      final mismatch = GaussDeferredModelDownloadRuntime.evaluateReadiness(
        const GaussDeferredModelArtifactEvidence(
          status: GaussDeferredModelDownloadStatus.ready,
          expectedSha256: validHash,
          actualSha256: 'abcdefabcdefabcdefabcdefabcdefabcdefabcdefabcdefabcdefabcdefabcd',
          modelSizeBytes: 1024,
          storedInPrivateAppStorage: true,
          offlineAfterInstall: true,
          mathLiveReviewRequired: true,
          directSolveAllowed: false,
          productionUrlBound: false,
          modelBinaryBundledInBaseApp: false,
        ),
      );
      expect(mismatch.decision, GaussDeferredModelReadinessDecision.blockedSha256Mismatch);

      final directSolve = GaussDeferredModelDownloadRuntime.evaluateReadiness(
        const GaussDeferredModelArtifactEvidence(
          status: GaussDeferredModelDownloadStatus.ready,
          expectedSha256: validHash,
          actualSha256: validHash,
          modelSizeBytes: 1024,
          storedInPrivateAppStorage: true,
          offlineAfterInstall: true,
          mathLiveReviewRequired: true,
          directSolveAllowed: true,
          productionUrlBound: false,
          modelBinaryBundledInBaseApp: false,
        ),
      );
      expect(directSolve.decision, GaussDeferredModelReadinessDecision.blockedDirectSolveAttempt);
    });

    test('allows only future Q249 adapter readiness, never immediate inference', () {
      const validHash = '0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef';
      final result = GaussDeferredModelDownloadRuntime.evaluateReadiness(
        const GaussDeferredModelArtifactEvidence(
          status: GaussDeferredModelDownloadStatus.ready,
          expectedSha256: validHash,
          actualSha256: validHash,
          modelSizeBytes: 42 * 1024 * 1024,
          storedInPrivateAppStorage: true,
          offlineAfterInstall: true,
          mathLiveReviewRequired: true,
          directSolveAllowed: false,
          productionUrlBound: false,
          modelBinaryBundledInBaseApp: false,
        ),
      );
      expect(result.decision, GaussDeferredModelReadinessDecision.readyForFutureQ249AdapterOnly);
      expect(result.canProceedToQ249Adapter, isTrue);
      expect(result.canRunInferenceNow, isFalse);
      expect(result.mathLiveReviewRequired, isTrue);
      expect(result.directSolveAllowed, isFalse);
    });

    test('keeps dependencies, manifest, and Android toolchain untouched', () {
      final pubspec = File('pubspec.yaml').readAsStringSync();
      final settings = File('android/settings.gradle').readAsStringSync();
      final manifest = File('android/app/src/main/AndroidManifest.xml').readAsStringSync();

      expect(pubspec, contains(RegExp(r'^\s*camera\s*:\s*0\.10\.6\s*$', multiLine: true)));
      expect(pubspec, contains(RegExp(r'^\s*camera_android\s*:\s*0\.10\.9\+3\s*$', multiLine: true)));
      expect(pubspec, isNot(contains('camera_android_camerax')));
      expect(pubspec, isNot(contains('google_mlkit_text_recognition')));
      expect(pubspec, isNot(contains('paddleocr')));
      expect(pubspec, isNot(contains('onnxruntime')));
      expect(pubspec, isNot(contains('flutter_downloader')));
      expect(settings, contains("id 'org.jetbrains.kotlin.android' version '2.1.0' apply false"));
      expect(
        settings.contains("id 'com.android.application' version '8.3.2' apply false") ||
            settings.contains("id 'com.android.application' version '8.6.1' apply false"),
        isTrue,
      );
      expect(manifest, contains('android.permission.CAMERA'));
      expect(manifest, isNot(contains('READ_MEDIA_IMAGES')));
    });
  });
}
