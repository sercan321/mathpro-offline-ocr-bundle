import 'legacy_cursor_main_path_retirement_policy.dart';

/// V172-Q96 — Legacy Cursor Physical Cleanup.
///
/// Q96 can delete files only after Q95 has genuinely retired the legacy main
/// path and a separate cleanup approval says rollback is no longer required.
/// In this package delivery it remains a guarded cleanup manifest; no legacy
/// cursor file is physically removed.
class LegacyCursorPhysicalCleanupPolicy {
  const LegacyCursorPhysicalCleanupPolicy._();

  static const String phase = 'V172-Q96';
  static const bool cleanupManifestImplemented = true;
  static const bool physicalCleanupPerformedInThisPackage = false;
  static const bool rollbackMustBePreservedUntilExplicitCleanupApproval = true;
  static const bool protectedUiSurfaceMutationAllowed = false;
  static const bool keyboardMutationAllowed = false;
  static const bool graphHistorySolutionUiMutationAllowed = false;

  static const List<String> cleanupCandidateFamilies = <String>[
    'legacy cursor overlay painter remnants',
    'old nearest fallback hit-test policies',
    'stale SlotBox-only court metadata',
    'unused geometry bundle bridge files',
    'legacy MathJax overlay cursor path remnants',
  ];

  static LegacyCursorPhysicalCleanupVerdict evaluate({
    required LegacyCursorMainPathRetirementVerdict q95Verdict,
    required bool cleanupApprovedExplicitly,
    required bool rollbackNoLongerRequiredByContract,
    required bool postRetirementSoakPassed,
    required bool protectedSurfacesUnchanged,
    required bool deletionManifestReviewed,
  }) {
    final issues = <String>[];
    if (!q95Verdict.legacyMainPathMayBeRetired) issues.add('Q95 legacy main-path retirement has not passed');
    if (!cleanupApprovedExplicitly) issues.add('explicit Q96 cleanup approval is missing');
    if (!rollbackNoLongerRequiredByContract) issues.add('rollback is still required by contract');
    if (!postRetirementSoakPassed) issues.add('post-retirement soak/regression period has not passed');
    if (!protectedSurfacesUnchanged) issues.add('protected UI surfaces changed');
    if (!deletionManifestReviewed) issues.add('deletion manifest has not been reviewed');

    final mayCleanup = issues.isEmpty;
    return LegacyCursorPhysicalCleanupVerdict(
      status: mayCleanup ? 'LEGACY_CURSOR_PHYSICAL_CLEANUP_ALLOWED' : 'BLOCKED_LEGACY_CURSOR_PHYSICAL_CLEANUP',
      issues: issues,
      physicalCleanupAllowed: mayCleanup,
      protectedFilesMayBeDeleted: false,
      graphHistorySolutionFilesMayBeDeleted: false,
    );
  }
}

class LegacyCursorPhysicalCleanupVerdict {
  const LegacyCursorPhysicalCleanupVerdict({
    required this.status,
    required this.issues,
    required this.physicalCleanupAllowed,
    required this.protectedFilesMayBeDeleted,
    required this.graphHistorySolutionFilesMayBeDeleted,
  });

  final String status;
  final List<String> issues;
  final bool physicalCleanupAllowed;
  final bool protectedFilesMayBeDeleted;
  final bool graphHistorySolutionFilesMayBeDeleted;

  bool get isBlocked => !physicalCleanupAllowed;
}
