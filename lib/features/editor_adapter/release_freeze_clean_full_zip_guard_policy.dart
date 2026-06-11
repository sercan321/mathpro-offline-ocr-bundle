import 'post_cleanup_regression_court_guard_policy.dart';

/// V172-Q114 — Release Freeze / Clean Full ZIP Guard.
///
/// Q114 is a final release-freeze guard only. It does not claim a release PASS,
/// does not execute cleanup, does not switch MathLive into the default editor,
/// and does not delete the legacy cursor. It defines the evidence required
/// before a later clean full ZIP can be treated as a releasable artifact.
class ReleaseFreezeCleanFullZipGuardPolicy {
  const ReleaseFreezeCleanFullZipGuardPolicy._();

  static const String phase = 'V172-Q114';
  static const String verifierScript = 'tool/verify_release_freeze_clean_full_zip_guard.mjs';
  static const String reportJson = 'tool/reports/release_freeze_clean_full_zip_guard_report.json';
  static const String reportMarkdown = 'tool/reports/release_freeze_clean_full_zip_guard_report.md';
  static const String expectedDeliveryZipName = 'MathProFlutterPhase17.zip';
  static const String q113VerifierScript = PostCleanupRegressionCourtGuardPolicy.verifierScript;

  static const bool releaseFreezeGuardImplemented = true;
  static const bool releaseFrozenInThisPackage = false;
  static const bool finalReleasePassClaimAllowedInThisPackage = false;
  static const bool cleanFullZipClaimAllowedWithoutFreshExtract = false;
  static const bool mathLiveDefaultSwitchAllowedInThisPackage = false;
  static const bool legacyCursorDeletionAllowedInThisPackage = false;
  static const bool postCleanupRegressionAssumedCompleteInThisPackage = false;
  static const bool protectedUiSurfaceMutationAllowed = false;
  static const bool fakeRuntimeEvidenceAllowed = false;
  static const bool fakeSmokeEvidenceAllowed = false;
  static const bool fakeDeviceEvidenceAllowed = false;
  static const bool patchOnlyDeliveryAllowed = false;
  static const bool staleZipAllowed = false;

  static ReleaseFreezeCleanFullZipGuardReadiness evaluateReadiness({
    required bool q113PostCleanupRegressionCourtReady,
    required bool q113GuardPackageReady,
    required bool flutterPubGetPassed,
    required bool flutterAnalyzePassed,
    required bool flutterTestPassed,
    required bool mathLiveLabRealDeviceRunPassed,
    required bool mainAppRealDeviceRunPassed,
    required bool graphHistorySolutionRuntimeVerified,
    required bool rollbackVerified,
    required bool protectedSurfacesUnchanged,
    required bool zipIntegrityVerified,
    required bool freshExtractVerified,
    required bool packageHygieneClean,
    required bool noStaleArchivesInsidePackage,
    required bool noPatchOnlyDelivery,
    required bool finalAuditDocsPresent,
    required bool noFakeEvidence,
    required bool explicitReleaseFreezeApproval,
  }) {
    final blockers = <String>[];
    if (!q113PostCleanupRegressionCourtReady) blockers.add('Q113 post-cleanup regression court is not ready for release review');
    if (!q113GuardPackageReady) blockers.add('Q113 package-side guard is not ready');
    if (!flutterPubGetPassed) blockers.add('flutter pub get PASS evidence is missing');
    if (!flutterAnalyzePassed) blockers.add('flutter analyze PASS evidence is missing');
    if (!flutterTestPassed) blockers.add('flutter test PASS evidence is missing');
    if (!mathLiveLabRealDeviceRunPassed) blockers.add('MathLive Lab real-device PASS evidence is missing');
    if (!mainAppRealDeviceRunPassed) blockers.add('main app real-device PASS evidence is missing');
    if (!graphHistorySolutionRuntimeVerified) blockers.add('Graph/History/Solution runtime verification is missing');
    if (!rollbackVerified) blockers.add('rollback verification is missing');
    if (!protectedSurfacesUnchanged) blockers.add('protected surfaces changed');
    if (!zipIntegrityVerified) blockers.add('final ZIP integrity verification is missing');
    if (!freshExtractVerified) blockers.add('fresh extract verification is missing');
    if (!packageHygieneClean) blockers.add('package hygiene is not clean');
    if (!noStaleArchivesInsidePackage) blockers.add('stale nested archive or generated artifact is present inside package');
    if (!noPatchOnlyDelivery) blockers.add('delivery is patch-only instead of full project ZIP');
    if (!finalAuditDocsPresent) blockers.add('final release-freeze audit documents are missing');
    if (!noFakeEvidence) blockers.add('runtime/smoke/device evidence was faked');
    if (!explicitReleaseFreezeApproval) blockers.add('explicit release-freeze approval is missing');

    final packageSideReleaseFreezeGuardReady =
        q113GuardPackageReady &&
        protectedSurfacesUnchanged &&
        zipIntegrityVerified &&
        freshExtractVerified &&
        packageHygieneClean &&
        noStaleArchivesInsidePackage &&
        noPatchOnlyDelivery &&
        finalAuditDocsPresent &&
        noFakeEvidence;

    final evidenceCompleteForReleaseFreezeReview = packageSideReleaseFreezeGuardReady &&
        q113PostCleanupRegressionCourtReady &&
        flutterPubGetPassed &&
        flutterAnalyzePassed &&
        flutterTestPassed &&
        mathLiveLabRealDeviceRunPassed &&
        mainAppRealDeviceRunPassed &&
        graphHistorySolutionRuntimeVerified &&
        rollbackVerified &&
        explicitReleaseFreezeApproval;

    return ReleaseFreezeCleanFullZipGuardReadiness(
      status: evidenceCompleteForReleaseFreezeReview
          ? 'RELEASE_FREEZE_CLEAN_FULL_ZIP_READY_FOR_FINAL_APPROVAL'
          : packageSideReleaseFreezeGuardReady
              ? 'RELEASE_FREEZE_CLEAN_FULL_ZIP_GUARD_PACKAGE_READY_BUT_EVIDENCE_BLOCKED'
              : 'BLOCKED_RELEASE_FREEZE_CLEAN_FULL_ZIP_GUARD',
      blockers: blockers,
      packageSideReleaseFreezeGuardReady: packageSideReleaseFreezeGuardReady,
      evidenceCompleteForReleaseFreezeReview: evidenceCompleteForReleaseFreezeReview,
      releaseFrozenInThisPackage: false,
      finalReleasePassClaimAllowedInThisPackage: false,
      cleanFullZipClaimAllowedWithoutFreshExtract: false,
      maySwitchMathLiveDefaultEditorNow: false,
      mayDeleteLegacyCursorNow: false,
      protectedUiSurfaceMutationAllowed: false,
    );
  }
}

class ReleaseFreezeCleanFullZipGuardReadiness {
  const ReleaseFreezeCleanFullZipGuardReadiness({
    required this.status,
    required this.blockers,
    required this.packageSideReleaseFreezeGuardReady,
    required this.evidenceCompleteForReleaseFreezeReview,
    required this.releaseFrozenInThisPackage,
    required this.finalReleasePassClaimAllowedInThisPackage,
    required this.cleanFullZipClaimAllowedWithoutFreshExtract,
    required this.maySwitchMathLiveDefaultEditorNow,
    required this.mayDeleteLegacyCursorNow,
    required this.protectedUiSurfaceMutationAllowed,
  });

  final String status;
  final List<String> blockers;
  final bool packageSideReleaseFreezeGuardReady;
  final bool evidenceCompleteForReleaseFreezeReview;
  final bool releaseFrozenInThisPackage;
  final bool finalReleasePassClaimAllowedInThisPackage;
  final bool cleanFullZipClaimAllowedWithoutFreshExtract;
  final bool maySwitchMathLiveDefaultEditorNow;
  final bool mayDeleteLegacyCursorNow;
  final bool protectedUiSurfaceMutationAllowed;

  bool get isBlocked => !evidenceCompleteForReleaseFreezeReview;
}
