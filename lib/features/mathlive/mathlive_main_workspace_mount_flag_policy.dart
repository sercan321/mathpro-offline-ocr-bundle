import 'mathlive_lab_smoke_evidence_closure_policy.dart';
import 'mathlive_main_editor_flag_activation_policy.dart';
import 'mathlive_solution_evaluator_candidate_adapter_policy.dart';

/// V172-Q106 — Main Workspace MathLive Mount Behind Internal Flag.
///
/// Q106 is a mount-readiness contract, not a default editor switch. It defines
/// exactly when a future main-workspace MathLive surface may be mounted behind
/// an explicit internal flag while keeping legacy rollback intact. In this
/// package no AppShell/workspace mutation is performed, MathLive remains disabled
/// by default, and missing Q101 runtime/smoke evidence keeps runtime mounting
/// blocked.
class MathLiveMainWorkspaceMountFlagPolicy {
  const MathLiveMainWorkspaceMountFlagPolicy._();

  static const String phase = 'V172-Q106';
  static const String verifierScript = 'tool/verify_mathlive_main_workspace_mount_flag.mjs';
  static const String reportJson = 'tool/reports/mathlive_main_workspace_mount_flag_report.json';
  static const String reportMarkdown = 'tool/reports/mathlive_main_workspace_mount_flag_report.md';
  static const String internalFlagName = MathLiveMainEditorFlagActivationPolicy.flagName;

  static const bool mountReadinessContractImplemented = true;
  static const bool mainWorkspaceMountImplementedInThisPackage = false;
  static const bool q93FlagContractRequired = true;
  static const bool q101LabSmokeEvidenceClosureRequired = true;
  static const bool q105SolutionEvaluatorCandidateAdapterRequired = true;
  static const bool explicitInternalFlagRequired = true;
  static const bool legacyRollbackRequired = true;
  static const bool mathLiveEnabledByDefault = false;
  static const bool appShellMutationAllowed = false;
  static const bool keyboardMutationAllowed = false;
  static const bool moreLongPressMutationAllowed = false;
  static const bool graphHistorySolutionUiMutationAllowed = false;
  static const bool protectedUiSurfaceMutationAllowed = false;
  static const bool legacyCursorDeletionAllowed = false;
  static const bool cursorPassClaimAllowed = false;
  static const bool fakeRuntimeEvidenceAllowed = false;
  static const bool fakeSmokeEvidenceAllowed = false;
  static const bool runtimeMountAllowedWithoutQ101 = false;
  static const bool defaultEditorSwitchAllowed = false;

  static MathLiveMainWorkspaceMountFlagReadiness evaluateReadiness({
    required bool q93FlagContractPresent,
    required bool q101LabSmokeEvidenceClosed,
    required bool q105SolutionEvaluatorAdapterPackageReady,
    required bool explicitInternalFlagEnabled,
    required bool officialRuntimeVerified,
    required bool protectedSurfacesUnchanged,
    required bool appShellUntouched,
    required bool keyboardUntouched,
    required bool graphHistorySolutionUiUntouched,
    required bool legacyRollbackAvailable,
    required bool virtualKeyboardDisabled,
    required bool remoteScriptsDisabled,
    required bool noFakeEvidence,
    required bool mainWorkspaceMountCodeNotMutated,
  }) {
    final blockers = <String>[];
    if (!q93FlagContractPresent) blockers.add('Q93 behind-flag main editor contract is missing');
    if (!q105SolutionEvaluatorAdapterPackageReady) blockers.add('Q105 Solution/Evaluator adapter is not package-ready');
    if (!q101LabSmokeEvidenceClosed) blockers.add('Q101 Lab smoke evidence closure has not passed; Q106 runtime mount must remain blocked');
    if (!explicitInternalFlagEnabled) blockers.add('explicit internal MathLive editor flag is not enabled');
    if (!officialRuntimeVerified) blockers.add('official local MathLive runtime is not verified');
    if (!protectedSurfacesUnchanged) blockers.add('protected UI surfaces changed');
    if (!appShellUntouched) blockers.add('app_shell.dart changed during Q106');
    if (!keyboardUntouched) blockers.add('keyboard/MORE/long-press surfaces changed during Q106');
    if (!graphHistorySolutionUiUntouched) blockers.add('Graph/History/Solution UI surfaces changed during Q106');
    if (!legacyRollbackAvailable) blockers.add('legacy rollback is not available');
    if (!virtualKeyboardDisabled) blockers.add('MathLive virtual keyboard is not disabled');
    if (!remoteScriptsDisabled) blockers.add('remote/CDN scripts are not disabled');
    if (!noFakeEvidence) blockers.add('runtime or smoke evidence was faked');
    if (!mainWorkspaceMountCodeNotMutated) blockers.add('main workspace mount code was mutated in a guard-only Q106 package');

    final packageReady = q93FlagContractPresent &&
        q105SolutionEvaluatorAdapterPackageReady &&
        protectedSurfacesUnchanged &&
        appShellUntouched &&
        keyboardUntouched &&
        graphHistorySolutionUiUntouched &&
        legacyRollbackAvailable &&
        virtualKeyboardDisabled &&
        remoteScriptsDisabled &&
        noFakeEvidence &&
        mainWorkspaceMountCodeNotMutated;
    final mayMountBehindFlagAtRuntime = packageReady &&
        q101LabSmokeEvidenceClosed &&
        explicitInternalFlagEnabled &&
        officialRuntimeVerified;

    return MathLiveMainWorkspaceMountFlagReadiness(
      status: mayMountBehindFlagAtRuntime
          ? 'MATHLIVE_MAIN_WORKSPACE_MOUNT_READY_BEHIND_INTERNAL_FLAG'
          : packageReady
              ? 'MATHLIVE_MAIN_WORKSPACE_MOUNT_FLAG_PACKAGE_READY_BUT_RUNTIME_EVIDENCE_BLOCKED'
              : 'BLOCKED_MATHLIVE_MAIN_WORKSPACE_MOUNT_FLAG',
      blockers: blockers,
      packageSideMountFlagReady: packageReady,
      mayMountBehindInternalFlagAtRuntime: mayMountBehindFlagAtRuntime,
      mathLiveEnabledByDefault: false,
      selectedDefaultEngine: 'legacyFlutterSlotEditor',
      rollbackEngine: 'legacyFlutterSlotEditor',
      maySwitchDefaultEditor: false,
      mayDeleteLegacyCursor: false,
      mayClaimCursorPass: false,
      protectedUiSurfaceMutationAllowed: false,
    );
  }

  static MathLiveMainWorkspaceMountPlan buildMountPlan({
    required String requestedEngine,
    required bool explicitInternalFlagEnabled,
    required MathLiveLabSmokeEvidenceClosureVerdict q101Verdict,
    required MathLiveSolutionEvaluatorAdapterReadiness q105Readiness,
    required bool officialRuntimeVerified,
    required bool protectedSurfacesUnchanged,
    required bool appShellUntouched,
    required bool keyboardUntouched,
    required bool graphHistorySolutionUiUntouched,
    required bool legacyRollbackAvailable,
  }) {
    final readiness = evaluateReadiness(
      q93FlagContractPresent: true,
      q101LabSmokeEvidenceClosed: q101Verdict.labSmokeEvidenceClosed,
      q105SolutionEvaluatorAdapterPackageReady: q105Readiness.packageSideSolutionEvaluatorReady,
      explicitInternalFlagEnabled: explicitInternalFlagEnabled,
      officialRuntimeVerified: officialRuntimeVerified,
      protectedSurfacesUnchanged: protectedSurfacesUnchanged,
      appShellUntouched: appShellUntouched,
      keyboardUntouched: keyboardUntouched,
      graphHistorySolutionUiUntouched: graphHistorySolutionUiUntouched,
      legacyRollbackAvailable: legacyRollbackAvailable,
      virtualKeyboardDisabled: true,
      remoteScriptsDisabled: true,
      noFakeEvidence: true,
      mainWorkspaceMountCodeNotMutated: true,
    );

    final wantsMathLive = requestedEngine == 'mathlive';
    final selectedEngine = wantsMathLive && readiness.mayMountBehindInternalFlagAtRuntime
        ? 'mathlive'
        : 'legacyFlutterSlotEditor';
    return MathLiveMainWorkspaceMountPlan(
      phase: phase,
      requestedEngine: requestedEngine,
      selectedEngine: selectedEngine,
      internalFlagName: internalFlagName,
      explicitInternalFlagEnabled: explicitInternalFlagEnabled,
      packageSideMountFlagReady: readiness.packageSideMountFlagReady,
      mayMountBehindInternalFlagAtRuntime: readiness.mayMountBehindInternalFlagAtRuntime,
      runtimeMountAllowed: readiness.mayMountBehindInternalFlagAtRuntime,
      mathLiveEnabledByDefault: false,
      defaultEditorSwitchAllowed: false,
      legacyRollbackAvailable: legacyRollbackAvailable,
      appShellMutationAllowed: false,
      keyboardMutationAllowed: false,
      graphHistorySolutionUiMutationAllowed: false,
      legacyCursorDeletionAllowed: false,
      cursorPassClaimAllowed: false,
      blockers: readiness.blockers,
    );
  }
}

class MathLiveMainWorkspaceMountFlagReadiness {
  const MathLiveMainWorkspaceMountFlagReadiness({
    required this.status,
    required this.blockers,
    required this.packageSideMountFlagReady,
    required this.mayMountBehindInternalFlagAtRuntime,
    required this.mathLiveEnabledByDefault,
    required this.selectedDefaultEngine,
    required this.rollbackEngine,
    required this.maySwitchDefaultEditor,
    required this.mayDeleteLegacyCursor,
    required this.mayClaimCursorPass,
    required this.protectedUiSurfaceMutationAllowed,
  });

  final String status;
  final List<String> blockers;
  final bool packageSideMountFlagReady;
  final bool mayMountBehindInternalFlagAtRuntime;
  final bool mathLiveEnabledByDefault;
  final String selectedDefaultEngine;
  final String rollbackEngine;
  final bool maySwitchDefaultEditor;
  final bool mayDeleteLegacyCursor;
  final bool mayClaimCursorPass;
  final bool protectedUiSurfaceMutationAllowed;

  bool get isRuntimeBlocked => !mayMountBehindInternalFlagAtRuntime;
}

class MathLiveMainWorkspaceMountPlan {
  const MathLiveMainWorkspaceMountPlan({
    required this.phase,
    required this.requestedEngine,
    required this.selectedEngine,
    required this.internalFlagName,
    required this.explicitInternalFlagEnabled,
    required this.packageSideMountFlagReady,
    required this.mayMountBehindInternalFlagAtRuntime,
    required this.runtimeMountAllowed,
    required this.mathLiveEnabledByDefault,
    required this.defaultEditorSwitchAllowed,
    required this.legacyRollbackAvailable,
    required this.appShellMutationAllowed,
    required this.keyboardMutationAllowed,
    required this.graphHistorySolutionUiMutationAllowed,
    required this.legacyCursorDeletionAllowed,
    required this.cursorPassClaimAllowed,
    required this.blockers,
  });

  final String phase;
  final String requestedEngine;
  final String selectedEngine;
  final String internalFlagName;
  final bool explicitInternalFlagEnabled;
  final bool packageSideMountFlagReady;
  final bool mayMountBehindInternalFlagAtRuntime;
  final bool runtimeMountAllowed;
  final bool mathLiveEnabledByDefault;
  final bool defaultEditorSwitchAllowed;
  final bool legacyRollbackAvailable;
  final bool appShellMutationAllowed;
  final bool keyboardMutationAllowed;
  final bool graphHistorySolutionUiMutationAllowed;
  final bool legacyCursorDeletionAllowed;
  final bool cursorPassClaimAllowed;
  final List<String> blockers;
}
