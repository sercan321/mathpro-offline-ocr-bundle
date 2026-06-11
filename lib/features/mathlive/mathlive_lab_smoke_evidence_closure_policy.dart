/// V172-Q101 — Lab Smoke Evidence Closure.
///
/// Q101 closes the canonical Lab smoke evidence gate only when the official
/// runtime bundle closure, the Q90R6 authoring report, and the Q90R5 verifier
/// all agree on the same real Lab evidence. It never creates fake evidence,
/// never turns MathLive into the default/main editor, never claims cursor or
/// Photomath/Wolfram PASS, and never deletes the legacy cursor engine.
class MathLiveLabSmokeEvidenceClosurePolicy {
  const MathLiveLabSmokeEvidenceClosurePolicy._();

  static const String phase = 'V172-Q101';
  static const String verifierScript = 'tool/verify_mathlive_lab_smoke_evidence_closure.mjs';
  static const String reportJson = 'tool/reports/mathlive_lab_smoke_evidence_closure_report.json';
  static const String reportMarkdown = 'tool/reports/mathlive_lab_smoke_evidence_closure_report.md';
  static const String canonicalEvidencePath = 'docs/evidence/V172_Q90R5_MATHLIVE_LAB_RUNTIME_SMOKE_EVIDENCE.json';
  static const bool labSmokeEvidenceClosureGateProvided = true;
  static const bool createsFakeSmokeEvidence = false;
  static const bool writesCanonicalEvidenceDuringClosureVerification = false;
  static const bool requiresQ100OfficialRuntimeBundleClosure = true;
  static const bool requiresQ90R6EvidenceAuthoringReport = true;
  static const bool requiresQ90R5SmokeEvidenceVerification = true;
  static const bool remoteScriptLoadingAllowed = false;
  static const bool mathLiveVirtualKeyboardEnabled = false;
  static const bool mainEditorSwitchAllowed = false;
  static const bool mainEditorMountAllowed = false;
  static const bool mathLiveEnabledByDefault = false;
  static const bool legacyCursorDeletionAllowed = false;
  static const bool protectedUiSurfaceMutationAllowed = false;
  static const bool graphHistorySolutionUiMutationAllowed = false;
  static const bool cursorPassClaimAllowed = false;
  static const bool photomathWolframClaimAllowed = false;
  static const bool realDeviceCursorCourtStillRequired = true;

  static MathLiveLabSmokeEvidenceClosureVerdict evaluate({
    required bool q100OfficialRuntimeBundleClosed,
    required bool q90r6EvidenceAuthored,
    required bool q90r5EvidenceVerified,
    required bool canonicalEvidenceFilePresent,
    required bool canonicalEvidenceJsonValid,
    required bool evidencePhaseIsQ90R5,
    required bool runtimeSmokePhaseIsQ90R2,
    required bool installVerified,
    required bool officialRuntimeScriptLoaded,
    required bool mathfieldElementDefined,
    required bool mathfieldInstanceMounted,
    required bool labRuntimeSmokePassed,
    required int smokeCommandPasses,
    required int smokeCommandTotal,
    required bool bridgeCanInsertLatex,
    required bool bridgeCanDeleteBackward,
    required bool bridgeCanExportLatex,
    required bool stateAdapterAcceptedExport,
    required bool virtualKeyboardDisabled,
    required bool remoteScriptsDisabled,
    required bool mainEditorStillLegacy,
    required bool protectedSurfacesUnchanged,
    required bool noCursorPassClaim,
    required bool noPhotomathWolframClaim,
    required bool packageHygieneClean,
  }) {
    final blockers = <String>[];
    if (!q100OfficialRuntimeBundleClosed) blockers.add('Q100 official runtime bundle closure has not passed');
    if (!q90r6EvidenceAuthored) blockers.add('Q90R6 smoke evidence authoring has not passed');
    if (!q90r5EvidenceVerified) blockers.add('Q90R5 canonical smoke evidence verifier has not passed');
    if (!canonicalEvidenceFilePresent) blockers.add('canonical Q90R5 smoke evidence file is missing');
    if (!canonicalEvidenceJsonValid) blockers.add('canonical smoke evidence JSON is invalid');
    if (!evidencePhaseIsQ90R5) blockers.add('canonical evidence phase is not V172-Q90R5');
    if (!runtimeSmokePhaseIsQ90R2) blockers.add('runtime smoke phase is not V172-Q90R2');
    if (!installVerified) blockers.add('evidence does not prove Q90R4 installVerified true');
    if (!officialRuntimeScriptLoaded) blockers.add('evidence does not prove official runtime script loaded');
    if (!mathfieldElementDefined) blockers.add('evidence does not prove math-field custom element defined');
    if (!mathfieldInstanceMounted) blockers.add('evidence does not prove math-field instance mounted');
    if (!labRuntimeSmokePassed) blockers.add('evidence does not prove Lab runtime smoke passed');
    if (smokeCommandPasses < 6 || smokeCommandTotal < 6) blockers.add('minimum smoke command evidence is incomplete');
    if (!bridgeCanInsertLatex) blockers.add('evidence does not prove insertLatex bridge smoke');
    if (!bridgeCanDeleteBackward) blockers.add('evidence does not prove deleteBackward bridge smoke');
    if (!bridgeCanExportLatex) blockers.add('evidence does not prove export LaTeX bridge smoke');
    if (!stateAdapterAcceptedExport) blockers.add('evidence does not prove Q86 state adapter accepted export');
    if (!virtualKeyboardDisabled) blockers.add('MathLive virtual keyboard is not disabled');
    if (!remoteScriptsDisabled) blockers.add('remote/CDN scripts are not disabled');
    if (!mainEditorStillLegacy) blockers.add('main editor did not remain legacy during evidence closure');
    if (!protectedSurfacesUnchanged) blockers.add('protected UI surfaces changed');
    if (!noCursorPassClaim) blockers.add('evidence illegally claims cursor PASS');
    if (!noPhotomathWolframClaim) blockers.add('evidence illegally claims Photomath/Wolfram level');
    if (!packageHygieneClean) blockers.add('package hygiene is not clean');

    final closed = blockers.isEmpty;
    return MathLiveLabSmokeEvidenceClosureVerdict(
      status: closed
          ? 'MATHLIVE_LAB_SMOKE_EVIDENCE_CLOSED_FOR_Q87_CURSOR_COURT'
          : 'BLOCKED_MATHLIVE_LAB_SMOKE_EVIDENCE_CLOSURE',
      blockers: blockers,
      labSmokeEvidenceClosed: closed,
      mayRunQ87CursorCourt: closed,
      mayClaimCursorPass: false,
      maySwitchMainEditor: false,
      mayMountMainEditor: false,
      mayEnableMathLiveByDefault: false,
      mayDeleteLegacyCursor: false,
    );
  }
}

class MathLiveLabSmokeEvidenceClosureVerdict {
  const MathLiveLabSmokeEvidenceClosureVerdict({
    required this.status,
    required this.blockers,
    required this.labSmokeEvidenceClosed,
    required this.mayRunQ87CursorCourt,
    required this.mayClaimCursorPass,
    required this.maySwitchMainEditor,
    required this.mayMountMainEditor,
    required this.mayEnableMathLiveByDefault,
    required this.mayDeleteLegacyCursor,
  });

  final String status;
  final List<String> blockers;
  final bool labSmokeEvidenceClosed;
  final bool mayRunQ87CursorCourt;
  final bool mayClaimCursorPass;
  final bool maySwitchMainEditor;
  final bool mayMountMainEditor;
  final bool mayEnableMathLiveByDefault;
  final bool mayDeleteLegacyCursor;

  bool get isBlocked => !labSmokeEvidenceClosed;
}
