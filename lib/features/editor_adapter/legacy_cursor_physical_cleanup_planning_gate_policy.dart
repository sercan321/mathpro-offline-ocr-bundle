import 'legacy_main_path_retirement_review_gate_policy.dart';

/// V172-Q121 — Legacy Cursor Physical Cleanup Planning Gate.
///
/// Q121 is not physical cleanup and not legacy cursor deletion. It is a
/// post-Q120 planning gate that blocks any cleanup-manifest review unless the
/// legacy main-path retirement review evidence is complete, human-reviewed,
/// explicitly approved, and the legacy rollback path is still intact.
class LegacyCursorPhysicalCleanupPlanningGatePolicy {
  const LegacyCursorPhysicalCleanupPlanningGatePolicy._();

  static const String phase = 'V172-Q121';
  static const String prerequisiteRetirementReviewPhase = LegacyMainPathRetirementReviewGatePolicy.phase;
  static const String verifierScript = 'tool/verify_legacy_cursor_physical_cleanup_planning_gate.mjs';
  static const String reportJson = 'tool/reports/legacy_cursor_physical_cleanup_planning_gate_report.json';
  static const String reportMarkdown = 'tool/reports/legacy_cursor_physical_cleanup_planning_gate_report.md';
  static const String planningDraftJson = 'docs/audit/V172_Q121_LEGACY_CURSOR_PHYSICAL_CLEANUP_PLANNING_DRAFT.json';
  static const String selectedDefaultEngine = 'legacyFlutterSlotEditor';
  static const String candidateEngine = 'mathlive';
  static const String rollbackEngine = 'legacyFlutterSlotEditor';

  static const bool planningGateOnly = true;
  static const bool physicalCleanupImplementedInThisPackage = false;
  static const bool legacyCursorPhysicalDeletionImplementedInThisPackage = false;
  static const bool legacyMainPathRetirementImplementedInThisPackage = false;
  static const bool mathLiveDefaultSwitchImplementedInThisPackage = false;
  static const bool mainWorkspaceMountImplementedInThisPackage = false;
  static const bool q120RetirementReviewEvidenceRequired = true;
  static const bool q120HumanReviewRequired = true;
  static const bool explicitPhysicalCleanupPlanningApprovalRequired = true;
  static const bool cleanupExecutionApprovalRequiredForLaterPhase = true;
  static const bool flutterAnalyzeRequired = true;
  static const bool flutterTestRequired = true;
  static const bool labDeviceRunRequired = true;
  static const bool mainDeviceRunRequired = true;
  static const bool graphRuntimeEvidenceRequired = true;
  static const bool historyRuntimeEvidenceRequired = true;
  static const bool solutionRuntimeEvidenceRequired = true;
  static const bool postActivationSoakRequired = true;
  static const bool legacyRollbackRequired = true;
  static const bool protectedInventoryRequired = true;
  static const bool rollbackInventoryRequired = true;
  static const bool dataPathInventoryRequired = true;
  static const bool cleanupCandidateInventoryRequired = true;
  static const bool manualReviewInventoryRequired = true;
  static const bool keyboardMutationAllowed = false;
  static const bool moreMutationAllowed = false;
  static const bool longPressMutationAllowed = false;
  static const bool appShellMutationAllowed = false;
  static const bool graphHistorySolutionUiMutationAllowed = false;
  static const bool protectedUiSurfaceMutationAllowed = false;
  static const bool fakeRuntimeEvidenceAllowed = false;
  static const bool fakeDeviceEvidenceAllowed = false;
  static const bool fakePlanningApprovalAllowed = false;
  static const bool cursorPassClaimAllowedInThisPackage = false;
  static const bool releasePassClaimAllowedInThisPackage = false;

  static const List<String> requiredPlanningCategories = <String>[
    'mustKeepProtectedSurface',
    'mustKeepRollbackUntilPostCleanupRegression',
    'mustKeepSharedEditorDataPath',
    'cleanupCandidateAfterExplicitExecutionApproval',
    'manualReviewRequiredBeforeDeletion',
  ];

  static const List<String> protectedSurfaces = <String>[
    'lib/features/keyboard/key_config.dart',
    'lib/features/keyboard/math_keyboard.dart',
    'lib/features/keyboard/bottom_dock.dart',
    'lib/features/keyboard/long_press_popup.dart',
    'lib/features/keyboard/premium_key.dart',
    'lib/features/workspace/math_label.dart',
    'lib/features/workspace/template_tray.dart',
    'lib/app/app_shell.dart',
    'lib/features/solution/solution_steps_panel.dart',
    'lib/features/graph/graph_card.dart',
    'lib/features/history/history_controller.dart',
    'lib/features/history/history_panel.dart',
  ];

  static const List<String> requiredPlanningCommands = <String>[
    'flutter pub get',
    'flutter analyze',
    'flutter test',
    'node tool/install_mathlive_runtime.mjs',
    'node tool/verify_mathlive_runtime.mjs',
    'node tool/verify_mathlive_official_runtime_bundle.mjs',
    'node tool/verify_mathlive_lab_smoke_evidence_closure.mjs',
    'node tool/verify_mathlive_post_q115_cursor_court_rerun.mjs',
    'node tool/verify_mathlive_main_editor_switch_preflight_gate.mjs',
    'node tool/verify_mathlive_main_editor_activation_dry_run_gate.mjs',
    'node tool/verify_mathlive_graph_history_solution_runtime_binding_gate.mjs',
    'node tool/verify_legacy_main_path_retirement_review_gate.mjs',
    'node tool/verify_legacy_cursor_physical_cleanup_planning_gate.mjs',
    'flutter run -t lib/main_mathlive_lab.dart -d 23106RN0DA',
    'flutter run -d 23106RN0DA',
  ];

  static LegacyCursorPhysicalCleanupPlanningGateReadiness evaluateReadiness({
    required bool q120RetirementReviewPackageReady,
    required bool q120RetirementReviewEvidenceComplete,
    required bool q120HumanReviewApproved,
    required bool explicitPhysicalCleanupPlanningApproval,
    required bool flutterAnalyzePassed,
    required bool flutterTestPassed,
    required bool labDeviceRunCaptured,
    required bool mainDeviceRunCaptured,
    required bool graphRuntimeEvidencePassed,
    required bool historyRuntimeEvidencePassed,
    required bool solutionRuntimeEvidencePassed,
    required bool postActivationSoakPassed,
    required bool planningDraftPresent,
    required bool planningDraftHasRequiredCategories,
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
    required bool noFakePlanningApproval,
  }) {
    final blockers = <String>[];
    if (!q120RetirementReviewPackageReady) blockers.add('Q120 retirement review gate package is not ready');
    if (!q120RetirementReviewEvidenceComplete) blockers.add('Q120 retirement review evidence is not complete');
    if (!q120HumanReviewApproved) blockers.add('Q120 human review approval is missing');
    if (!explicitPhysicalCleanupPlanningApproval) blockers.add('explicit Q121 physical cleanup planning approval is missing');
    if (!flutterAnalyzePassed) blockers.add('flutter analyze PASS evidence is missing');
    if (!flutterTestPassed) blockers.add('flutter test PASS evidence is missing');
    if (!labDeviceRunCaptured) blockers.add('MathLive Lab real-device run evidence is missing');
    if (!mainDeviceRunCaptured) blockers.add('main app real-device run evidence is missing');
    if (!graphRuntimeEvidencePassed) blockers.add('Graph runtime evidence is missing');
    if (!historyRuntimeEvidencePassed) blockers.add('History runtime evidence is missing');
    if (!solutionRuntimeEvidencePassed) blockers.add('Solution runtime evidence is missing');
    if (!postActivationSoakPassed) blockers.add('post-activation soak evidence is missing');
    if (!planningDraftPresent) blockers.add('Q121 cleanup planning draft is missing');
    if (!planningDraftHasRequiredCategories) blockers.add('Q121 cleanup planning categories are incomplete');
    if (!protectedSurfacesUnchanged) blockers.add('protected UI surfaces changed');
    if (!keyboardUntouched) blockers.add('keyboard source changed');
    if (!moreUntouched) blockers.add('MORE source changed');
    if (!longPressUntouched) blockers.add('long-press source changed');
    if (!appShellUntouched) blockers.add('app_shell.dart changed');
    if (!graphHistorySolutionUiUntouched) blockers.add('Graph/History/Solution UI changed');
    if (!rollbackFilesPreserved) blockers.add('legacy rollback files were not preserved');
    if (!sharedEditorDataPathPreserved) blockers.add('shared editor/data-path files were not preserved');
    if (!noDefaultEditorSwitchInThisPackage) blockers.add('Q121 attempted default editor switch');
    if (!noMainWorkspaceMountInThisPackage) blockers.add('Q121 attempted main workspace mount');
    if (!noLegacyRetirementInThisPackage) blockers.add('Q121 attempted legacy main-path retirement');
    if (!noPhysicalLegacyDeletionInThisPackage) blockers.add('Q121 attempted physical legacy cursor deletion');
    if (!noRuntimeBehaviorChangeInThisPackage) blockers.add('Q121 attempted runtime behavior change');
    if (!noFakeRuntimeEvidence) blockers.add('runtime evidence was faked');
    if (!noFakeDeviceEvidence) blockers.add('device evidence was faked');
    if (!noFakePlanningApproval) blockers.add('cleanup planning approval was faked');

    final packageSidePlanningReady = q120RetirementReviewPackageReady &&
        planningDraftPresent &&
        planningDraftHasRequiredCategories &&
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
        noFakePlanningApproval;

    final planningEvidenceComplete = packageSidePlanningReady &&
        q120RetirementReviewEvidenceComplete &&
        q120HumanReviewApproved &&
        explicitPhysicalCleanupPlanningApproval &&
        flutterAnalyzePassed &&
        flutterTestPassed &&
        labDeviceRunCaptured &&
        mainDeviceRunCaptured &&
        graphRuntimeEvidencePassed &&
        historyRuntimeEvidencePassed &&
        solutionRuntimeEvidencePassed &&
        postActivationSoakPassed;

    return LegacyCursorPhysicalCleanupPlanningGateReadiness(
      status: planningEvidenceComplete
          ? 'Q121_LEGACY_CURSOR_PHYSICAL_CLEANUP_PLANNING_READY_FOR_HUMAN_APPROVAL'
          : packageSidePlanningReady
              ? 'Q121_LEGACY_CURSOR_PHYSICAL_CLEANUP_PLANNING_PACKAGE_READY_BUT_EVIDENCE_BLOCKED'
              : 'BLOCKED_Q121_LEGACY_CURSOR_PHYSICAL_CLEANUP_PLANNING_GATE',
      blockers: blockers,
      packageSidePlanningReady: packageSidePlanningReady,
      planningEvidenceComplete: planningEvidenceComplete,
      planningDraftJson: planningDraftJson,
      selectedDefaultEngine: selectedDefaultEngine,
      candidateEngine: candidateEngine,
      rollbackEngine: rollbackEngine,
      mayProceedToPhysicalCleanupExecutionReview: planningEvidenceComplete,
      mayDeleteLegacyCursorNow: false,
      mayRetireLegacyMainPathNow: false,
      maySwitchDefaultEditorNow: false,
      mayMountMathLiveInMainWorkspaceNow: false,
      mayClaimCursorPass: false,
      mayClaimReleasePass: false,
      protectedUiSurfaceMutationAllowed: false,
    );
  }
}

class LegacyCursorPhysicalCleanupPlanningGateReadiness {
  const LegacyCursorPhysicalCleanupPlanningGateReadiness({
    required this.status,
    required this.blockers,
    required this.packageSidePlanningReady,
    required this.planningEvidenceComplete,
    required this.planningDraftJson,
    required this.selectedDefaultEngine,
    required this.candidateEngine,
    required this.rollbackEngine,
    required this.mayProceedToPhysicalCleanupExecutionReview,
    required this.mayDeleteLegacyCursorNow,
    required this.mayRetireLegacyMainPathNow,
    required this.maySwitchDefaultEditorNow,
    required this.mayMountMathLiveInMainWorkspaceNow,
    required this.mayClaimCursorPass,
    required this.mayClaimReleasePass,
    required this.protectedUiSurfaceMutationAllowed,
  });

  final String status;
  final List<String> blockers;
  final bool packageSidePlanningReady;
  final bool planningEvidenceComplete;
  final String planningDraftJson;
  final String selectedDefaultEngine;
  final String candidateEngine;
  final String rollbackEngine;
  final bool mayProceedToPhysicalCleanupExecutionReview;
  final bool mayDeleteLegacyCursorNow;
  final bool mayRetireLegacyMainPathNow;
  final bool maySwitchDefaultEditorNow;
  final bool mayMountMathLiveInMainWorkspaceNow;
  final bool mayClaimCursorPass;
  final bool mayClaimReleasePass;
  final bool protectedUiSurfaceMutationAllowed;

  bool get isBlocked => !planningEvidenceComplete;
}
