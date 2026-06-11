import '../editor_adapter/math_editor_adapter.dart';
import '../editor_adapter/math_editor_engine_switch_policy.dart';
import 'mathlive_cursor_court_policy.dart';

/// V172-Q89 — MathLive Main Editor Integration Guard.
///
/// This is not the main-editor switch itself. It is the final guard around a
/// future MathLive main-editor surface: the package may prepare integration
/// contracts, but it must not mount MathLive as the active editor until Q87
/// evidence, Q88 engine selection, offline runtime bundling,
/// Graph/History/Solution adapter readiness, rollback availability, and
/// protected UI surface integrity are all proven together.
class MathLiveMainEditorIntegrationPolicy {
  const MathLiveMainEditorIntegrationPolicy._();

  static const String phase = 'V172-Q89';
  static const String integrationName = 'MathLiveMainEditorIntegrationGuard';

  static const bool integrationGuardImplemented = true;
  static const bool passiveIntegrationShellAllowed = true;
  static const bool mainEditorIntegratedNow = false;
  static const bool mathLiveMountedInMainWorkspaceByDefault = false;
  static const bool legacyEditorRemainsDefault = true;
  static const bool legacyRollbackRequired = true;
  static const bool q87CursorCourtRequired = true;
  static const bool q88EngineSwitchRequired = true;
  static const bool officialRuntimeRequired = true;
  static const bool graphHistorySolutionAdaptersRequired = true;
  static const bool mathLiveVirtualKeyboardMustRemainDisabled = true;
  static const bool remoteScriptsMustRemainDisabled = true;
  static const bool protectedUiSurfaceMutationAllowed = false;
  static const bool keyboardSurfaceMutationAllowed = false;
  static const bool appShellMutationAllowed = false;
  static const bool graphHistorySolutionMutationAllowed = false;
  static const bool fakeMathLivePassClaimAllowed = false;
  static const bool photomathLevelClaimAllowedWithoutEvidence = false;

  static MathLiveMainEditorIntegrationVerdict evaluate({
    required MathEditorEngineSelection engineSelection,
    required MathLiveCursorCourtVerdict courtVerdict,
    required bool officialRuntimeBundled,
    required bool graphHistorySolutionAdaptersReady,
    required bool rollbackAvailable,
    required bool protectedSurfacesUnchanged,
    required bool virtualKeyboardDisabled,
    required bool remoteScriptsDisabled,
    required bool userExplicitlyEnabledFlag,
  }) {
    final issues = <String>[];
    if (!userExplicitlyEnabledFlag) issues.add('MathLive main-editor flag is not explicitly enabled');
    if (!engineSelection.selectedMathLive || !engineSelection.switchAllowed) {
      issues.add('Q88 engine switch has not selected MathLive');
    }
    if (!courtVerdict.mayClaimMathLiveCursorPass) issues.add('Q87 cursor court has not passed');
    if (!officialRuntimeBundled) issues.add('official MathLive runtime is not bundled');
    if (!graphHistorySolutionAdaptersReady) issues.add('Graph/History/Solution adapters are not ready');
    if (!rollbackAvailable) issues.add('legacy rollback is not available');
    if (!protectedSurfacesUnchanged) issues.add('protected UI surfaces changed');
    if (!virtualKeyboardDisabled) issues.add('MathLive virtual keyboard is not disabled');
    if (!remoteScriptsDisabled) issues.add('remote scripts are not disabled');

    final allowed = issues.isEmpty;
    return MathLiveMainEditorIntegrationVerdict(
      status: allowed ? 'READY_BEHIND_FLAG' : 'BLOCKED_LEGACY_DEFAULT',
      selectedEngine: allowed ? MathEditorEngineKind.mathLive : MathEditorEngineKind.legacyFlutterSlotEditor,
      mainEditorMayMountMathLive: allowed,
      legacyRollbackAvailable: rollbackAvailable || legacyEditorRemainsDefault,
      issues: issues,
      diagnostic: allowed
          ? 'q89-mathlive-main-editor-integration-ready-behind-flag'
          : 'q89-mathlive-main-editor-integration-blocked-legacy-default',
    );
  }

  static bool mayPreparePassiveShell({
    required bool localAssetsDeclared,
    required bool protectedSurfacesUnchanged,
    required bool remoteScriptsDisabled,
  }) {
    return passiveIntegrationShellAllowed &&
        localAssetsDeclared &&
        protectedSurfacesUnchanged &&
        remoteScriptsDisabled &&
        !mainEditorIntegratedNow &&
        !mathLiveMountedInMainWorkspaceByDefault;
  }
}

class MathLiveMainEditorIntegrationVerdict {
  const MathLiveMainEditorIntegrationVerdict({
    required this.status,
    required this.selectedEngine,
    required this.mainEditorMayMountMathLive,
    required this.legacyRollbackAvailable,
    required this.issues,
    required this.diagnostic,
  });

  final String status;
  final MathEditorEngineKind selectedEngine;
  final bool mainEditorMayMountMathLive;
  final bool legacyRollbackAvailable;
  final List<String> issues;
  final String diagnostic;

  bool get isBlocked => !mainEditorMayMountMathLive;
  bool get selectedLegacy => selectedEngine == MathEditorEngineKind.legacyFlutterSlotEditor;
}
