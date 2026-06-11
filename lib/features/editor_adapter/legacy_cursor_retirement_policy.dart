import 'math_editor_adapter.dart';
import '../mathlive/mathlive_main_editor_integration_policy.dart';

/// V172-Q90 — Legacy Cursor Retirement Phase 1 Guard.
///
/// This is deliberately not a physical deletion phase. The failed custom
/// Flutter cursor stack remains available as LegacyFlutterSlotEditor fallback
/// until a proven MathLive main-editor path exists. Phase 1 only defines the
/// safe retirement gate: legacy overlay/hit-test code may be bypassed on a
/// MathLive-selected editor path, but legacy files, rollback, protected UI
/// surfaces, Graph, History, Solution, and the frozen keyboard remain intact.
class LegacyCursorRetirementPolicy {
  const LegacyCursorRetirementPolicy._();

  static const String phase = 'V172-Q90';
  static const String retirementName = 'LegacyCursorRetirementPhase1Guard';

  static const bool phase1GuardImplemented = true;
  static const bool physicalLegacyDeletionAllowed = false;
  static const bool legacyCursorFilesMayBeDeleted = false;
  static const bool legacyEngineRemainsRollback = true;
  static const bool legacyEngineRemainsDefaultUntilMathLiveReady = true;
  static const bool broadCustomCursorPatchingAllowed = false;
  static const bool legacyOverlayBypassAllowedOnlyForProvenMathLiveEngine = true;
  static const bool legacyHitTestBypassAllowedOnlyForProvenMathLiveEngine = true;
  static const bool mathLiveMainEditorMustAlreadyBeGateReady = true;
  static const bool graphHistorySolutionAdaptersMustRemainConnected = true;
  static const bool protectedUiSurfaceMutationAllowed = false;
  static const bool keyboardSurfaceMutationAllowed = false;
  static const bool appShellMutationAllowed = false;
  static const bool solutionGraphHistoryMutationAllowed = false;
  static const bool fakeRetirementPassClaimAllowed = false;
  static const bool photomathLevelClaimAllowedWithoutEvidence = false;

  static LegacyCursorRetirementVerdict evaluate({
    required MathLiveMainEditorIntegrationVerdict mainEditorVerdict,
    required MathEditorEngineKind activeEngine,
    required bool q89GateReady,
    required bool rollbackAvailable,
    required bool protectedSurfacesUnchanged,
    required bool graphHistorySolutionAdaptersReady,
    required bool mathLiveRuntimeOfficialAndOffline,
    required bool virtualKeyboardDisabled,
    required bool remoteScriptsDisabled,
    required bool userExplicitlyEnabledMathLiveFlag,
  }) {
    final issues = <String>[];
    if (!q89GateReady || !mainEditorVerdict.mainEditorMayMountMathLive) {
      issues.add('Q89 main-editor MathLive mount gate is not ready');
    }
    if (activeEngine != MathEditorEngineKind.mathLive) {
      issues.add('active editor engine is not MathLive');
    }
    if (!rollbackAvailable || !mainEditorVerdict.legacyRollbackAvailable) {
      issues.add('legacy rollback is not available');
    }
    if (!protectedSurfacesUnchanged) issues.add('protected UI surfaces changed');
    if (!graphHistorySolutionAdaptersReady) issues.add('Graph/History/Solution adapters are not ready');
    if (!mathLiveRuntimeOfficialAndOffline) issues.add('official offline MathLive runtime is not proven');
    if (!virtualKeyboardDisabled) issues.add('MathLive virtual keyboard is not disabled');
    if (!remoteScriptsDisabled) issues.add('remote scripts are not disabled');
    if (!userExplicitlyEnabledMathLiveFlag) issues.add('MathLive editor flag is not explicitly enabled');

    final mayBypass = issues.isEmpty;
    return LegacyCursorRetirementVerdict(
      status: mayBypass ? 'PHASE1_BYPASS_READY_BEHIND_FLAG' : 'BLOCKED_KEEP_LEGACY_ACTIVE',
      legacyDeletionAllowed: false,
      legacyRollbackRequired: true,
      legacyOverlayMayBeBypassedForActiveMathLivePath: mayBypass,
      legacyHitTestMayBeBypassedForActiveMathLivePath: mayBypass,
      selectedEngine: mayBypass ? MathEditorEngineKind.mathLive : MathEditorEngineKind.legacyFlutterSlotEditor,
      diagnostic: mayBypass
          ? 'q90-legacy-cursor-retirement-phase1-bypass-ready-behind-flag'
          : 'q90-legacy-cursor-retirement-blocked-keep-legacy-active',
      issues: issues,
    );
  }

  static bool mayDeleteLegacyCursorFiles({
    required bool phase1BypassProven,
    required bool laterRetirementPhaseApproved,
    required bool rollbackNoLongerRequiredByContract,
  }) {
    return physicalLegacyDeletionAllowed &&
        phase1BypassProven &&
        laterRetirementPhaseApproved &&
        rollbackNoLongerRequiredByContract;
  }

  static bool shouldUseLegacyAsDefault({required bool mathLiveGateReady}) {
    return legacyEngineRemainsDefaultUntilMathLiveReady && !mathLiveGateReady;
  }
}

class LegacyCursorRetirementVerdict {
  const LegacyCursorRetirementVerdict({
    required this.status,
    required this.legacyDeletionAllowed,
    required this.legacyRollbackRequired,
    required this.legacyOverlayMayBeBypassedForActiveMathLivePath,
    required this.legacyHitTestMayBeBypassedForActiveMathLivePath,
    required this.selectedEngine,
    required this.diagnostic,
    required this.issues,
  });

  final String status;
  final bool legacyDeletionAllowed;
  final bool legacyRollbackRequired;
  final bool legacyOverlayMayBeBypassedForActiveMathLivePath;
  final bool legacyHitTestMayBeBypassedForActiveMathLivePath;
  final MathEditorEngineKind selectedEngine;
  final String diagnostic;
  final List<String> issues;

  bool get isBlocked => status == 'BLOCKED_KEEP_LEGACY_ACTIVE';
  bool get selectedLegacy => selectedEngine == MathEditorEngineKind.legacyFlutterSlotEditor;
}
