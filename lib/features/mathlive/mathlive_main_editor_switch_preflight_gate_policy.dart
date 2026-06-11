import 'mathlive_graph_eligibility_adapter_policy.dart';
import 'mathlive_history_adapter_policy.dart';
import 'mathlive_lab_smoke_evidence_closure_policy.dart';
import 'mathlive_main_editor_switch_conditional_activation_policy.dart';
import 'mathlive_main_keyboard_bridge_policy.dart';
import 'mathlive_main_workspace_mount_flag_policy.dart';
import 'mathlive_official_runtime_bundle_closure_policy.dart';
import 'mathlive_post_q115_cursor_court_rerun_policy.dart';
import 'mathlive_solution_evaluator_candidate_adapter_policy.dart';

/// V172-Q117 — Main Editor Switch Preflight Gate.
///
/// Q117 is not an editor switch. It is a surgical preflight gate that consumes
/// the post-Q115 cursor court rerun contract before any later phase may even
/// review activating MathLive in the main workspace behind an internal flag.
/// Without Q116 post-Q115 12/12 real-device evidence and explicit human review,
/// Q117 must remain evidence-blocked and must keep the legacy cursor stack as
/// default + rollback.
class MathLiveMainEditorSwitchPreflightGatePolicy {
  const MathLiveMainEditorSwitchPreflightGatePolicy._();

  static const String phase = 'V172-Q117';
  static const String prerequisitePostQ115CourtPhase = MathLivePostQ115CursorCourtRerunPolicy.phase;
  static const String prerequisiteConditionalActivationPhase = MathLiveMainEditorSwitchConditionalActivationPolicy.phase;
  static const String verifierScript = 'tool/verify_mathlive_main_editor_switch_preflight_gate.mjs';
  static const String reportJson = 'tool/reports/mathlive_main_editor_switch_preflight_gate_report.json';
  static const String reportMarkdown = 'tool/reports/mathlive_main_editor_switch_preflight_gate_report.md';
  static const String candidateEngine = MathLiveMainEditorSwitchConditionalActivationPolicy.candidateEngine;
  static const String defaultEngine = MathLiveMainEditorSwitchConditionalActivationPolicy.defaultEngine;
  static const String rollbackEngine = MathLiveMainEditorSwitchConditionalActivationPolicy.rollbackEngine;
  static const String internalFlagName = MathLiveMainWorkspaceMountFlagPolicy.internalFlagName;

  static const bool preflightGateOnly = true;
  static const bool actualMainEditorSwitchImplementedInThisPackage = false;
  static const bool mainWorkspaceMountImplementedInThisPackage = false;
  static const bool mathLiveEnabledByDefault = false;
  static const bool legacyFlutterSlotEditorRemainsDefault = true;
  static const bool legacyRollbackRequired = true;
  static const bool q116PostQ115CursorCourtRerunRequired = true;
  static const bool q116HumanReviewRequired = true;
  static const bool q109ConditionalActivationGateRequired = true;
  static const bool q100OfficialRuntimeBundleClosureRequired = true;
  static const bool q101LabSmokeEvidenceClosureRequired = true;
  static const bool q103GraphEligibilityAdapterRequired = true;
  static const bool q104HistoryAdapterRequired = true;
  static const bool q105SolutionEvaluatorAdapterRequired = true;
  static const bool q106MountFlagRequired = true;
  static const bool q107MainKeyboardBridgeRequired = true;
  static const bool flutterAnalyzeRequired = true;
  static const bool flutterTestRequired = true;
  static const bool explicitInternalFlagRequiredForLaterReview = true;
  static const bool explicitActivationReviewRequiredForLaterReview = true;
  static const bool keyboardMutationAllowed = false;
  static const bool moreMutationAllowed = false;
  static const bool longPressMutationAllowed = false;
  static const bool appShellMutationAllowed = false;
  static const bool graphHistorySolutionUiMutationAllowed = false;
  static const bool protectedUiSurfaceMutationAllowed = false;
  static const bool legacyCursorRetirementAllowedInThisPackage = false;
  static const bool legacyCursorDeletionAllowed = false;
  static const bool fakeRuntimeEvidenceAllowed = false;
  static const bool fakeSmokeEvidenceAllowed = false;
  static const bool fakeDeviceEvidenceAllowed = false;
  static const bool cursorPassClaimAllowedInThisPackage = false;
  static const bool mathLiveVirtualKeyboardEnabled = false;
  static const bool remoteScriptLoadingAllowed = false;

  static const List<String> requiredPreflightCommands = <String>[
    'flutter pub get',
    'flutter analyze',
    'flutter test',
    'node tool/install_mathlive_runtime.mjs',
    'node tool/verify_mathlive_runtime.mjs',
    'node tool/verify_mathlive_official_runtime_bundle.mjs',
    'node tool/verify_mathlive_lab_smoke_evidence_closure.mjs',
    'node tool/verify_mathlive_structural_caret_anchor_geometry_repair.mjs',
    'node tool/verify_mathlive_real_device_cursor_court_execution.mjs',
    'node tool/verify_mathlive_post_q115_cursor_court_rerun.mjs',
    'node tool/verify_mathlive_main_editor_switch_preflight_gate.mjs',
    'flutter run -t lib/main_mathlive_lab.dart -d 23106RN0DA',
    'flutter run -d 23106RN0DA',
  ];

  static MathLiveMainEditorSwitchPreflightReadiness evaluateReadiness({
    required bool q116PostQ115EvidenceComplete,
    required bool q116HumanReviewApproved,
    required bool q109ConditionalActivationPackageReady,
    required bool q100OfficialRuntimeBundleClosed,
    required bool q101LabSmokeEvidenceClosed,
    required bool q103GraphEligibilityAdapterReady,
    required bool q104HistoryAdapterReady,
    required bool q105SolutionEvaluatorAdapterReady,
    required bool q106MountFlagPackageReady,
    required bool q107MainKeyboardBridgePackageReady,
    required bool flutterAnalyzePassed,
    required bool flutterTestPassed,
    required bool explicitInternalFlagEnabled,
    required bool explicitActivationReviewApproved,
    required bool protectedSurfacesUnchanged,
    required bool keyboardUntouched,
    required bool moreUntouched,
    required bool longPressUntouched,
    required bool appShellUntouched,
    required bool graphHistorySolutionUiUntouched,
    required bool legacyRollbackAvailable,
    required bool virtualKeyboardDisabled,
    required bool remoteScriptsDisabled,
    required bool noFakeEvidence,
    required bool noActualSwitchInThisPackage,
    required bool noLegacyRetirementOrDeletion,
  }) {
    final blockers = <String>[];
    if (!q116PostQ115EvidenceComplete) blockers.add('Q116 post-Q115 real-device cursor court rerun evidence is not complete');
    if (!q116HumanReviewApproved) blockers.add('Q116 post-Q115 cursor court human review approval is missing');
    if (!q109ConditionalActivationPackageReady) blockers.add('Q109 conditional activation package gate is not ready');
    if (!q100OfficialRuntimeBundleClosed) blockers.add('Q100 official runtime bundle closure has not passed');
    if (!q101LabSmokeEvidenceClosed) blockers.add('Q101 Lab smoke evidence closure has not passed');
    if (!q103GraphEligibilityAdapterReady) blockers.add('Q103 graph eligibility adapter is not ready');
    if (!q104HistoryAdapterReady) blockers.add('Q104 History adapter is not ready');
    if (!q105SolutionEvaluatorAdapterReady) blockers.add('Q105 Solution/Evaluator adapter is not ready');
    if (!q106MountFlagPackageReady) blockers.add('Q106 mount flag package readiness is missing');
    if (!q107MainKeyboardBridgePackageReady) blockers.add('Q107 main keyboard bridge package readiness is missing');
    if (!flutterAnalyzePassed) blockers.add('flutter analyze PASS evidence is missing');
    if (!flutterTestPassed) blockers.add('flutter test PASS evidence is missing');
    if (!explicitInternalFlagEnabled) blockers.add('explicit internal MathLive editor flag is not enabled');
    if (!explicitActivationReviewApproved) blockers.add('explicit activation review approval is missing');
    if (!protectedSurfacesUnchanged) blockers.add('protected UI surfaces changed');
    if (!keyboardUntouched) blockers.add('keyboard source changed');
    if (!moreUntouched) blockers.add('MORE behavior source changed');
    if (!longPressUntouched) blockers.add('long-press source changed');
    if (!appShellUntouched) blockers.add('app_shell.dart changed');
    if (!graphHistorySolutionUiUntouched) blockers.add('Graph/History/Solution UI changed');
    if (!legacyRollbackAvailable) blockers.add('legacy rollback is not available');
    if (!virtualKeyboardDisabled) blockers.add('MathLive virtual keyboard is not disabled');
    if (!remoteScriptsDisabled) blockers.add('remote/CDN scripts are not disabled');
    if (!noFakeEvidence) blockers.add('runtime/smoke/device evidence was faked');
    if (!noActualSwitchInThisPackage) blockers.add('Q117 package attempted to switch the main editor');
    if (!noLegacyRetirementOrDeletion) blockers.add('Q117 package attempted legacy retirement or deletion');

    final packageSideGateReady = q109ConditionalActivationPackageReady &&
        q103GraphEligibilityAdapterReady &&
        q104HistoryAdapterReady &&
        q105SolutionEvaluatorAdapterReady &&
        q106MountFlagPackageReady &&
        q107MainKeyboardBridgePackageReady &&
        protectedSurfacesUnchanged &&
        keyboardUntouched &&
        moreUntouched &&
        longPressUntouched &&
        appShellUntouched &&
        graphHistorySolutionUiUntouched &&
        legacyRollbackAvailable &&
        virtualKeyboardDisabled &&
        remoteScriptsDisabled &&
        noFakeEvidence &&
        noActualSwitchInThisPackage &&
        noLegacyRetirementOrDeletion;

    final preflightEvidenceComplete = packageSideGateReady &&
        q116PostQ115EvidenceComplete &&
        q116HumanReviewApproved &&
        q100OfficialRuntimeBundleClosed &&
        q101LabSmokeEvidenceClosed &&
        flutterAnalyzePassed &&
        flutterTestPassed &&
        explicitInternalFlagEnabled &&
        explicitActivationReviewApproved;

    return MathLiveMainEditorSwitchPreflightReadiness(
      status: preflightEvidenceComplete
          ? 'Q117_MAIN_EDITOR_SWITCH_PREFLIGHT_READY_FOR_HUMAN_REVIEW'
          : packageSideGateReady
              ? 'Q117_MAIN_EDITOR_SWITCH_PREFLIGHT_PACKAGE_READY_BUT_EVIDENCE_BLOCKED'
              : 'BLOCKED_Q117_MAIN_EDITOR_SWITCH_PREFLIGHT_PACKAGE',
      blockers: blockers,
      packageSideGateReady: packageSideGateReady,
      preflightEvidenceComplete: preflightEvidenceComplete,
      selectedDefaultEngine: defaultEngine,
      candidateEngine: candidateEngine,
      rollbackEngine: rollbackEngine,
      mayProceedToMainEditorActivationReview: preflightEvidenceComplete,
      actualMainEditorSwitchImplementedInThisPackage: false,
      mathLiveEnabledByDefault: false,
      maySwitchDefaultEditorNow: false,
      mayRetireLegacyMainPathNow: false,
      mayDeleteLegacyCursor: false,
      mayClaimCursorPass: false,
      protectedUiSurfaceMutationAllowed: false,
    );
  }

  static Map<String, String> prerequisitePhaseMap() => <String, String>{
        'postQ115CursorCourtRerun': prerequisitePostQ115CourtPhase,
        'conditionalActivation': prerequisiteConditionalActivationPhase,
        'officialRuntimeBundle': MathLiveOfficialRuntimeBundleClosurePolicy.phase,
        'labSmokeEvidenceClosure': MathLiveLabSmokeEvidenceClosurePolicy.phase,
        'graphEligibility': MathLiveGraphEligibilityAdapterPolicy.phase,
        'historyAdapter': MathLiveHistoryAdapterPolicy.phase,
        'solutionEvaluator': MathLiveSolutionEvaluatorCandidateAdapterPolicy.phase,
        'mountFlag': MathLiveMainWorkspaceMountFlagPolicy.phase,
        'mainKeyboardBridge': MathLiveMainKeyboardBridgePolicy.phase,
      };
}

class MathLiveMainEditorSwitchPreflightReadiness {
  const MathLiveMainEditorSwitchPreflightReadiness({
    required this.status,
    required this.blockers,
    required this.packageSideGateReady,
    required this.preflightEvidenceComplete,
    required this.selectedDefaultEngine,
    required this.candidateEngine,
    required this.rollbackEngine,
    required this.mayProceedToMainEditorActivationReview,
    required this.actualMainEditorSwitchImplementedInThisPackage,
    required this.mathLiveEnabledByDefault,
    required this.maySwitchDefaultEditorNow,
    required this.mayRetireLegacyMainPathNow,
    required this.mayDeleteLegacyCursor,
    required this.mayClaimCursorPass,
    required this.protectedUiSurfaceMutationAllowed,
  });

  final String status;
  final List<String> blockers;
  final bool packageSideGateReady;
  final bool preflightEvidenceComplete;
  final String selectedDefaultEngine;
  final String candidateEngine;
  final String rollbackEngine;
  final bool mayProceedToMainEditorActivationReview;
  final bool actualMainEditorSwitchImplementedInThisPackage;
  final bool mathLiveEnabledByDefault;
  final bool maySwitchDefaultEditorNow;
  final bool mayRetireLegacyMainPathNow;
  final bool mayDeleteLegacyCursor;
  final bool mayClaimCursorPass;
  final bool protectedUiSurfaceMutationAllowed;

  bool get isBlocked => !preflightEvidenceComplete;
}
