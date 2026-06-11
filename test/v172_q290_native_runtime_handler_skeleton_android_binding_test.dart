import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_native_runtime_handler_skeleton_android_binding.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_native_runtime_handler_skeleton_android_binding_policy.dart';

void main() {
  group('V172-Q290 Native Runtime Handler Skeleton Android Binding', () {
    test('declares only the default-off skeleton contract and blocks runtime binding', () {
      final result = GaussNativeRuntimeHandlerSkeletonAndroidBinding.evaluate();

      expect(result.phase, GaussNativeRuntimeHandlerSkeletonAndroidBindingPolicy.phase);
      expect(result.sourcePhase, 'V172-Q289-RUNTIME-DEPENDENCY-ACTUAL-TRIAL-BEHIND-DEFAULT-OFF-FLAG');
      expect(result.selectedEngineLabel, 'PP-FormulaNet-S');
      expect(result.reservedMethodChannelName, 'com.mathpro.gauss/pp_formulanet_s_runtime');
      expect(result.reservedNativeHandlerName, 'GaussPpFormulaNetSRuntimeHandler');
      expect(result.bridgeFeatureFlag, 'gauss.ppFormulaNetS.nativeRuntimeHandler.defaultOff');
      expect(result.decision, GaussNativeRuntimeHandlerSkeletonAndroidBindingDecision.skeletonContractReadyRuntimeBindingBlocked);
      expect(result.bridgeFeatureFlagEnabledByDefault, isFalse);
      expect(result.nativeHandlerImplementationAdded, isFalse);
      expect(result.androidBindingImplementationAdded, isFalse);
      expect(result.methodChannelRuntimeBindingAdded, isFalse);
      expect(result.realOcrRuntimeAdded, isFalse);
      expect(result.paddleRuntimeAdded, isFalse);
      expect(result.modelBinaryBundledInBaseApp, isFalse);
      expect(result.imageToLatexInferenceExecuted, isFalse);
      expect(result.ocrPassClaimed, isFalse);
    });

    test('documents request, response and error envelopes without invoking OCR', () {
      expect(
        GaussNativeRuntimeHandlerSkeletonAndroidBindingPolicy.requestEnvelopeFields,
        containsAll(<String>[
          'requestId',
          'croppedImagePrivatePath',
          'verifiedArtifactPrivatePath',
          'expectedArtifactSha256',
          'actualArtifactSha256',
          'androidAbi',
          'reviewOnlyMode',
          'runtimeFeatureFlagEnabled',
        ]),
      );
      expect(
        GaussNativeRuntimeHandlerSkeletonAndroidBindingPolicy.responseEnvelopeFields,
        containsAll(<String>[
          'primaryLatexCandidate',
          'alternativeLatexCandidates',
          'latencyMs',
          'peakMemoryMb',
          'reviewRequired',
          'directWorkspaceMutationAttempted',
        ]),
      );
      expect(
        GaussNativeRuntimeHandlerSkeletonAndroidBindingPolicy.bridgeErrorCodes,
        containsAll(<String>[
          'runtimeFeatureFlagOff',
          'nativeHandlerNotImplemented',
          'methodChannelNotBound',
          'artifactShaMismatch',
          'unsupportedAbi',
          'timeout',
          'memoryPressure',
        ]),
      );
    });

    test('does not mutate protected Android, MathLive, camera, keyboard or dependency files', () {
      final pubspec = File('pubspec.yaml').readAsStringSync();
      final changed = File('docs/audit/V172_Q290_CHANGED_FILES.md').readAsStringSync();

      for (final forbidden in GaussNativeRuntimeHandlerSkeletonAndroidBindingPolicy.blockedDependencyFamilies) {
        expect(pubspec, isNot(contains(forbidden)));
      }

      expect(pubspec, contains('camera: 0.10.6'));
      expect(pubspec, contains('camera_android: 0.10.9+3'));
      expect(pubspec, isNot(contains('camera_android_camerax')));
      expect(changed, isNot(contains('- `android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt`')));
      expect(changed, isNot(contains('- `android/app/src/main/AndroidManifest.xml`')));
      expect(changed, isNot(contains('- `assets/mathlive/mathlive_prod_bridge.js`')));
      expect(changed, isNot(contains('- `lib/features/mathlive/mathlive_production_editor_surface.dart`')));
      expect(changed, isNot(contains('- `lib/features/camera/gauss_camera_capture_shell.dart`')));
      expect(changed, isNot(contains('- `lib/features/keyboard/key_config.dart`')));
    });
  });
}
