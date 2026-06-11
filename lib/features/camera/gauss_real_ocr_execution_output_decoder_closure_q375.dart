import 'gauss_real_ocr_execution_output_decoder_closure_q375_policy.dart';

class GaussRealOcrExecutionOutputDecoderClosureQ375Result {
  const GaussRealOcrExecutionOutputDecoderClosureQ375Result({
    required this.phase,
    required this.sourcePhase,
    required this.status,
    required this.bridgeChannel,
    required this.bridgeMethod,
    required this.decoderVersion,
    required this.outputDecoderImplemented,
    required this.outputDecoderDoesNotInventLatex,
    required this.decoderRequiresReadableModelOutputOrExplicitOverride,
    required this.requiresEditableMathLiveReviewBeforeImport,
    required this.requiresExplicitUserApprovalBeforeWorkspaceImport,
    required this.directOcrToWorkspaceImportBlocked,
    required this.directOcrToSolveGraphSolutionHistoryBlocked,
    required this.startupAutoExecutionBlocked,
    required this.cameraAutoExecutionBlocked,
    required this.workspaceAutoExecutionBlocked,
    required this.ocrPassClaimed,
  });

  final String phase;
  final String sourcePhase;
  final String status;
  final String bridgeChannel;
  final String bridgeMethod;
  final String decoderVersion;
  final bool outputDecoderImplemented;
  final bool outputDecoderDoesNotInventLatex;
  final bool decoderRequiresReadableModelOutputOrExplicitOverride;
  final bool requiresEditableMathLiveReviewBeforeImport;
  final bool requiresExplicitUserApprovalBeforeWorkspaceImport;
  final bool directOcrToWorkspaceImportBlocked;
  final bool directOcrToSolveGraphSolutionHistoryBlocked;
  final bool startupAutoExecutionBlocked;
  final bool cameraAutoExecutionBlocked;
  final bool workspaceAutoExecutionBlocked;
  final bool ocrPassClaimed;
}

class GaussRealOcrDecodedCandidateQ375 {
  const GaussRealOcrDecodedCandidateQ375({
    required this.candidateLatex,
    required this.candidateConfidence,
    required this.candidateSource,
    required this.candidateLatexDecoded,
    required this.decoderBlockedReason,
    required this.requiresEditableMathLiveReviewBeforeImport,
    required this.requiresExplicitUserApprovalBeforeWorkspaceImport,
    required this.directOcrToWorkspaceImportBlocked,
  });

  final String candidateLatex;
  final double candidateConfidence;
  final String candidateSource;
  final bool candidateLatexDecoded;
  final String decoderBlockedReason;
  final bool requiresEditableMathLiveReviewBeforeImport;
  final bool requiresExplicitUserApprovalBeforeWorkspaceImport;
  final bool directOcrToWorkspaceImportBlocked;

  Map<String, Object?> toJson() {
    return <String, Object?>{
      'phase': GaussRealOcrExecutionOutputDecoderClosureQ375Policy.phase,
      'candidateLatex': candidateLatex,
      'candidateConfidence': candidateConfidence,
      'candidateSource': candidateSource,
      'candidateLatexDecoded': candidateLatexDecoded,
      'decoderBlockedReason': decoderBlockedReason,
      'requiresEditableMathLiveReviewBeforeImport': requiresEditableMathLiveReviewBeforeImport,
      'requiresExplicitUserApprovalBeforeWorkspaceImport': requiresExplicitUserApprovalBeforeWorkspaceImport,
      'directOcrToWorkspaceImportBlocked': directOcrToWorkspaceImportBlocked,
      'ocrPassClaimed': false,
    };
  }
}

class GaussRealOcrExecutionOutputDecoderClosureQ375 {
  const GaussRealOcrExecutionOutputDecoderClosureQ375._();

  static GaussRealOcrExecutionOutputDecoderClosureQ375Result evaluate() {
    return const GaussRealOcrExecutionOutputDecoderClosureQ375Result(
      phase: GaussRealOcrExecutionOutputDecoderClosureQ375Policy.phase,
      sourcePhase: GaussRealOcrExecutionOutputDecoderClosureQ375Policy.sourcePhase,
      status: GaussRealOcrExecutionOutputDecoderClosureQ375Policy.status,
      bridgeChannel: GaussRealOcrExecutionOutputDecoderClosureQ375Policy.bridgeChannel,
      bridgeMethod: GaussRealOcrExecutionOutputDecoderClosureQ375Policy.bridgeMethod,
      decoderVersion: GaussRealOcrExecutionOutputDecoderClosureQ375Policy.decoderVersion,
      outputDecoderImplemented: true,
      outputDecoderDoesNotInventLatex: true,
      decoderRequiresReadableModelOutputOrExplicitOverride: true,
      requiresEditableMathLiveReviewBeforeImport: true,
      requiresExplicitUserApprovalBeforeWorkspaceImport: true,
      directOcrToWorkspaceImportBlocked: true,
      directOcrToSolveGraphSolutionHistoryBlocked: true,
      startupAutoExecutionBlocked: true,
      cameraAutoExecutionBlocked: true,
      workspaceAutoExecutionBlocked: true,
      ocrPassClaimed: false,
    );
  }

  static GaussRealOcrDecodedCandidateQ375 decodeEvidence(
    Map<String, Object?> evidence, {
    String explicitDecoderLatexOverride = '',
  }) {
    final imageEvidence = _asMap(evidence['imageEvidence']);
    final rawCandidate = _firstNonEmptyString(<Object?>[
      evidence['candidateLatex'],
      evidence['rawCandidateFromInference'],
      imageEvidence['candidateLatex'],
      imageEvidence['decodedLatex'],
      imageEvidence['primaryLatexCandidate'],
      imageEvidence['latex'],
    ]);
    final override = explicitDecoderLatexOverride.trim();
    final candidate = rawCandidate.isNotEmpty ? rawCandidate : override;
    final decoded = candidate.isNotEmpty;
    final blockedReason = decoded
        ? ''
        : _firstNonEmptyString(<Object?>[
            evidence['decoderBlockedReason'],
            imageEvidence['blockedReason'],
            'decoder-vocabulary-not-available-or-empty-model-output',
          ]);

    return GaussRealOcrDecodedCandidateQ375(
      candidateLatex: candidate,
      candidateConfidence: decoded ? _confidence(evidence['candidateConfidence']) : 0.0,
      candidateSource: rawCandidate.isNotEmpty
          ? 'q375-decoded-from-inference-evidence'
          : (override.isNotEmpty ? 'q375-explicit-decoder-override' : 'q375-no-candidate'),
      candidateLatexDecoded: decoded,
      decoderBlockedReason: blockedReason,
      requiresEditableMathLiveReviewBeforeImport: true,
      requiresExplicitUserApprovalBeforeWorkspaceImport: true,
      directOcrToWorkspaceImportBlocked: true,
    );
  }

  static Map<String, Object?> _asMap(Object? value) {
    if (value is Map) {
      return value.map((key, mapValue) => MapEntry(key.toString(), mapValue));
    }
    return const <String, Object?>{};
  }

  static String _firstNonEmptyString(List<Object?> values) {
    for (final value in values) {
      final text = value?.toString().trim() ?? '';
      if (text.isNotEmpty) return text;
    }
    return '';
  }

  static double _confidence(Object? value) {
    if (value is num) {
      final asDouble = value.toDouble();
      if (asDouble >= 0.0 && asDouble <= 1.0) return asDouble;
    }
    return 0.72;
  }
}
