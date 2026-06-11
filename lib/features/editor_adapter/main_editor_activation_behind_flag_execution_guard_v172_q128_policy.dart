/// V172-Q128 — Main Editor Activation Behind Flag Execution Guard.
///
/// Guard-only batch phase. It does not switch MathLive into the main/default
/// editor, does not delete or retire the legacy cursor path, does not mutate
/// protected keyboard/MORE/long-press/AppShell/Graph/History/Solution surfaces,
/// and does not claim cursor/device/release PASS without real user-side evidence.
class MainEditorActivationBehindFlagExecutionGuardV172Q128Policy {
  const MainEditorActivationBehindFlagExecutionGuardV172Q128Policy._();

  static const String phase = 'V172-Q128';
  static const String verifierScript = 'tool/verify_main_editor_activation_behind_flag_execution_guard_v172_q128.mjs';
  static const String reportJson = 'tool/reports/main_editor_activation_behind_flag_execution_guard_v172_q128_report.json';
  static const String expectedStatus = 'Q128_MAIN_EDITOR_ACTIVATION_BEHIND_FLAG_PACKAGE_READY_BUT_CURSOR_EVIDENCE_BLOCKED';
  static const String selectedDefaultEngine = 'legacyFlutterSlotEditor';
  static const String candidateEngine = 'mathlive';
  static const String rollbackEngine = 'legacyFlutterSlotEditor';
  static const String prerequisite = 'Q127 cursor court closure decision';

  static const bool guardOnly = true;
  static const bool packageSideBatchPhase = true;
  static const bool realDeviceEvidenceRequired = true;
  static const bool flutterAnalyzeEvidenceRequired = true;
  static const bool flutterTestEvidenceRequired = true;
  static const bool humanReviewApprovalRequired = true;
  static const bool explicitUserApprovalRequired = true;
  static const bool mathLiveDefaultSwitchImplementedInThisPackage = false;
  static const bool mainWorkspaceMountImplementedInThisPackage = false;
  static const bool runtimeGraphHistorySolutionWritesImplementedInThisPackage = false;
  static const bool legacyMainPathRetirementImplementedInThisPackage = false;
  static const bool legacyCursorPhysicalDeletionImplementedInThisPackage = false;
  static const bool physicalCleanupExecutedInThisPackage = false;
  static const bool releasePassClaimedInThisPackage = false;
  static const bool cursorPassClaimedInThisPackage = false;
  static const bool legacyFlutterSlotEditorRemainsDefault = true;
  static const bool legacyRollbackRequired = true;
  static const bool keyboardMutationAllowed = false;
  static const bool moreMutationAllowed = false;
  static const bool longPressMutationAllowed = false;
  static const bool appShellMutationAllowed = false;
  static const bool graphHistorySolutionUiMutationAllowed = false;
  static const bool protectedUiSurfaceMutationAllowed = false;
  static const bool fakeRuntimeEvidenceAllowed = false;
  static const bool fakeDeviceEvidenceAllowed = false;
  static const bool fakeReleaseEvidenceAllowed = false;

  static MainEditorActivationBehindFlagExecutionGuardReadiness evaluateReadiness({
    required bool prerequisitePackageReady,
    required bool prerequisiteEvidenceComplete,
    required bool flutterAnalyzePassed,
    required bool flutterTestPassed,
    required bool labDeviceRunCaptured,
    required bool mainAppDeviceRunCaptured,
    required bool protectedSurfacesUnchanged,
    required bool packageHygieneClean,
    required bool explicitApproval,
    required bool noDefaultEditorSwitchInThisPackage,
    required bool noLegacyRetirementInThisPackage,
    required bool noPhysicalLegacyDeletionInThisPackage,
    required bool noFakeRuntimeEvidence,
    required bool noFakeDeviceEvidence,
    required bool noFakeReleaseEvidence,
  }) {
    final blockers = <String>[];
    if (!prerequisitePackageReady) blockers.add('prerequisite package gate is not ready');
    if (!prerequisiteEvidenceComplete) blockers.add('prerequisite real evidence is incomplete');
    if (!flutterAnalyzePassed) blockers.add('flutter analyze PASS evidence is missing');
    if (!flutterTestPassed) blockers.add('flutter test PASS evidence is missing');
    if (!labDeviceRunCaptured) blockers.add('MathLive Lab real-device evidence is missing');
    if (!mainAppDeviceRunCaptured) blockers.add('main app real-device evidence is missing');
    if (!protectedSurfacesUnchanged) blockers.add('protected UI surfaces changed');
    if (!packageHygieneClean) blockers.add('package hygiene is not clean');
    if (!explicitApproval) blockers.add('explicit Q128 approval is missing');
    if (!noDefaultEditorSwitchInThisPackage) blockers.add('default editor switch occurred in this guard-only package');
    if (!noLegacyRetirementInThisPackage) blockers.add('legacy retirement occurred in this guard-only package');
    if (!noPhysicalLegacyDeletionInThisPackage) blockers.add('legacy cursor deletion occurred in this guard-only package');
    if (!noFakeRuntimeEvidence) blockers.add('runtime evidence was faked');
    if (!noFakeDeviceEvidence) blockers.add('device evidence was faked');
    if (!noFakeReleaseEvidence) blockers.add('release evidence was faked');
    final packageReady = prerequisitePackageReady && protectedSurfacesUnchanged && packageHygieneClean &&
        noDefaultEditorSwitchInThisPackage && noLegacyRetirementInThisPackage &&
        noPhysicalLegacyDeletionInThisPackage && noFakeRuntimeEvidence && noFakeDeviceEvidence &&
        noFakeReleaseEvidence;
    final evidenceComplete = prerequisiteEvidenceComplete && flutterAnalyzePassed && flutterTestPassed &&
        labDeviceRunCaptured && mainAppDeviceRunCaptured && explicitApproval;
    return MainEditorActivationBehindFlagExecutionGuardReadiness(
      packageReady: packageReady,
      evidenceComplete: evidenceComplete,
      blockers: List.unmodifiable(blockers),
    );
  }
}

class MainEditorActivationBehindFlagExecutionGuardReadiness {
  const MainEditorActivationBehindFlagExecutionGuardReadiness({
    required this.packageReady,
    required this.evidenceComplete,
    required this.blockers,
  });

  final bool packageReady;
  final bool evidenceComplete;
  final List<String> blockers;

  bool get mayProgress => packageReady && evidenceComplete && blockers.isEmpty;
  bool get mayClaimReleasePass => false;
  bool get mayClaimCursorPass => false;
  bool get mayDeleteLegacyCursor => false;
  bool get maySwitchDefaultEditor => false;
}
