import 'gauss_real_ocr_execution_output_decoder_closure_q375.dart';
import 'gauss_real_onnx_output_decoder_candidate_extraction_binding_q379_policy.dart';

class GaussRealOnnxOutputDecoderCandidateExtractionBindingQ379Result {
  const GaussRealOnnxOutputDecoderCandidateExtractionBindingQ379Result({
    required this.phase,
    required this.sourcePhase,
    required this.bridgeChannel,
    required this.bridgeMethod,
    required this.decoderVersion,
    required this.acceptsReadableStringOutput,
    required this.acceptsAsciiCodepointOutput,
    required this.acceptsTokenIdVocabularyOutput,
    required this.outputDecoderDoesNotInventLatex,
    required this.reviewRequiredBeforeImport,
    required this.explicitApprovalRequiredBeforeImport,
    required this.directOcrToWorkspaceBlocked,
    required this.directOcrToSolveGraphSolutionHistoryBlocked,
    required this.ocrPassClaimed,
  });

  final String phase;
  final String sourcePhase;
  final String bridgeChannel;
  final String bridgeMethod;
  final String decoderVersion;
  final bool acceptsReadableStringOutput;
  final bool acceptsAsciiCodepointOutput;
  final bool acceptsTokenIdVocabularyOutput;
  final bool outputDecoderDoesNotInventLatex;
  final bool reviewRequiredBeforeImport;
  final bool explicitApprovalRequiredBeforeImport;
  final bool directOcrToWorkspaceBlocked;
  final bool directOcrToSolveGraphSolutionHistoryBlocked;
  final bool ocrPassClaimed;

  Map<String, Object?> toJson() => <String, Object?>{
        'phase': phase,
        'sourcePhase': sourcePhase,
        'bridgeChannel': bridgeChannel,
        'bridgeMethod': bridgeMethod,
        'decoderVersion': decoderVersion,
        'acceptsReadableStringOutput': acceptsReadableStringOutput,
        'acceptsAsciiCodepointOutput': acceptsAsciiCodepointOutput,
        'acceptsTokenIdVocabularyOutput': acceptsTokenIdVocabularyOutput,
        'outputDecoderDoesNotInventLatex': outputDecoderDoesNotInventLatex,
        'reviewRequiredBeforeImport': reviewRequiredBeforeImport,
        'explicitApprovalRequiredBeforeImport': explicitApprovalRequiredBeforeImport,
        'directOcrToWorkspaceBlocked': directOcrToWorkspaceBlocked,
        'directOcrToSolveGraphSolutionHistoryBlocked': directOcrToSolveGraphSolutionHistoryBlocked,
        'ocrPassClaimed': ocrPassClaimed,
      };
}

class GaussRealOnnxOutputDecoderCandidateExtractionBindingQ379 {
  const GaussRealOnnxOutputDecoderCandidateExtractionBindingQ379._();

  static GaussRealOnnxOutputDecoderCandidateExtractionBindingQ379Result evaluate() {
    return const GaussRealOnnxOutputDecoderCandidateExtractionBindingQ379Result(
      phase: GaussRealOnnxOutputDecoderCandidateExtractionBindingQ379Policy.phase,
      sourcePhase: GaussRealOnnxOutputDecoderCandidateExtractionBindingQ379Policy.sourcePhase,
      bridgeChannel: GaussRealOnnxOutputDecoderCandidateExtractionBindingQ379Policy.bridgeChannel,
      bridgeMethod: GaussRealOnnxOutputDecoderCandidateExtractionBindingQ379Policy.bridgeMethod,
      decoderVersion: GaussRealOnnxOutputDecoderCandidateExtractionBindingQ379Policy.decoderVersion,
      acceptsReadableStringOutput: true,
      acceptsAsciiCodepointOutput: true,
      acceptsTokenIdVocabularyOutput: true,
      outputDecoderDoesNotInventLatex: true,
      reviewRequiredBeforeImport: true,
      explicitApprovalRequiredBeforeImport: true,
      directOcrToWorkspaceBlocked: true,
      directOcrToSolveGraphSolutionHistoryBlocked: true,
      ocrPassClaimed: false,
    );
  }

  static GaussRealOcrDecodedCandidateQ375 decodeEvidence(Map<String, Object?> evidence) {
    return GaussRealOcrExecutionOutputDecoderClosureQ375.decodeEvidence(
      evidence,
      explicitDecoderLatexOverride: evidence['decoderLatexOverride']?.toString() ?? '',
    );
  }
}
