import 'legacy_cursor_physical_cleanup_planning_gate_policy.dart';

/// V172-Q122 — Legacy Cursor Physical Cleanup Execution Guard.
///
/// Guard-only phase. No files are deleted, no legacy main-path retirement is
/// executed, and MathLive is not switched into the main/default editor path.
class LegacyCursorPhysicalCleanupExecutionGuardV172Q122Policy {
  const LegacyCursorPhysicalCleanupExecutionGuardV172Q122Policy._();

  static const String phase = 'V172-Q122';
  static const String prerequisitePlanningPhase = LegacyCursorPhysicalCleanupPlanningGatePolicy.phase;
  static const String verifierScript = 'tool/verify_legacy_cursor_physical_cleanup_execution_guard_v172_q122.mjs';
  static const String reportJson = 'tool/reports/legacy_cursor_physical_cleanup_execution_guard_v172_q122_report.json';
  static const String selectedDefaultEngine = 'legacyFlutterSlotEditor';
  static const String candidateEngine = 'mathlive';
  static const String rollbackEngine = 'legacyFlutterSlotEditor';

  static const bool executionGuardOnly = true;
  static const bool physicalCleanupExecutedInThisPackage = false;
  static const bool legacyCursorPhysicalDeletionImplementedInThisPackage = false;
  static const bool legacyMainPathRetirementImplementedInThisPackage = false;
  static const bool mathLiveDefaultSwitchImplementedInThisPackage = false;
  static const bool mainWorkspaceMountImplementedInThisPackage = false;
  static const bool q121PlanningPackageReadyRequired = true;
  static const bool q121PlanningEvidenceRequired = true;
  static const bool q121HumanReviewRequired = true;
  static const bool explicitPhysicalCleanupExecutionApprovalRequired = true;
  static const bool flutterAnalyzeRequired = true;
  static const bool flutterTestRequired = true;
  static const bool labDeviceRunRequired = true;
  static const bool mainDeviceRunRequired = true;
  static const bool graphRuntimeEvidenceRequired = true;
  static const bool historyRuntimeEvidenceRequired = true;
  static const bool solutionRuntimeEvidenceRequired = true;
  static const bool postActivationSoakRequired = true;
  static const bool cleanupDeltaManifestRequiredForLaterPhase = true;
  static const bool rollbackVerificationRequired = true;
  static const bool protectedSurfaceHashVerificationRequired = true;
  static const bool keyboardMutationAllowed = false;
  static const bool moreMutationAllowed = false;
  static const bool longPressMutationAllowed = false;
  static const bool appShellMutationAllowed = false;
  static const bool graphHistorySolutionUiMutationAllowed = false;
  static const bool protectedUiSurfaceMutationAllowed = false;
  static const bool fakeRuntimeEvidenceAllowed = false;
  static const bool fakeDeviceEvidenceAllowed = false;
  static const bool fakeExecutionApprovalAllowed = false;
  static const bool cursorPassClaimAllowedInThisPackage = false;
  static const bool releasePassClaimAllowedInThisPackage = false;

  static LegacyCursorPhysicalCleanupExecutionGuardV172Q122Readiness evaluateReadiness({
    required bool q121PlanningPackageReady,
    required bool q121PlanningEvidenceComplete,
    required bool q121HumanReviewApproved,
    required bool explicitPhysicalCleanupExecutionApproval,
    required bool flutterAnalyzePassed,
    required bool flutterTestPassed,
    required bool labDeviceRunCaptured,
    required bool mainDeviceRunCaptured,
    required bool graphRuntimeEvidencePassed,
    required bool historyRuntimeEvidencePassed,
    required bool solutionRuntimeEvidencePassed,
    required bool postActivationSoakPassed,
    required bool cleanupDeltaManifestPrepared,
    required bool protectedSurfacesUnchanged,
    required bool keyboardUntouched,
    required bool moreUntouched,
    required bool longPressUntouched,
    required bool appShellUntouched,
    required bool graphHistorySolutionUiUntouched,
    required bool rollbackFilesPreserved,
    required bool sharedEditorDataPathPreserved,
    required bool noDefaultEditorSwitchInThisPackage,
    required bool noMainWorkspaceMountInThisPackage,
    required bool noLegacyRetirementInThisPackage,
    required bool noPhysicalLegacyDeletionInThisPackage,
    required bool noRuntimeBehaviorChangeInThisPackage,
    required bool noFakeRuntimeEvidence,
    required bool noFakeDeviceEvidence,
    required bool noFakeExecutionApproval,
  }) {
    final blockers = <String>[];
    if (!q121PlanningPackageReady) blockers.add('Q121 cleanup planning gate package is not ready');
    if (!q121PlanningEvidenceComplete) blockers.add('Q121 cleanup planning evidence is not complete');
    if (!q121HumanReviewApproved) blockers.add('Q121 human review approval is missing');
    if (!explicitPhysicalCleanupExecutionApproval) blockers.add('explicit Q122 physical cleanup execution approval is missing');
    if (!flutterAnalyzePassed) blockers.add('flutter analyze PASS evidence is missing');
    if (!flutterTestPassed) blockers.add('flutter test PASS evidence is missing');
    if (!labDeviceRunCaptured) blockers.add('MathLive Lab real-device run evidence is missing');
    if (!mainDeviceRunCaptured) blockers.add('main app real-device run evidence is missing');
    if (!graphRuntimeEvidencePassed) blockers.add('Graph runtime evidence is missing');
    if (!historyRuntimeEvidencePassed) blockers.add('History runtime evidence is missing');
    if (!solutionRuntimeEvidencePassed) blockers.add('Solution runtime evidence is missing');
    if (!postActivationSoakPassed) blockers.add('post-activation soak evidence is missing');
    if (!cleanupDeltaManifestPrepared) blockers.add('cleanup delta manifest is not prepared');
    if (!protectedSurfacesUnchanged) blockers.add('protected UI surfaces changed');
    if (!rollbackFilesPreserved) blockers.add('legacy rollback files were not preserved');
    if (!sharedEditorDataPathPreserved) blockers.add('shared editor/data-path files were not preserved');
    if (!noDefaultEditorSwitchInThisPackage) blockers.add('Q122 attempted default editor switch');
    if (!noMainWorkspaceMountInThisPackage) blockers.add('Q122 attempted main workspace mount');
    if (!noLegacyRetirementInThisPackage) blockers.add('Q122 attempted legacy main-path retirement');
    if (!noPhysicalLegacyDeletionInThisPackage) blockers.add('Q122 attempted physical legacy cursor deletion');
    if (!noRuntimeBehaviorChangeInThisPackage) blockers.add('Q122 attempted runtime behavior change');
    if (!noFakeRuntimeEvidence) blockers.add('runtime evidence was faked');
    if (!noFakeDeviceEvidence) blockers.add('device evidence was faked');
    if (!noFakeExecutionApproval) blockers.add('physical cleanup execution approval was faked');

    final packageSideExecutionGuardReady = q121PlanningPackageReady &&
        protectedSurfacesUnchanged &&
        keyboardUntouched &&
        moreUntouched &&
        longPressUntouched &&
        appShellUntouched &&
        graphHistorySolutionUiUntouched &&
        rollbackFilesPreserved &&
        sharedEditorDataPathPreserved &&
        noDefaultEditorSwitchInThisPackage &&
        noMainWorkspaceMountInThisPackage &&
        noLegacyRetirementInThisPackage &&
        noPhysicalLegacyDeletionInThisPackage &&
        noRuntimeBehaviorChangeInThisPackage &&
        noFakeRuntimeEvidence &&
        noFakeDeviceEvidence &&
        noFakeExecutionApproval;

    final executionEvidenceComplete = q121PlanningPackageReady &&
        q121PlanningEvidenceComplete &&
        q121HumanReviewApproved &&
        explicitPhysicalCleanupExecutionApproval &&
        flutterAnalyzePassed &&
        flutterTestPassed &&
        labDeviceRunCaptured &&
        mainDeviceRunCaptured &&
        graphRuntimeEvidencePassed &&
        historyRuntimeEvidencePassed &&
        solutionRuntimeEvidencePassed &&
        postActivationSoakPassed &&
        cleanupDeltaManifestPrepared &&
        packageSideExecutionGuardReady;

    return LegacyCursorPhysicalCleanupExecutionGuardV172Q122Readiness(
      packageSideExecutionGuardReady: packageSideExecutionGuardReady,
      executionEvidenceComplete: executionEvidenceComplete,
      mayExecutePhysicalCleanupReview: executionEvidenceComplete,
      mayDeleteLegacyCursorNow: false,
      mayRetireLegacyMainPathNow: false,
      maySwitchDefaultEditorNow: false,
      mayClaimCursorPass: false,
      mayClaimReleasePass: false,
      protectedUiSurfaceMutationAllowed: false,
      blockers: blockers,
    );
  }
}

class LegacyCursorPhysicalCleanupExecutionGuardV172Q122Readiness {
  const LegacyCursorPhysicalCleanupExecutionGuardV172Q122Readiness({
    required this.packageSideExecutionGuardReady,
    required this.executionEvidenceComplete,
    required this.mayExecutePhysicalCleanupReview,
    required this.mayDeleteLegacyCursorNow,
    required this.mayRetireLegacyMainPathNow,
    required this.maySwitchDefaultEditorNow,
    required this.mayClaimCursorPass,
    required this.mayClaimReleasePass,
    required this.protectedUiSurfaceMutationAllowed,
    required this.blockers,
  });

  final bool packageSideExecutionGuardReady;
  final bool executionEvidenceComplete;
  final bool mayExecutePhysicalCleanupReview;
  final bool mayDeleteLegacyCursorNow;
  final bool mayRetireLegacyMainPathNow;
  final bool maySwitchDefaultEditorNow;
  final bool mayClaimCursorPass;
  final bool mayClaimReleasePass;
  final bool protectedUiSurfaceMutationAllowed;
  final List<String> blockers;

  String get status => executionEvidenceComplete
      ? 'Q122_LEGACY_CURSOR_PHYSICAL_CLEANUP_EXECUTION_READY_FOR_HUMAN_APPROVAL'
      : packageSideExecutionGuardReady
          ? 'Q122_LEGACY_CURSOR_PHYSICAL_CLEANUP_EXECUTION_GUARD_PACKAGE_READY_BUT_EVIDENCE_BLOCKED'
          : 'BLOCKED_Q122_LEGACY_CURSOR_PHYSICAL_CLEANUP_EXECUTION_GUARD';
}
