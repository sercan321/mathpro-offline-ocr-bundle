import '../mathlive/mathlive_main_editor_switch_conditional_activation_policy.dart';

/// V172-Q110 — Legacy Cursor Main Path Retirement Actual Gate.
///
/// Q110 is a hard pre-retirement gate only. It does not retire the legacy
/// cursor main path, does not switch MathLive into the default editor path, and
/// does not delete any legacy cursor file. It records the exact evidence that
/// must be present before a later phase may perform the actual main-path
/// retirement review.
class LegacyCursorMainPathRetirementActualGatePolicy {
  const LegacyCursorMainPathRetirementActualGatePolicy._();

  static const String phase = 'V172-Q110';
  static const String verifierScript = 'tool/verify_legacy_cursor_main_path_retirement_actual_gate.mjs';
  static const String reportJson = 'tool/reports/legacy_cursor_main_path_retirement_actual_gate_report.json';
  static const String reportMarkdown = 'tool/reports/legacy_cursor_main_path_retirement_actual_gate_report.md';
  static const String defaultEngine = 'legacyFlutterSlotEditor';
  static const String candidateEngine = 'mathlive';
  static const String rollbackEngine = 'legacyFlutterSlotEditor';
  static const String q109ConditionalActivationPhase = MathLiveMainEditorSwitchConditionalActivationPolicy.phase;

  static const bool actualLegacyMainPathRetirementImplementedInThisPackage = false;
  static const bool mathLiveDefaultSwitchImplementedInThisPackage = false;
  static const bool mainWorkspaceMountImplementedInThisPackage = false;
  static const bool legacyCursorDeletionAllowed = false;
  static const bool legacyRollbackRequired = true;
  static const bool q109ConditionalActivationRequired = true;
  static const bool q108RealDeviceCursorCourtRequired = true;
  static const bool flutterAnalyzeRequired = true;
  static const bool flutterTestRequired = true;
  static const bool explicitRetirementApprovalRequired = true;
  static const bool postActivationSoakRequired = true;
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

  static LegacyCursorMainPathRetirementActualGateReadiness evaluateReadiness({
    required bool q109ConditionalActivationReadyForReview,
    required bool mathLiveMainEditorActivatedBehindInternalFlag,
    required bool q108RealDeviceCursorCourtPassed,
    required bool flutterAnalyzePassed,
    required bool flutterTestPassed,
    required bool graphAdapterReady,
    required bool historyAdapterReady,
    required bool solutionAdapterReady,
    required bool legacyRollbackAvailable,
    required bool postActivationSoakPassed,
    required bool explicitRetirementApprovalApproved,
    required bool protectedSurfacesUnchanged,
    required bool keyboardUntouched,
    required bool moreUntouched,
    required bool longPressUntouched,
    required bool appShellUntouched,
    required bool graphHistorySolutionUiUntouched,
    required bool noFakeEvidence,
    required bool noActualRetirementInThisPackage,
    required bool noPhysicalDeletionAttempted,
  }) {
    final blockers = <String>[];
    if (!q109ConditionalActivationReadyForReview) blockers.add('Q109 conditional activation is not ready for review');
    if (!mathLiveMainEditorActivatedBehindInternalFlag) blockers.add('MathLive main editor has not been activated behind the internal flag');
    if (!q108RealDeviceCursorCourtPassed) blockers.add('Q108 real-device cursor court has not passed');
    if (!flutterAnalyzePassed) blockers.add('flutter analyze PASS evidence is missing');
    if (!flutterTestPassed) blockers.add('flutter test PASS evidence is missing');
    if (!graphAdapterReady) blockers.add('Graph adapter readiness is missing');
    if (!historyAdapterReady) blockers.add('History adapter readiness is missing');
    if (!solutionAdapterReady) blockers.add('Solution/Evaluator adapter readiness is missing');
    if (!legacyRollbackAvailable) blockers.add('legacy rollback is not available');
    if (!postActivationSoakPassed) blockers.add('post-activation soak evidence is missing');
    if (!explicitRetirementApprovalApproved) blockers.add('explicit legacy main-path retirement approval is missing');
    if (!protectedSurfacesUnchanged) blockers.add('protected UI surfaces changed');
    if (!keyboardUntouched) blockers.add('keyboard source changed');
    if (!moreUntouched) blockers.add('MORE behavior source changed');
    if (!longPressUntouched) blockers.add('long-press source changed');
    if (!appShellUntouched) blockers.add('app_shell.dart changed');
    if (!graphHistorySolutionUiUntouched) blockers.add('Graph/History/Solution UI changed');
    if (!noFakeEvidence) blockers.add('runtime/smoke/device evidence was faked');
    if (!noActualRetirementInThisPackage) blockers.add('Q110 package attempted actual legacy main-path retirement');
    if (!noPhysicalDeletionAttempted) blockers.add('Q110 package attempted physical legacy cursor deletion');

    final packageSideGateReady = graphAdapterReady &&
        historyAdapterReady &&
        solutionAdapterReady &&
        legacyRollbackAvailable &&
        protectedSurfacesUnchanged &&
        keyboardUntouched &&
        moreUntouched &&
        longPressUntouched &&
        appShellUntouched &&
        graphHistorySolutionUiUntouched &&
        noFakeEvidence &&
        noActualRetirementInThisPackage &&
        noPhysicalDeletionAttempted;
    final evidenceCompleteForLaterRetirementReview = packageSideGateReady &&
        q109ConditionalActivationReadyForReview &&
        mathLiveMainEditorActivatedBehindInternalFlag &&
        q108RealDeviceCursorCourtPassed &&
        flutterAnalyzePassed &&
        flutterTestPassed &&
        postActivationSoakPassed &&
        explicitRetirementApprovalApproved;

    return LegacyCursorMainPathRetirementActualGateReadiness(
      status: evidenceCompleteForLaterRetirementReview
          ? 'LEGACY_CURSOR_MAIN_PATH_RETIREMENT_READY_FOR_EXPLICIT_REVIEW'
          : packageSideGateReady
              ? 'LEGACY_CURSOR_MAIN_PATH_RETIREMENT_GATE_PACKAGE_READY_BUT_EVIDENCE_BLOCKED'
              : 'BLOCKED_LEGACY_CURSOR_MAIN_PATH_RETIREMENT_ACTUAL_GATE',
      blockers: blockers,
      packageSideGateReady: packageSideGateReady,
      evidenceCompleteForLaterRetirementReview: evidenceCompleteForLaterRetirementReview,
      selectedDefaultEngine: defaultEngine,
      candidateEngine: candidateEngine,
      rollbackEngine: rollbackEngine,
      actualLegacyMainPathRetirementImplementedInThisPackage: false,
      mayRetireLegacyMainPathInLaterReviewedPhase: evidenceCompleteForLaterRetirementReview,
      mayRetireLegacyMainPathNow: false,
      mayDeleteLegacyCursor: false,
      maySwitchDefaultEditorNow: false,
      protectedUiSurfaceMutationAllowed: false,
      cursorPassClaimAllowedInThisPackage: false,
    );
  }
}

class LegacyCursorMainPathRetirementActualGateReadiness {
  const LegacyCursorMainPathRetirementActualGateReadiness({
    required this.status,
    required this.blockers,
    required this.packageSideGateReady,
    required this.evidenceCompleteForLaterRetirementReview,
    required this.selectedDefaultEngine,
    required this.candidateEngine,
    required this.rollbackEngine,
    required this.actualLegacyMainPathRetirementImplementedInThisPackage,
    required this.mayRetireLegacyMainPathInLaterReviewedPhase,
    required this.mayRetireLegacyMainPathNow,
    required this.mayDeleteLegacyCursor,
    required this.maySwitchDefaultEditorNow,
    required this.protectedUiSurfaceMutationAllowed,
    required this.cursorPassClaimAllowedInThisPackage,
  });

  final String status;
  final List<String> blockers;
  final bool packageSideGateReady;
  final bool evidenceCompleteForLaterRetirementReview;
  final String selectedDefaultEngine;
  final String candidateEngine;
  final String rollbackEngine;
  final bool actualLegacyMainPathRetirementImplementedInThisPackage;
  final bool mayRetireLegacyMainPathInLaterReviewedPhase;
  final bool mayRetireLegacyMainPathNow;
  final bool mayDeleteLegacyCursor;
  final bool maySwitchDefaultEditorNow;
  final bool protectedUiSurfaceMutationAllowed;
  final bool cursorPassClaimAllowedInThisPackage;

  bool get isBlocked => !evidenceCompleteForLaterRetirementReview;
}
