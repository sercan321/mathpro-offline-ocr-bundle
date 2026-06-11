import 'mathlive_main_editor_switch_conditional_activation_policy.dart';
import 'mathlive_main_editor_switch_preflight_gate_policy.dart';
import 'mathlive_main_workspace_mount_flag_policy.dart';

/// V172-Q118 — Main Editor Activation Dry-Run Gate.
///
/// Q118 is deliberately not a runtime activation. It is the first activation-
/// shaped court after Q117, but while Q116/Q117 evidence is absent it must run
/// only as a dry-run gate. It proves that the package still refuses to switch
/// the default editor, retire the legacy cursor path, mutate protected UI
/// surfaces, or claim cursor/device PASS without the complete post-Q115 cursor
/// court evidence chain and explicit activation approval.
class MathLiveMainEditorActivationDryRunGatePolicy {
  const MathLiveMainEditorActivationDryRunGatePolicy._();

  static const String phase = 'V172-Q118';
  static const String prerequisitePreflightPhase = MathLiveMainEditorSwitchPreflightGatePolicy.phase;
  static const String prerequisiteConditionalActivationPhase = MathLiveMainEditorSwitchConditionalActivationPolicy.phase;
  static const String verifierScript = 'tool/verify_mathlive_main_editor_activation_dry_run_gate.mjs';
  static const String reportJson = 'tool/reports/mathlive_main_editor_activation_dry_run_gate_report.json';
  static const String reportMarkdown = 'tool/reports/mathlive_main_editor_activation_dry_run_gate_report.md';
  static const String captureJson = 'tool/reports/mathlive_main_editor_activation_dry_run_gate_capture.json';
  static const String candidateEngine = MathLiveMainEditorSwitchPreflightGatePolicy.candidateEngine;
  static const String defaultEngine = MathLiveMainEditorSwitchPreflightGatePolicy.defaultEngine;
  static const String rollbackEngine = MathLiveMainEditorSwitchPreflightGatePolicy.rollbackEngine;
  static const String internalFlagName = MathLiveMainWorkspaceMountFlagPolicy.internalFlagName;

  static const bool dryRunGateOnly = true;
  static const bool actualMainEditorSwitchImplementedInThisPackage = false;
  static const bool mainWorkspaceMountImplementedInThisPackage = false;
  static const bool mathLiveEnabledByDefault = false;
  static const bool legacyFlutterSlotEditorRemainsDefault = true;
  static const bool legacyRollbackRequired = true;
  static const bool q117PreflightEvidenceRequired = true;
  static const bool q117HumanReviewRequired = true;
  static const bool explicitActivationApprovalRequired = true;
  static const bool explicitRuntimeFlagRequired = true;
  static const bool postActivationSoakRequiredBeforeDefaultSwitch = true;
  static const bool graphHistorySolutionRuntimeVerificationRequired = true;
  static const bool flutterAnalyzeRequired = true;
  static const bool flutterTestRequired = true;
  static const bool labDeviceRunRequired = true;
  static const bool mainDeviceRunRequired = true;
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

  static const List<String> requiredDryRunCommands = <String>[
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
    'flutter run -t lib/main_mathlive_lab.dart -d 23106RN0DA',
    'flutter run -d 23106RN0DA',
  ];

  static MathLiveMainEditorActivationDryRunReadiness evaluateReadiness({
    required bool q117PreflightPackageReady,
    required bool q117PreflightEvidenceComplete,
    required bool q117HumanReviewApproved,
    required bool explicitRuntimeFlagEnabled,
    required bool explicitActivationApproval,
    required bool flutterAnalyzePassed,
    required bool flutterTestPassed,
    required bool labDeviceRunCaptured,
    required bool mainDeviceRunCaptured,
    required bool graphRuntimeVerified,
    required bool historyRuntimeVerified,
    required bool solutionRuntimeVerified,
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
    if (!q117PreflightPackageReady) blockers.add('Q117 main-editor switch preflight package gate is not ready');
    if (!q117PreflightEvidenceComplete) blockers.add('Q117 preflight evidence is not complete');
    if (!q117HumanReviewApproved) blockers.add('Q117 human review approval is missing');
    if (!explicitRuntimeFlagEnabled) blockers.add('explicit runtime MathLive main-editor flag is not enabled');
    if (!explicitActivationApproval) blockers.add('explicit Q118 activation approval is missing');
    if (!flutterAnalyzePassed) blockers.add('flutter analyze PASS evidence is missing');
    if (!flutterTestPassed) blockers.add('flutter test PASS evidence is missing');
    if (!labDeviceRunCaptured) blockers.add('MathLive Lab real-device run evidence is missing');
    if (!mainDeviceRunCaptured) blockers.add('main app real-device run evidence is missing');
    if (!graphRuntimeVerified) blockers.add('Graph runtime verification is missing');
    if (!historyRuntimeVerified) blockers.add('History runtime verification is missing');
    if (!solutionRuntimeVerified) blockers.add('Solution runtime verification is missing');
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
    if (!noActualSwitchInThisPackage) blockers.add('Q118 package attempted to switch the main editor');
    if (!noLegacyRetirementOrDeletion) blockers.add('Q118 package attempted legacy retirement or deletion');

    final packageSideGateReady = q117PreflightPackageReady &&
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
        q117PreflightEvidenceComplete &&
        q117HumanReviewApproved &&
        explicitRuntimeFlagEnabled &&
        explicitActivationApproval &&
        flutterAnalyzePassed &&
        flutterTestPassed &&
        labDeviceRunCaptured &&
        mainDeviceRunCaptured &&
        graphRuntimeVerified &&
        historyRuntimeVerified &&
        solutionRuntimeVerified;

    return MathLiveMainEditorActivationDryRunReadiness(
      status: activationEvidenceComplete
          ? 'Q118_MAIN_EDITOR_ACTIVATION_DRY_RUN_READY_FOR_HUMAN_REVIEW'
          : packageSideGateReady
              ? 'Q118_MAIN_EDITOR_ACTIVATION_DRY_RUN_PACKAGE_READY_BUT_PREFLIGHT_EVIDENCE_BLOCKED'
              : 'BLOCKED_Q118_MAIN_EDITOR_ACTIVATION_DRY_RUN_PACKAGE',
      blockers: blockers,
      packageSideGateReady: packageSideGateReady,
      activationEvidenceComplete: activationEvidenceComplete,
      selectedDefaultEngine: defaultEngine,
      candidateEngine: candidateEngine,
      rollbackEngine: rollbackEngine,
      mayProceedToRuntimeActivationReview: activationEvidenceComplete,
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
        'preflightGate': prerequisitePreflightPhase,
        'conditionalActivation': prerequisiteConditionalActivationPhase,
      };
}

class MathLiveMainEditorActivationDryRunReadiness {
  const MathLiveMainEditorActivationDryRunReadiness({
    required this.status,
    required this.blockers,
    required this.packageSideGateReady,
    required this.activationEvidenceComplete,
    required this.selectedDefaultEngine,
    required this.candidateEngine,
    required this.rollbackEngine,
    required this.mayProceedToRuntimeActivationReview,
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
  final bool mayProceedToRuntimeActivationReview;
  final bool actualMainEditorSwitchImplementedInThisPackage;
  final bool mathLiveEnabledByDefault;
  final bool maySwitchDefaultEditorNow;
  final bool mayRetireLegacyMainPathNow;
  final bool mayDeleteLegacyCursor;
  final bool mayClaimCursorPass;
  final bool protectedUiSurfaceMutationAllowed;

  bool get isBlocked => !activationEvidenceComplete;
}
