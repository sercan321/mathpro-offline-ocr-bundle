/// V172-Q98 — MathLive Transition Evidence Orchestrator.
///
/// Q98 reduces the user's repeated local-test burden by defining a single
/// package-side evidence ledger/orchestrator boundary for the MathLive
/// transition. It does not run real-device checks inside Dart, does not make
/// MathLive the default/main editor, does not retire or delete the legacy cursor
/// engine, and does not mutate protected UI surfaces. Real Flutter and
/// real-device logs are still required before any downstream PASS claim.
class MathLiveTransitionEvidenceOrchestratorPolicy {
  const MathLiveTransitionEvidenceOrchestratorPolicy._();

  static const String phase = 'V172-Q98';
  static const bool singleCommandCourtOrchestratorProvided = true;
  static const bool realFlutterStillRequired = true;
  static const bool realDeviceStillRequired = true;
  static const bool staticPackageMayClaimDevicePass = false;
  static const bool mainEditorSwitchAllowed = false;
  static const bool mathLiveEnabledByDefault = false;
  static const bool legacyCursorDeletionAllowed = false;
  static const bool protectedUiSurfaceMutationAllowed = false;
  static const bool graphHistorySolutionUiMutationAllowed = false;

  static MathLiveTransitionEvidenceOrchestratorVerdict evaluate({
    required bool contractVerifierPassed,
    required bool runtimeVerifierPassed,
    required bool smokeEvidenceVerifierPassed,
    required bool flutterPubGetPassed,
    required bool flutterAnalyzePassed,
    required bool flutterTestPassed,
    required bool mainAppRealDeviceRunEvidencePresent,
    required bool mathLiveLabRealDeviceRunEvidencePresent,
    required bool protectedSurfacesUnchanged,
    required bool packageHygieneClean,
    required bool noMainEditorSwitchAttempted,
    required bool noLegacyDeletionAttempted,
  }) {
    final blockers = <String>[];
    if (!contractVerifierPassed) blockers.add('contract verifier PASS is missing');
    if (!runtimeVerifierPassed) blockers.add('MathLive runtime verifier PASS is missing');
    if (!smokeEvidenceVerifierPassed) blockers.add('MathLive smoke evidence verifier PASS is missing');
    if (!flutterPubGetPassed) blockers.add('flutter pub get PASS log is missing');
    if (!flutterAnalyzePassed) blockers.add('flutter analyze PASS log is missing');
    if (!flutterTestPassed) blockers.add('flutter test PASS log is missing');
    if (!mainAppRealDeviceRunEvidencePresent) blockers.add('main app real-device run evidence is missing');
    if (!mathLiveLabRealDeviceRunEvidencePresent) blockers.add('MathLive Lab real-device run evidence is missing');
    if (!protectedSurfacesUnchanged) blockers.add('protected UI surfaces changed');
    if (!packageHygieneClean) blockers.add('package hygiene is not clean');
    if (!noMainEditorSwitchAttempted) blockers.add('main editor switch was attempted during Q98');
    if (!noLegacyDeletionAttempted) blockers.add('legacy cursor deletion was attempted during Q98');

    final ready = blockers.isEmpty;
    return MathLiveTransitionEvidenceOrchestratorVerdict(
      status: ready
          ? 'MATHLIVE_TRANSITION_EVIDENCE_LEDGER_READY_FOR_FINAL_REVIEW'
          : 'BLOCKED_MATHLIVE_TRANSITION_EVIDENCE_ORCHESTRATOR',
      blockers: blockers,
      evidenceLedgerComplete: ready,
      mayClaimRealDevicePass: false,
      maySwitchMainEditor: false,
      mayDeleteLegacyCursor: false,
    );
  }
}

class MathLiveTransitionEvidenceOrchestratorVerdict {
  const MathLiveTransitionEvidenceOrchestratorVerdict({
    required this.status,
    required this.blockers,
    required this.evidenceLedgerComplete,
    required this.mayClaimRealDevicePass,
    required this.maySwitchMainEditor,
    required this.mayDeleteLegacyCursor,
  });

  final String status;
  final List<String> blockers;
  final bool evidenceLedgerComplete;
  final bool mayClaimRealDevicePass;
  final bool maySwitchMainEditor;
  final bool mayDeleteLegacyCursor;

  bool get isBlocked => !evidenceLedgerComplete;
}
