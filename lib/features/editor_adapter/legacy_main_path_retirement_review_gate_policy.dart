import '../mathlive/mathlive_graph_history_solution_runtime_binding_gate_policy.dart';

/// V172-Q120 — Legacy Main Path Retirement Review Gate.
///
/// Q120 is not legacy cursor retirement, not a default editor switch, and not
/// physical cleanup. It is a review gate that blocks any legacy main-path
/// retirement discussion until Q119 Graph/History/Solution runtime binding
/// evidence, explicit human review, Flutter evidence, real-device evidence,
/// rollback evidence, and protected-surface invariants are all real.
class LegacyMainPathRetirementReviewGatePolicy {
  const LegacyMainPathRetirementReviewGatePolicy._();

  static const String phase = 'V172-Q120';
  static const String prerequisiteRuntimeBindingPhase = MathLiveGraphHistorySolutionRuntimeBindingGatePolicy.phase;
  static const String verifierScript = 'tool/verify_legacy_main_path_retirement_review_gate.mjs';
  static const String reportJson = 'tool/reports/legacy_main_path_retirement_review_gate_report.json';
  static const String reportMarkdown = 'tool/reports/legacy_main_path_retirement_review_gate_report.md';
  static const String captureJson = 'tool/reports/legacy_main_path_retirement_review_gate_capture.json';
  static const String selectedDefaultEngine = 'legacyFlutterSlotEditor';
  static const String candidateEngine = 'mathlive';
  static const String rollbackEngine = 'legacyFlutterSlotEditor';

  static const bool reviewGateOnly = true;
  static const bool actualLegacyMainPathRetirementImplementedInThisPackage = false;
  static const bool legacyCursorPhysicalDeletionImplementedInThisPackage = false;
  static const bool mathLiveDefaultSwitchImplementedInThisPackage = false;
  static const bool mainWorkspaceMountImplementedInThisPackage = false;
  static const bool legacyRollbackRequired = true;
  static const bool q119RuntimeBindingEvidenceRequired = true;
  static const bool q119HumanReviewRequired = true;
  static const bool explicitRetirementReviewApprovalRequired = true;
  static const bool flutterAnalyzeRequired = true;
  static const bool flutterTestRequired = true;
  static const bool labDeviceRunRequired = true;
  static const bool mainDeviceRunRequired = true;
  static const bool postActivationSoakRequired = true;
  static const bool graphRuntimeEvidenceRequired = true;
  static const bool historyRuntimeEvidenceRequired = true;
  static const bool solutionRuntimeEvidenceRequired = true;
  static const bool keyboardMutationAllowed = false;
  static const bool moreMutationAllowed = false;
  static const bool longPressMutationAllowed = false;
  static const bool appShellMutationAllowed = false;
  static const bool graphHistorySolutionUiMutationAllowed = false;
  static const bool protectedUiSurfaceMutationAllowed = false;
  static const bool fakeRuntimeEvidenceAllowed = false;
  static const bool fakeSmokeEvidenceAllowed = false;
  static const bool fakeDeviceEvidenceAllowed = false;
  static const bool fakeRetirementApprovalAllowed = false;
  static const bool cursorPassClaimAllowedInThisPackage = false;
  static const bool releasePassClaimAllowedInThisPackage = false;

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

  static const List<String> requiredReviewCommands = <String>[
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
    'flutter run -t lib/main_mathlive_lab.dart -d 23106RN0DA',
    'flutter run -d 23106RN0DA',
  ];

  static LegacyMainPathRetirementReviewReadiness evaluateReadiness({
    required bool q119RuntimeBindingPackageReady,
    required bool q119RuntimeBindingEvidenceComplete,
    required bool q119HumanReviewApproved,
    required bool explicitRetirementReviewApproval,
    required bool flutterAnalyzePassed,
    required bool flutterTestPassed,
    required bool labDeviceRunCaptured,
    required bool mainDeviceRunCaptured,
    required bool graphRuntimeEvidencePassed,
    required bool historyRuntimeEvidencePassed,
    required bool solutionRuntimeEvidencePassed,
    required bool postActivationSoakPassed,
    required bool protectedSurfacesUnchanged,
    required bool keyboardUntouched,
    required bool moreUntouched,
    required bool longPressUntouched,
    required bool appShellUntouched,
    required bool graphHistorySolutionUiUntouched,
    required bool legacyRollbackAvailable,
    required bool noDefaultEditorSwitchInThisPackage,
    required bool noMainWorkspaceMountInThisPackage,
    required bool noActualLegacyRetirementInThisPackage,
    required bool noPhysicalLegacyDeletionInThisPackage,
    required bool noFakeRuntimeEvidence,
    required bool noFakeDeviceEvidence,
    required bool noFakeRetirementApproval,
  }) {
    final blockers = <String>[];
    if (!q119RuntimeBindingPackageReady) blockers.add('Q119 runtime binding gate package is not ready');
    if (!q119RuntimeBindingEvidenceComplete) blockers.add('Q119 runtime binding evidence is not complete');
    if (!q119HumanReviewApproved) blockers.add('Q119 human review approval is missing');
    if (!explicitRetirementReviewApproval) blockers.add('explicit Q120 legacy main-path retirement review approval is missing');
    if (!flutterAnalyzePassed) blockers.add('flutter analyze PASS evidence is missing');
    if (!flutterTestPassed) blockers.add('flutter test PASS evidence is missing');
    if (!labDeviceRunCaptured) blockers.add('MathLive Lab real-device run evidence is missing');
    if (!mainDeviceRunCaptured) blockers.add('main app real-device run evidence is missing');
    if (!graphRuntimeEvidencePassed) blockers.add('Graph runtime evidence is missing');
    if (!historyRuntimeEvidencePassed) blockers.add('History runtime evidence is missing');
    if (!solutionRuntimeEvidencePassed) blockers.add('Solution runtime evidence is missing');
    if (!postActivationSoakPassed) blockers.add('post-activation soak evidence is missing');
    if (!protectedSurfacesUnchanged) blockers.add('protected UI surfaces changed');
    if (!keyboardUntouched) blockers.add('keyboard source changed');
    if (!moreUntouched) blockers.add('MORE source changed');
    if (!longPressUntouched) blockers.add('long-press source changed');
    if (!appShellUntouched) blockers.add('app_shell.dart changed');
    if (!graphHistorySolutionUiUntouched) blockers.add('Graph/History/Solution UI changed');
    if (!legacyRollbackAvailable) blockers.add('legacy rollback is not available');
    if (!noDefaultEditorSwitchInThisPackage) blockers.add('Q120 package attempted default editor switch');
    if (!noMainWorkspaceMountInThisPackage) blockers.add('Q120 package attempted main workspace mount');
    if (!noActualLegacyRetirementInThisPackage) blockers.add('Q120 package attempted actual legacy main-path retirement');
    if (!noPhysicalLegacyDeletionInThisPackage) blockers.add('Q120 package attempted physical legacy cursor deletion');
    if (!noFakeRuntimeEvidence) blockers.add('runtime evidence was faked');
    if (!noFakeDeviceEvidence) blockers.add('device evidence was faked');
    if (!noFakeRetirementApproval) blockers.add('retirement review approval was faked');

    final packageSideGateReady = q119RuntimeBindingPackageReady &&
        protectedSurfacesUnchanged &&
        keyboardUntouched &&
        moreUntouched &&
        longPressUntouched &&
        appShellUntouched &&
        graphHistorySolutionUiUntouched &&
        legacyRollbackAvailable &&
        noDefaultEditorSwitchInThisPackage &&
        noMainWorkspaceMountInThisPackage &&
        noActualLegacyRetirementInThisPackage &&
        noPhysicalLegacyDeletionInThisPackage &&
        noFakeRuntimeEvidence &&
        noFakeDeviceEvidence &&
        noFakeRetirementApproval;

    final reviewEvidenceComplete = packageSideGateReady &&
        q119RuntimeBindingEvidenceComplete &&
        q119HumanReviewApproved &&
        explicitRetirementReviewApproval &&
        flutterAnalyzePassed &&
        flutterTestPassed &&
        labDeviceRunCaptured &&
        mainDeviceRunCaptured &&
        graphRuntimeEvidencePassed &&
        historyRuntimeEvidencePassed &&
        solutionRuntimeEvidencePassed &&
        postActivationSoakPassed;

    return LegacyMainPathRetirementReviewReadiness(
      status: reviewEvidenceComplete
          ? 'Q120_LEGACY_MAIN_PATH_RETIREMENT_REVIEW_READY_FOR_HUMAN_APPROVAL'
          : packageSideGateReady
              ? 'Q120_LEGACY_MAIN_PATH_RETIREMENT_REVIEW_PACKAGE_READY_BUT_EVIDENCE_BLOCKED'
              : 'BLOCKED_Q120_LEGACY_MAIN_PATH_RETIREMENT_REVIEW_GATE',
      blockers: blockers,
      packageSideGateReady: packageSideGateReady,
      reviewEvidenceComplete: reviewEvidenceComplete,
      selectedDefaultEngine: selectedDefaultEngine,
      candidateEngine: candidateEngine,
      rollbackEngine: rollbackEngine,
      mayRetireLegacyMainPathNow: false,
      mayDeleteLegacyCursor: false,
      maySwitchDefaultEditorNow: false,
      mayMountMathLiveInMainWorkspaceNow: false,
      mayProceedToPhysicalCleanupPlanning: reviewEvidenceComplete,
      protectedUiSurfaceMutationAllowed: false,
      cursorPassClaimAllowedInThisPackage: false,
      releasePassClaimAllowedInThisPackage: false,
    );
  }
}

class LegacyMainPathRetirementReviewReadiness {
  const LegacyMainPathRetirementReviewReadiness({
    required this.status,
    required this.blockers,
    required this.packageSideGateReady,
    required this.reviewEvidenceComplete,
    required this.selectedDefaultEngine,
    required this.candidateEngine,
    required this.rollbackEngine,
    required this.mayRetireLegacyMainPathNow,
    required this.mayDeleteLegacyCursor,
    required this.maySwitchDefaultEditorNow,
    required this.mayMountMathLiveInMainWorkspaceNow,
    required this.mayProceedToPhysicalCleanupPlanning,
    required this.protectedUiSurfaceMutationAllowed,
    required this.cursorPassClaimAllowedInThisPackage,
    required this.releasePassClaimAllowedInThisPackage,
  });

  final String status;
  final List<String> blockers;
  final bool packageSideGateReady;
  final bool reviewEvidenceComplete;
  final String selectedDefaultEngine;
  final String candidateEngine;
  final String rollbackEngine;
  final bool mayRetireLegacyMainPathNow;
  final bool mayDeleteLegacyCursor;
  final bool maySwitchDefaultEditorNow;
  final bool mayMountMathLiveInMainWorkspaceNow;
  final bool mayProceedToPhysicalCleanupPlanning;
  final bool protectedUiSurfaceMutationAllowed;
  final bool cursorPassClaimAllowedInThisPackage;
  final bool releasePassClaimAllowedInThisPackage;

  bool get isBlocked => !reviewEvidenceComplete;
}
