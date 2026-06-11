import 'package:flutter/services.dart';

import 'gauss_real_camera_ocr_user_flow_binding_q378_policy.dart';
import 'gauss_camera_ocr_runtime_finalization_q381_policy.dart';
import 'gauss_real_editable_review_approved_workspace_import_binding_q376.dart';
import 'gauss_real_ocr_execution_output_decoder_closure_q375.dart';

class GaussRealCameraOcrUserFlowBindingQ378Evidence {
  const GaussRealCameraOcrUserFlowBindingQ378Evidence({
    required this.phase,
    required this.status,
    required this.imagePath,
    required this.nativeEvidence,
    required this.decodedCandidate,
    required this.reviewDraft,
    required this.blockedReason,
  });

  final String phase;
  final String status;
  final String imagePath;
  final Map<String, Object?> nativeEvidence;
  final GaussRealOcrDecodedCandidateQ375 decodedCandidate;
  final GaussEditableOcrReviewDraftQ376 reviewDraft;
  final String blockedReason;

  bool get hasDecodedCandidate => decodedCandidate.candidateLatexDecoded;
  bool get reviewReady => reviewDraft.reviewReady;

  Map<String, Object?> toJson() {
    return <String, Object?>{
      'phase': phase,
      'status': status,
      'imagePath': imagePath,
      'nativeEvidence': nativeEvidence,
      'decodedCandidate': decodedCandidate.toJson(),
      'reviewDraft': reviewDraft.toJson(),
      'blockedReason': blockedReason,
      'hasDecodedCandidate': hasDecodedCandidate,
      'reviewReady': reviewReady,
      'directOcrToWorkspaceImportBlocked': true,
      'directOcrToSolveGraphSolutionHistoryBlocked': true,
      'ocrPassClaimed': false,
    };
  }
}

class GaussRealCameraOcrUserFlowBindingQ378ImportResult {
  const GaussRealCameraOcrUserFlowBindingQ378ImportResult({
    required this.phase,
    required this.command,
    required this.importCallbackInvoked,
    required this.mathLiveControllerSyncRequested,
    required this.workspaceStateSyncRequested,
    required this.solveGraphSolutionHistoryTouched,
  });

  final String phase;
  final GaussApprovedWorkspaceImportCommandQ376 command;
  final bool importCallbackInvoked;
  final bool mathLiveControllerSyncRequested;
  final bool workspaceStateSyncRequested;
  final bool solveGraphSolutionHistoryTouched;

  bool get workspaceImportReady => command.approvedWorkspaceImportReady;

  Map<String, Object?> toJson() {
    return <String, Object?>{
      'phase': phase,
      'command': command.toJson(),
      'workspaceImportReady': workspaceImportReady,
      'importCallbackInvoked': importCallbackInvoked,
      'mathLiveControllerSyncRequested': mathLiveControllerSyncRequested,
      'workspaceStateSyncRequested': workspaceStateSyncRequested,
      'solveGraphSolutionHistoryTouched': solveGraphSolutionHistoryTouched,
      'ocrPassClaimed': false,
    };
  }
}

class GaussRealCameraOcrUserFlowBindingQ378 {
  const GaussRealCameraOcrUserFlowBindingQ378._();

  static const MethodChannel channel = MethodChannel(
    GaussRealCameraOcrUserFlowBindingQ378Policy.bridgeChannel,
  );

  static Future<GaussRealCameraOcrUserFlowBindingQ378Evidence> captureAndPrepareReview({
    required String imagePath,
    int rotationQuarterTurns = 0,
    String modelSourcePath = '',
    String decoderLatexOverride = '',
  }) async {
    final trimmedImagePath = imagePath.trim();
    if (trimmedImagePath.isEmpty) {
      final decoded = GaussRealOcrExecutionOutputDecoderClosureQ375.decodeEvidence(
        const <String, Object?>{'decoderBlockedReason': 'q378-image-path-empty'},
      );
      final reviewDraft = GaussRealEditableReviewApprovedWorkspaceImportBindingQ376.prepareReviewDraft(decoded);
      return GaussRealCameraOcrUserFlowBindingQ378Evidence(
        phase: GaussRealCameraOcrUserFlowBindingQ378Policy.phase,
        status: 'BLOCKED',
        imagePath: '',
        nativeEvidence: const <String, Object?>{'blockedReason': 'q378-image-path-empty'},
        decodedCandidate: decoded,
        reviewDraft: reviewDraft,
        blockedReason: 'q378-image-path-empty',
      );
    }

    // Q389R2_OFFLINE: backend/endpoint image upload is forbidden. The only
    // production path is the local device-only Paddle Lite Formula OCR bundle.

    final response = await channel.invokeMapMethod<String, Object?>(
      GaussCameraOcrRuntimeFinalizationQ381Policy.bridgeMethod,
      <String, Object?>{
        'imagePath': trimmedImagePath,
        'sourceImagePath': trimmedImagePath,
        'rotationQuarterTurns': rotationQuarterTurns,
        'cropFrameWidthFactor': GaussCameraOcrRuntimeFinalizationQ381Policy.normalizedCropFrameWidth,
        'cropFrameHeightFactor': GaussCameraOcrRuntimeFinalizationQ381Policy.normalizedCropFrameHeight,
        'modelSourcePath': modelSourcePath.trim().isEmpty ? null : modelSourcePath.trim(),
        'decoderLatexOverride': decoderLatexOverride.trim().isEmpty ? null : decoderLatexOverride.trim(),
        'q378BindingVersion': GaussRealCameraOcrUserFlowBindingQ378Policy.bindingVersion,
        'q381BindingVersion': GaussCameraOcrRuntimeFinalizationQ381Policy.bindingVersion,
      },
    );
    final evidence = response ?? <String, Object?>{
      'phase': GaussRealCameraOcrUserFlowBindingQ378Policy.phase,
      'status': 'NO_NATIVE_RESPONSE',
      'blockedReason': 'q378-native-decoder-no-response',
      'candidateLatex': '',
      'candidateConfidence': 0.0,
    };
    final decoded = GaussRealOcrExecutionOutputDecoderClosureQ375.decodeEvidence(evidence);
    final reviewDraft = GaussRealEditableReviewApprovedWorkspaceImportBindingQ376.prepareReviewDraft(decoded);
    final blockedReason = decoded.candidateLatexDecoded
        ? ''
        : (decoded.decoderBlockedReason.trim().isNotEmpty
            ? decoded.decoderBlockedReason.trim()
            : 'q378-decoded-candidate-not-ready');
    return GaussRealCameraOcrUserFlowBindingQ378Evidence(
      phase: GaussRealCameraOcrUserFlowBindingQ378Policy.phase,
      status: decoded.candidateLatexDecoded ? 'REVIEW_READY' : 'BLOCKED',
      imagePath: trimmedImagePath,
      nativeEvidence: evidence,
      decodedCandidate: decoded,
      reviewDraft: reviewDraft,
      blockedReason: blockedReason,
    );
  }

  static GaussRealCameraOcrUserFlowBindingQ378ImportResult prepareApprovedImport({
    required GaussEditableOcrReviewDraftQ376 reviewDraft,
    required String approvedLatex,
    required bool explicitUserApproval,
  }) {
    final command = GaussRealEditableReviewApprovedWorkspaceImportBindingQ376.buildApprovedWorkspaceImportCommand(
      reviewDraft: reviewDraft,
      reviewCompleted: true,
      explicitUserApproval: explicitUserApproval,
      approvedLatexOverride: approvedLatex,
    );
    return GaussRealCameraOcrUserFlowBindingQ378ImportResult(
      phase: GaussRealCameraOcrUserFlowBindingQ378Policy.phase,
      command: command,
      importCallbackInvoked: command.approvedWorkspaceImportReady,
      mathLiveControllerSyncRequested: command.approvedWorkspaceImportReady,
      workspaceStateSyncRequested: command.approvedWorkspaceImportReady,
      solveGraphSolutionHistoryTouched: false,
    );
  }
}
