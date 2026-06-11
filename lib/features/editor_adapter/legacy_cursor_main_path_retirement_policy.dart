import '../mathlive/mathlive_main_editor_flag_activation_policy.dart';
import '../mathlive/mathlive_real_device_cursor_court_policy.dart';

/// V172-Q95 — Legacy Cursor Main Path Retirement.
///
/// This is not physical deletion. It only permits taking the old cursor overlay
/// and hit-test path out of the active main route after MathLive has passed the
/// real-device court and rollback remains available.
class LegacyCursorMainPathRetirementPolicy {
  const LegacyCursorMainPathRetirementPolicy._();

  static const String phase = 'V172-Q95';
  static const bool physicalDeletionAllowed = false;
  static const bool rollbackStillRequired = true;
  static const bool protectedUiSurfaceMutationAllowed = false;
  static const bool keyboardMutationAllowed = false;
  static const bool graphHistorySolutionUiMutationAllowed = false;
  static const bool fakeRetirementPassClaimAllowed = false;

  static LegacyCursorMainPathRetirementVerdict evaluate({
    required MathLiveMainEditorFlagActivationVerdict q93Verdict,
    required MathLiveRealDeviceCursorCourtVerdict q94Verdict,
    required bool graphHistorySolutionAdaptersReady,
    required bool rollbackAvailable,
    required bool protectedSurfacesUnchanged,
    required bool noPhysicalDeletionAttempted,
  }) {
    final issues = <String>[];
    if (!q93Verdict.mayMountMathLiveInMainWorkspaceBehindFlag) issues.add('Q93 behind-flag MathLive path is not available');
    if (!q94Verdict.mayRetireLegacyMainPath) issues.add('Q94 real-device cursor court has not passed');
    if (!graphHistorySolutionAdaptersReady) issues.add('Graph/History/Solution adapters are not ready');
    if (!rollbackAvailable || !q93Verdict.legacyRollbackAvailable) issues.add('legacy rollback is not available');
    if (!protectedSurfacesUnchanged) issues.add('protected UI surfaces changed');
    if (!noPhysicalDeletionAttempted) issues.add('physical legacy deletion attempted during Q95');

    final mayRetireMainPath = issues.isEmpty;
    return LegacyCursorMainPathRetirementVerdict(
      status: mayRetireMainPath ? 'LEGACY_CURSOR_MAIN_PATH_RETIREMENT_READY' : 'BLOCKED_LEGACY_CURSOR_MAIN_PATH_RETIREMENT',
      issues: issues,
      legacyMainPathMayBeRetired: mayRetireMainPath,
      legacyRollbackRequired: true,
      physicalDeletionAllowed: false,
      activeEngineAfterRetirement: mayRetireMainPath ? 'mathlive' : 'legacyFlutterSlotEditor',
    );
  }
}

class LegacyCursorMainPathRetirementVerdict {
  const LegacyCursorMainPathRetirementVerdict({
    required this.status,
    required this.issues,
    required this.legacyMainPathMayBeRetired,
    required this.legacyRollbackRequired,
    required this.physicalDeletionAllowed,
    required this.activeEngineAfterRetirement,
  });

  final String status;
  final List<String> issues;
  final bool legacyMainPathMayBeRetired;
  final bool legacyRollbackRequired;
  final bool physicalDeletionAllowed;
  final String activeEngineAfterRetirement;

  bool get isBlocked => !legacyMainPathMayBeRetired;
}
