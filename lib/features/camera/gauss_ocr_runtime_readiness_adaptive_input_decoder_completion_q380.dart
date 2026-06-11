import 'gauss_ocr_runtime_readiness_adaptive_input_decoder_completion_q380_policy.dart';

class GaussOcrRuntimeReadinessAdaptiveInputDecoderCompletionQ380Result {
  const GaussOcrRuntimeReadinessAdaptiveInputDecoderCompletionQ380Result({
    required this.phase,
    required this.sourcePhase,
    required this.bridgeChannel,
    required this.bridgeMethod,
    required this.decoderVersion,
    required this.privateStoragePreflightRequired,
    required this.adaptiveInputMetadataEnabled,
    required this.logitVocabularyDecoderEnabled,
    required this.fakeLatexGenerationBlocked,
    required this.editableReviewRequired,
    required this.explicitWorkspaceImportApprovalRequired,
    required this.directSolveGraphSolutionHistoryBlocked,
    required this.ocrPassClaimed,
  });

  final String phase;
  final String sourcePhase;
  final String bridgeChannel;
  final String bridgeMethod;
  final String decoderVersion;
  final bool privateStoragePreflightRequired;
  final bool adaptiveInputMetadataEnabled;
  final bool logitVocabularyDecoderEnabled;
  final bool fakeLatexGenerationBlocked;
  final bool editableReviewRequired;
  final bool explicitWorkspaceImportApprovalRequired;
  final bool directSolveGraphSolutionHistoryBlocked;
  final bool ocrPassClaimed;

  Map<String, Object?> toJson() => <String, Object?>{
        'phase': phase,
        'sourcePhase': sourcePhase,
        'bridgeChannel': bridgeChannel,
        'bridgeMethod': bridgeMethod,
        'decoderVersion': decoderVersion,
        'privateStoragePreflightRequired': privateStoragePreflightRequired,
        'adaptiveInputMetadataEnabled': adaptiveInputMetadataEnabled,
        'logitVocabularyDecoderEnabled': logitVocabularyDecoderEnabled,
        'fakeLatexGenerationBlocked': fakeLatexGenerationBlocked,
        'editableReviewRequired': editableReviewRequired,
        'explicitWorkspaceImportApprovalRequired': explicitWorkspaceImportApprovalRequired,
        'directSolveGraphSolutionHistoryBlocked': directSolveGraphSolutionHistoryBlocked,
        'ocrPassClaimed': ocrPassClaimed,
      };
}

class GaussOcrRuntimeReadinessAdaptiveInputDecoderCompletionQ380 {
  const GaussOcrRuntimeReadinessAdaptiveInputDecoderCompletionQ380._();

  static GaussOcrRuntimeReadinessAdaptiveInputDecoderCompletionQ380Result evaluate() {
    return const GaussOcrRuntimeReadinessAdaptiveInputDecoderCompletionQ380Result(
      phase: GaussOcrRuntimeReadinessAdaptiveInputDecoderCompletionQ380Policy.phase,
      sourcePhase: GaussOcrRuntimeReadinessAdaptiveInputDecoderCompletionQ380Policy.sourcePhase,
      bridgeChannel: GaussOcrRuntimeReadinessAdaptiveInputDecoderCompletionQ380Policy.bridgeChannel,
      bridgeMethod: GaussOcrRuntimeReadinessAdaptiveInputDecoderCompletionQ380Policy.bridgeMethod,
      decoderVersion: GaussOcrRuntimeReadinessAdaptiveInputDecoderCompletionQ380Policy.decoderVersion,
      privateStoragePreflightRequired: true,
      adaptiveInputMetadataEnabled: true,
      logitVocabularyDecoderEnabled: true,
      fakeLatexGenerationBlocked: true,
      editableReviewRequired: true,
      explicitWorkspaceImportApprovalRequired: true,
      directSolveGraphSolutionHistoryBlocked: true,
      ocrPassClaimed: false,
    );
  }
}
