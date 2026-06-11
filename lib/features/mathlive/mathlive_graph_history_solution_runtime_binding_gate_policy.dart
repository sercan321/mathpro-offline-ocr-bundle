import 'mathlive_graph_eligibility_adapter_policy.dart';
import 'mathlive_history_adapter_policy.dart';
import 'mathlive_main_editor_activation_dry_run_gate_policy.dart';
import 'mathlive_solution_evaluator_candidate_adapter_policy.dart';

/// V172-Q119 — Graph / History / Solution Runtime Binding Gate.
///
/// Q119 is not a runtime binding implementation. It is a release-safety gate
/// that keeps MathLive Graph, History, and Solution writes disabled until Q118
/// activation dry-run evidence, explicit human approval, Flutter evidence,
/// real-device runs, protected-surface invariants, adapter readiness, and
/// rollback evidence are all present.
class MathLiveGraphHistorySolutionRuntimeBindingGatePolicy {
  const MathLiveGraphHistorySolutionRuntimeBindingGatePolicy._();

  static const String phase = 'V172-Q119';
  static const String prerequisiteActivationDryRunPhase = MathLiveMainEditorActivationDryRunGatePolicy.phase;
  static const String graphAdapterPhase = MathLiveGraphEligibilityAdapterPolicy.phase;
  static const String historyAdapterPhase = MathLiveHistoryAdapterPolicy.phase;
  static const String solutionAdapterPhase = MathLiveSolutionEvaluatorCandidateAdapterPolicy.phase;
  static const String verifierScript = 'tool/verify_mathlive_graph_history_solution_runtime_binding_gate.mjs';
  static const String reportJson = 'tool/reports/mathlive_graph_history_solution_runtime_binding_gate_report.json';
  static const String reportMarkdown = 'tool/reports/mathlive_graph_history_solution_runtime_binding_gate_report.md';
  static const String captureJson = 'tool/reports/mathlive_graph_history_solution_runtime_binding_gate_capture.json';
  static const String inputEngine = 'mathlive';
  static const String defaultEngine = MathLiveMainEditorActivationDryRunGatePolicy.defaultEngine;
  static const String rollbackEngine = MathLiveMainEditorActivationDryRunGatePolicy.rollbackEngine;

  static const bool gateOnly = true;
  static const bool runtimeGraphBindingImplementedInThisPackage = false;
  static const bool runtimeHistoryBindingImplementedInThisPackage = false;
  static const bool runtimeSolutionBindingImplementedInThisPackage = false;
  static const bool graphCardMutationAllowed = false;
  static const bool historyControllerMutationAllowed = false;
  static const bool historyPanelMutationAllowed = false;
  static const bool solutionStepsPanelMutationAllowed = false;
  static const bool graphHistorySolutionUiMutationAllowed = false;
  static const bool keyboardMutationAllowed = false;
  static const bool moreMutationAllowed = false;
  static const bool longPressMutationAllowed = false;
  static const bool appShellMutationAllowed = false;
  static const bool mathLiveEnabledByDefault = false;
  static const bool mainEditorSwitchAllowedInThisPackage = false;
  static const bool legacyCursorRetirementAllowedInThisPackage = false;
  static const bool legacyCursorDeletionAllowed = false;
  static const bool legacyRollbackRequired = true;
  static const bool q118ActivationEvidenceRequired = true;
  static const bool q118HumanReviewRequired = true;
  static const bool explicitRuntimeBindingApprovalRequired = true;
  static const bool flutterAnalyzeRequired = true;
  static const bool flutterTestRequired = true;
  static const bool labDeviceRunRequired = true;
  static const bool mainDeviceRunRequired = true;
  static const bool graphRuntimeScenarioEvidenceRequired = true;
  static const bool historyRuntimeScenarioEvidenceRequired = true;
  static const bool solutionRuntimeScenarioEvidenceRequired = true;
  static const bool fakeGraphEvidenceAllowed = false;
  static const bool fakeHistoryEvidenceAllowed = false;
  static const bool fakeSolutionEvidenceAllowed = false;
  static const bool fakeRuntimeEvidenceAllowed = false;
  static const bool fakeDeviceEvidenceAllowed = false;
  static const bool cursorPassClaimAllowedInThisPackage = false;
  static const bool releasePassClaimAllowedInThisPackage = false;

  static const List<String> protectedRuntimeUiSurfaces = <String>[
    'lib/features/graph/graph_card.dart',
    'lib/features/history/history_controller.dart',
    'lib/features/history/history_panel.dart',
    'lib/features/solution/solution_steps_panel.dart',
  ];

  static const List<String> requiredBindingCourtCommands = <String>[
    'flutter pub get',
    'flutter analyze',
    'flutter test',
    'node tool/install_mathlive_runtime.mjs',
    'node tool/verify_mathlive_runtime.mjs',
    'node tool/verify_mathlive_official_runtime_bundle.mjs',
    'node tool/verify_mathlive_lab_smoke_evidence_closure.mjs',
    'node tool/verify_mathlive_structural_caret_anchor_geometry_repair.mjs',
    'node tool/verify_mathlive_post_q115_cursor_court_rerun.mjs',
    'node tool/verify_mathlive_main_editor_switch_preflight_gate.mjs',
    'node tool/verify_mathlive_main_editor_activation_dry_run_gate.mjs',
    'node tool/verify_mathlive_graph_history_solution_runtime_binding_gate.mjs',
    'flutter run -t lib/main_mathlive_lab.dart -d 23106RN0DA',
    'flutter run -d 23106RN0DA',
  ];

  static MathLiveGraphHistorySolutionRuntimeBindingReadiness evaluateReadiness({
    required bool q118ActivationDryRunPackageReady,
    required bool q118ActivationEvidenceComplete,
    required bool q118HumanReviewApproved,
    required bool explicitRuntimeBindingApproval,
    required bool q103GraphAdapterReady,
    required bool q104HistoryAdapterReady,
    required bool q105SolutionAdapterReady,
    required bool flutterAnalyzePassed,
    required bool flutterTestPassed,
    required bool labDeviceRunCaptured,
    required bool mainDeviceRunCaptured,
    required bool graphRuntimeScenarioEvidenceProvided,
    required bool historyRuntimeScenarioEvidenceProvided,
    required bool solutionRuntimeScenarioEvidenceProvided,
    required bool protectedSurfacesUnchanged,
    required bool graphCardUntouched,
    required bool historyControllerUntouched,
    required bool historyPanelUntouched,
    required bool solutionStepsPanelUntouched,
    required bool keyboardUntouched,
    required bool moreUntouched,
    required bool longPressUntouched,
    required bool appShellUntouched,
    required bool legacyRollbackAvailable,
    required bool noRuntimeGraphWriteInThisPackage,
    required bool noRuntimeHistoryWriteInThisPackage,
    required bool noRuntimeSolutionWriteInThisPackage,
    required bool noFakeGraphEvidence,
    required bool noFakeHistoryEvidence,
    required bool noFakeSolutionEvidence,
    required bool noFakeRuntimeEvidence,
    required bool noMainEditorSwitchInThisPackage,
    required bool noLegacyRetirementOrDeletion,
  }) {
    final blockers = <String>[];
    if (!q118ActivationDryRunPackageReady) blockers.add('Q118 activation dry-run package gate is not ready');
    if (!q118ActivationEvidenceComplete) blockers.add('Q118 activation dry-run evidence is not complete');
    if (!q118HumanReviewApproved) blockers.add('Q118 human review approval is missing');
    if (!explicitRuntimeBindingApproval) blockers.add('explicit Q119 Graph/History/Solution runtime binding approval is missing');
    if (!q103GraphAdapterReady) blockers.add('Q103 Graph eligibility adapter is not ready');
    if (!q104HistoryAdapterReady) blockers.add('Q104 History adapter is not ready');
    if (!q105SolutionAdapterReady) blockers.add('Q105 Solution/Evaluator adapter is not ready');
    if (!flutterAnalyzePassed) blockers.add('flutter analyze PASS evidence is missing');
    if (!flutterTestPassed) blockers.add('flutter test PASS evidence is missing');
    if (!labDeviceRunCaptured) blockers.add('MathLive Lab real-device run evidence is missing');
    if (!mainDeviceRunCaptured) blockers.add('main app real-device run evidence is missing');
    if (!graphRuntimeScenarioEvidenceProvided) blockers.add('Graph runtime scenario evidence is missing');
    if (!historyRuntimeScenarioEvidenceProvided) blockers.add('History runtime scenario evidence is missing');
    if (!solutionRuntimeScenarioEvidenceProvided) blockers.add('Solution runtime scenario evidence is missing');
    if (!protectedSurfacesUnchanged) blockers.add('protected UI surfaces changed');
    if (!graphCardUntouched) blockers.add('graph_card.dart changed');
    if (!historyControllerUntouched) blockers.add('history_controller.dart changed');
    if (!historyPanelUntouched) blockers.add('history_panel.dart changed');
    if (!solutionStepsPanelUntouched) blockers.add('solution_steps_panel.dart changed');
    if (!keyboardUntouched) blockers.add('keyboard source changed');
    if (!moreUntouched) blockers.add('MORE behavior source changed');
    if (!longPressUntouched) blockers.add('long-press source changed');
    if (!appShellUntouched) blockers.add('app_shell.dart changed');
    if (!legacyRollbackAvailable) blockers.add('legacy rollback is not available');
    if (!noRuntimeGraphWriteInThisPackage) blockers.add('Q119 package attempted runtime Graph writes');
    if (!noRuntimeHistoryWriteInThisPackage) blockers.add('Q119 package attempted runtime History writes');
    if (!noRuntimeSolutionWriteInThisPackage) blockers.add('Q119 package attempted runtime Solution writes');
    if (!noFakeGraphEvidence) blockers.add('Graph runtime evidence was faked');
    if (!noFakeHistoryEvidence) blockers.add('History runtime evidence was faked');
    if (!noFakeSolutionEvidence) blockers.add('Solution runtime evidence was faked');
    if (!noFakeRuntimeEvidence) blockers.add('runtime/device evidence was faked');
    if (!noMainEditorSwitchInThisPackage) blockers.add('Q119 package attempted to switch the main editor');
    if (!noLegacyRetirementOrDeletion) blockers.add('Q119 package attempted legacy retirement or deletion');

    final packageSideGateReady = q118ActivationDryRunPackageReady &&
        q103GraphAdapterReady &&
        q104HistoryAdapterReady &&
        q105SolutionAdapterReady &&
        protectedSurfacesUnchanged &&
        graphCardUntouched &&
        historyControllerUntouched &&
        historyPanelUntouched &&
        solutionStepsPanelUntouched &&
        keyboardUntouched &&
        moreUntouched &&
        longPressUntouched &&
        appShellUntouched &&
        legacyRollbackAvailable &&
        noRuntimeGraphWriteInThisPackage &&
        noRuntimeHistoryWriteInThisPackage &&
        noRuntimeSolutionWriteInThisPackage &&
        noFakeGraphEvidence &&
        noFakeHistoryEvidence &&
        noFakeSolutionEvidence &&
        noFakeRuntimeEvidence &&
        noMainEditorSwitchInThisPackage &&
        noLegacyRetirementOrDeletion;

    final runtimeBindingEvidenceComplete = packageSideGateReady &&
        q118ActivationEvidenceComplete &&
        q118HumanReviewApproved &&
        explicitRuntimeBindingApproval &&
        flutterAnalyzePassed &&
        flutterTestPassed &&
        labDeviceRunCaptured &&
        mainDeviceRunCaptured &&
        graphRuntimeScenarioEvidenceProvided &&
        historyRuntimeScenarioEvidenceProvided &&
        solutionRuntimeScenarioEvidenceProvided;

    return MathLiveGraphHistorySolutionRuntimeBindingReadiness(
      status: runtimeBindingEvidenceComplete
          ? 'Q119_GRAPH_HISTORY_SOLUTION_RUNTIME_BINDING_READY_FOR_HUMAN_REVIEW'
          : packageSideGateReady
              ? 'Q119_GRAPH_HISTORY_SOLUTION_RUNTIME_BINDING_PACKAGE_READY_BUT_EVIDENCE_BLOCKED'
              : 'BLOCKED_Q119_GRAPH_HISTORY_SOLUTION_RUNTIME_BINDING_GATE',
      blockers: blockers,
      packageSideGateReady: packageSideGateReady,
      runtimeBindingEvidenceComplete: runtimeBindingEvidenceComplete,
      mayBindGraphAtRuntime: runtimeBindingEvidenceComplete,
      mayBindHistoryAtRuntime: runtimeBindingEvidenceComplete,
      mayBindSolutionAtRuntime: runtimeBindingEvidenceComplete,
      maySwitchMainEditor: false,
      mayRetireLegacyMainPath: false,
      mayDeleteLegacyCursor: false,
      mayClaimCursorPass: false,
      mayClaimReleasePass: false,
      mayMutateProtectedRuntimeUiSurfaces: false,
    );
  }
}

class MathLiveGraphHistorySolutionRuntimeBindingReadiness {
  const MathLiveGraphHistorySolutionRuntimeBindingReadiness({
    required this.status,
    required this.blockers,
    required this.packageSideGateReady,
    required this.runtimeBindingEvidenceComplete,
    required this.mayBindGraphAtRuntime,
    required this.mayBindHistoryAtRuntime,
    required this.mayBindSolutionAtRuntime,
    required this.maySwitchMainEditor,
    required this.mayRetireLegacyMainPath,
    required this.mayDeleteLegacyCursor,
    required this.mayClaimCursorPass,
    required this.mayClaimReleasePass,
    required this.mayMutateProtectedRuntimeUiSurfaces,
  });

  final String status;
  final List<String> blockers;
  final bool packageSideGateReady;
  final bool runtimeBindingEvidenceComplete;
  final bool mayBindGraphAtRuntime;
  final bool mayBindHistoryAtRuntime;
  final bool mayBindSolutionAtRuntime;
  final bool maySwitchMainEditor;
  final bool mayRetireLegacyMainPath;
  final bool mayDeleteLegacyCursor;
  final bool mayClaimCursorPass;
  final bool mayClaimReleasePass;
  final bool mayMutateProtectedRuntimeUiSurfaces;

  bool get isEvidenceBlocked => packageSideGateReady && !runtimeBindingEvidenceComplete;
}
