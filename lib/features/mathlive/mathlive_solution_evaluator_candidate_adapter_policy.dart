import '../../logic/evaluator_bridge.dart';
import 'mathlive_graph_eligibility_adapter_policy.dart';
import 'mathlive_history_adapter_policy.dart';
import 'mathlive_state_adapter.dart';
import 'mathlive_state_normalization_hardening_policy.dart';

/// V172-Q105 — Solution / Evaluator Candidate Adapter.
///
/// Q105 converts package-side MathLive normalized expressions into deterministic
/// Solution/Evaluator candidate envelopes. It does not add a new solver, does
/// not mutate solution_steps_panel.dart, does not write runtime Solution state,
/// does not switch or mount the main editor, and does not claim device/cursor
/// success. Unsupported expressions are preserved with honest unsupported
/// reasons instead of fake solution steps.
class MathLiveSolutionEvaluatorCandidateAdapterPolicy {
  const MathLiveSolutionEvaluatorCandidateAdapterPolicy._();

  static const String phase = 'V172-Q105';
  static const String verifierScript = 'tool/verify_mathlive_solution_evaluator_candidate_adapter.mjs';
  static const String reportJson = 'tool/reports/mathlive_solution_evaluator_candidate_adapter_report.json';
  static const String reportMarkdown = 'tool/reports/mathlive_solution_evaluator_candidate_adapter_report.md';
  static const bool packageSideSolutionEvaluatorAdapterImplemented = true;
  static const bool q102StateNormalizationRequired = true;
  static const bool q103GraphEligibilityAdapterRequired = true;
  static const bool q104HistoryAdapterRequired = true;
  static const bool q101LabSmokeEvidenceClosureRequiredForRuntimeActivation = true;
  static const bool solutionStepsPanelMutationAllowed = false;
  static const bool solutionUiMutationAllowed = false;
  static const bool graphUiMutationAllowed = false;
  static const bool historyUiMutationAllowed = false;
  static const bool keyboardMutationAllowed = false;
  static const bool appShellMutationAllowed = false;
  static const bool mainEditorSwitchAllowed = false;
  static const bool mainEditorMountAllowed = false;
  static const bool mathLiveEnabledByDefault = false;
  static const bool legacyCursorDeletionAllowed = false;
  static const bool protectedUiSurfaceMutationAllowed = false;
  static const bool cursorPassClaimAllowed = false;
  static const bool fakeSolutionAllowed = false;
  static const bool runtimeSolutionWriteAllowed = false;
  static const String inputEngine = 'mathlive';

  static MathLiveSolutionEvaluatorAdapterReadiness evaluateReadiness({
    required bool adapterPolicyPresent,
    required bool deterministicSolutionSamplesPass,
    required bool q102StateNormalizationReady,
    required bool q103GraphEligibilityReady,
    required bool q104HistoryAdapterReady,
    required bool q101LabSmokeEvidenceClosed,
    required bool protectedSurfacesUnchanged,
    required bool solutionStepsPanelUntouched,
    required bool graphHistorySolutionUiUntouched,
    required bool mainEditorStillLegacy,
    required bool noFakeSolutionGenerated,
    required bool noRuntimeEvidenceFaked,
  }) {
    final blockers = <String>[];
    if (!adapterPolicyPresent) blockers.add('Q105 solution/evaluator adapter policy is missing');
    if (!deterministicSolutionSamplesPass) blockers.add('Q105 deterministic solution/evaluator samples did not pass');
    if (!q102StateNormalizationReady) blockers.add('Q102 state normalization is not package-ready');
    if (!q103GraphEligibilityReady) blockers.add('Q103 graph eligibility adapter is not package-ready');
    if (!q104HistoryAdapterReady) blockers.add('Q104 history adapter is not package-ready');
    if (!q101LabSmokeEvidenceClosed) blockers.add('Q101 Lab smoke evidence closure has not passed; Q105 must remain package-side only');
    if (!protectedSurfacesUnchanged) blockers.add('protected UI surfaces changed');
    if (!solutionStepsPanelUntouched) blockers.add('solution_steps_panel.dart changed during Q105');
    if (!graphHistorySolutionUiUntouched) blockers.add('Graph/History/Solution UI surfaces changed');
    if (!mainEditorStillLegacy) blockers.add('main editor did not remain legacy/default');
    if (!noFakeSolutionGenerated) blockers.add('fake solution steps or fake evaluator result were generated');
    if (!noRuntimeEvidenceFaked) blockers.add('runtime evidence was faked');

    final packageReady = adapterPolicyPresent &&
        deterministicSolutionSamplesPass &&
        q102StateNormalizationReady &&
        q103GraphEligibilityReady &&
        q104HistoryAdapterReady &&
        protectedSurfacesUnchanged &&
        solutionStepsPanelUntouched &&
        graphHistorySolutionUiUntouched &&
        mainEditorStillLegacy &&
        noFakeSolutionGenerated &&
        noRuntimeEvidenceFaked;
    final runtimeReady = packageReady && q101LabSmokeEvidenceClosed;
    return MathLiveSolutionEvaluatorAdapterReadiness(
      status: runtimeReady
          ? 'MATHLIVE_SOLUTION_EVALUATOR_ADAPTER_READY_FOR_RUNTIME_BINDING'
          : packageReady
              ? 'MATHLIVE_SOLUTION_EVALUATOR_ADAPTER_PACKAGE_READY_BUT_RUNTIME_EVIDENCE_BLOCKED'
              : 'BLOCKED_MATHLIVE_SOLUTION_EVALUATOR_ADAPTER',
      blockers: blockers,
      packageSideSolutionEvaluatorReady: packageReady,
      mayProceedToRuntimeSolutionBinding: runtimeReady,
      mayWriteSolutionAtRuntime: runtimeReady,
      maySwitchMainEditor: false,
      mayMountMainEditor: false,
      mayDeleteLegacyCursor: false,
      mayClaimCursorPass: false,
      mayMutateSolutionStepsPanel: false,
    );
  }

  static MathLiveSolutionEvaluatorCandidateEnvelope buildCandidateEnvelope(
    MathLiveEditorStateSnapshot snapshot, {
    DateTime? createdAtUtc,
    String? candidateIdSeed,
  }) {
    final normalized = MathLiveStateNormalizationHardeningPolicy.normalizeSnapshot(snapshot);
    final expression = normalized.solutionCandidateExpression.trim();
    final evaluation = EvaluatorBridge.evaluateBasic(expression);
    final semantic = EvaluatorBridge.analyzeSemantic(expression);
    final graph = MathLiveGraphEligibilityAdapterPolicy.classifyNormalized(normalized);
    final history = MathLiveHistoryAdapterPolicy.buildEntryEnvelope(
      snapshot,
      createdAtUtc: createdAtUtc,
      entryIdSeed: candidateIdSeed == null ? null : 'q105-history-$candidateIdSeed',
    );
    final createdAt = (createdAtUtc ?? DateTime.fromMillisecondsSinceEpoch(0, isUtc: true)).toUtc();
    final idSeed = candidateIdSeed ?? _stableSeed('${snapshot.latex}|$expression|${createdAt.toIso8601String()}');
    final hasEvaluatorResult = evaluation.displayValue != null && evaluation.unsupportedReason == null;
    final hasNumericResult = evaluation.value != null && hasEvaluatorResult;
    final hasSymbolicResult = evaluation.value == null && hasEvaluatorResult && (evaluation.displayValue ?? '').isNotEmpty;
    final unsupportedReason = evaluation.unsupportedReason ?? '';
    final requiresAdvancedSolver = unsupportedReason.isNotEmpty || semantic.isLimitation;

    return MathLiveSolutionEvaluatorCandidateEnvelope(
      phase: phase,
      id: 'mathlive-solution-$idSeed',
      inputEngine: inputEngine,
      sourceLatex: normalized.sourceLatex,
      normalizedExpression: normalized.normalizedExpression,
      plainText: normalized.plainText,
      mathJson: normalized.mathJson,
      evaluatorCandidateExpression: normalized.evaluatorCandidateExpression,
      solutionCandidateExpression: expression,
      evaluateRequested: snapshot.evaluateRequested,
      semanticKind: semantic.kind,
      semanticTitle: semantic.title,
      semanticDescription: semantic.description,
      semanticTags: semantic.tags,
      semanticStepsPreview: semantic.steps,
      evaluatorDisplayValue: evaluation.displayValue ?? '',
      evaluatorSemanticType: evaluation.semanticType ?? semantic.kind,
      evaluatorSemanticNote: evaluation.semanticNote ?? semantic.title,
      evaluatorUnsupportedReason: unsupportedReason,
      hasEvaluatorResult: hasEvaluatorResult,
      hasNumericResult: hasNumericResult,
      hasSymbolicResult: hasSymbolicResult,
      requiresAdvancedSolver: requiresAdvancedSolver,
      graphEligibilityKind: graph.eligibilityKind,
      graphNormalizedExpression: graph.graphNormalizedExpression,
      historyEntryId: history.id,
      createdAtIso8601: createdAt.toIso8601String(),
      fakeSolutionGenerated: false,
      runtimeSolutionWriteAllowed: false,
      solutionStepsPanelMutationAllowed: false,
      mainEditorSwitchAllowed: false,
      legacyCursorDeletionAllowed: false,
    );
  }

  static String _stableSeed(String value) {
    var hash = 0x811c9dc5;
    for (final codeUnit in value.codeUnits) {
      hash ^= codeUnit;
      hash = (hash * 0x01000193) & 0xffffffff;
    }
    return hash.toRadixString(16).padLeft(8, '0');
  }
}

class MathLiveSolutionEvaluatorAdapterReadiness {
  const MathLiveSolutionEvaluatorAdapterReadiness({
    required this.status,
    required this.blockers,
    required this.packageSideSolutionEvaluatorReady,
    required this.mayProceedToRuntimeSolutionBinding,
    required this.mayWriteSolutionAtRuntime,
    required this.maySwitchMainEditor,
    required this.mayMountMainEditor,
    required this.mayDeleteLegacyCursor,
    required this.mayClaimCursorPass,
    required this.mayMutateSolutionStepsPanel,
  });

  final String status;
  final List<String> blockers;
  final bool packageSideSolutionEvaluatorReady;
  final bool mayProceedToRuntimeSolutionBinding;
  final bool mayWriteSolutionAtRuntime;
  final bool maySwitchMainEditor;
  final bool mayMountMainEditor;
  final bool mayDeleteLegacyCursor;
  final bool mayClaimCursorPass;
  final bool mayMutateSolutionStepsPanel;

  bool get isRuntimeBlocked => !mayProceedToRuntimeSolutionBinding;
}

class MathLiveSolutionEvaluatorCandidateEnvelope {
  const MathLiveSolutionEvaluatorCandidateEnvelope({
    required this.phase,
    required this.id,
    required this.inputEngine,
    required this.sourceLatex,
    required this.normalizedExpression,
    required this.plainText,
    required this.mathJson,
    required this.evaluatorCandidateExpression,
    required this.solutionCandidateExpression,
    required this.evaluateRequested,
    required this.semanticKind,
    required this.semanticTitle,
    required this.semanticDescription,
    required this.semanticTags,
    required this.semanticStepsPreview,
    required this.evaluatorDisplayValue,
    required this.evaluatorSemanticType,
    required this.evaluatorSemanticNote,
    required this.evaluatorUnsupportedReason,
    required this.hasEvaluatorResult,
    required this.hasNumericResult,
    required this.hasSymbolicResult,
    required this.requiresAdvancedSolver,
    required this.graphEligibilityKind,
    required this.graphNormalizedExpression,
    required this.historyEntryId,
    required this.createdAtIso8601,
    required this.fakeSolutionGenerated,
    required this.runtimeSolutionWriteAllowed,
    required this.solutionStepsPanelMutationAllowed,
    required this.mainEditorSwitchAllowed,
    required this.legacyCursorDeletionAllowed,
  });

  final String phase;
  final String id;
  final String inputEngine;
  final String sourceLatex;
  final String normalizedExpression;
  final String plainText;
  final Object? mathJson;
  final String evaluatorCandidateExpression;
  final String solutionCandidateExpression;
  final bool evaluateRequested;
  final String semanticKind;
  final String semanticTitle;
  final String semanticDescription;
  final List<String> semanticTags;
  final List<String> semanticStepsPreview;
  final String evaluatorDisplayValue;
  final String evaluatorSemanticType;
  final String evaluatorSemanticNote;
  final String evaluatorUnsupportedReason;
  final bool hasEvaluatorResult;
  final bool hasNumericResult;
  final bool hasSymbolicResult;
  final bool requiresAdvancedSolver;
  final String graphEligibilityKind;
  final String graphNormalizedExpression;
  final String historyEntryId;
  final String createdAtIso8601;
  final bool fakeSolutionGenerated;
  final bool runtimeSolutionWriteAllowed;
  final bool solutionStepsPanelMutationAllowed;
  final bool mainEditorSwitchAllowed;
  final bool legacyCursorDeletionAllowed;

  bool get hasSolutionPayload => solutionCandidateExpression.trim().isNotEmpty;
  bool get hasHonestUnsupportedReason => evaluatorUnsupportedReason.trim().isNotEmpty;
  bool get isMathLiveCandidate => inputEngine == MathLiveSolutionEvaluatorCandidateAdapterPolicy.inputEngine;

  Map<String, Object?> toJson() => <String, Object?>{
        'phase': phase,
        'id': id,
        'inputEngine': inputEngine,
        'sourceLatex': sourceLatex,
        'normalizedExpression': normalizedExpression,
        'plainText': plainText,
        'mathJson': mathJson,
        'evaluatorCandidateExpression': evaluatorCandidateExpression,
        'solutionCandidateExpression': solutionCandidateExpression,
        'evaluateRequested': evaluateRequested,
        'semanticKind': semanticKind,
        'semanticTitle': semanticTitle,
        'semanticDescription': semanticDescription,
        'semanticTags': semanticTags,
        'semanticStepsPreview': semanticStepsPreview,
        'evaluatorDisplayValue': evaluatorDisplayValue,
        'evaluatorSemanticType': evaluatorSemanticType,
        'evaluatorSemanticNote': evaluatorSemanticNote,
        'evaluatorUnsupportedReason': evaluatorUnsupportedReason,
        'hasEvaluatorResult': hasEvaluatorResult,
        'hasNumericResult': hasNumericResult,
        'hasSymbolicResult': hasSymbolicResult,
        'requiresAdvancedSolver': requiresAdvancedSolver,
        'graphEligibilityKind': graphEligibilityKind,
        'graphNormalizedExpression': graphNormalizedExpression,
        'historyEntryId': historyEntryId,
        'createdAtIso8601': createdAtIso8601,
        'fakeSolutionGenerated': fakeSolutionGenerated,
        'runtimeSolutionWriteAllowed': runtimeSolutionWriteAllowed,
        'solutionStepsPanelMutationAllowed': solutionStepsPanelMutationAllowed,
        'mainEditorSwitchAllowed': mainEditorSwitchAllowed,
        'legacyCursorDeletionAllowed': legacyCursorDeletionAllowed,
      };
}
