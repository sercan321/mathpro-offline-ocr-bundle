import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_paddle_runtime_abi_trim_delivery_guard_q385.dart';

void main() {
  group('V172-Q385 Paddle runtime ABI trim and delivery guard', () {
    test('policy keeps model download-only while narrowing base runtime delivery to arm64', () {
      expect(
        GaussPaddleRuntimeAbiTrimDeliveryGuardQ385Policy.phase,
        'V172-Q385-PADDLE-RUNTIME-ABI-TRIM-AND-DELIVERY-GUARD',
      );
      expect(
        GaussPaddleRuntimeAbiTrimDeliveryGuardQ385Policy.sourcePhase,
        'V172-Q384R2-CAMERA-OCR-RUNTIME-MODEL-FORMAT-BINDING-PREFLIGHT',
      );
      expect(GaussPaddleRuntimeAbiTrimDeliveryGuardQ385Policy.baseRuntimeDeliveryMode, 'base-apk-arm64-v8a-only-paddle-lite-runtime-model-download-only');
      expect(GaussPaddleRuntimeAbiTrimDeliveryGuardQ385Policy.packagedBaseAbi, 'arm64-v8a');
      expect(GaussPaddleRuntimeAbiTrimDeliveryGuardQ385Policy.gradleAbiFilterContract, "abiFilters 'arm64-v8a'");
      expect(GaussPaddleRuntimeAbiTrimDeliveryGuardQ385Policy.modelBinaryBundledInBaseApp, isFalse);
      expect(GaussPaddleRuntimeAbiTrimDeliveryGuardQ385Policy.ppFormulaNetSModelRemainsDeferredDownload, isTrue);
      expect(GaussPaddleRuntimeAbiTrimDeliveryGuardQ385Policy.onnxRuntimeReintroducedInBaseApk, isFalse);
      expect(GaussPaddleRuntimeAbiTrimDeliveryGuardQ385Policy.paddleLiteRuntimeKeptInBaseForCurrentBridge, isTrue);
      expect(GaussPaddleRuntimeAbiTrimDeliveryGuardQ385Policy.arm64OnlyBaseRuntimePackagingEnabled, isTrue);
      expect(GaussPaddleRuntimeAbiTrimDeliveryGuardQ385Policy.armeabiV7aPackagedInBaseRelease, isFalse);
      expect(GaussPaddleRuntimeAbiTrimDeliveryGuardQ385Policy.x86OrX64PackagedInBaseRelease, isFalse);
      expect(GaussPaddleRuntimeAbiTrimDeliveryGuardQ385Policy.nativeRuntimeNetworkDownloadAllowed, isFalse);
      expect(GaussPaddleRuntimeAbiTrimDeliveryGuardQ385Policy.playFeatureDeliveryRuntimeModuleImplemented, isFalse);
      expect(GaussPaddleRuntimeAbiTrimDeliveryGuardQ385Policy.productionInferenceClaimedByQ385, isFalse);
    });

    test('base runtime file list preserves only current safe bridge expectations', () {
      expect(GaussPaddleRuntimeAbiTrimDeliveryGuardQ385Policy.retainedBaseRuntimeFiles, containsAll(<String>[
        'android/app/libs/PaddlePredictor.jar',
        'android/app/src/main/jniLibs/arm64-v8a/libpaddle_lite_jni.so',
      ]));
      expect(GaussPaddleRuntimeAbiTrimDeliveryGuardQ385Policy.fakeLatexCandidateAllowed, isFalse);
      expect(GaussPaddleRuntimeAbiTrimDeliveryGuardQ385Policy.workspaceAutoImportAllowed, isFalse);
      expect(GaussPaddleRuntimeAbiTrimDeliveryGuardQ385Policy.solveGraphSolutionHistoryTouched, isFalse);
    });
  });
}
