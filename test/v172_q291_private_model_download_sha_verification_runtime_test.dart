import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_private_model_download_sha_verification_runtime.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_private_model_download_sha_verification_runtime_policy.dart';

void main() {
  group('V172-Q291 Private Model Download and SHA Verification Runtime', () {
    test('keeps private model download and SHA verification blocked until real evidence exists', () {
      final result = GaussPrivateModelDownloadShaVerificationRuntime.evaluate();

      expect(result.phase, GaussPrivateModelDownloadShaVerificationRuntimePolicy.phase);
      expect(result.sourcePhase, 'V172-Q290-NATIVE-RUNTIME-HANDLER-SKELETON-ANDROID-BINDING');
      expect(result.selectedEngineLabel, 'PP-FormulaNet-S');
      expect(result.downloadFeatureFlag, 'gauss.ppFormulaNetS.privateModelDownload.defaultOff');
      expect(result.expectedSha256State, 'PENDING_DOWNLOAD_AND_HASH_VERIFICATION');
      expect(
        result.decision,
        GaussPrivateModelDownloadShaVerificationRuntimeDecision.downloadShaContractReadyProductionDownloadBlocked,
      );
      expect(result.downloadFeatureFlagEnabledByDefault, isFalse);
      expect(result.productionDownloadEnabled, isFalse);
      expect(result.realNetworkDownloadWorkerImplemented, isFalse);
      expect(result.modelDownloadStarted, isFalse);
      expect(result.actualSha256ComputedInPackage, isFalse);
      expect(result.artifactSha256Verified, isFalse);
      expect(result.artifactAcceptedForRuntime, isFalse);
      expect(result.privateArtifactLoadEnabled, isFalse);
      expect(result.runtimeInvocationEnabled, isFalse);
      expect(result.modelBinaryBundledInBaseApp, isFalse);
      expect(result.imageToLatexInferenceExecuted, isFalse);
      expect(result.ocrPassClaimed, isFalse);
    });

    test('requires private storage, checksum-before-ready, atomic move, cleanup, and offline-ready proof', () {
      const preconditions = GaussPrivateModelDownloadShaVerificationRuntimePolicy.downloadVerificationPreconditions;

      expect(preconditions, contains('q288-real-artifact-source-intake-present'));
      expect(preconditions, contains('q289-runtime-dependency-trial-default-off-present'));
      expect(preconditions, contains('q290-native-runtime-handler-skeleton-present'));
      expect(preconditions, contains('official-artifact-url-required-before-production-download'));
      expect(preconditions, contains('expected-sha256-must-be-64-hex-before-ready'));
      expect(preconditions, contains('download-must-target-private-app-storage-only'));
      expect(preconditions, contains('temporary-file-required-before-checksum'));
      expect(preconditions, contains('actual-sha256-must-match-expected-sha256-before-atomic-move'));
      expect(preconditions, contains('atomic-move-required-after-checksum-pass'));
      expect(preconditions, contains('partial-or-corrupt-download-cleanup-required'));
      expect(preconditions, contains('unverified-model-must-never-be-used-by-runtime'));
      expect(preconditions, contains('offline-ready-only-after-verified-artifact'));
      expect(preconditions, contains('user-consent-and-wifi-policy-required-before-large-download'));
      expect(preconditions, contains('editable-mathlive-review-and-explicit-user-approval-remain-mandatory'));
      expect(preconditions, contains('direct-solve-graph-solution-history-remain-blocked-for-camera-output'));
    });

    test('defines the private artifact envelope without binding a production URL or downloader', () {
      const fields = GaussPrivateModelDownloadShaVerificationRuntimePolicy.privateArtifactEnvelopeFields;
      const errorCodes = GaussPrivateModelDownloadShaVerificationRuntimePolicy.downloadErrorCodes;

      for (final field in [
        'artifactId',
        'engineLabel',
        'officialSourceLocator',
        'expectedSha256',
        'actualSha256',
        'temporaryPrivatePath',
        'verifiedPrivatePath',
        'checksumStatus',
        'atomicMoveStatus',
        'offlineReady',
        'runtimeAccepted',
      ]) {
        expect(fields, contains(field));
      }

      for (final code in [
        'downloadFeatureFlagOff',
        'officialUrlMissing',
        'expectedSha256Missing',
        'expectedSha256Invalid',
        'artifactShaMismatch',
        'atomicMoveFailed',
        'partialDownloadCleanupFailed',
        'privateStorageUnavailable',
      ]) {
        expect(errorCodes, contains(code));
      }
    });

    test('does not mutate protected runtime files, pubspec dependencies, or bundle model artifacts', () {
      final pubspec = File('pubspec.yaml').readAsStringSync();
      final changed = File('docs/audit/V172_Q291_CHANGED_FILES.md').readAsStringSync();

      for (final forbidden in GaussPrivateModelDownloadShaVerificationRuntimePolicy.blockedDependencyFamilies) {
        expect(pubspec, isNot(contains(forbidden)));
      }

      expect(pubspec, contains('camera: 0.10.6'));
      expect(pubspec, contains('camera_android: 0.10.9+3'));
      expect(pubspec, isNot(contains('camera_android_camerax')));

      expect(changed, isNot(contains('- `lib/features/keyboard/key_config.dart`')));
      expect(changed, isNot(contains('- `assets/mathlive/mathlive_prod_bridge.js`')));
      expect(changed, isNot(contains('- `lib/features/mathlive/mathlive_production_editor_surface.dart`')));
      expect(changed, isNot(contains('- `lib/features/camera/gauss_camera_capture_shell.dart`')));
      expect(changed, isNot(contains('- `android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt`')));
      expect(changed, isNot(contains('- `android/app/src/main/AndroidManifest.xml`')));
    });
  });
}
