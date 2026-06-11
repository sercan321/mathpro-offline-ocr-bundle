import 'gauss_ocr_mathlive_review_import_policy.dart';
import 'gauss_ocr_runtime_adapter.dart';

/// Decision state for converting a Q249 adapter envelope into a MathLive review
/// import draft.
enum GaussOcrMathLiveReviewImportDecision {
  blockedAdapterNotReady,
  blockedMissingPrimaryCandidate,
  blockedUnsafeCandidate,
  editableReviewDraftReady,
  workspaceImportReadyAfterUserApproval,
}

/// Candidate copied from the OCR adapter into the editable MathLive review
/// draft. The candidate stays review-only until the user explicitly approves
/// the edited LaTeX.
class GaussOcrMathLiveReviewCandidateDraft {
  const GaussOcrMathLiveReviewCandidateDraft({
    required this.rank,
    required this.originalLatex,
    required this.editableLatex,
    required this.confidence,
    required this.engineLabel,
    required this.warnings,
  });

  factory GaussOcrMathLiveReviewCandidateDraft.fromAdapterCandidate(
    GaussOcrRuntimeLatexCandidate candidate, {
    String? editedLatex,
  }) {
    return GaussOcrMathLiveReviewCandidateDraft(
      rank: candidate.rank,
      originalLatex: candidate.latex,
      editableLatex: editedLatex ?? candidate.latex,
      confidence: candidate.confidence,
      engineLabel: candidate.engineLabel,
      warnings: candidate.warningCodes.map((warning) => warning.name).toList(growable: false),
    );
  }

  final int rank;
  final String originalLatex;
  final String editableLatex;
  final double confidence;
  final String engineLabel;
  final List<String> warnings;

  bool get hasEditableLatex => editableLatex.trim().isNotEmpty;
  bool get usesSelectedEngine => engineLabel == GaussOcrMathLiveReviewImportPolicy.selectedEngineLabel;
  bool get confidenceInRange => confidence >= 0 && confidence <= 1;
  bool get editedByUser => editableLatex != originalLatex;
  bool get canBeShownInMathLiveReview => hasEditableLatex && usesSelectedEngine && confidenceInRange;
}

/// Review-first import draft created from the Q249 adapter envelope.
///
/// The draft is allowed to open an editable MathLive review surface. It does not
/// write the workspace until the user explicitly approves the edited candidate,
/// and it never directly evaluates, graphs, solves, or writes History.
class GaussOcrMathLiveReviewImportDraft {
  const GaussOcrMathLiveReviewImportDraft({
    required this.phase,
    required this.sourceAdapterPhase,
    required this.decision,
    required this.primaryCandidate,
    required this.alternativeCandidates,
    required this.issues,
    required this.userApproved,
    required this.mathLiveReviewRequired,
    required this.directWorkspaceImportAllowed,
    required this.directSolveAllowed,
  });

  final String phase;
  final String sourceAdapterPhase;
  final GaussOcrMathLiveReviewImportDecision decision;
  final GaussOcrMathLiveReviewCandidateDraft? primaryCandidate;
  final List<GaussOcrMathLiveReviewCandidateDraft> alternativeCandidates;
  final List<String> issues;
  final bool userApproved;
  final bool mathLiveReviewRequired;
  final bool directWorkspaceImportAllowed;
  final bool directSolveAllowed;

  bool get hasBlockingIssues => issues.isNotEmpty;
  bool get hasPrimaryCandidate => primaryCandidate != null;
  bool get canOpenEditableMathLiveReview =>
      decision == GaussOcrMathLiveReviewImportDecision.editableReviewDraftReady &&
      hasPrimaryCandidate &&
      !hasBlockingIssues &&
      mathLiveReviewRequired &&
      directWorkspaceImportAllowed == false &&
      directSolveAllowed == false;

  bool get canImportToWorkspaceAfterUserApproval =>
      decision == GaussOcrMathLiveReviewImportDecision.workspaceImportReadyAfterUserApproval &&
      userApproved &&
      hasPrimaryCandidate &&
      !hasBlockingIssues &&
      mathLiveReviewRequired &&
      directWorkspaceImportAllowed == false &&
      directSolveAllowed == false;

  bool get canEvaluateBeforeApproval => false;
  bool get canGraphBeforeApproval => false;
  bool get canWriteSolutionBeforeApproval => false;
  bool get canWriteHistoryBeforeApproval => false;
}

/// Q250 OCR → MathLive review-import contract.
///
/// This class only prepares an editable review draft from a Q249 adapter
/// envelope. It never calls the production MathLive bridge and never mutates the
/// workspace by itself.
class GaussOcrMathLiveReviewImport {
  const GaussOcrMathLiveReviewImport._();

  static const phase = GaussOcrMathLiveReviewImportPolicy.phase;
  static const closesOverPhase = GaussOcrMathLiveReviewImportPolicy.closesOverPhase;
  static const selectedEngineLabel = GaussOcrMathLiveReviewImportPolicy.selectedEngineLabel;
  static const reviewSurfaceKey = GaussOcrMathLiveReviewImportPolicy.reviewSurfaceKey;

  static const requiresQ249AdapterEnvelope = true;
  static const requiresEditableMathLiveReview = true;
  static const requiresUserApprovalBeforeWorkspaceImport = true;
  static const allowsDirectWorkspaceImport = false;
  static const allowsDirectSolve = false;
  static const callsProductionMathLiveBridge = false;

  static const forbiddenReviewImportActions = <String>[
    'callMathLiveProductionBridge',
    'setWorkspaceLatexWithoutUserApproval',
    'evaluateFromCameraBeforeApproval',
    'graphFromCameraBeforeApproval',
    'writeSolutionFromCameraBeforeApproval',
    'writeHistoryFromCameraBeforeApproval',
    'runPpFormulaNetSInference',
  ];

  static GaussOcrMathLiveReviewImportDraft createEditableReviewDraft({
    required GaussOcrRuntimeAdapterEnvelope adapterEnvelope,
    bool userApproved = false,
    String? userEditedLatex,
  }) {
    final issues = <String>[];

    if (adapterEnvelope.phase != GaussOcrRuntimeAdapter.phase ||
        adapterEnvelope.decision != GaussOcrRuntimeAdapterDecision.reviewOnlyEnvelopeReady ||
        !adapterEnvelope.mayOpenMathLiveReviewOnly) {
      issues.add('Q249 adapter envelope must be review-only ready before MathLive review import.');
      return _draft(
        decision: GaussOcrMathLiveReviewImportDecision.blockedAdapterNotReady,
        adapterEnvelope: adapterEnvelope,
        primaryCandidate: null,
        alternativeCandidates: const <GaussOcrMathLiveReviewCandidateDraft>[],
        issues: issues,
        userApproved: false,
      );
    }

    final primary = adapterEnvelope.primaryCandidate;
    if (primary == null) {
      issues.add('A primary LaTeX candidate is required before editable MathLive review.');
      return _draft(
        decision: GaussOcrMathLiveReviewImportDecision.blockedMissingPrimaryCandidate,
        adapterEnvelope: adapterEnvelope,
        primaryCandidate: null,
        alternativeCandidates: const <GaussOcrMathLiveReviewCandidateDraft>[],
        issues: issues,
        userApproved: false,
      );
    }

    final primaryDraft = GaussOcrMathLiveReviewCandidateDraft.fromAdapterCandidate(
      primary,
      editedLatex: userEditedLatex,
    );
    if (!primaryDraft.canBeShownInMathLiveReview) {
      issues.add('Primary candidate is not safe for editable MathLive review.');
    }

    final alternatives = adapterEnvelope.alternativeCandidates
        .map(GaussOcrMathLiveReviewCandidateDraft.fromAdapterCandidate)
        .toList(growable: false);
    for (var i = 0; i < alternatives.length; i += 1) {
      if (!alternatives[i].canBeShownInMathLiveReview) {
        issues.add('Alternative candidate $i is not safe for editable MathLive review.');
      }
    }

    if (issues.isNotEmpty) {
      return _draft(
        decision: GaussOcrMathLiveReviewImportDecision.blockedUnsafeCandidate,
        adapterEnvelope: adapterEnvelope,
        primaryCandidate: primaryDraft,
        alternativeCandidates: alternatives,
        issues: issues,
        userApproved: false,
      );
    }

    return _draft(
      decision: userApproved
          ? GaussOcrMathLiveReviewImportDecision.workspaceImportReadyAfterUserApproval
          : GaussOcrMathLiveReviewImportDecision.editableReviewDraftReady,
      adapterEnvelope: adapterEnvelope,
      primaryCandidate: primaryDraft,
      alternativeCandidates: alternatives,
      issues: const <String>[],
      userApproved: userApproved,
    );
  }

  static GaussOcrMathLiveReviewImportDraft _draft({
    required GaussOcrMathLiveReviewImportDecision decision,
    required GaussOcrRuntimeAdapterEnvelope adapterEnvelope,
    required GaussOcrMathLiveReviewCandidateDraft? primaryCandidate,
    required List<GaussOcrMathLiveReviewCandidateDraft> alternativeCandidates,
    required List<String> issues,
    required bool userApproved,
  }) {
    return GaussOcrMathLiveReviewImportDraft(
      phase: phase,
      sourceAdapterPhase: adapterEnvelope.phase,
      decision: decision,
      primaryCandidate: primaryCandidate,
      alternativeCandidates: List<GaussOcrMathLiveReviewCandidateDraft>.unmodifiable(alternativeCandidates),
      issues: List<String>.unmodifiable(issues),
      userApproved: userApproved,
      mathLiveReviewRequired: true,
      directWorkspaceImportAllowed: false,
      directSolveAllowed: false,
    );
  }
}
