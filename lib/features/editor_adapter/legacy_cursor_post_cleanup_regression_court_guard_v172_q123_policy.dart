import 'legacy_cursor_physical_cleanup_execution_guard_v172_q122_policy.dart';

/// V172-Q123 — Post-Cleanup Regression Court Guard.
///
/// Guard-only phase. It does not run a post-cleanup regression court, does not
/// execute cleanup, does not delete legacy cursor files, does not retire the
/// legacy main path, and does not switch MathLive into the main/default editor.
class LegacyCursorPostCleanupRegressionCourtGuardV172Q123Policy {
  const LegacyCursorPostCleanupRegressionCourtGuardV172Q123Policy._();

  static const String phase = 'V172-Q123';
  static const String prerequisiteCleanupExecutionPhase = LegacyCursorPhysicalCleanupExecutionGuardV172Q122Policy.phase;
  static const String verifierScript = 'tool/verify_legacy_cursor_post_cleanup_regression_court_guard_v172_q123.mjs';
  static const String reportJson = 'tool/reports/legacy_cursor_post_cleanup_regression_court_guard_v172_q123_report.json';
  static const String selectedDefaultEngine = 'legacyFlutterSlotEditor';
  static const String candidateEngine = 'mathlive';
  static const String rollbackEngine = 'legacyFlutterSlotEditor';

  static const bool postCleanupRegressionCourtGuardOnly = true;
  static const bool postCleanupRegressionCourtExecutedInThisPackage = false;
  static const bool physicalCleanupExecutedInThisPackage = false;
  static const bool legacyCursorPhysicalDeletionImplementedInThisPackage = false;
  static const bool legacyMainPathRetirementImplementedInThisPackage = false;
  static const bool mathLiveDefaultSwitchImplementedInThisPackage = false;
  static const bool mainWorkspaceMountImplementedInThisPackage = false;
  static const bool runtimeGraphHistorySolutionWritesImplementedInThisPackage = false;
  static const bool cleanupDeltaManifestGeneratedInThisPackage = false;
  static const bool legacyFlutterSlotEditorRemainsDefault = true;
  static const bool legacyRollbackRequired = true;
  static const bool q122ExecutionEvidenceRequired = true;
  static const bool approvedCleanupExecutionRequired = true;
  static const bool cleanupDeltaManifestRequired = true;
  static const bool flutterPubGetRequired = true;
  static const bool flutterAnalyzeRequired = true;
  static const bool flutterTestRequired = true;
  static const bool labDeviceRunRequired = true;
  static const bool mainDeviceRunRequired = true;
  static const bool q108RealDeviceCursorCourtRequired = true;
  static const bool graphRuntimeEvidenceRequired = true;
  static const bool historyRuntimeEvidenceRequired = true;
  static const bool solutionRuntimeEvidenceRequired = true;
  static const bool rollbackVerificationRequired = true;
  static const bool noLegacyCursorOverlayOnMathLivePathRequired = true;
  static const bool packageHygieneRequired = true;
  static const bool explicitPostCleanupRegressionApprovalRequired = true;

  static const bool keyboardMutationAllowed = false;
  static const bool moreMutationAllowed = false;
  static const bool longPressMutationAllowed = false;
  static const bool appShellMutationAllowed = false;
  static const bool graphHistorySolutionUiMutationAllowed = false;
  static const bool protectedUiSurfaceMutationAllowed = false;
  static const bool fakeRuntimeEvidenceAllowed = false;
  static const bool fakeDeviceEvidenceAllowed = false;
  static const bool fakeCleanupEvidenceAllowed = false;
  static const bool cursorPassClaimAllowedInThisPackage = false;
  static const bool releasePassClaimAllowedInThisPackage = false;

  static LegacyCursorPostCleanupRegressionCourtGuardV172Q123Readiness evaluateReadiness({
    required bool q122ExecutionGuardPackageReady,
    required bool q122ExecutionEvidenceComplete,
    required bool q122HumanReviewApproved,
    required bool approvedCleanupActuallyExecuted,
    required bool cleanupDeltaManifestPresent,
    required bool flutterPubGetPassed,
    required bool flutterAnalyzePassed,
    required bool flutterTestPassed,
    required bool labDeviceRunCaptured,
    required bool mainDeviceRunCaptured,
    required bool q108RealDeviceCursorCourtPassed,
    required bool graphRuntimeEvidencePassed,
    required bool historyRuntimeEvidencePassed,
    required bool solutionRuntimeEvidencePassed,
    required bool noLegacyCursorOverlayOnMathLivePath,
    required bool rollbackVerificationPassed,
    required bool protectedSurfacesUnchanged,
    required bool keyboardUntouched,
    required bool moreUntouched,
    required bool longPressUntouched,
    required bool appShellUntouched,
    required bool graphHistorySolutionUiUntouched,
    required bool packageHygieneClean,
    required bool noDefaultEditorSwitchInThisPackage,
    required bool noMainWorkspaceMountInThisPackage,
    required bool noLegacyRetirementInThisPackage,
    required bool noPhysicalLegacyDeletionInThisPackage,
    required bool noRuntimeBehaviorChangeInThisPackage,
    required bool noFakeRuntimeEvidence,
    required bool noFakeDeviceEvidence,
    required bool noFakeCleanupEvidence,
    required bool explicitPostCleanupRegressionCourtApproval,
  }) {
    final blockers = <String>[];
    if (!q122ExecutionGuardPackageReady) blockers.add('Q122 cleanup execution guard package is not ready');
    if (!q122ExecutionEvidenceComplete) blockers.add('Q122 cleanup execution evidence is incomplete');
    if (!q122HumanReviewApproved) blockers.add('Q122 human review approval is missing');
    if (!approvedCleanupActuallyExecuted) blockers.add('approved cleanup execution has not actually run');
    if (!cleanupDeltaManifestPresent) blockers.add('cleanup delta manifest is missing');
    if (!flutterPubGetPassed) blockers.add('flutter pub get PASS evidence is missing');
    if (!flutterAnalyzePassed) blockers.add('flutter analyze PASS evidence is missing');
    if (!flutterTestPassed) blockers.add('flutter test PASS evidence is missing');
    if (!labDeviceRunCaptured) blockers.add('MathLive Lab real-device run evidence is missing');
    if (!mainDeviceRunCaptured) blockers.add('main app real-device run evidence is missing');
    if (!q108RealDeviceCursorCourtPassed) blockers.add('Q108/Q116 real-device cursor court PASS evidence is missing');
    if (!graphRuntimeEvidencePassed) blockers.add('Graph runtime evidence is missing');
    if (!historyRuntimeEvidencePassed) blockers.add('History runtime evidence is missing');
    if (!solutionRuntimeEvidencePassed) blockers.add('Solution runtime evidence is missing');
    if (!noLegacyCursorOverlayOnMathLivePath) blockers.add('legacy cursor overlay absence on MathLive path is not verified');
    if (!rollbackVerificationPassed) blockers.add('rollback verification is missing');
    if (!protectedSurfacesUnchanged) blockers.add('protected surfaces changed');
    if (!keyboardUntouched) blockers.add('keyboard protected files changed');
    if (!moreUntouched) blockers.add('MORE contract changed');
    if (!longPressUntouched) blockers.add('long-press contract changed');
    if (!appShellUntouched) blockers.add('AppShell changed');
    if (!graphHistorySolutionUiUntouched) blockers.add('Graph/History/Solution UI changed');
    if (!packageHygieneClean) blockers.add('package hygiene is not clean');
    if (!noDefaultEditorSwitchInThisPackage) blockers.add('default editor switch occurred in this package');
    if (!noMainWorkspaceMountInThisPackage) blockers.add('main workspace MathLive mount occurred in this package');
    if (!noLegacyRetirementInThisPackage) blockers.add('legacy main-path retirement occurred in this package');
    if (!noPhysicalLegacyDeletionInThisPackage) blockers.add('legacy cursor files were physically deleted in this package');
    if (!noRuntimeBehaviorChangeInThisPackage) blockers.add('runtime behavior changed in this guard-only package');
    if (!noFakeRuntimeEvidence) blockers.add('runtime evidence was faked');
    if (!noFakeDeviceEvidence) blockers.add('device evidence was faked');
    if (!noFakeCleanupEvidence) blockers.add('cleanup/regression evidence was faked');
    if (!explicitPostCleanupRegressionCourtApproval) blockers.add('explicit Q123 post-cleanup regression court approval is missing');

    final packageSidePostCleanupRegressionGuardReady =
        q122ExecutionGuardPackageReady &&
        protectedSurfacesUnchanged &&
        keyboardUntouched &&
        moreUntouched &&
        longPressUntouched &&
        appShellUntouched &&
        graphHistorySolutionUiUntouched &&
        packageHygieneClean &&
        noDefaultEditorSwitchInThisPackage &&
        noMainWorkspaceMountInThisPackage &&
        noLegacyRetirementInThisPackage &&
        noPhysicalLegacyDeletionInThisPackage &&
        noRuntimeBehaviorChangeInThisPackage &&
        noFakeRuntimeEvidence &&
        noFakeDeviceEvidence &&
        noFakeCleanupEvidence;

    final postCleanupRegressionEvidenceComplete = packageSidePostCleanupRegressionGuardReady &&
        q122ExecutionEvidenceComplete &&
        q122HumanReviewApproved &&
        approvedCleanupActuallyExecuted &&
        cleanupDeltaManifestPresent &&
        flutterPubGetPassed &&
        flutterAnalyzePassed &&
        flutterTestPassed &&
        labDeviceRunCaptured &&
        mainDeviceRunCaptured &&
        q108RealDeviceCursorCourtPassed &&
        graphRuntimeEvidencePassed &&
        historyRuntimeEvidencePassed &&
        solutionRuntimeEvidencePassed &&
        noLegacyCursorOverlayOnMathLivePath &&
        rollbackVerificationPassed &&
        explicitPostCleanupRegressionCourtApproval;

    return LegacyCursorPostCleanupRegressionCourtGuardV172Q123Readiness(
      status: postCleanupRegressionEvidenceComplete
          ? 'Q123_POST_CLEANUP_REGRESSION_COURT_READY_FOR_HUMAN_REVIEW'
          : packageSidePostCleanupRegressionGuardReady
              ? 'Q123_POST_CLEANUP_REGRESSION_COURT_GUARD_PACKAGE_READY_BUT_CLEANUP_EVIDENCE_BLOCKED'
              : 'BLOCKED_Q123_POST_CLEANUP_REGRESSION_COURT_GUARD',
      blockers: blockers,
      packageSidePostCleanupRegressionGuardReady: packageSidePostCleanupRegressionGuardReady,
      postCleanupRegressionEvidenceComplete: postCleanupRegressionEvidenceComplete,
      mayRunPostCleanupRegressionCourtReview: postCleanupRegressionEvidenceComplete,
      mayClaimPostCleanupPass: false,
      mayClaimCursorPass: false,
      mayClaimReleasePass: false,
      maySwitchDefaultEditorNow: false,
      mayRetireLegacyMainPathNow: false,
      mayDeleteLegacyCursorNow: false,
      protectedUiSurfaceMutationAllowed: false,
    );
  }
}

class LegacyCursorPostCleanupRegressionCourtGuardV172Q123Readiness {
  const LegacyCursorPostCleanupRegressionCourtGuardV172Q123Readiness({
    required this.status,
    required this.blockers,
    required this.packageSidePostCleanupRegressionGuardReady,
    required this.postCleanupRegressionEvidenceComplete,
    required this.mayRunPostCleanupRegressionCourtReview,
    required this.mayClaimPostCleanupPass,
    required this.mayClaimCursorPass,
    required this.mayClaimReleasePass,
    required this.maySwitchDefaultEditorNow,
    required this.mayRetireLegacyMainPathNow,
    required this.mayDeleteLegacyCursorNow,
    required this.protectedUiSurfaceMutationAllowed,
  });

  final String status;
  final List<String> blockers;
  final bool packageSidePostCleanupRegressionGuardReady;
  final bool postCleanupRegressionEvidenceComplete;
  final bool mayRunPostCleanupRegressionCourtReview;
  final bool mayClaimPostCleanupPass;
  final bool mayClaimCursorPass;
  final bool mayClaimReleasePass;
  final bool maySwitchDefaultEditorNow;
  final bool mayRetireLegacyMainPathNow;
  final bool mayDeleteLegacyCursorNow;
  final bool protectedUiSurfaceMutationAllowed;

  bool get isBlocked => !postCleanupRegressionEvidenceComplete;
}
