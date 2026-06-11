import 'mathlive_keyboard_bridge_policy.dart';
import 'mathlive_main_workspace_mount_flag_policy.dart';

/// V172-Q107 — MathPro Keyboard → MathLive Main Bridge Hardening.
///
/// Q107 is a bridge-readiness contract for a future main-workspace MathLive
/// surface. It reuses the frozen Q85 MathPro Keyboard → MathLive command mapper
/// as the source of truth, but keeps the bridge candidate package-side only until
/// Q106 mount readiness, Q101 smoke evidence, official runtime verification, and
/// an explicit internal flag are all real. This file does not mutate keyboard,
/// MORE, long-press, AppShell, Graph, History, Solution, or legacy cursor files.
class MathLiveMainKeyboardBridgePolicy {
  const MathLiveMainKeyboardBridgePolicy._();

  static const String phase = 'V172-Q107';
  static const String verifierScript = 'tool/verify_mathlive_main_keyboard_bridge.mjs';
  static const String reportJson = 'tool/reports/mathlive_main_keyboard_bridge_report.json';
  static const String reportMarkdown = 'tool/reports/mathlive_main_keyboard_bridge_report.md';
  static const String bridgeName = 'MathProKeyboardToMathLiveMainBridgeCandidate';
  static const String sourceBridgePhase = MathLiveKeyboardBridgePolicy.phase;
  static const String mountFlagPhase = MathLiveMainWorkspaceMountFlagPolicy.phase;
  static const String internalFlagName = MathLiveMainWorkspaceMountFlagPolicy.internalFlagName;

  static const bool q85LabBridgeIsSourceOfTruth = true;
  static const bool q106MountFlagRequired = true;
  static const bool q101LabSmokeEvidenceClosureRequired = true;
  static const bool officialRuntimeVerificationRequired = true;
  static const bool explicitInternalFlagRequired = true;
  static const bool mainWorkspaceBridgeImplementedInThisPackage = false;
  static const bool mainBridgeRuntimeBindingAllowedWithoutEvidence = false;
  static const bool mathLiveEnabledByDefault = false;
  static const bool defaultEditorSwitchAllowed = false;
  static const bool keyboardMutationAllowed = false;
  static const bool moreMutationAllowed = false;
  static const bool longPressMutationAllowed = false;
  static const bool appShellMutationAllowed = false;
  static const bool graphHistorySolutionUiMutationAllowed = false;
  static const bool protectedUiSurfaceMutationAllowed = false;
  static const bool legacyCursorDeletionAllowed = false;
  static const bool cursorPassClaimAllowed = false;
  static const bool fakeRuntimeEvidenceAllowed = false;
  static const bool fakeSmokeEvidenceAllowed = false;
  static const bool mathLiveVirtualKeyboardEnabled = false;
  static const bool remoteScriptLoadingAllowed = false;

  /// Minimal frozen-key sample matrix that must remain consistent with Q85.
  /// This is intentionally a subset: it checks critical behaviors without
  /// editing or reordering the protected keyboard source-of-truth.
  static const Map<String, String> requiredFrozenMappingSubset = <String, String>{
    '7': '7',
    '+': '+',
    '−': '-',
    '×': r'\times ',
    '÷': r'\div ',
    '%': r'\%',
    '=': '=',
    '□/□': r'\frac{}{}',
    '√□': r'\sqrt{}',
    '□^□': '^{}',
    'sin': r'\sin\left(\right)',
    'log': r'\log_{}\left(\right)',
    '∫□dx': r'\int {}\,d{}',
  };

  static List<String> validateFrozenMappingSubset({String lastAnswer = '42'}) {
    final failures = <String>[];
    for (final entry in requiredFrozenMappingSubset.entries) {
      final command = MathLiveKeyboardBridgePolicy.commandForLabel(entry.key, lastAnswer: lastAnswer);
      if (command.action != 'insertLatex') {
        failures.add('${entry.key}: expected insertLatex, got ${command.action}');
      } else if (command.latex != entry.value) {
        failures.add('${entry.key}: expected ${entry.value}, got ${command.latex}');
      }
    }
    final backspace = MathLiveKeyboardBridgePolicy.commandForLabel('⌫', lastAnswer: lastAnswer);
    if (backspace.action != 'deleteBackward') failures.add('⌫: expected deleteBackward, got ${backspace.action}');
    final clear = MathLiveKeyboardBridgePolicy.commandForLabel('C', lastAnswer: lastAnswer);
    if (clear.action != 'clear') failures.add('C: expected clear, got ${clear.action}');
    final evaluate = MathLiveKeyboardBridgePolicy.commandForLabel('↵', lastAnswer: lastAnswer);
    if (evaluate.action != 'evaluate') failures.add('↵: expected evaluate, got ${evaluate.action}');
    final more = MathLiveKeyboardBridgePolicy.commandForLabel('MORE', lastAnswer: lastAnswer);
    if (more.action != 'noOp' || more.accepted) failures.add('MORE: expected protected noOp, got ${more.action}/${more.accepted}');
    final ans = MathLiveKeyboardBridgePolicy.commandForLabel('Ans', lastAnswer: lastAnswer);
    if (ans.action != 'insertLatex' || ans.latex != lastAnswer) failures.add('Ans: expected last-answer insertLatex');
    return failures;
  }

  static MathLiveMainKeyboardBridgeReadiness evaluateReadiness({
    required bool q85BridgePresent,
    required bool q106MountFlagPackageReady,
    required bool q101LabSmokeEvidenceClosed,
    required bool officialRuntimeVerified,
    required bool explicitInternalFlagEnabled,
    required bool protectedSurfacesUnchanged,
    required bool keyboardUntouched,
    required bool appShellUntouched,
    required bool graphHistorySolutionUiUntouched,
    required bool legacyRollbackAvailable,
    required bool virtualKeyboardDisabled,
    required bool remoteScriptsDisabled,
    required bool noFakeEvidence,
    required bool frozenMappingSubsetPasses,
  }) {
    final blockers = <String>[];
    if (!q85BridgePresent) blockers.add('Q85 frozen MathPro keyboard bridge source-of-truth is missing');
    if (!q106MountFlagPackageReady) blockers.add('Q106 main-workspace mount flag package readiness is missing');
    if (!q101LabSmokeEvidenceClosed) blockers.add('Q101 Lab smoke evidence closure has not passed; Q107 runtime main bridge must remain blocked');
    if (!officialRuntimeVerified) blockers.add('official local MathLive runtime is not verified');
    if (!explicitInternalFlagEnabled) blockers.add('explicit internal MathLive editor flag is not enabled');
    if (!protectedSurfacesUnchanged) blockers.add('protected UI surfaces changed');
    if (!keyboardUntouched) blockers.add('keyboard/MORE/long-press source changed during Q107');
    if (!appShellUntouched) blockers.add('app_shell.dart changed during Q107');
    if (!graphHistorySolutionUiUntouched) blockers.add('Graph/History/Solution UI changed during Q107');
    if (!legacyRollbackAvailable) blockers.add('legacy rollback is not available');
    if (!virtualKeyboardDisabled) blockers.add('MathLive virtual keyboard is not disabled');
    if (!remoteScriptsDisabled) blockers.add('remote/CDN scripts are not disabled');
    if (!noFakeEvidence) blockers.add('runtime or smoke evidence was faked');
    if (!frozenMappingSubsetPasses) blockers.add('frozen Q85 keyboard mapping subset drifted');

    final packageReady = q85BridgePresent &&
        q106MountFlagPackageReady &&
        protectedSurfacesUnchanged &&
        keyboardUntouched &&
        appShellUntouched &&
        graphHistorySolutionUiUntouched &&
        legacyRollbackAvailable &&
        virtualKeyboardDisabled &&
        remoteScriptsDisabled &&
        noFakeEvidence &&
        frozenMappingSubsetPasses;
    final mayBindMainKeyboardBridgeAtRuntime = packageReady &&
        q101LabSmokeEvidenceClosed &&
        officialRuntimeVerified &&
        explicitInternalFlagEnabled;

    return MathLiveMainKeyboardBridgeReadiness(
      status: mayBindMainKeyboardBridgeAtRuntime
          ? 'MATHLIVE_MAIN_KEYBOARD_BRIDGE_READY_BEHIND_INTERNAL_FLAG'
          : packageReady
              ? 'MATHLIVE_MAIN_KEYBOARD_BRIDGE_PACKAGE_READY_BUT_RUNTIME_EVIDENCE_BLOCKED'
              : 'BLOCKED_MATHLIVE_MAIN_KEYBOARD_BRIDGE',
      blockers: blockers,
      packageSideMainKeyboardBridgeReady: packageReady,
      mayBindMainKeyboardBridgeAtRuntime: mayBindMainKeyboardBridgeAtRuntime,
      selectedDefaultEngine: 'legacyFlutterSlotEditor',
      rollbackEngine: 'legacyFlutterSlotEditor',
      mathLiveEnabledByDefault: false,
      maySwitchDefaultEditor: false,
      mayDeleteLegacyCursor: false,
      mayClaimCursorPass: false,
      mayMutateKeyboard: false,
      mayMutateAppShell: false,
      mayMutateGraphHistorySolutionUi: false,
    );
  }

  static MathLiveMainKeyboardBridgeCommandEnvelope buildCommandEnvelope({
    required String label,
    String lastAnswer = '',
    bool runtimeBindingAllowed = false,
  }) {
    final command = MathLiveKeyboardBridgePolicy.commandForLabel(label, lastAnswer: lastAnswer);
    return MathLiveMainKeyboardBridgeCommandEnvelope(
      phase: phase,
      sourceBridgePhase: sourceBridgePhase,
      label: label,
      action: command.action,
      acceptedByFrozenMapper: command.accepted,
      latex: command.latex,
      reason: command.reason,
      runtimeBindingAllowed: runtimeBindingAllowed,
      mainWorkspaceBridgeImplementedInThisPackage: mainWorkspaceBridgeImplementedInThisPackage,
      mathLiveVirtualKeyboardEnabled: mathLiveVirtualKeyboardEnabled,
      keyboardMutationAllowed: keyboardMutationAllowed,
      defaultEditorSwitchAllowed: defaultEditorSwitchAllowed,
      legacyCursorDeletionAllowed: legacyCursorDeletionAllowed,
    );
  }
}

class MathLiveMainKeyboardBridgeReadiness {
  const MathLiveMainKeyboardBridgeReadiness({
    required this.status,
    required this.blockers,
    required this.packageSideMainKeyboardBridgeReady,
    required this.mayBindMainKeyboardBridgeAtRuntime,
    required this.selectedDefaultEngine,
    required this.rollbackEngine,
    required this.mathLiveEnabledByDefault,
    required this.maySwitchDefaultEditor,
    required this.mayDeleteLegacyCursor,
    required this.mayClaimCursorPass,
    required this.mayMutateKeyboard,
    required this.mayMutateAppShell,
    required this.mayMutateGraphHistorySolutionUi,
  });

  final String status;
  final List<String> blockers;
  final bool packageSideMainKeyboardBridgeReady;
  final bool mayBindMainKeyboardBridgeAtRuntime;
  final String selectedDefaultEngine;
  final String rollbackEngine;
  final bool mathLiveEnabledByDefault;
  final bool maySwitchDefaultEditor;
  final bool mayDeleteLegacyCursor;
  final bool mayClaimCursorPass;
  final bool mayMutateKeyboard;
  final bool mayMutateAppShell;
  final bool mayMutateGraphHistorySolutionUi;
}

class MathLiveMainKeyboardBridgeCommandEnvelope {
  const MathLiveMainKeyboardBridgeCommandEnvelope({
    required this.phase,
    required this.sourceBridgePhase,
    required this.label,
    required this.action,
    required this.acceptedByFrozenMapper,
    required this.latex,
    required this.reason,
    required this.runtimeBindingAllowed,
    required this.mainWorkspaceBridgeImplementedInThisPackage,
    required this.mathLiveVirtualKeyboardEnabled,
    required this.keyboardMutationAllowed,
    required this.defaultEditorSwitchAllowed,
    required this.legacyCursorDeletionAllowed,
  });

  final String phase;
  final String sourceBridgePhase;
  final String label;
  final String action;
  final bool acceptedByFrozenMapper;
  final String latex;
  final String reason;
  final bool runtimeBindingAllowed;
  final bool mainWorkspaceBridgeImplementedInThisPackage;
  final bool mathLiveVirtualKeyboardEnabled;
  final bool keyboardMutationAllowed;
  final bool defaultEditorSwitchAllowed;
  final bool legacyCursorDeletionAllowed;

  Map<String, Object?> toJson() => <String, Object?>{
        'phase': phase,
        'sourceBridgePhase': sourceBridgePhase,
        'label': label,
        'action': action,
        'acceptedByFrozenMapper': acceptedByFrozenMapper,
        'latex': latex,
        'reason': reason,
        'runtimeBindingAllowed': runtimeBindingAllowed,
        'mainWorkspaceBridgeImplementedInThisPackage': mainWorkspaceBridgeImplementedInThisPackage,
        'mathLiveVirtualKeyboardEnabled': mathLiveVirtualKeyboardEnabled,
        'keyboardMutationAllowed': keyboardMutationAllowed,
        'defaultEditorSwitchAllowed': defaultEditorSwitchAllowed,
        'legacyCursorDeletionAllowed': legacyCursorDeletionAllowed,
      };
}
