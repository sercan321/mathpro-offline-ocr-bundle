import 'mathlive_graph_eligibility_adapter_policy.dart';
import 'mathlive_history_adapter_policy.dart';
import 'mathlive_lab_smoke_evidence_closure_policy.dart';
import 'mathlive_main_keyboard_bridge_policy.dart';
import 'mathlive_main_workspace_mount_flag_policy.dart';
import 'mathlive_official_runtime_bundle_closure_policy.dart';
import 'mathlive_real_device_cursor_court_execution_policy.dart';
import 'mathlive_solution_evaluator_candidate_adapter_policy.dart';

/// V172-Q109 — Main Editor Switch Conditional Activation.
///
/// Q109 is a conditional activation gate only. It does not switch the default
/// editor, does not mount MathLive in the main workspace, and does not retire or
/// delete the legacy cursor. It defines the exact evidence set that must be
/// present before a later phase may review activating MathLive behind the
/// explicit internal flag.
class MathLiveMainEditorSwitchConditionalActivationPolicy {
  const MathLiveMainEditorSwitchConditionalActivationPolicy._();

  static const String phase = 'V172-Q109';
  static const String verifierScript = 'tool/verify_mathlive_main_editor_switch_conditional_activation.mjs';
  static const String reportJson = 'tool/reports/mathlive_main_editor_switch_conditional_activation_report.json';
  static const String reportMarkdown = 'tool/reports/mathlive_main_editor_switch_conditional_activation_report.md';
  static const String internalFlagName = MathLiveMainWorkspaceMountFlagPolicy.internalFlagName;
  static const String candidateEngine = 'mathlive';
  static const String defaultEngine = 'legacyFlutterSlotEditor';
  static const String rollbackEngine = 'legacyFlutterSlotEditor';
  static const String q100OfficialRuntimePhase = MathLiveOfficialRuntimeBundleClosurePolicy.phase;
  static const String q101LabSmokeEvidenceClosurePhase = MathLiveLabSmokeEvidenceClosurePolicy.phase;
  static const String q103GraphEligibilityPhase = MathLiveGraphEligibilityAdapterPolicy.phase;
  static const String q104HistoryAdapterPhase = MathLiveHistoryAdapterPolicy.phase;
  static const String q105SolutionEvaluatorPhase = MathLiveSolutionEvaluatorCandidateAdapterPolicy.phase;
  static const String q106MountFlagPhase = MathLiveMainWorkspaceMountFlagPolicy.phase;
  static const String q107MainKeyboardBridgePhase = MathLiveMainKeyboardBridgePolicy.phase;
  static const String q108RealDeviceCursorCourtExecutionPhase = MathLiveRealDeviceCursorCourtExecutionPolicy.phase;

  static const bool conditionalActivationGateImplemented = true;
  static const bool actualMainEditorSwitchImplementedInThisPackage = false;
  static const bool mainWorkspaceMountImplementedInThisPackage = false;
  static const bool mathLiveEnabledByDefault = false;
  static const bool legacyRemainsDefaultUntilLaterApprovedPhase = true;
  static const bool legacyRollbackRequired = true;
  static const bool q100OfficialRuntimeBundleClosureRequired = true;
  static const bool q101LabSmokeEvidenceClosureRequired = true;
  static const bool q103GraphEligibilityAdapterRequired = true;
  static const bool q104HistoryAdapterRequired = true;
  static const bool q105SolutionEvaluatorAdapterRequired = true;
  static const bool q106MountFlagRequired = true;
  static const bool q107MainKeyboardBridgeRequired = true;
  static const bool q108RealDeviceCursorCourtExecutionRequired = true;
  static const bool explicitInternalFlagRequired = true;
  static const bool explicitActivationReviewRequired = true;
  static const bool flutterAnalyzeRequired = true;
  static const bool flutterTestRequired = true;
  static const bool realDeviceCursorCourtPassRequired = true;
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

  static MathLiveMainEditorSwitchConditionalActivationReadiness evaluateReadiness({
    required bool q100OfficialRuntimeBundleClosed,
    required bool q101LabSmokeEvidenceClosed,
    required bool q103GraphEligibilityAdapterReady,
    required bool q104HistoryAdapterReady,
    required bool q105SolutionEvaluatorAdapterReady,
    required bool q106MountFlagPackageReady,
    required bool q107MainKeyboardBridgePackageReady,
    required bool q108RealDeviceCursorCourtEvidenceComplete,
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
    if (!q100OfficialRuntimeBundleClosed) blockers.add('Q100 official runtime bundle closure has not passed');
    if (!q101LabSmokeEvidenceClosed) blockers.add('Q101 Lab smoke evidence closure has not passed');
    if (!q103GraphEligibilityAdapterReady) blockers.add('Q103 graph eligibility adapter is not ready');
    if (!q104HistoryAdapterReady) blockers.add('Q104 History adapter is not ready');
    if (!q105SolutionEvaluatorAdapterReady) blockers.add('Q105 Solution/Evaluator adapter is not ready');
    if (!q106MountFlagPackageReady) blockers.add('Q106 mount flag package readiness is missing');
    if (!q107MainKeyboardBridgePackageReady) blockers.add('Q107 main keyboard bridge package readiness is missing');
    if (!q108RealDeviceCursorCourtEvidenceComplete) blockers.add('Q108 real-device cursor court evidence is not complete');
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
    if (!noActualSwitchInThisPackage) blockers.add('Q109 package attempted to switch the main editor');
    if (!noLegacyRetirementOrDeletion) blockers.add('Q109 package attempted legacy retirement or deletion');

    final packageSideGateReady = q103GraphEligibilityAdapterReady &&
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
    final activationEvidenceComplete = packageSideGateReady &&
        q100OfficialRuntimeBundleClosed &&
        q101LabSmokeEvidenceClosed &&
        q108RealDeviceCursorCourtEvidenceComplete &&
        flutterAnalyzePassed &&
        flutterTestPassed &&
        explicitInternalFlagEnabled &&
        explicitActivationReviewApproved;

    return MathLiveMainEditorSwitchConditionalActivationReadiness(
      status: activationEvidenceComplete
          ? 'MATHLIVE_MAIN_EDITOR_CONDITIONAL_ACTIVATION_READY_FOR_REVIEW'
          : packageSideGateReady
              ? 'MATHLIVE_MAIN_EDITOR_CONDITIONAL_ACTIVATION_PACKAGE_READY_BUT_EVIDENCE_BLOCKED'
              : 'BLOCKED_MATHLIVE_MAIN_EDITOR_CONDITIONAL_ACTIVATION',
      blockers: blockers,
      packageSideGateReady: packageSideGateReady,
      activationEvidenceComplete: activationEvidenceComplete,
      selectedDefaultEngine: defaultEngine,
      candidateEngine: candidateEngine,
      rollbackEngine: rollbackEngine,
      mayActivateBehindInternalFlagForReview: activationEvidenceComplete,
      actualMainEditorSwitchImplementedInThisPackage: false,
      mathLiveEnabledByDefault: false,
      maySwitchDefaultEditorNow: false,
      mayRetireLegacyMainPathNow: false,
      mayDeleteLegacyCursor: false,
      mayClaimCursorPass: false,
      protectedUiSurfaceMutationAllowed: false,
    );
  }
}

class MathLiveMainEditorSwitchConditionalActivationReadiness {
  const MathLiveMainEditorSwitchConditionalActivationReadiness({
    required this.status,
    required this.blockers,
    required this.packageSideGateReady,
    required this.activationEvidenceComplete,
    required this.selectedDefaultEngine,
    required this.candidateEngine,
    required this.rollbackEngine,
    required this.mayActivateBehindInternalFlagForReview,
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
  final bool activationEvidenceComplete;
  final String selectedDefaultEngine;
  final String candidateEngine;
  final String rollbackEngine;
  final bool mayActivateBehindInternalFlagForReview;
  final bool actualMainEditorSwitchImplementedInThisPackage;
  final bool mathLiveEnabledByDefault;
  final bool maySwitchDefaultEditorNow;
  final bool mayRetireLegacyMainPathNow;
  final bool mayDeleteLegacyCursor;
  final bool mayClaimCursorPass;
  final bool protectedUiSurfaceMutationAllowed;

  bool get isBlocked => !activationEvidenceComplete;
}
