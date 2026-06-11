import 'mathlive_graph_history_solution_adapter_policy.dart';

/// V172-Q93 — Main Editor MathLive Activation Behind Flag.
///
/// This phase does not turn MathLive on by default and does not mount it in the
/// current main workspace in this package. It defines the strict activation
/// contract for a later user-enabled internal flag, preserving legacy rollback.
class MathLiveMainEditorFlagActivationPolicy {
  const MathLiveMainEditorFlagActivationPolicy._();

  static const String phase = 'V172-Q93';
  static const bool flagContractImplemented = true;
  static const bool mathLiveEnabledByDefault = false;
  static const bool legacyEditorRemainsDefaultWithoutFlag = true;
  static const bool legacyRollbackRequired = true;
  static const bool protectedUiSurfaceMutationAllowed = false;
  static const bool keyboardSurfaceMutationAllowed = false;
  static const bool moreLongPressMutationAllowed = false;
  static const bool graphHistorySolutionUiMutationAllowed = false;
  static const bool physicalLegacyDeletionAllowed = false;
  static const bool cursorPassClaimAllowed = false;
  static const String flagName = 'mathpro.internal.editorEngine.mathlive';

  static MathLiveMainEditorFlagActivationVerdict evaluate({
    required bool userExplicitlyEnabledFlag,
    required bool q91EvidenceClosed,
    required MathLiveGraphHistorySolutionAdapterReadiness q92Readiness,
    required bool officialRuntimeVerified,
    required bool rollbackAvailable,
    required bool protectedSurfacesUnchanged,
    required bool virtualKeyboardDisabled,
    required bool remoteScriptsDisabled,
    required bool mainWorkspaceMountRequested,
  }) {
    final issues = <String>[];
    if (!userExplicitlyEnabledFlag) issues.add('MathLive main-editor flag is not enabled by the user/internal tester');
    if (!q91EvidenceClosed) issues.add('Q91 runtime/evidence closure has not verified');
    if (!q92Readiness.adapterReadyForFlaggedMainEditor) issues.add('Q92 Graph/History/Solution adapter readiness is not verified');
    if (!officialRuntimeVerified) issues.add('official local MathLive runtime is not verified');
    if (!rollbackAvailable) issues.add('legacy rollback is not available');
    if (!protectedSurfacesUnchanged) issues.add('protected UI surfaces changed');
    if (!virtualKeyboardDisabled) issues.add('MathLive virtual keyboard is not disabled');
    if (!remoteScriptsDisabled) issues.add('remote scripts are not disabled');

    final mayActivateBehindFlag = issues.isEmpty && mainWorkspaceMountRequested;
    return MathLiveMainEditorFlagActivationVerdict(
      status: mayActivateBehindFlag ? 'MATHLIVE_MAIN_EDITOR_FLAG_READY' : 'BLOCKED_MATHLIVE_MAIN_EDITOR_FLAG',
      issues: issues,
      selectedEngine: mayActivateBehindFlag ? 'mathlive' : 'legacyFlutterSlotEditor',
      mayMountMathLiveInMainWorkspaceBehindFlag: mayActivateBehindFlag,
      mathLiveEnabledByDefault: false,
      legacyRollbackAvailable: rollbackAvailable,
      mayDeleteLegacyCursor: false,
      mayClaimCursorPass: false,
    );
  }
}

class MathLiveMainEditorFlagActivationVerdict {
  const MathLiveMainEditorFlagActivationVerdict({
    required this.status,
    required this.issues,
    required this.selectedEngine,
    required this.mayMountMathLiveInMainWorkspaceBehindFlag,
    required this.mathLiveEnabledByDefault,
    required this.legacyRollbackAvailable,
    required this.mayDeleteLegacyCursor,
    required this.mayClaimCursorPass,
  });

  final String status;
  final List<String> issues;
  final String selectedEngine;
  final bool mayMountMathLiveInMainWorkspaceBehindFlag;
  final bool mathLiveEnabledByDefault;
  final bool legacyRollbackAvailable;
  final bool mayDeleteLegacyCursor;
  final bool mayClaimCursorPass;

  bool get isBlocked => !mayMountMathLiveInMainWorkspaceBehindFlag;
}
