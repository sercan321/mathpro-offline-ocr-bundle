import 'legacy_cursor_physical_cleanup_execution_guard_policy.dart';

/// V172-Q113 — Post-Cleanup Regression Court Guard.
///
/// Q113 is a post-cleanup regression court guard only. It does not pretend that
/// Q112 physical cleanup has run. It defines the final regression evidence that
/// must exist after a separately approved cleanup package before any release or
/// post-cleanup PASS can be claimed.
class PostCleanupRegressionCourtGuardPolicy {
  const PostCleanupRegressionCourtGuardPolicy._();

  static const String phase = 'V172-Q113';
  static const String verifierScript = 'tool/verify_post_cleanup_regression_court_guard.mjs';
  static const String reportJson = 'tool/reports/post_cleanup_regression_court_guard_report.json';
  static const String reportMarkdown = 'tool/reports/post_cleanup_regression_court_guard_report.md';
  static const String q112ExecutionGuardVerifier = LegacyCursorPhysicalCleanupExecutionGuardPolicy.verifierScript;

  static const bool postCleanupRegressionCourtGuardImplemented = true;
  static const bool postCleanupRegressionExecutedInThisPackage = false;
  static const bool physicalCleanupAssumedCompleteInThisPackage = false;
  static const bool finalReleaseCandidateClaimAllowedInThisPackage = false;
  static const bool mayClaimPostCleanupPassNow = false;
  static const bool mayClaimCursorPassNow = false;
  static const bool mayClaimPhotomathWolframLevelNow = false;
  static const bool maySwitchMathLiveDefaultEditorNow = false;
  static const bool mayDeleteLegacyCursorNow = false;
  static const bool q112ApprovedCleanupExecutionRequired = true;
  static const bool cleanupDeltaManifestRequired = true;
  static const bool flutterPubGetRequired = true;
  static const bool flutterAnalyzeRequired = true;
  static const bool flutterTestRequired = true;
  static const bool mathLiveLabRealDeviceRunRequired = true;
  static const bool mainAppRealDeviceRunRequired = true;
  static const bool q108RealDeviceCursorCourtRequired = true;
  static const bool graphHistorySolutionRuntimeRequired = true;
  static const bool rollbackVerificationRequired = true;
  static const bool noLegacyCursorOverlayOnMathLivePathRequired = true;
  static const bool protectedSurfacesMustRemainUnchanged = true;
  static const bool packageHygieneRequired = true;
  static const bool fakeRuntimeEvidenceAllowed = false;
  static const bool fakeSmokeEvidenceAllowed = false;
  static const bool fakeDeviceEvidenceAllowed = false;
  static const bool keyboardMutationAllowed = false;
  static const bool moreMutationAllowed = false;
  static const bool longPressMutationAllowed = false;
  static const bool appShellMutationAllowed = false;
  static const bool graphHistorySolutionUiMutationAllowed = false;
  static const bool protectedUiSurfaceMutationAllowed = false;

  static PostCleanupRegressionCourtGuardReadiness evaluateReadiness({
    required bool q112ExecutionGuardPackageReady,
    required bool q112EvidenceCompleteForPhysicalCleanupExecution,
    required bool approvedCleanupActuallyExecuted,
    required bool cleanupDeltaManifestPresent,
    required bool flutterPubGetPassed,
    required bool flutterAnalyzePassed,
    required bool flutterTestPassed,
    required bool mathLiveLabRealDeviceRunPassed,
    required bool mainAppRealDeviceRunPassed,
    required bool q108RealDeviceCursorCourtPassed,
    required bool graphWorks,
    required bool historyWorks,
    required bool solutionInputWorks,
    required bool noLegacyCursorOverlayVisibleOnMathLivePath,
    required bool rollbackFlagWorks,
    required bool protectedSurfacesUnchanged,
    required bool packageHygieneClean,
    required bool noFakeEvidence,
    required bool explicitReleaseApprovalApproved,
  }) {
    final blockers = <String>[];
    if (!q112ExecutionGuardPackageReady) blockers.add('Q112 cleanup execution guard package is not ready');
    if (!q112EvidenceCompleteForPhysicalCleanupExecution) blockers.add('Q112 physical cleanup execution evidence is incomplete');
    if (!approvedCleanupActuallyExecuted) blockers.add('approved physical cleanup package has not actually executed');
    if (!cleanupDeltaManifestPresent) blockers.add('cleanup delta manifest is missing');
    if (!flutterPubGetPassed) blockers.add('flutter pub get PASS evidence is missing');
    if (!flutterAnalyzePassed) blockers.add('flutter analyze PASS evidence is missing');
    if (!flutterTestPassed) blockers.add('flutter test PASS evidence is missing');
    if (!mathLiveLabRealDeviceRunPassed) blockers.add('MathLive Lab real-device run PASS evidence is missing');
    if (!mainAppRealDeviceRunPassed) blockers.add('main app real-device run PASS evidence is missing');
    if (!q108RealDeviceCursorCourtPassed) blockers.add('Q108 real-device cursor court PASS evidence is missing');
    if (!graphWorks) blockers.add('Graph runtime behavior is not verified');
    if (!historyWorks) blockers.add('History runtime behavior is not verified');
    if (!solutionInputWorks) blockers.add('Solution input runtime behavior is not verified');
    if (!noLegacyCursorOverlayVisibleOnMathLivePath) blockers.add('legacy cursor overlay absence on MathLive path is not verified');
    if (!rollbackFlagWorks) blockers.add('rollback flag behavior is not verified');
    if (!protectedSurfacesUnchanged) blockers.add('protected UI surfaces changed');
    if (!packageHygieneClean) blockers.add('package hygiene is not clean');
    if (!noFakeEvidence) blockers.add('runtime/smoke/device evidence was faked');
    if (!explicitReleaseApprovalApproved) blockers.add('explicit post-cleanup release approval is missing');

    final packageSideRegressionGuardReady =
        protectedSurfacesUnchanged && packageHygieneClean && noFakeEvidence;
    final evidenceCompleteForPostCleanupRegressionCourt = packageSideRegressionGuardReady &&
        q112ExecutionGuardPackageReady &&
        q112EvidenceCompleteForPhysicalCleanupExecution &&
        approvedCleanupActuallyExecuted &&
        cleanupDeltaManifestPresent &&
        flutterPubGetPassed &&
        flutterAnalyzePassed &&
        flutterTestPassed &&
        mathLiveLabRealDeviceRunPassed &&
        mainAppRealDeviceRunPassed &&
        q108RealDeviceCursorCourtPassed &&
        graphWorks &&
        historyWorks &&
        solutionInputWorks &&
        noLegacyCursorOverlayVisibleOnMathLivePath &&
        rollbackFlagWorks &&
        explicitReleaseApprovalApproved;

    return PostCleanupRegressionCourtGuardReadiness(
      status: evidenceCompleteForPostCleanupRegressionCourt
          ? 'POST_CLEANUP_REGRESSION_COURT_READY_FOR_RELEASE_REVIEW'
          : packageSideRegressionGuardReady
              ? 'POST_CLEANUP_REGRESSION_COURT_GUARD_PACKAGE_READY_BUT_EVIDENCE_BLOCKED'
              : 'BLOCKED_POST_CLEANUP_REGRESSION_COURT_GUARD',
      blockers: blockers,
      packageSideRegressionGuardReady: packageSideRegressionGuardReady,
      evidenceCompleteForPostCleanupRegressionCourt: evidenceCompleteForPostCleanupRegressionCourt,
      postCleanupRegressionExecutedInThisPackage: false,
      physicalCleanupAssumedCompleteInThisPackage: false,
      finalReleaseCandidateClaimAllowedInThisPackage: false,
      mayClaimPostCleanupPassNow: false,
      mayClaimCursorPassNow: false,
      mayClaimPhotomathWolframLevelNow: false,
      maySwitchMathLiveDefaultEditorNow: false,
      mayDeleteLegacyCursorNow: false,
      protectedUiSurfaceMutationAllowed: false,
    );
  }
}

class PostCleanupRegressionCourtGuardReadiness {
  const PostCleanupRegressionCourtGuardReadiness({
    required this.status,
    required this.blockers,
    required this.packageSideRegressionGuardReady,
    required this.evidenceCompleteForPostCleanupRegressionCourt,
    required this.postCleanupRegressionExecutedInThisPackage,
    required this.physicalCleanupAssumedCompleteInThisPackage,
    required this.finalReleaseCandidateClaimAllowedInThisPackage,
    required this.mayClaimPostCleanupPassNow,
    required this.mayClaimCursorPassNow,
    required this.mayClaimPhotomathWolframLevelNow,
    required this.maySwitchMathLiveDefaultEditorNow,
    required this.mayDeleteLegacyCursorNow,
    required this.protectedUiSurfaceMutationAllowed,
  });

  final String status;
  final List<String> blockers;
  final bool packageSideRegressionGuardReady;
  final bool evidenceCompleteForPostCleanupRegressionCourt;
  final bool postCleanupRegressionExecutedInThisPackage;
  final bool physicalCleanupAssumedCompleteInThisPackage;
  final bool finalReleaseCandidateClaimAllowedInThisPackage;
  final bool mayClaimPostCleanupPassNow;
  final bool mayClaimCursorPassNow;
  final bool mayClaimPhotomathWolframLevelNow;
  final bool maySwitchMathLiveDefaultEditorNow;
  final bool mayDeleteLegacyCursorNow;
  final bool protectedUiSurfaceMutationAllowed;

  bool get isBlocked => !evidenceCompleteForPostCleanupRegressionCourt;
}
