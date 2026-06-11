import 'legacy_cursor_post_cleanup_regression_court_guard_v172_q123_policy.dart';

/// V172-Q124 — Release Freeze Final Review Guard.
///
/// Guard-only phase. It does not freeze a release, does not claim release PASS,
/// does not execute cleanup, does not delete legacy cursor files, does not retire
/// the legacy main path, and does not switch MathLive into the main/default editor.
class ReleaseFreezeFinalReviewGuardV172Q124Policy {
  const ReleaseFreezeFinalReviewGuardV172Q124Policy._();

  static const String phase = 'V172-Q124';
  static const String prerequisitePostCleanupRegressionPhase = LegacyCursorPostCleanupRegressionCourtGuardV172Q123Policy.phase;
  static const String verifierScript = 'tool/verify_release_freeze_final_review_guard_v172_q124.mjs';
  static const String reportJson = 'tool/reports/release_freeze_final_review_guard_v172_q124_report.json';
  static const String expectedPrimaryZipName = 'MathProFlutterPhase17.zip';
  static const String selectedDefaultEngine = 'legacyFlutterSlotEditor';
  static const String candidateEngine = 'mathlive';
  static const String rollbackEngine = 'legacyFlutterSlotEditor';

  static const bool releaseFreezeFinalReviewGuardOnly = true;
  static const bool finalReleaseFrozenInThisPackage = false;
  static const bool releasePassClaimedInThisPackage = false;
  static const bool postCleanupRegressionCourtExecutedInThisPackage = false;
  static const bool physicalCleanupExecutedInThisPackage = false;
  static const bool legacyCursorPhysicalDeletionImplementedInThisPackage = false;
  static const bool legacyMainPathRetirementImplementedInThisPackage = false;
  static const bool mathLiveDefaultSwitchImplementedInThisPackage = false;
  static const bool mainWorkspaceMountImplementedInThisPackage = false;
  static const bool runtimeGraphHistorySolutionWritesImplementedInThisPackage = false;
  static const bool legacyFlutterSlotEditorRemainsDefault = true;
  static const bool legacyRollbackRequired = true;
  static const bool q123PostCleanupRegressionEvidenceRequired = true;
  static const bool q123HumanReviewApprovalRequired = true;
  static const bool flutterPubGetRequired = true;
  static const bool flutterAnalyzeRequired = true;
  static const bool flutterTestRequired = true;
  static const bool mathLiveLabDeviceRunRequired = true;
  static const bool mainAppDeviceRunRequired = true;
  static const bool q108Q116CursorCourtPassRequired = true;
  static const bool graphRuntimeEvidenceRequired = true;
  static const bool historyRuntimeEvidenceRequired = true;
  static const bool solutionRuntimeEvidenceRequired = true;
  static const bool rollbackVerificationRequired = true;
  static const bool cleanFullZipRequired = true;
  static const bool freshExtractVerificationRequired = true;
  static const bool noStaleNestedArtifactsRequired = true;
  static const bool explicitQ124ReleaseFreezeApprovalRequired = true;

  static const bool keyboardMutationAllowed = false;
  static const bool moreMutationAllowed = false;
  static const bool longPressMutationAllowed = false;
  static const bool appShellMutationAllowed = false;
  static const bool graphHistorySolutionUiMutationAllowed = false;
  static const bool protectedUiSurfaceMutationAllowed = false;
  static const bool fakeRuntimeEvidenceAllowed = false;
  static const bool fakeDeviceEvidenceAllowed = false;
  static const bool fakeReleaseEvidenceAllowed = false;
  static const bool cursorPassClaimAllowedInThisPackage = false;
  static const bool releasePassClaimAllowedInThisPackage = false;

  static ReleaseFreezeFinalReviewGuardV172Q124Readiness evaluateReadiness({
    required bool q123PostCleanupRegressionGuardPackageReady,
    required bool q123PostCleanupRegressionEvidenceComplete,
    required bool q123HumanReviewApproved,
    required bool flutterPubGetPassed,
    required bool flutterAnalyzePassed,
    required bool flutterTestPassed,
    required bool mathLiveLabDeviceRunCaptured,
    required bool mainAppDeviceRunCaptured,
    required bool q108Q116CursorCourtPassed,
    required bool graphRuntimeEvidencePassed,
    required bool historyRuntimeEvidencePassed,
    required bool solutionRuntimeEvidencePassed,
    required bool rollbackVerificationPassed,
    required bool protectedSurfacesUnchanged,
    required bool keyboardUntouched,
    required bool moreUntouched,
    required bool longPressUntouched,
    required bool appShellUntouched,
    required bool graphHistorySolutionUiUntouched,
    required bool packageHygieneClean,
    required bool zipIntegrityVerified,
    required bool freshExtractVerified,
    required bool noStaleNestedArtifacts,
    required bool primaryZipNameLocked,
    required bool noDefaultEditorSwitchInThisPackage,
    required bool noMainWorkspaceMountInThisPackage,
    required bool noLegacyRetirementInThisPackage,
    required bool noPhysicalLegacyDeletionInThisPackage,
    required bool noRuntimeBehaviorChangeInThisPackage,
    required bool noFakeRuntimeEvidence,
    required bool noFakeDeviceEvidence,
    required bool noFakeReleaseEvidence,
    required bool explicitReleaseFreezeApproval,
  }) {
    final blockers = <String>[];
    if (!q123PostCleanupRegressionGuardPackageReady) blockers.add('Q123 post-cleanup regression guard package is not ready');
    if (!q123PostCleanupRegressionEvidenceComplete) blockers.add('Q123 post-cleanup regression evidence is incomplete');
    if (!q123HumanReviewApproved) blockers.add('Q123 human review approval is missing');
    if (!flutterPubGetPassed) blockers.add('flutter pub get PASS evidence is missing');
    if (!flutterAnalyzePassed) blockers.add('flutter analyze PASS evidence is missing');
    if (!flutterTestPassed) blockers.add('flutter test PASS evidence is missing');
    if (!mathLiveLabDeviceRunCaptured) blockers.add('MathLive Lab real-device evidence is missing');
    if (!mainAppDeviceRunCaptured) blockers.add('main app real-device evidence is missing');
    if (!q108Q116CursorCourtPassed) blockers.add('Q108/Q116 real-device cursor court PASS evidence is missing');
    if (!graphRuntimeEvidencePassed) blockers.add('Graph runtime evidence is missing');
    if (!historyRuntimeEvidencePassed) blockers.add('History runtime evidence is missing');
    if (!solutionRuntimeEvidencePassed) blockers.add('Solution runtime evidence is missing');
    if (!rollbackVerificationPassed) blockers.add('rollback verification is missing');
    if (!protectedSurfacesUnchanged) blockers.add('protected surfaces changed');
    if (!keyboardUntouched) blockers.add('keyboard protected files changed');
    if (!moreUntouched) blockers.add('MORE contract changed');
    if (!longPressUntouched) blockers.add('long-press contract changed');
    if (!appShellUntouched) blockers.add('AppShell changed');
    if (!graphHistorySolutionUiUntouched) blockers.add('Graph/History/Solution UI changed');
    if (!packageHygieneClean) blockers.add('package hygiene is not clean');
    if (!zipIntegrityVerified) blockers.add('zip integrity verification is missing');
    if (!freshExtractVerified) blockers.add('fresh extract verification is missing');
    if (!noStaleNestedArtifacts) blockers.add('stale nested artifacts are present');
    if (!primaryZipNameLocked) blockers.add('primary delivery zip name is not locked to MathProFlutterPhase17.zip');
    if (!noDefaultEditorSwitchInThisPackage) blockers.add('default editor switch occurred in this package');
    if (!noMainWorkspaceMountInThisPackage) blockers.add('main workspace MathLive mount occurred in this package');
    if (!noLegacyRetirementInThisPackage) blockers.add('legacy main-path retirement occurred in this package');
    if (!noPhysicalLegacyDeletionInThisPackage) blockers.add('legacy cursor files were physically deleted in this package');
    if (!noRuntimeBehaviorChangeInThisPackage) blockers.add('runtime behavior changed in this guard-only package');
    if (!noFakeRuntimeEvidence) blockers.add('runtime evidence was faked');
    if (!noFakeDeviceEvidence) blockers.add('device evidence was faked');
    if (!noFakeReleaseEvidence) blockers.add('release/freeze evidence was faked');
    if (!explicitReleaseFreezeApproval) blockers.add('explicit Q124 release-freeze approval is missing');

    final packageSideReleaseFreezeFinalReviewGuardReady =
        q123PostCleanupRegressionGuardPackageReady &&
        protectedSurfacesUnchanged &&
        keyboardUntouched &&
        moreUntouched &&
        longPressUntouched &&
        appShellUntouched &&
        graphHistorySolutionUiUntouched &&
        packageHygieneClean &&
        zipIntegrityVerified &&
        freshExtractVerified &&
        noStaleNestedArtifacts &&
        primaryZipNameLocked &&
        noDefaultEditorSwitchInThisPackage &&
        noMainWorkspaceMountInThisPackage &&
        noLegacyRetirementInThisPackage &&
        noPhysicalLegacyDeletionInThisPackage &&
        noRuntimeBehaviorChangeInThisPackage &&
        noFakeRuntimeEvidence &&
        noFakeDeviceEvidence &&
        noFakeReleaseEvidence;

    final releaseFreezeFinalReviewEvidenceComplete = packageSideReleaseFreezeFinalReviewGuardReady &&
        q123PostCleanupRegressionEvidenceComplete &&
        q123HumanReviewApproved &&
        flutterPubGetPassed &&
        flutterAnalyzePassed &&
        flutterTestPassed &&
        mathLiveLabDeviceRunCaptured &&
        mainAppDeviceRunCaptured &&
        q108Q116CursorCourtPassed &&
        graphRuntimeEvidencePassed &&
        historyRuntimeEvidencePassed &&
        solutionRuntimeEvidencePassed &&
        rollbackVerificationPassed &&
        explicitReleaseFreezeApproval;

    return ReleaseFreezeFinalReviewGuardV172Q124Readiness(
      status: releaseFreezeFinalReviewEvidenceComplete
          ? 'Q124_RELEASE_FREEZE_FINAL_REVIEW_READY_FOR_HUMAN_APPROVAL'
          : packageSideReleaseFreezeFinalReviewGuardReady
              ? 'Q124_RELEASE_FREEZE_FINAL_REVIEW_GUARD_PACKAGE_READY_BUT_POST_CLEANUP_EVIDENCE_BLOCKED'
              : 'BLOCKED_Q124_RELEASE_FREEZE_FINAL_REVIEW_GUARD',
      blockers: blockers,
      packageSideReleaseFreezeFinalReviewGuardReady: packageSideReleaseFreezeFinalReviewGuardReady,
      releaseFreezeFinalReviewEvidenceComplete: releaseFreezeFinalReviewEvidenceComplete,
      mayOpenReleaseFreezeFinalReview: releaseFreezeFinalReviewEvidenceComplete,
      mayClaimReleasePass: false,
      mayClaimCursorPass: false,
      maySwitchDefaultEditorNow: false,
      mayRetireLegacyMainPathNow: false,
      mayDeleteLegacyCursorNow: false,
      protectedUiSurfaceMutationAllowed: false,
    );
  }
}

class ReleaseFreezeFinalReviewGuardV172Q124Readiness {
  const ReleaseFreezeFinalReviewGuardV172Q124Readiness({
    required this.status,
    required this.blockers,
    required this.packageSideReleaseFreezeFinalReviewGuardReady,
    required this.releaseFreezeFinalReviewEvidenceComplete,
    required this.mayOpenReleaseFreezeFinalReview,
    required this.mayClaimReleasePass,
    required this.mayClaimCursorPass,
    required this.maySwitchDefaultEditorNow,
    required this.mayRetireLegacyMainPathNow,
    required this.mayDeleteLegacyCursorNow,
    required this.protectedUiSurfaceMutationAllowed,
  });

  final String status;
  final List<String> blockers;
  final bool packageSideReleaseFreezeFinalReviewGuardReady;
  final bool releaseFreezeFinalReviewEvidenceComplete;
  final bool mayOpenReleaseFreezeFinalReview;
  final bool mayClaimReleasePass;
  final bool mayClaimCursorPass;
  final bool maySwitchDefaultEditorNow;
  final bool mayRetireLegacyMainPathNow;
  final bool mayDeleteLegacyCursorNow;
  final bool protectedUiSurfaceMutationAllowed;

  bool get isBlocked => !releaseFreezeFinalReviewEvidenceComplete;
}
