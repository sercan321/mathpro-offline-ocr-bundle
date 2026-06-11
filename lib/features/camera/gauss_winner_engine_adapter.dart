import 'gauss_ocr_benchmark_external_lab_intake_validation_gate.dart';
import 'gauss_ocr_benchmark_external_lab_intake_validation_gate_policy.dart';
import 'gauss_ocr_engine_benchmark_court.dart';
import 'gauss_winner_engine_adapter_policy.dart';

/// V172-Q241 review-only adapter status.
///
/// These states describe a future winner-engine adapter envelope. Q241 does not
/// select or execute an engine; it only defines safe boundaries for the later
/// runtime binding phase.
enum GaussWinnerEngineAdapterStatus {
  contractReady,
  blockedByIntakeGate,
  blockedUnsafeCandidate,
  noWinnerSelected,
  runtimeUnavailable,
}

enum GaussWinnerEngineAdapterIssueSeverity {
  info,
  warning,
  blocking,
}

class GaussWinnerEngineAdapterIssue {
  const GaussWinnerEngineAdapterIssue({
    required this.code,
    required this.message,
    required this.severity,
  });

  final String code;
  final String message;
  final GaussWinnerEngineAdapterIssueSeverity severity;

  bool get isBlocking => severity == GaussWinnerEngineAdapterIssueSeverity.blocking;
}

/// Capture context for a future OCR winner adapter invocation.
class GaussWinnerEngineAdapterInput {
  const GaussWinnerEngineAdapterInput({
    required this.capturePath,
    required this.rotationQuarterTurns,
    required this.sourcePhase,
    required this.externalReportSha256,
    required this.fixtureManifestSha256,
  });

  final String capturePath;
  final int rotationQuarterTurns;
  final String sourcePhase;
  final String externalReportSha256;
  final String fixtureManifestSha256;

  bool get hasCapturePath => capturePath.trim().isNotEmpty;
  int get rotationDegrees => (rotationQuarterTurns % 4) * 90;
  bool get fromQ240R3Gate => sourcePhase == GaussOcrBenchmarkExternalLabIntakeValidationGatePolicy.fullPhase;
}

/// Candidate shape emitted by the future winner adapter.
///
/// The candidate is deliberately review-only. It cannot directly write the
/// workspace, evaluate, graph, solve, or write History.
class GaussWinnerEngineAdapterCandidate {
  const GaussWinnerEngineAdapterCandidate({
    required this.rank,
    required this.latex,
    required this.confidence,
    required this.engineFamily,
    required this.engineLabel,
    required this.warnings,
  });

  final int rank;
  final String latex;
  final double confidence;
  final GaussOcrBenchmarkEngineFamily engineFamily;
  final String engineLabel;
  final List<String> warnings;

  bool get hasLatexCandidate => latex.trim().isNotEmpty;
  bool get confidenceInRange => confidence >= 0 && confidence <= 1;
  bool get requiresEditableMathLiveReview => true;
  bool get directSolveAllowed => false;
  bool get directWorkspaceImportAllowed => false;
  bool get graphAllowedBeforeReview => false;
  bool get solutionAllowedBeforeReview => false;
  bool get historyWriteAllowedBeforeReview => false;
}

class GaussWinnerEngineAdapterEnvelope {
  const GaussWinnerEngineAdapterEnvelope({
    required this.phase,
    required this.status,
    required this.input,
    required this.primaryCandidate,
    required this.alternativeCandidates,
    required this.issues,
    required this.sourceIntakeDecision,
    required this.productionRuntimeBindingAllowed,
    required this.benchmarkWinnerSelected,
  });

  final String phase;
  final GaussWinnerEngineAdapterStatus status;
  final GaussWinnerEngineAdapterInput input;
  final GaussWinnerEngineAdapterCandidate? primaryCandidate;
  final List<GaussWinnerEngineAdapterCandidate> alternativeCandidates;
  final List<GaussWinnerEngineAdapterIssue> issues;
  final GaussOcrExternalLabIntakeDecision sourceIntakeDecision;
  final bool productionRuntimeBindingAllowed;
  final bool benchmarkWinnerSelected;

  bool get hasBlockingIssues => issues.any((issue) => issue.isBlocking);
  bool get mathLiveReviewRequired => true;
  bool get directSolveAllowed => false;
  bool get directWorkspaceImportAllowed => false;
  bool get graphAllowedBeforeReview => false;
  bool get solutionAllowedBeforeReview => false;
  bool get historyWriteAllowedBeforeReview => false;

  bool get mayOpenMathLiveReviewOnly =>
      status == GaussWinnerEngineAdapterStatus.contractReady &&
      !hasBlockingIssues &&
      productionRuntimeBindingAllowed == false &&
      benchmarkWinnerSelected == false &&
      directSolveAllowed == false &&
      directWorkspaceImportAllowed == false &&
      mathLiveReviewRequired;
}

/// V172-Q241 adapter foundation.
///
/// It creates and validates review-only envelopes for future OCR adapter work.
/// It intentionally has no dependency on an OCR runtime, model file, downloader,
/// MathLive production bridge, workspace controller, solver, graph, solution, or
/// history writer.
class GaussWinnerEngineAdapterFoundation {
  const GaussWinnerEngineAdapterFoundation._();

  static const String phase = GaussWinnerEngineAdapterPolicy.fullPhase;
  static const bool realEngineInvocationAllowed = false;
  static const bool productionRuntimeBindingAllowed = false;
  static const bool benchmarkWinnerSelected = false;
  static const bool directSolveAllowed = false;
  static const bool directWorkspaceImportAllowed = false;
  static const bool mathLiveReviewRequired = true;

  static const List<String> adapterSafetyStages = <String>[
    'q240r3IntakeDecisionGate',
    'captureInputShapeGate',
    'candidateLatexShapeGate',
    'candidateConfidenceGate',
    'mathLiveReviewOnlyGate',
    'directSolveBlockGate',
    'workspaceImportBlockGate',
    'graphHistorySolutionBlockGate',
    'productionRuntimeBindingBlockGate',
  ];

  static const List<String> forbiddenRuntimeBindings = <String>[
    'runOcrEngine',
    'downloadModel',
    'loadOnnxRuntime',
    'loadPaddleRuntime',
    'callMathLiveProductionBridge',
    'setWorkspaceLatexWithoutReview',
    'evaluateFromCamera',
    'graphFromCamera',
    'writeHistoryFromCamera',
    'solveFromCamera',
  ];

  static GaussWinnerEngineAdapterEnvelope createReviewOnlyEnvelope({
    required GaussWinnerEngineAdapterInput input,
    required GaussOcrExternalLabIntakeValidationResult intakeResult,
    GaussWinnerEngineAdapterCandidate? candidate,
    List<GaussWinnerEngineAdapterCandidate> alternatives = const <GaussWinnerEngineAdapterCandidate>[],
  }) {
    final issues = <GaussWinnerEngineAdapterIssue>[];
    void block(String code, String message) {
      issues.add(
        GaussWinnerEngineAdapterIssue(
          code: code,
          message: message,
          severity: GaussWinnerEngineAdapterIssueSeverity.blocking,
        ),
      );
    }

    if (!intakeResult.mayEnterWinnerAdapterReview) {
      block('q240r3IntakeDecision', 'Q240R3 intake gate must mark evidence eligible before adapter review.');
    }
    if (!input.hasCapturePath) {
      block('capturePath', 'Adapter input must preserve the captured image path for future review context.');
    }
    if (!input.fromQ240R3Gate) {
      block('sourcePhase', 'Adapter input must be sourced from the Q240R3 intake validation gate.');
    }
    if (candidate != null) {
      _validateCandidate(candidate, issues, 'primaryCandidate');
    }
    for (var i = 0; i < alternatives.length; i += 1) {
      _validateCandidate(alternatives[i], issues, 'alternativeCandidate:$i');
    }

    final blockedByIntake = !intakeResult.mayEnterWinnerAdapterReview;
    final blockedUnsafeCandidate = issues.any((issue) => issue.code.toLowerCase().contains('candidate'));
    final status = blockedByIntake
        ? GaussWinnerEngineAdapterStatus.blockedByIntakeGate
        : blockedUnsafeCandidate
            ? GaussWinnerEngineAdapterStatus.blockedUnsafeCandidate
            : GaussWinnerEngineAdapterStatus.contractReady;

    return GaussWinnerEngineAdapterEnvelope(
      phase: phase,
      status: status,
      input: input,
      primaryCandidate: candidate,
      alternativeCandidates: List<GaussWinnerEngineAdapterCandidate>.unmodifiable(alternatives),
      issues: List<GaussWinnerEngineAdapterIssue>.unmodifiable(issues),
      sourceIntakeDecision: intakeResult.decision,
      productionRuntimeBindingAllowed: false,
      benchmarkWinnerSelected: false,
    );
  }

  static void _validateCandidate(
    GaussWinnerEngineAdapterCandidate candidate,
    List<GaussWinnerEngineAdapterIssue> issues,
    String prefix,
  ) {
    void block(String code, String message) {
      issues.add(
        GaussWinnerEngineAdapterIssue(
          code: '$prefix:$code',
          message: message,
          severity: GaussWinnerEngineAdapterIssueSeverity.blocking,
        ),
      );
    }

    if (!candidate.hasLatexCandidate) {
      block('latex', 'Future adapter candidates must contain a non-empty LaTeX candidate.');
    }
    if (!candidate.confidenceInRange) {
      block('confidence', 'Future adapter candidate confidence must be between 0 and 1.');
    }
    if (!candidate.requiresEditableMathLiveReview) {
      block('mathLiveReview', 'Future adapter candidates must require editable MathLive review.');
    }
    if (candidate.directSolveAllowed) {
      block('directSolve', 'Future adapter candidates must block direct solve.');
    }
    if (candidate.directWorkspaceImportAllowed) {
      block('workspaceImport', 'Future adapter candidates must block direct workspace import.');
    }
  }

  static bool get blocksUnsafeRuntimeBindings =>
      forbiddenRuntimeBindings.contains('runOcrEngine') &&
      forbiddenRuntimeBindings.contains('setWorkspaceLatexWithoutReview') &&
      forbiddenRuntimeBindings.contains('evaluateFromCamera') &&
      productionRuntimeBindingAllowed == false &&
      directSolveAllowed == false &&
      directWorkspaceImportAllowed == false;

  static bool get exposesReviewOnlyContract =>
      adapterSafetyStages.contains('mathLiveReviewOnlyGate') &&
      mathLiveReviewRequired &&
      directSolveAllowed == false &&
      directWorkspaceImportAllowed == false;
}
