import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_first_real_runtime_startup_smoke.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_first_real_runtime_startup_smoke_policy.dart';

void main() {
  group('V172-Q293 First Real Runtime Startup Smoke', () {
    test('keeps first runtime startup blocked until real runtime evidence exists', () {
      final result = GaussFirstRealRuntimeStartupSmoke.evaluate();

      expect(result.phase, GaussFirstRealRuntimeStartupSmokePolicy.phase);
      expect(result.sourcePhase, 'V172-Q292-REAL-PRIVATE-ARTIFACT-LOAD-SMOKE');
      expect(result.selectedEngineLabel, 'PP-FormulaNet-S');
      expect(result.startupFeatureFlag, 'gauss.ppFormulaNetS.firstRealRuntimeStartupSmoke.defaultOff');
      expect(
        result.startupReadinessState,
        'BLOCKED_PENDING_Q292_REAL_PRIVATE_ARTIFACT_LOAD_AND_NATIVE_RUNTIME_EVIDENCE',
      );
      expect(
        result.decision,
        GaussFirstRealRuntimeStartupSmokeDecision.startupSmokeContractReadyRealStartupBlocked,
      );
      expect(result.startupFeatureFlagEnabledByDefault, isFalse);
      expect(result.realRuntimeStartupExecuted, isFalse);
      expect(result.nativeRuntimeHandlerImplemented, isFalse);
      expect(result.methodChannelRuntimeBindingAdded, isFalse);
      expect(result.realPrivateArtifactFileLoaded, isFalse);
      expect(result.modelFormatProbeExecuted, isFalse);
      expect(result.runtimeWarmupCallExecuted, isFalse);
      expect(result.imageToLatexInferenceExecuted, isFalse);
      expect(result.ocrPassClaimed, isFalse);
    });

    test('requires artifact load, format probe, native runtime, ABI, timeout, and memory evidence', () {
      const preconditions = GaussFirstRealRuntimeStartupSmokePolicy.runtimeStartupSmokePreconditions;

      expect(preconditions, contains('q292-real-private-artifact-load-smoke-present'));
      expect(preconditions, contains('q292-real-private-artifact-load-still-pending'));
      expect(preconditions, contains('verified-private-artifact-required-before-runtime-startup'));
      expect(preconditions, contains('expected-actual-sha256-match-required-before-runtime-startup'));
      expect(preconditions, contains('model-format-probe-required-before-runtime-startup'));
      expect(preconditions, contains('native-runtime-package-required-before-runtime-startup'));
      expect(preconditions, contains('supported-android-abi-required-before-runtime-startup'));
      expect(preconditions, contains('startup-timeout-budget-required'));
      expect(preconditions, contains('memory-pressure-policy-required'));
      expect(preconditions, contains('runtime-startup-evidence-log-required'));
      expect(preconditions, contains('editable-mathlive-review-and-explicit-user-approval-remain-mandatory'));
      expect(preconditions, contains('direct-solve-graph-solution-history-remain-blocked-for-camera-output'));
      expect(preconditions, contains('no-real-runtime-startup-without-user-side-native-runtime-evidence'));
    });

    test('guards runtime startup request/result envelopes without starting native runtime', () {
      const request = GaussRuntimeStartupRequestEnvelope(
        requestId: 'q293-startup',
        engineLabel: 'PP-FormulaNet-S',
        verifiedPrivateArtifactPath: '/data/user/0/com.mathpro.flutter/files/models/pp_formulanet_s/verified',
        expectedSha256: 'bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb',
        actualSha256: 'bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb',
        runtimePackageId: 'pp-formulanet-s-runtime-candidate',
        androidAbi: 'arm64-v8a',
        startupTimeoutMs: 2800,
        startupFeatureFlagEnabled: true,
        modelFormatProbeStatus: 'passed',
        privateArtifactLoadStatus: 'passed',
      );

      final result = GaussFirstRealRuntimeStartupSmoke.guardedStartupSmoke(request);

      expect(result.status, 'blocked');
      expect(result.runtimeProcessStarted, isFalse);
      expect(result.modelArtifactOpened, isTrue);
      expect(result.modelFormatProbePassed, isTrue);
      expect(result.warmupCallExecuted, isFalse);
      expect(result.imageInferenceExecuted, isFalse);
      expect(result.errorCode, 'noRealRuntimeStartupExecutedInQ293');
      expect(result.reviewRequired, isTrue);
      expect(result.directWorkspaceMutationAttempted, isFalse);
      expect(result.canProceedToImageInference, isFalse);
      expect(result.canImportToWorkspace, isFalse);
      expect(result.canEvaluate, isFalse);
      expect(result.canGraph, isFalse);
      expect(result.canWriteSolutionOrHistory, isFalse);
    });

    test('does not mutate protected runtime files, pubspec dependencies, or bundle model/native artifacts', () {
      final pubspec = File('pubspec.yaml').readAsStringSync();
      final changed = File('docs/audit/V172_Q293_CHANGED_FILES.md').readAsStringSync();

      for (final forbidden in GaussFirstRealRuntimeStartupSmokePolicy.blockedDependencyFamilies) {
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
