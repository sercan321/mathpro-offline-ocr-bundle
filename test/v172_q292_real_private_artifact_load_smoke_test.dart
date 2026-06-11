import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_real_private_artifact_load_smoke.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_real_private_artifact_load_smoke_policy.dart';

void main() {
  group('V172-Q292 Real Private Artifact Load Smoke', () {
    test('keeps real private artifact load blocked until verified artifact evidence exists', () {
      final result = GaussRealPrivateArtifactLoadSmoke.evaluate();

      expect(result.phase, GaussRealPrivateArtifactLoadSmokePolicy.phase);
      expect(result.sourcePhase, 'V172-Q291-PRIVATE-MODEL-DOWNLOAD-SHA-VERIFICATION-RUNTIME');
      expect(result.selectedEngineLabel, 'PP-FormulaNet-S');
      expect(result.loadFeatureFlag, 'gauss.ppFormulaNetS.realPrivateArtifactLoadSmoke.defaultOff');
      expect(result.verifiedPrivateArtifactState, 'BLOCKED_PENDING_REAL_VERIFIED_PRIVATE_ARTIFACT');
      expect(
        result.decision,
        GaussRealPrivateArtifactLoadSmokeDecision.loadSmokeContractReadyRealLoadBlocked,
      );
      expect(result.loadFeatureFlagEnabledByDefault, isFalse);
      expect(result.realPrivateArtifactFileLoaded, isFalse);
      expect(result.modelFormatProbeExecuted, isFalse);
      expect(result.nativeRuntimeBridgeInvoked, isFalse);
      expect(result.runtimeInvocationEnabled, isFalse);
      expect(result.modelBinaryBundledInBaseApp, isFalse);
      expect(result.imageToLatexInferenceExecuted, isFalse);
      expect(result.ocrPassClaimed, isFalse);
    });

    test('requires Q291 verified private artifact, SHA match, atomic move, and private storage evidence', () {
      const preconditions = GaussRealPrivateArtifactLoadSmokePolicy.privateArtifactLoadSmokePreconditions;

      expect(preconditions, contains('q291-private-model-download-sha-verification-present'));
      expect(preconditions, contains('q291-verified-private-artifact-still-pending'));
      expect(preconditions, contains('expected-sha256-required-before-private-artifact-load'));
      expect(preconditions, contains('actual-sha256-required-before-private-artifact-load'));
      expect(preconditions, contains('expected-actual-sha256-match-required-before-load'));
      expect(preconditions, contains('atomic-move-completed-evidence-required-before-load'));
      expect(preconditions, contains('private-app-storage-path-required'));
      expect(preconditions, contains('model-format-probe-plan-required'));
      expect(preconditions, contains('dummy-input-only-smoke-required-before-inference'));
      expect(preconditions, contains('editable-mathlive-review-and-explicit-user-approval-remain-mandatory'));
      expect(preconditions, contains('direct-solve-graph-solution-history-remain-blocked-for-camera-output'));
      expect(preconditions, contains('no-real-private-artifact-load-without-user-side-evidence'));
    });

    test('guards the private artifact load request/result envelope without executing a real load', () {
      const request = GaussRealPrivateArtifactLoadRequestEnvelope(
        requestId: 'q292-smoke',
        engineLabel: 'PP-FormulaNet-S',
        verifiedPrivatePath: '/data/user/0/com.mathpro.flutter/files/models/pp_formulanet_s/verified',
        expectedSha256: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
        actualSha256: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
        artifactSizeBytes: 224 * 1024 * 1024,
        androidAbi: 'arm64-v8a',
        timeoutMs: 2400,
        loadFeatureFlagEnabled: true,
        privateStoragePathVerified: true,
        checksumStatus: 'passed',
        atomicMoveStatus: 'completed',
      );

      final result = GaussRealPrivateArtifactLoadSmoke.guardedLoadSmoke(request);

      expect(result.status, 'blocked');
      expect(result.artifactPathAccepted, isTrue);
      expect(result.shaMatch, isTrue);
      expect(result.realFileLoadExecuted, isFalse);
      expect(result.modelFormatProbeExecuted, isFalse);
      expect(result.runtimeBridgeInvoked, isFalse);
      expect(result.errorCode, 'noRealArtifactLoadExecutedInQ292');
      expect(result.reviewRequired, isTrue);
      expect(result.directWorkspaceMutationAttempted, isFalse);
      expect(result.canProceedToRuntimeStartup, isFalse);
      expect(result.canImportToWorkspace, isFalse);
      expect(result.canEvaluate, isFalse);
      expect(result.canGraph, isFalse);
      expect(result.canWriteSolutionOrHistory, isFalse);
    });

    test('does not mutate protected runtime files, pubspec dependencies, or bundle model artifacts', () {
      final pubspec = File('pubspec.yaml').readAsStringSync();
      final changed = File('docs/audit/V172_Q292_CHANGED_FILES.md').readAsStringSync();

      for (final forbidden in GaussRealPrivateArtifactLoadSmokePolicy.blockedDependencyFamilies) {
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
