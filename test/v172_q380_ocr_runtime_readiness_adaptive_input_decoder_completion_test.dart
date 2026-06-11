import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_ocr_runtime_readiness_adaptive_input_decoder_completion_q380.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_ocr_runtime_readiness_adaptive_input_decoder_completion_q380_policy.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_real_camera_ocr_user_flow_binding_q378_policy.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_store_privacy_final_release_gate_q363_policy.dart';

void main() {
  test('q380 records adaptive runtime decoder completion without OCR pass claim', () {
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
    final q380 = manifest['v172Q380OcrRuntimeReadinessAdaptiveInputDecoderCompletion'] as Map<String, dynamic>;

    expect(manifest['cameraOcrLatestPhase'], GaussStorePrivacyFinalReleaseGateQ363Policy.phase);
    expect(manifest['activeProductDevelopmentLatestPhase'], GaussStorePrivacyFinalReleaseGateQ363Policy.phase);
    expect(manifest['ocrRuntimeReadinessAdaptiveInputDecoderCompletionLatestPhase'], GaussOcrRuntimeReadinessAdaptiveInputDecoderCompletionQ380Policy.phase);
    expect(q380['phase'], GaussOcrRuntimeReadinessAdaptiveInputDecoderCompletionQ380Policy.phase);
    expect(q380['q378CameraFlowUsesQ380Bridge'], isTrue);
    expect(q380['privateStoragePreflightBeforeInference'], isTrue);
    expect(q380['adaptiveOnnxInputMetadataShapeEnabled'], isTrue);
    expect(q380['floatLogitVocabularyArgmaxDecoderImplemented'], isTrue);
    expect(q380['fakeLatexGenerationBlocked'], isTrue);
    expect(q380['editableMathLiveReviewRequiredBeforeImport'], isTrue);
    expect(q380['explicitUserApprovalRequiredBeforeWorkspaceImport'], isTrue);
    expect(q380['solveGraphSolutionHistoryAutoTriggerBlocked'], isTrue);
    expect(q380['ocrPassClaimedByPackage'], isFalse);
  });

  test('q380 Dart policy exposes review-first adaptive runtime invariants', () {
    final result = GaussOcrRuntimeReadinessAdaptiveInputDecoderCompletionQ380.evaluate();
    expect(result.phase, GaussOcrRuntimeReadinessAdaptiveInputDecoderCompletionQ380Policy.phase);
    expect(result.bridgeMethod, GaussOcrRuntimeReadinessAdaptiveInputDecoderCompletionQ380Policy.bridgeMethod);
    expect(result.privateStoragePreflightRequired, isTrue);
    expect(result.adaptiveInputMetadataEnabled, isTrue);
    expect(result.logitVocabularyDecoderEnabled, isTrue);
    expect(result.fakeLatexGenerationBlocked, isTrue);
    expect(result.editableReviewRequired, isTrue);
    expect(result.explicitWorkspaceImportApprovalRequired, isTrue);
    expect(result.directSolveGraphSolutionHistoryBlocked, isTrue);
    expect(result.ocrPassClaimed, isFalse);
  });

  test('q380 camera flow uses adaptive decoder bridge and native code contains adaptive markers', () {
    final q378Policy = File('lib/features/camera/gauss_real_camera_ocr_user_flow_binding_q378_policy.dart').readAsStringSync();
    final mainActivity = File('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt').readAsStringSync();

    expect(GaussRealCameraOcrUserFlowBindingQ378Policy.decoderBridgeMethod, GaussOcrRuntimeReadinessAdaptiveInputDecoderCompletionQ380Policy.bridgeMethod);
    expect(q378Policy, contains("decoderBridgeMethod = 'ocrRuntimeReadinessAdaptiveInputDecoderCompletion'"));
    expect(mainActivity, contains('q380OcrRuntimeReadinessAdaptiveInputDecoderCompletion'));
    expect(mainActivity, contains('q380ResolveInputTensorPlan'));
    expect(mainActivity, contains('q380BuildImageTensorValues'));
    expect(mainActivity, contains('q380DecodeFloatLogitsWithVocabulary'));
    expect(mainActivity, contains('privateStorageActivationEvidence'));
    expect(mainActivity, contains('adaptiveInputLayout'));
    expect(mainActivity, contains('directOcrToSolveGraphSolutionHistoryBlocked'));
  });
}
