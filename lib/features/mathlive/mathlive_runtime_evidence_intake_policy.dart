/// V172-Q99 — MathLive Runtime / Smoke Evidence Intake Closure.
///
/// Q99 is a package-side intake closure. It turns the Q90R4 runtime verifier,
/// Q90R5 canonical smoke evidence, and Q98 court ledger into one reviewable
/// readiness gate. It does not install a fake runtime, does not write fake
/// smoke evidence, does not switch the main editor, does not enable MathLive by
/// default, does not delete legacy cursor files, and does not mutate protected
/// keyboard/MORE/long-press/AppShell/Graph/History/Solution surfaces.
class MathLiveRuntimeEvidenceIntakePolicy {
  const MathLiveRuntimeEvidenceIntakePolicy._();

  static const String phase = 'V172-Q99';
  static const bool runtimeAndSmokeEvidenceIntakeProvided = true;
  static const bool createsFakeRuntimeEvidence = false;
  static const bool createsFakeSmokeEvidence = false;
  static const bool mainEditorSwitchAllowed = false;
  static const bool mathLiveEnabledByDefault = false;
  static const bool legacyCursorDeletionAllowed = false;
  static const bool protectedUiSurfaceMutationAllowed = false;
  static const bool graphHistorySolutionUiMutationAllowed = false;
  static const bool realDeviceCourtStillRequired = true;

  static MathLiveRuntimeEvidenceIntakeVerdict evaluate({
    required bool officialRuntimeVendorFilesPresent,
    required bool runtimeVerifierPassed,
    required bool canonicalSmokeEvidencePresent,
    required bool smokeEvidenceVerifierPassed,
    required bool q98CourtReportPresent,
    required bool protectedSurfacesUnchanged,
    required bool noMainEditorSwitchAttempted,
    required bool noLegacyDeletionAttempted,
    required bool packageHygieneClean,
  }) {
    final blockers = <String>[];
    if (!officialRuntimeVendorFilesPresent) blockers.add('official MathLive runtime vendor files are missing');
    if (!runtimeVerifierPassed) blockers.add('Q90R4 runtime verifier PASS is missing');
    if (!canonicalSmokeEvidencePresent) blockers.add('canonical Q90R5 smoke evidence is missing');
    if (!smokeEvidenceVerifierPassed) blockers.add('Q90R5 smoke evidence verifier PASS is missing');
    if (!q98CourtReportPresent) blockers.add('Q98 transition court report is missing');
    if (!protectedSurfacesUnchanged) blockers.add('protected UI surfaces changed');
    if (!noMainEditorSwitchAttempted) blockers.add('main editor switch was attempted during Q99');
    if (!noLegacyDeletionAttempted) blockers.add('legacy cursor deletion was attempted during Q99');
    if (!packageHygieneClean) blockers.add('package hygiene is not clean');

    final ready = blockers.isEmpty;
    return MathLiveRuntimeEvidenceIntakeVerdict(
      status: ready
          ? 'MATHLIVE_RUNTIME_EVIDENCE_INTAKE_READY_FOR_Q92_REVIEW'
          : 'BLOCKED_MATHLIVE_RUNTIME_EVIDENCE_INTAKE',
      blockers: blockers,
      runtimeEvidenceIntakeReady: ready,
      mayStartQ92AdapterReview: ready,
      mayClaimCursorPass: false,
      maySwitchMainEditor: false,
      mayEnableMathLiveByDefault: false,
      mayDeleteLegacyCursor: false,
    );
  }
}

class MathLiveRuntimeEvidenceIntakeVerdict {
  const MathLiveRuntimeEvidenceIntakeVerdict({
    required this.status,
    required this.blockers,
    required this.runtimeEvidenceIntakeReady,
    required this.mayStartQ92AdapterReview,
    required this.mayClaimCursorPass,
    required this.maySwitchMainEditor,
    required this.mayEnableMathLiveByDefault,
    required this.mayDeleteLegacyCursor,
  });

  final String status;
  final List<String> blockers;
  final bool runtimeEvidenceIntakeReady;
  final bool mayStartQ92AdapterReview;
  final bool mayClaimCursorPass;
  final bool maySwitchMainEditor;
  final bool mayEnableMathLiveByDefault;
  final bool mayDeleteLegacyCursor;

  bool get isBlocked => !runtimeEvidenceIntakeReady;
}
