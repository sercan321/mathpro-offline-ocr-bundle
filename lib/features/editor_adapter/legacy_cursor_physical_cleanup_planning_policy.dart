import 'legacy_cursor_main_path_retirement_actual_gate_policy.dart';

/// V172-Q111 — Legacy Cursor Physical Cleanup Planning.
///
/// Q111 is an inventory/planning phase only. It does not delete files, does not
/// perform physical cleanup, does not retire the legacy cursor main path, and
/// does not switch or mount MathLive as the main editor. It classifies legacy
/// cursor-related files before a later Q112 cleanup execution review.
class LegacyCursorPhysicalCleanupPlanningPolicy {
  const LegacyCursorPhysicalCleanupPlanningPolicy._();

  static const String phase = 'V172-Q111';
  static const String verifierScript = 'tool/verify_legacy_cursor_physical_cleanup_planning.mjs';
  static const String reportJson = 'tool/reports/legacy_cursor_physical_cleanup_planning_report.json';
  static const String reportMarkdown = 'tool/reports/legacy_cursor_physical_cleanup_planning_report.md';
  static const String inventoryManifest = 'docs/audit/V172_Q111_LEGACY_CURSOR_PHYSICAL_CLEANUP_INVENTORY.json';
  static const String q110RetirementGatePhase = LegacyCursorMainPathRetirementActualGatePolicy.phase;

  static const bool physicalCleanupPlanningImplemented = true;
  static const bool actualPhysicalCleanupImplementedInThisPackage = false;
  static const bool legacyCursorFileDeletionAllowedNow = false;
  static const bool mayDeleteLegacyCursorNow = false;
  static const bool q110RetirementGateRequired = true;
  static const bool q109ConditionalActivationRequired = true;
  static const bool q108RealDeviceCursorCourtRequired = true;
  static const bool flutterAnalyzeRequired = true;
  static const bool flutterTestRequired = true;
  static const bool explicitCleanupApprovalRequired = true;
  static const bool manualReviewRequiredBeforeQ112 = true;
  static const bool rollbackFilesMustBePreserved = true;
  static const bool dataPathFilesMustBePreserved = true;
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

  static const List<String> requiredInventoryCategories = <String>[
    'mustKeepProtectedSurface',
    'mustKeepDataModelOrSharedEditorCore',
    'retainRollbackUntilPostActivation',
    'cleanupCandidateAfterQ112Review',
    'manualReviewRequiredBeforeDeletion',
  ];

  static LegacyCursorPhysicalCleanupPlanningReadiness evaluateReadiness({
    required bool q110RetirementGateReadyForReview,
    required bool q109ConditionalActivationReadyForReview,
    required bool q108RealDeviceCursorCourtPassed,
    required bool flutterAnalyzePassed,
    required bool flutterTestPassed,
    required bool inventoryManifestPresent,
    required bool inventoryHasRequiredCategories,
    required bool protectedSurfacesUnchanged,
    required bool rollbackFilesPreserved,
    required bool dataPathFilesPreserved,
    required bool noPhysicalDeletionAttempted,
    required bool noRuntimeBehaviorChange,
    required bool noFakeEvidence,
    required bool manualReviewCompleted,
    required bool explicitCleanupApprovalApproved,
  }) {
    final blockers = <String>[];
    if (!q110RetirementGateReadyForReview) blockers.add('Q110 retirement gate is not ready for review');
    if (!q109ConditionalActivationReadyForReview) blockers.add('Q109 conditional activation is not ready for review');
    if (!q108RealDeviceCursorCourtPassed) blockers.add('Q108 real-device cursor court has not passed');
    if (!flutterAnalyzePassed) blockers.add('flutter analyze PASS evidence is missing');
    if (!flutterTestPassed) blockers.add('flutter test PASS evidence is missing');
    if (!inventoryManifestPresent) blockers.add('Q111 cleanup inventory manifest is missing');
    if (!inventoryHasRequiredCategories) blockers.add('Q111 cleanup inventory categories are incomplete');
    if (!protectedSurfacesUnchanged) blockers.add('protected UI surfaces changed');
    if (!rollbackFilesPreserved) blockers.add('legacy rollback files were not preserved');
    if (!dataPathFilesPreserved) blockers.add('shared editor/data-path files were not preserved');
    if (!noPhysicalDeletionAttempted) blockers.add('Q111 attempted physical legacy cursor deletion');
    if (!noRuntimeBehaviorChange) blockers.add('Q111 attempted runtime editor behavior change');
    if (!noFakeEvidence) blockers.add('runtime/smoke/device evidence was faked');
    if (!manualReviewCompleted) blockers.add('manual cleanup inventory review is missing');
    if (!explicitCleanupApprovalApproved) blockers.add('explicit Q112 cleanup approval is missing');

    final packageSidePlanningReady = inventoryManifestPresent &&
        inventoryHasRequiredCategories &&
        protectedSurfacesUnchanged &&
        rollbackFilesPreserved &&
        dataPathFilesPreserved &&
        noPhysicalDeletionAttempted &&
        noRuntimeBehaviorChange &&
        noFakeEvidence;
    final evidenceCompleteForCleanupExecutionReview = packageSidePlanningReady &&
        q110RetirementGateReadyForReview &&
        q109ConditionalActivationReadyForReview &&
        q108RealDeviceCursorCourtPassed &&
        flutterAnalyzePassed &&
        flutterTestPassed &&
        manualReviewCompleted &&
        explicitCleanupApprovalApproved;

    return LegacyCursorPhysicalCleanupPlanningReadiness(
      status: evidenceCompleteForCleanupExecutionReview
          ? 'LEGACY_CURSOR_PHYSICAL_CLEANUP_READY_FOR_EXPLICIT_Q112_REVIEW'
          : packageSidePlanningReady
              ? 'LEGACY_CURSOR_PHYSICAL_CLEANUP_PLANNING_PACKAGE_READY_BUT_EVIDENCE_BLOCKED'
              : 'BLOCKED_LEGACY_CURSOR_PHYSICAL_CLEANUP_PLANNING',
      blockers: blockers,
      packageSidePlanningReady: packageSidePlanningReady,
      evidenceCompleteForCleanupExecutionReview: evidenceCompleteForCleanupExecutionReview,
      inventoryManifest: inventoryManifest,
      actualPhysicalCleanupImplementedInThisPackage: false,
      mayDeleteLegacyCursorNow: false,
      mayExecuteCleanupInLaterReviewedQ112: evidenceCompleteForCleanupExecutionReview,
      protectedUiSurfaceMutationAllowed: false,
      cursorPassClaimAllowedInThisPackage: false,
    );
  }
}

class LegacyCursorPhysicalCleanupPlanningReadiness {
  const LegacyCursorPhysicalCleanupPlanningReadiness({
    required this.status,
    required this.blockers,
    required this.packageSidePlanningReady,
    required this.evidenceCompleteForCleanupExecutionReview,
    required this.inventoryManifest,
    required this.actualPhysicalCleanupImplementedInThisPackage,
    required this.mayDeleteLegacyCursorNow,
    required this.mayExecuteCleanupInLaterReviewedQ112,
    required this.protectedUiSurfaceMutationAllowed,
    required this.cursorPassClaimAllowedInThisPackage,
  });

  final String status;
  final List<String> blockers;
  final bool packageSidePlanningReady;
  final bool evidenceCompleteForCleanupExecutionReview;
  final String inventoryManifest;
  final bool actualPhysicalCleanupImplementedInThisPackage;
  final bool mayDeleteLegacyCursorNow;
  final bool mayExecuteCleanupInLaterReviewedQ112;
  final bool protectedUiSurfaceMutationAllowed;
  final bool cursorPassClaimAllowedInThisPackage;

  bool get isBlocked => !evidenceCompleteForCleanupExecutionReview;
}
