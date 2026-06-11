import 'mathlive_graph_eligibility_adapter_policy.dart';
import 'mathlive_state_adapter.dart';
import 'mathlive_state_normalization_hardening_policy.dart';

/// V172-Q104 — History Adapter Real Binding.
///
/// Q104 binds MathLive's normalized package-side expression payload to a safe
/// History entry envelope without mutating history_controller.dart,
/// history_panel.dart, keyboard surfaces, AppShell, Graph/Solution UI, the main
/// editor mount, or the legacy cursor stack. It is still a package-side adapter
/// phase until Q101 Lab smoke evidence closure and later real-device courts are
/// genuinely proven.
class MathLiveHistoryAdapterPolicy {
  const MathLiveHistoryAdapterPolicy._();

  static const String phase = 'V172-Q104';
  static const String verifierScript = 'tool/verify_mathlive_history_adapter.mjs';
  static const String reportJson = 'tool/reports/mathlive_history_adapter_report.json';
  static const String reportMarkdown = 'tool/reports/mathlive_history_adapter_report.md';
  static const bool packageSideHistoryAdapterImplemented = true;
  static const bool q102StateNormalizationRequired = true;
  static const bool q103GraphEligibilityAdapterRequired = true;
  static const bool q101LabSmokeEvidenceClosureRequiredForRuntimeActivation = true;
  static const bool historyControllerMutationAllowed = false;
  static const bool historyPanelMutationAllowed = false;
  static const bool historyUiMutationAllowed = false;
  static const bool graphUiMutationAllowed = false;
  static const bool solutionUiMutationAllowed = false;
  static const bool keyboardMutationAllowed = false;
  static const bool appShellMutationAllowed = false;
  static const bool mainEditorSwitchAllowed = false;
  static const bool mainEditorMountAllowed = false;
  static const bool mathLiveEnabledByDefault = false;
  static const bool legacyCursorDeletionAllowed = false;
  static const bool protectedUiSurfaceMutationAllowed = false;
  static const bool cursorPassClaimAllowed = false;
  static const bool fakeHistoryWriteAllowed = false;
  static const String inputEngine = 'mathlive';

  static MathLiveHistoryAdapterReadiness evaluateReadiness({
    required bool adapterPolicyPresent,
    required bool deterministicHistorySamplesPass,
    required bool q102StateNormalizationReady,
    required bool q103GraphEligibilityReady,
    required bool q101LabSmokeEvidenceClosed,
    required bool protectedSurfacesUnchanged,
    required bool historyControllerUntouched,
    required bool historyPanelUntouched,
    required bool graphHistorySolutionUiUntouched,
    required bool mainEditorStillLegacy,
    required bool noFakeHistoryWrite,
    required bool noRuntimeEvidenceFaked,
  }) {
    final blockers = <String>[];
    if (!adapterPolicyPresent) blockers.add('Q104 history adapter policy is missing');
    if (!deterministicHistorySamplesPass) blockers.add('Q104 deterministic history samples did not pass');
    if (!q102StateNormalizationReady) blockers.add('Q102 state normalization is not package-ready');
    if (!q103GraphEligibilityReady) blockers.add('Q103 graph eligibility adapter is not package-ready');
    if (!q101LabSmokeEvidenceClosed) blockers.add('Q101 Lab smoke evidence closure has not passed; Q104 must remain package-side only');
    if (!protectedSurfacesUnchanged) blockers.add('protected UI surfaces changed');
    if (!historyControllerUntouched) blockers.add('history_controller.dart changed during Q104');
    if (!historyPanelUntouched) blockers.add('history_panel.dart changed during Q104');
    if (!graphHistorySolutionUiUntouched) blockers.add('Graph/History/Solution UI surfaces changed');
    if (!mainEditorStillLegacy) blockers.add('main editor did not remain legacy/default');
    if (!noFakeHistoryWrite) blockers.add('fake History write was produced before runtime activation');
    if (!noRuntimeEvidenceFaked) blockers.add('runtime evidence was faked');

    final packageReady = adapterPolicyPresent &&
        deterministicHistorySamplesPass &&
        q102StateNormalizationReady &&
        q103GraphEligibilityReady &&
        protectedSurfacesUnchanged &&
        historyControllerUntouched &&
        historyPanelUntouched &&
        graphHistorySolutionUiUntouched &&
        mainEditorStillLegacy &&
        noFakeHistoryWrite &&
        noRuntimeEvidenceFaked;
    final runtimeReady = packageReady && q101LabSmokeEvidenceClosed;
    return MathLiveHistoryAdapterReadiness(
      status: runtimeReady
          ? 'MATHLIVE_HISTORY_ADAPTER_READY_FOR_RUNTIME_BINDING'
          : packageReady
              ? 'MATHLIVE_HISTORY_ADAPTER_PACKAGE_READY_BUT_RUNTIME_EVIDENCE_BLOCKED'
              : 'BLOCKED_MATHLIVE_HISTORY_ADAPTER',
      blockers: blockers,
      packageSideHistoryReady: packageReady,
      mayProceedToRuntimeHistoryBinding: runtimeReady,
      mayWriteHistoryAtRuntime: runtimeReady,
      maySwitchMainEditor: false,
      mayMountMainEditor: false,
      mayDeleteLegacyCursor: false,
      mayClaimCursorPass: false,
      mayMutateHistoryController: false,
      mayMutateHistoryPanel: false,
    );
  }

  static MathLiveHistoryEntryEnvelope buildEntryEnvelope(
    MathLiveEditorStateSnapshot snapshot, {
    DateTime? createdAtUtc,
    String? entryIdSeed,
  }) {
    final normalized = MathLiveStateNormalizationHardeningPolicy.normalizeSnapshot(snapshot);
    final graph = MathLiveGraphEligibilityAdapterPolicy.classifyNormalized(normalized);
    final createdAt = (createdAtUtc ?? DateTime.fromMillisecondsSinceEpoch(0, isUtc: true)).toUtc();
    final expression = normalized.historyPayloadExpression.trim();
    final idSeed = entryIdSeed ?? _stableSeed('${snapshot.latex}|$expression|${createdAt.toIso8601String()}');
    return MathLiveHistoryEntryEnvelope(
      phase: phase,
      id: 'mathlive-history-$idSeed',
      inputEngine: inputEngine,
      sourceLatex: normalized.sourceLatex,
      normalizedExpression: normalized.normalizedExpression,
      inputExpression: expression,
      displayExpression: expression,
      plainText: snapshot.plainText,
      mathJson: snapshot.mathJson,
      evaluateRequested: snapshot.evaluateRequested,
      graphEligibilityKind: graph.eligibilityKind,
      graphNormalizedExpression: graph.graphNormalizedExpression,
      graphCandidateAvailable: graph.isGraphCandidate,
      solutionCandidateExpression: normalized.solutionCandidateExpression,
      evaluatorDisplayValue: graph.evaluatorDisplayValue,
      evaluatorSemanticType: graph.evaluatorSemanticType,
      evaluatorUnsupportedReason: graph.evaluatorUnsupportedReason,
      createdAtIso8601: createdAt.toIso8601String(),
      pinned: false,
      runtimeWriteAllowed: false,
      historyControllerMutationAllowed: false,
      historyPanelMutationAllowed: false,
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

class MathLiveHistoryAdapterReadiness {
  const MathLiveHistoryAdapterReadiness({
    required this.status,
    required this.blockers,
    required this.packageSideHistoryReady,
    required this.mayProceedToRuntimeHistoryBinding,
    required this.mayWriteHistoryAtRuntime,
    required this.maySwitchMainEditor,
    required this.mayMountMainEditor,
    required this.mayDeleteLegacyCursor,
    required this.mayClaimCursorPass,
    required this.mayMutateHistoryController,
    required this.mayMutateHistoryPanel,
  });

  final String status;
  final List<String> blockers;
  final bool packageSideHistoryReady;
  final bool mayProceedToRuntimeHistoryBinding;
  final bool mayWriteHistoryAtRuntime;
  final bool maySwitchMainEditor;
  final bool mayMountMainEditor;
  final bool mayDeleteLegacyCursor;
  final bool mayClaimCursorPass;
  final bool mayMutateHistoryController;
  final bool mayMutateHistoryPanel;

  bool get isRuntimeBlocked => !mayProceedToRuntimeHistoryBinding;
}

class MathLiveHistoryEntryEnvelope {
  const MathLiveHistoryEntryEnvelope({
    required this.phase,
    required this.id,
    required this.inputEngine,
    required this.sourceLatex,
    required this.normalizedExpression,
    required this.inputExpression,
    required this.displayExpression,
    required this.plainText,
    required this.mathJson,
    required this.evaluateRequested,
    required this.graphEligibilityKind,
    required this.graphNormalizedExpression,
    required this.graphCandidateAvailable,
    required this.solutionCandidateExpression,
    required this.evaluatorDisplayValue,
    required this.evaluatorSemanticType,
    required this.evaluatorUnsupportedReason,
    required this.createdAtIso8601,
    required this.pinned,
    required this.runtimeWriteAllowed,
    required this.historyControllerMutationAllowed,
    required this.historyPanelMutationAllowed,
    required this.mainEditorSwitchAllowed,
    required this.legacyCursorDeletionAllowed,
  });

  final String phase;
  final String id;
  final String inputEngine;
  final String sourceLatex;
  final String normalizedExpression;
  final String inputExpression;
  final String displayExpression;
  final String plainText;
  final Object? mathJson;
  final bool evaluateRequested;
  final String graphEligibilityKind;
  final String graphNormalizedExpression;
  final bool graphCandidateAvailable;
  final String solutionCandidateExpression;
  final String evaluatorDisplayValue;
  final String evaluatorSemanticType;
  final String evaluatorUnsupportedReason;
  final String createdAtIso8601;
  final bool pinned;
  final bool runtimeWriteAllowed;
  final bool historyControllerMutationAllowed;
  final bool historyPanelMutationAllowed;
  final bool mainEditorSwitchAllowed;
  final bool legacyCursorDeletionAllowed;

  bool get hasInputExpression => inputExpression.trim().isNotEmpty;
  bool get isMathLiveEntry => inputEngine == MathLiveHistoryAdapterPolicy.inputEngine;

  Map<String, Object?> toJson() => <String, Object?>{
        'phase': phase,
        'id': id,
        'inputEngine': inputEngine,
        'sourceLatex': sourceLatex,
        'normalizedExpression': normalizedExpression,
        'inputExpression': inputExpression,
        'displayExpression': displayExpression,
        'plainText': plainText,
        'mathJson': mathJson,
        'evaluateRequested': evaluateRequested,
        'graphEligibilityKind': graphEligibilityKind,
        'graphNormalizedExpression': graphNormalizedExpression,
        'graphCandidateAvailable': graphCandidateAvailable,
        'solutionCandidateExpression': solutionCandidateExpression,
        'evaluatorDisplayValue': evaluatorDisplayValue,
        'evaluatorSemanticType': evaluatorSemanticType,
        'evaluatorUnsupportedReason': evaluatorUnsupportedReason,
        'createdAtIso8601': createdAtIso8601,
        'pinned': pinned,
        'runtimeWriteAllowed': runtimeWriteAllowed,
        'historyControllerMutationAllowed': historyControllerMutationAllowed,
        'historyPanelMutationAllowed': historyPanelMutationAllowed,
        'mainEditorSwitchAllowed': mainEditorSwitchAllowed,
        'legacyCursorDeletionAllowed': legacyCursorDeletionAllowed,
      };
}
