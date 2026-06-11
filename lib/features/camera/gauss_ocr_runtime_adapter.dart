import 'gauss_deferred_model_download_runtime.dart';
import 'gauss_ocr_runtime_adapter_policy.dart';
import 'gauss_pp_formulanet_s_user_selection.dart';

/// Capture/crop input contract for the future PP-FormulaNet-S adapter.
///
/// The adapter receives only already-captured image context. Q249 does not open
/// the camera, crop images, download models, or execute OCR.
class GaussOcrRuntimeAdapterInput {
  const GaussOcrRuntimeAdapterInput({
    required this.capturePath,
    required this.cropFrameId,
    required this.rotationQuarterTurns,
    required this.modelEvidence,
    required this.preprocessProfile,
    required this.sourcePhase,
  });

  final String capturePath;
  final String cropFrameId;
  final int rotationQuarterTurns;
  final GaussDeferredModelArtifactEvidence modelEvidence;
  final String preprocessProfile;
  final String sourcePhase;

  bool get hasCapturePath => capturePath.trim().isNotEmpty;
  bool get hasCropFrame => cropFrameId.trim().isNotEmpty;
  int get rotationDegrees => (rotationQuarterTurns % 4) * 90;
  bool get fromQ248ReadinessPhase => sourcePhase == GaussDeferredModelDownloadRuntime.phase;
}

enum GaussOcrRuntimeAdapterDecision {
  blockedByDeferredModelGate,
  blockedMissingCapture,
  blockedMissingCropFrame,
  blockedUnsafeCandidate,
  reviewOnlyEnvelopeReady,
}

enum GaussOcrRuntimeWarningCode {
  lowConfidence,
  lowLight,
  skewedCapture,
  mildBlur,
  possibleSubscriptAmbiguity,
  possibleIntegralLimitAmbiguity,
  possibleFractionGroupingAmbiguity,
  modelRuntimeUnavailable,
}

/// Future OCR candidate shape emitted by the PP-FormulaNet-S adapter.
///
/// This is a candidate contract, not a production inference result in Q249.
class GaussOcrRuntimeLatexCandidate {
  const GaussOcrRuntimeLatexCandidate({
    required this.rank,
    required this.latex,
    required this.confidence,
    required this.engineLabel,
    required this.warningCodes,
    required this.reviewOnly,
  });

  final int rank;
  final String latex;
  final double confidence;
  final String engineLabel;
  final List<GaussOcrRuntimeWarningCode> warningCodes;
  final bool reviewOnly;

  bool get hasLatex => latex.trim().isNotEmpty;
  bool get confidenceInRange => confidence >= 0 && confidence <= 1;
  bool get usesSelectedEngine => engineLabel == GaussPpFormulaNetSUserSelection.selectedEngineLabel;
  bool get requiresEditableMathLiveReview => reviewOnly;
  bool get directWorkspaceImportAllowed => false;
  bool get directSolveAllowed => false;
  bool get graphAllowedBeforeReview => false;
  bool get solutionAllowedBeforeReview => false;
  bool get historyWriteAllowedBeforeReview => false;
}

class GaussOcrRuntimeAdapterEnvelope {
  const GaussOcrRuntimeAdapterEnvelope({
    required this.phase,
    required this.decision,
    required this.input,
    required this.primaryCandidate,
    required this.alternativeCandidates,
    required this.issues,
    required this.modelReadiness,
    required this.productionInferenceAllowed,
    required this.mathLiveReviewRequired,
    required this.directWorkspaceImportAllowed,
    required this.directSolveAllowed,
  });

  final String phase;
  final GaussOcrRuntimeAdapterDecision decision;
  final GaussOcrRuntimeAdapterInput input;
  final GaussOcrRuntimeLatexCandidate? primaryCandidate;
  final List<GaussOcrRuntimeLatexCandidate> alternativeCandidates;
  final List<String> issues;
  final GaussDeferredModelReadinessResult modelReadiness;
  final bool productionInferenceAllowed;
  final bool mathLiveReviewRequired;
  final bool directWorkspaceImportAllowed;
  final bool directSolveAllowed;

  bool get hasBlockingIssues => issues.isNotEmpty;
  bool get graphAllowedBeforeReview => false;
  bool get solutionAllowedBeforeReview => false;
  bool get historyWriteAllowedBeforeReview => false;

  bool get mayOpenMathLiveReviewOnly =>
      decision == GaussOcrRuntimeAdapterDecision.reviewOnlyEnvelopeReady &&
      !hasBlockingIssues &&
      productionInferenceAllowed == false &&
      mathLiveReviewRequired &&
      directWorkspaceImportAllowed == false &&
      directSolveAllowed == false;
}

/// Q249 PP-FormulaNet-S runtime adapter contract.
///
/// The class validates a future adapter envelope and deliberately returns a
/// review-only result. It never runs Paddle, loads model bytes, calls MathLive's
/// production bridge, writes the workspace, evaluates, graphs, solves, or writes
/// History.
class GaussOcrRuntimeAdapter {
  const GaussOcrRuntimeAdapter._();

  static const phase = GaussOcrRuntimeAdapterPolicy.phase;
  static const selectedEngineLabel = GaussOcrRuntimeAdapterPolicy.selectedEngineLabel;
  static const fallbackEngineLabel = GaussOcrRuntimeAdapterPolicy.fallbackEngineLabel;
  static const adapterMode = GaussOcrRuntimeAdapterPolicy.adapterMode;

  static const realInferenceEnabledInQ249 = false;
  static const productionRuntimeBindingAllowed = false;
  static const requiresQ248Readiness = true;
  static const requiresEditableMathLiveReview = true;
  static const allowsDirectWorkspaceImport = false;
  static const allowsDirectSolve = false;

  static const forbiddenRuntimeActions = <String>[
    'loadPaddleRuntime',
    'runPpFormulaNetSInference',
    'downloadModelNow',
    'callMathLiveProductionBridge',
    'setWorkspaceLatexWithoutReview',
    'evaluateFromCamera',
    'graphFromCamera',
    'writeHistoryFromCamera',
    'solveFromCamera',
  ];

  static const outputEnvelopeFields = <String>[
    'primaryLatexCandidate',
    'alternativeLatexCandidates',
    'confidence',
    'warnings',
    'engineMetadata',
    'mathLiveEditableReviewRequired',
  ];

  static GaussOcrRuntimeAdapterEnvelope createReviewOnlyEnvelope({
    required GaussOcrRuntimeAdapterInput input,
    GaussOcrRuntimeLatexCandidate? primaryCandidate,
    List<GaussOcrRuntimeLatexCandidate> alternativeCandidates = const <GaussOcrRuntimeLatexCandidate>[],
  }) {
    final issues = <String>[];
    final readiness = GaussDeferredModelDownloadRuntime.evaluateReadiness(input.modelEvidence);

    if (readiness.isBlocked) {
      issues.addAll(readiness.issues);
      return _envelope(
        decision: GaussOcrRuntimeAdapterDecision.blockedByDeferredModelGate,
        input: input,
        primaryCandidate: primaryCandidate,
        alternativeCandidates: alternativeCandidates,
        issues: issues,
        modelReadiness: readiness,
      );
    }

    if (!input.hasCapturePath) {
      issues.add('Captured image path is required before PP-FormulaNet-S adapter review.');
      return _envelope(
        decision: GaussOcrRuntimeAdapterDecision.blockedMissingCapture,
        input: input,
        primaryCandidate: primaryCandidate,
        alternativeCandidates: alternativeCandidates,
        issues: issues,
        modelReadiness: readiness,
      );
    }

    if (!input.hasCropFrame) {
      issues.add('Crop/scan-frame id is required before PP-FormulaNet-S adapter review.');
      return _envelope(
        decision: GaussOcrRuntimeAdapterDecision.blockedMissingCropFrame,
        input: input,
        primaryCandidate: primaryCandidate,
        alternativeCandidates: alternativeCandidates,
        issues: issues,
        modelReadiness: readiness,
      );
    }

    if (!input.fromQ248ReadinessPhase) {
      issues.add('Adapter input must be sourced from the Q248 deferred model readiness phase.');
    }

    if (primaryCandidate != null) {
      _validateCandidate(primaryCandidate, issues, 'primaryCandidate');
    }
    for (var i = 0; i < alternativeCandidates.length; i += 1) {
      _validateCandidate(alternativeCandidates[i], issues, 'alternativeCandidate:$i');
    }

    return _envelope(
      decision: issues.isEmpty
          ? GaussOcrRuntimeAdapterDecision.reviewOnlyEnvelopeReady
          : GaussOcrRuntimeAdapterDecision.blockedUnsafeCandidate,
      input: input,
      primaryCandidate: primaryCandidate,
      alternativeCandidates: alternativeCandidates,
      issues: issues,
      modelReadiness: readiness,
    );
  }

  static void _validateCandidate(
    GaussOcrRuntimeLatexCandidate candidate,
    List<String> issues,
    String prefix,
  ) {
    if (candidate.rank < 1) {
      issues.add('$prefix rank must start at 1.');
    }
    if (!candidate.hasLatex) {
      issues.add('$prefix must contain a non-empty LaTeX candidate.');
    }
    if (!candidate.confidenceInRange) {
      issues.add('$prefix confidence must be between 0 and 1.');
    }
    if (!candidate.usesSelectedEngine) {
      issues.add('$prefix must use PP-FormulaNet-S as the selected primary engine.');
    }
    if (!candidate.requiresEditableMathLiveReview) {
      issues.add('$prefix must be review-only and require editable MathLive review.');
    }
    if (candidate.directWorkspaceImportAllowed) {
      issues.add('$prefix must block direct workspace import.');
    }
    if (candidate.directSolveAllowed) {
      issues.add('$prefix must block direct solve.');
    }
  }

  static GaussOcrRuntimeAdapterEnvelope _envelope({
    required GaussOcrRuntimeAdapterDecision decision,
    required GaussOcrRuntimeAdapterInput input,
    required GaussOcrRuntimeLatexCandidate? primaryCandidate,
    required List<GaussOcrRuntimeLatexCandidate> alternativeCandidates,
    required List<String> issues,
    required GaussDeferredModelReadinessResult modelReadiness,
  }) {
    return GaussOcrRuntimeAdapterEnvelope(
      phase: phase,
      decision: decision,
      input: input,
      primaryCandidate: primaryCandidate,
      alternativeCandidates: List<GaussOcrRuntimeLatexCandidate>.unmodifiable(alternativeCandidates),
      issues: List<String>.unmodifiable(issues),
      modelReadiness: modelReadiness,
      productionInferenceAllowed: false,
      mathLiveReviewRequired: true,
      directWorkspaceImportAllowed: false,
      directSolveAllowed: false,
    );
  }
}
