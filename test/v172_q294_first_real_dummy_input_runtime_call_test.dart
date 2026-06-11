import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_first_real_dummy_input_runtime_call.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_first_real_dummy_input_runtime_call_policy.dart';

void main() {
  group('V172-Q294 First Real Dummy Input Runtime Call', () {
    test('keeps dummy input runtime call blocked until real startup and binding evidence exists', () {
      final result = GaussFirstRealDummyInputRuntimeCall.evaluate();

      expect(result.phase, GaussFirstRealDummyInputRuntimeCallPolicy.phase);
      expect(result.sourcePhase, 'V172-Q293-FIRST-REAL-RUNTIME-STARTUP-SMOKE');
      expect(result.selectedEngineLabel, 'PP-FormulaNet-S');
      expect(result.dummyCallFeatureFlag, 'gauss.ppFormulaNetS.firstRealDummyInputRuntimeCall.defaultOff');
      expect(
        result.dummyCallReadinessState,
        'BLOCKED_PENDING_Q293_REAL_RUNTIME_STARTUP_AND_METHOD_CHANNEL_EVIDENCE',
      );
      expect(
        result.decision,
        GaussFirstRealDummyInputRuntimeCallDecision.dummyInputRuntimeCallContractReadyRealCallBlocked,
      );
      expect(result.dummyCallFeatureFlagEnabledByDefault, isFalse);
      expect(result.realDummyInputRuntimeCallExecuted, isFalse);
      expect(result.nativeRuntimeStartupExecuted, isFalse);
      expect(result.nativeRuntimeHandlerImplemented, isFalse);
      expect(result.methodChannelRuntimeBindingAdded, isFalse);
      expect(result.realPrivateArtifactFileLoaded, isFalse);
      expect(result.modelFormatProbeExecuted, isFalse);
      expect(result.dummyInputFixtureSentToNativeRuntime, isFalse);
      expect(result.dummyRuntimeResponseParsed, isFalse);
      expect(result.imageToLatexInferenceExecuted, isFalse);
      expect(result.ocrPassClaimed, isFalse);
    });

    test('requires startup, MethodChannel, native handler, dummy fixture, timeout, and memory evidence', () {
      const preconditions = GaussFirstRealDummyInputRuntimeCallPolicy.dummyInputRuntimeCallPreconditions;

      expect(preconditions, contains('q293-first-real-runtime-startup-smoke-present'));
      expect(preconditions, contains('q293-real-runtime-startup-still-pending'));
      expect(preconditions, contains('verified-private-artifact-required-before-dummy-call'));
      expect(preconditions, contains('expected-actual-sha256-match-required-before-dummy-call'));
      expect(preconditions, contains('model-format-probe-required-before-dummy-call'));
      expect(preconditions, contains('native-runtime-startup-required-before-dummy-call'));
      expect(preconditions, contains('method-channel-binding-required-before-dummy-call'));
      expect(preconditions, contains('native-handler-required-before-dummy-call'));
      expect(preconditions, contains('deterministic-dummy-input-fixture-required'));
      expect(preconditions, contains('dummy-input-timeout-budget-required'));
      expect(preconditions, contains('memory-pressure-policy-required'));
      expect(preconditions, contains('dummy-input-evidence-log-required'));
      expect(preconditions, contains('editable-mathlive-review-and-explicit-user-approval-remain-mandatory'));
      expect(preconditions, contains('direct-solve-graph-solution-history-remain-blocked-for-camera-output'));
      expect(preconditions, contains('no-real-dummy-input-call-without-user-side-runtime-startup-evidence'));
    });

    test('guards dummy input request/result envelopes without invoking native runtime', () {
      const request = GaussDummyInputRuntimeCallRequestEnvelope(
        requestId: 'q294-dummy-call',
        engineLabel: 'PP-FormulaNet-S',
        runtimeSessionId: 'runtime-session-candidate',
        verifiedPrivateArtifactPath: '/data/user/0/com.mathpro.flutter/files/models/pp_formulanet_s/verified',
        expectedSha256: 'cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc',
        actualSha256: 'cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc',
        androidAbi: 'arm64-v8a',
        dummyInputFixtureId: 'blank-224x224-rgba-smoke-fixture',
        dummyInputPayloadHash: 'dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd',
        timeoutMs: 1600,
        dummyCallFeatureFlagEnabled: true,
        runtimeStartupStatus: 'passed',
        methodChannelBindingStatus: 'passed',
        nativeHandlerStatus: 'passed',
      );

      final result = GaussFirstRealDummyInputRuntimeCall.guardedDummyInputCall(request);

      expect(result.status, 'blocked');
      expect(result.runtimeSessionUsed, isTrue);
      expect(result.dummyInputSent, isFalse);
      expect(result.nativeRuntimeInvoked, isFalse);
      expect(result.dummyResponseParsed, isFalse);
      expect(result.imageInferenceExecuted, isFalse);
      expect(result.errorCode, 'noRealDummyInputRuntimeCallExecutedInQ294');
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
      final changed = File('docs/audit/V172_Q294_CHANGED_FILES.md').readAsStringSync();

      for (final forbidden in GaussFirstRealDummyInputRuntimeCallPolicy.blockedDependencyFamilies) {
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
