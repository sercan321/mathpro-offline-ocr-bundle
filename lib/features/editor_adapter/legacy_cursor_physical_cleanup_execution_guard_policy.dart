import 'legacy_cursor_physical_cleanup_planning_policy.dart';

/// V172-Q112 — Legacy Cursor Physical Cleanup Execution Guard.
///
/// Q112 is still a guard-only phase in this package. It does not delete files
/// and does not execute cleanup. It converts the Q111 inventory into a stricter
/// execution-permission court so later physical cleanup cannot happen unless
/// Q110/Q109/Q108/Flutter/manual review/explicit approval evidence is real.
class LegacyCursorPhysicalCleanupExecutionGuardPolicy {
  const LegacyCursorPhysicalCleanupExecutionGuardPolicy._();

  static const String phase = 'V172-Q112';
  static const String verifierScript = 'tool/verify_legacy_cursor_physical_cleanup_execution_guard.mjs';
  static const String reportJson = 'tool/reports/legacy_cursor_physical_cleanup_execution_guard_report.json';
  static const String reportMarkdown = 'tool/reports/legacy_cursor_physical_cleanup_execution_guard_report.md';
  static const String q111InventoryManifest = LegacyCursorPhysicalCleanupPlanningPolicy.inventoryManifest;
  static const String q111PlanningVerifier = LegacyCursorPhysicalCleanupPlanningPolicy.verifierScript;

  static const bool cleanupExecutionGuardImplemented = true;
  static const bool physicalCleanupExecutionImplementedInThisPackage = false;
  static const bool actualPhysicalCleanupImplementedInThisPackage = false;
  static const bool legacyCursorFileDeletionAllowedNow = false;
  static const bool mayDeleteLegacyCursorNow = false;
  static const bool mayExecuteCleanupInThisPackage = false;
  static const bool q111InventoryManifestRequired = true;
  static const bool q111PlanningReadinessRequired = true;
  static const bool q110RetirementGateRequired = true;
  static const bool q109ConditionalActivationRequired = true;
  static const bool q108RealDeviceCursorCourtRequired = true;
  static const bool flutterAnalyzeRequired = true;
  static const bool flutterTestRequired = true;
  static const bool postActivationSoakRequired = true;
  static const bool manualInventoryReviewRequired = true;
  static const bool explicitQ112CleanupApprovalRequired = true;
  static const bool cleanupCandidateFilesMustStillExist = true;
  static const bool rollbackFilesMustBePreserved = true;
  static const bool dataPathFilesMustBePreserved = true;
  static const bool protectedSurfacesMustRemainUnchanged = true;
  static const bool keyboardMutationAllowed = false;
  static const bool moreMutationAllowed = false;
  static const bool longPressMutationAllowed = false;
  static const bool appShellMutationAllowed = false;
  static const bool graphHistorySolutionUiMutationAllowed = false;
  static const bool protectedUiSurfaceMutationAllowed = false;
  static const bool fakeRuntimeEvidenceAllowed = false;
  static const bool fakeSmokeEvidenceAllowed = false;
  static const bool fakeDeviceEvidenceAllowed = false;
  static const bool cursorPassClaimAllowedInThisPackage = false;

  static LegacyCursorPhysicalCleanupExecutionGuardReadiness evaluateReadiness({
    required bool q111PlanningPackageReady,
    required bool q111EvidenceCompleteForCleanupExecutionReview,
    required bool q110RetirementGateReadyForReview,
    required bool q109ConditionalActivationReadyForReview,
    required bool q108RealDeviceCursorCourtPassed,
    required bool flutterAnalyzePassed,
    required bool flutterTestPassed,
    required bool postActivationSoakPassed,
    required bool inventoryManifestPresent,
    required bool inventoryCategoriesComplete,
    required bool cleanupCandidatesClassified,
    required bool cleanupCandidateFilesStillPresent,
    required bool protectedSurfacesUnchanged,
    required bool rollbackFilesPreserved,
    required bool dataPathFilesPreserved,
    required bool noPhysicalDeletionAttempted,
    required bool noRuntimeBehaviorChange,
    required bool noFakeEvidence,
    required bool manualInventoryReviewCompleted,
    required bool explicitQ112CleanupApprovalApproved,
  }) {
    final blockers = <String>[];
    if (!q111PlanningPackageReady) blockers.add('Q111 physical cleanup planning package is not ready');
    if (!q111EvidenceCompleteForCleanupExecutionReview) blockers.add('Q111 evidence is not complete for cleanup execution review');
    if (!q110RetirementGateReadyForReview) blockers.add('Q110 retirement gate is not ready for review');
    if (!q109ConditionalActivationReadyForReview) blockers.add('Q109 conditional activation is not ready for review');
    if (!q108RealDeviceCursorCourtPassed) blockers.add('Q108 real-device cursor court has not passed');
    if (!flutterAnalyzePassed) blockers.add('flutter analyze PASS evidence is missing');
    if (!flutterTestPassed) blockers.add('flutter test PASS evidence is missing');
    if (!postActivationSoakPassed) blockers.add('post-activation soak evidence is missing');
    if (!inventoryManifestPresent) blockers.add('Q111 inventory manifest is missing');
    if (!inventoryCategoriesComplete) blockers.add('Q111 inventory categories are incomplete');
    if (!cleanupCandidatesClassified) blockers.add('cleanup candidates are not classified');
    if (!cleanupCandidateFilesStillPresent) blockers.add('cleanup candidate files were already deleted');
    if (!protectedSurfacesUnchanged) blockers.add('protected UI surfaces changed');
    if (!rollbackFilesPreserved) blockers.add('legacy rollback files were not preserved');
    if (!dataPathFilesPreserved) blockers.add('shared editor/data-path files were not preserved');
    if (!noPhysicalDeletionAttempted) blockers.add('Q112 attempted physical legacy cursor deletion');
    if (!noRuntimeBehaviorChange) blockers.add('Q112 attempted runtime editor behavior change');
    if (!noFakeEvidence) blockers.add('runtime/smoke/device evidence was faked');
    if (!manualInventoryReviewCompleted) blockers.add('manual Q111 inventory review is missing');
    if (!explicitQ112CleanupApprovalApproved) blockers.add('explicit Q112 cleanup approval is missing');

    final packageSideExecutionGuardReady = inventoryManifestPresent &&
        inventoryCategoriesComplete &&
        cleanupCandidatesClassified &&
        cleanupCandidateFilesStillPresent &&
        protectedSurfacesUnchanged &&
        rollbackFilesPreserved &&
        dataPathFilesPreserved &&
        noPhysicalDeletionAttempted &&
        noRuntimeBehaviorChange &&
        noFakeEvidence;
    final evidenceCompleteForPhysicalCleanupExecution = packageSideExecutionGuardReady &&
        q111PlanningPackageReady &&
        q111EvidenceCompleteForCleanupExecutionReview &&
        q110RetirementGateReadyForReview &&
        q109ConditionalActivationReadyForReview &&
        q108RealDeviceCursorCourtPassed &&
        flutterAnalyzePassed &&
        flutterTestPassed &&
        postActivationSoakPassed &&
        manualInventoryReviewCompleted &&
        explicitQ112CleanupApprovalApproved;

    return LegacyCursorPhysicalCleanupExecutionGuardReadiness(
      status: evidenceCompleteForPhysicalCleanupExecution
          ? 'LEGACY_CURSOR_PHYSICAL_CLEANUP_EXECUTION_READY_FOR_SEPARATE_APPROVED_PACKAGE'
          : packageSideExecutionGuardReady
              ? 'LEGACY_CURSOR_PHYSICAL_CLEANUP_EXECUTION_GUARD_PACKAGE_READY_BUT_EVIDENCE_BLOCKED'
              : 'BLOCKED_LEGACY_CURSOR_PHYSICAL_CLEANUP_EXECUTION_GUARD',
      blockers: blockers,
      packageSideExecutionGuardReady: packageSideExecutionGuardReady,
      evidenceCompleteForPhysicalCleanupExecution: evidenceCompleteForPhysicalCleanupExecution,
      q111InventoryManifest: q111InventoryManifest,
      physicalCleanupExecutionImplementedInThisPackage: false,
      mayDeleteLegacyCursorNow: false,
      mayExecuteCleanupInThisPackage: false,
      mayExecuteCleanupInSeparateApprovedPackage: evidenceCompleteForPhysicalCleanupExecution,
      protectedUiSurfaceMutationAllowed: false,
      cursorPassClaimAllowedInThisPackage: false,
    );
  }
}

class LegacyCursorPhysicalCleanupExecutionGuardReadiness {
  const LegacyCursorPhysicalCleanupExecutionGuardReadiness({
    required this.status,
    required this.blockers,
    required this.packageSideExecutionGuardReady,
    required this.evidenceCompleteForPhysicalCleanupExecution,
    required this.q111InventoryManifest,
    required this.physicalCleanupExecutionImplementedInThisPackage,
    required this.mayDeleteLegacyCursorNow,
    required this.mayExecuteCleanupInThisPackage,
    required this.mayExecuteCleanupInSeparateApprovedPackage,
    required this.protectedUiSurfaceMutationAllowed,
    required this.cursorPassClaimAllowedInThisPackage,
  });

  final String status;
  final List<String> blockers;
  final bool packageSideExecutionGuardReady;
  final bool evidenceCompleteForPhysicalCleanupExecution;
  final String q111InventoryManifest;
  final bool physicalCleanupExecutionImplementedInThisPackage;
  final bool mayDeleteLegacyCursorNow;
  final bool mayExecuteCleanupInThisPackage;
  final bool mayExecuteCleanupInSeparateApprovedPackage;
  final bool protectedUiSurfaceMutationAllowed;
  final bool cursorPassClaimAllowedInThisPackage;

  bool get isBlocked => !evidenceCompleteForPhysicalCleanupExecution;
}
