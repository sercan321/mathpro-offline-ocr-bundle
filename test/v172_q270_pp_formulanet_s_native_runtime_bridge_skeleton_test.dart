import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_pp_formulanet_s_native_runtime_bridge_skeleton.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_pp_formulanet_s_native_runtime_bridge_skeleton_policy.dart';

void main() {
  group('V172-Q270-PP-FORMULANET-S-NATIVE-RUNTIME-BRIDGE-SKELETON', () {
    const approvedInput = GaussPpFormulaNetSNativeRuntimeBridgeSkeletonInput(
      q269RuntimeDependencyIsolationPresent: true,
      q269StillNoRuntimeDependencyNoInference: true,
      runtimeBridgeCandidateDocumented: true,
      methodChannelProtocolDocumented: true,
      jniProtocolDocumented: true,
      bridgeInputImagePathEnvelopeDocumented: true,
      bridgeOutputLatexCandidateEnvelopeDocumented: true,
      bridgeErrorCodeTaxonomyDocumented: true,
      timeoutCancellationPolicyDocumented: true,
      memoryPressurePolicyDocumented: true,
      latencyBudgetMs: 2500,
      peakMemoryBudgetMb: 384,
      featureFlagDefaultOffDocumented: true,
      noDefaultRuntimeEnablement: true,
      fallbackPlanDocumented: true,
      formulaOcrPrimaryOnly: true,
      editableMathLiveReviewRequired: true,
      userApprovalRequiredBeforeWorkspaceImport: true,
      directSolveBlocked: true,
      directGraphSolutionHistoryBlocked: true,
      noPaddleRuntimeAdded: true,
      noPaddleOcrDependencyAdded: true,
      noNativeBridgeImplementationAdded: true,
      noJniBindingAdded: true,
      noMethodChannelRuntimeBindingAdded: true,
      noModelBinaryBundledInBaseApp: true,
      noProductionModelUrlBound: true,
      noRealNetworkDownloadWorkerImplemented: true,
      productionDownloadEnabled: false,
      noProductionInferenceAllowed: true,
      bridgeSkeletonPassClaimed: false,
      ocrPassClaimed: false,
      bridgeSkeletonLabel: 'Q270 ready for future native runtime bridge prototype only',
    );

    test('gates bridge skeleton without runtime binding or inference in Q270', () {
      final result = GaussPpFormulaNetSNativeRuntimeBridgeSkeleton.evaluate(approvedInput);

      expect(result.decision, GaussPpFormulaNetSNativeRuntimeBridgeSkeletonDecision.readyForFutureNativeRuntimeBridgePrototypeOnly);
      expect(result.nativeRuntimeBridgeSkeletonStaticReady, isTrue);
      expect(result.readyForFutureNativeRuntimeBridgePrototypeOnly, isTrue);
      expect(result.phase, GaussPpFormulaNetSNativeRuntimeBridgeSkeletonPolicy.phase);
      expect(result.sourcePhase, GaussPpFormulaNetSNativeRuntimeBridgeSkeletonPolicy.sourcePhase);
      expect(result.selectedEngineLabel, 'PP-FormulaNet-S');
      expect(result.bridgeSkeletonMode, 'native-runtime-bridge-skeleton-gate-only-no-native-runtime-no-inference');
      expect(result.requiredBridgeSkeletonGates, contains('methodChannelProtocolDocumented'));
      expect(result.requiredBridgeSkeletonGates, contains('jniProtocolDocumented'));
      expect(result.requiredBridgeSkeletonGates, contains('bridgeInputImagePathEnvelopeDocumented'));
      expect(result.requiredBridgeSkeletonGates, contains('bridgeOutputLatexCandidateEnvelopeDocumented'));
      expect(result.bridgeInputEnvelopeFields, contains('croppedImagePath'));
      expect(result.bridgeOutputEnvelopeFields, contains('primaryLatexCandidate'));
      expect(result.bridgeErrorCodes, contains('timeout'));
      expect(result.bridgeSkeletonStrategies, contains('featureFlagDefaultOffBridgeSkeleton'));
      expect(result.forbiddenActions, contains('addNativeBridgeImplementationInQ270'));
      expect(result.realOcrRuntimeAdded, isFalse);
      expect(result.paddleRuntimeAdded, isFalse);
      expect(result.paddleOcrDependencyAdded, isFalse);
      expect(result.nativeBridgeImplementationAdded, isFalse);
      expect(result.jniBindingAdded, isFalse);
      expect(result.methodChannelRuntimeBindingAdded, isFalse);
      expect(result.modelBinaryBundledInBaseApp, isFalse);
      expect(result.productionDownloadEnabled, isFalse);
      expect(result.productionInferenceAllowed, isFalse);
      expect(result.runtimeFeatureFlagDefaultOff, isTrue);
      expect(result.bridgeSkeletonPassClaimed, isFalse);
      expect(result.ocrPassClaimed, isFalse);
      expect(result.canImplementNativeBridgeInQ270, isFalse);
      expect(result.canBindRuntimeMethodChannelInQ270, isFalse);
      expect(result.canClaimBridgeSkeletonPassInQ270, isFalse);
      expect(result.canClaimOcrPassInQ270, isFalse);
      expect(result.canEnableRuntimeBridgeByDefaultInQ270, isFalse);
      expect(result.canImportCameraOutputWithoutUserApproval, isFalse);
    });

    test('keeps runtime dependencies absent from pubspec during Q270', () {
      final pubspec = File('pubspec.yaml').readAsStringSync().toLowerCase();
      expect(pubspec, contains('camera: 0.10.6'));
      expect(pubspec, contains('camera_android: 0.10.9+3'));
      for (final forbidden in <String>[
        'google_mlkit_text_recognition',
        'paddleocr',
        'paddle_flutter',
        'paddle_lite',
        'onnxruntime',
        'tesseract',
        'pix2text',
        'flutter_downloader',
        'background_downloader',
        'dio',
      ]) {
        expect(pubspec.contains(forbidden), isFalse, reason: 'Q270 must not add $forbidden');
      }
    });
  });
}
