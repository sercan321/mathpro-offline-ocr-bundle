/// V172-Q90R6 — MathLive Lab Smoke Evidence Authoring Harness.
///
/// Q90R5 verifies an already-captured lab smoke evidence file. Q90R6 adds the
/// missing authoring/capture contract: a copied bridge report from the isolated
/// MathLive Lab may be converted into the canonical Q90R5 evidence file only
/// after Q90R4 runtime install verification has passed. This does not switch the
/// main editor, does not delete the legacy cursor stack, and does not claim
/// cursor/Photomath/Wolfram PASS.
class MathLiveLabSmokeEvidenceAuthoringPolicy {
  const MathLiveLabSmokeEvidenceAuthoringPolicy._();

  static const String phase = 'V172-Q90R6';
  static const String writerScript = 'tool/write_mathlive_lab_smoke_evidence.mjs';
  static const String defaultCaptureInput = 'tool/mathlive_lab_runtime_smoke_capture.json';
  static const String canonicalEvidenceOutput = 'docs/evidence/V172_Q90R5_MATHLIVE_LAB_RUNTIME_SMOKE_EVIDENCE.json';
  static const String runtimeVerificationReport = 'tool/verify_mathlive_runtime_report.json';
  static const bool mainEditorSwitchAllowed = false;
  static const bool mainEditorMountAllowed = false;
  static const bool legacyEngineRemainsDefault = true;
  static const bool legacyEngineRemainsRollback = true;
  static const bool physicalLegacyDeletionAllowed = false;
  static const bool cursorPassClaimAllowedFromAuthoredEvidence = false;
  static const bool photomathLevelClaimAllowedFromAuthoredEvidence = false;
  static const bool remoteScriptsAllowed = false;
  static const bool mathLiveVirtualKeyboardMustStayDisabled = true;
  static const bool requiresQ90R4RuntimeVerificationReport = true;
  static const bool requiresQ90R5VerifierAfterWriting = true;
  static const bool requiresManualBridgeCapture = true;

  static MathLiveLabSmokeEvidenceAuthoringVerdict evaluate({
    required bool runtimeVerificationReportPresent,
    required bool runtimeInstallVerified,
    required bool captureInputPresent,
    required bool capturePhaseAcceptable,
    required bool captureRuntimeSmokePassed,
    required bool captureOfficialRuntimeLoaded,
    required bool captureMathfieldMounted,
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
    required bool fakeCursorPassClaimAbsent,
    required bool photomathClaimAbsent,
  }) {
    final issues = <String>[];
    if (!runtimeVerificationReportPresent) issues.add('Q90R4 runtime verification report is missing');
    if (!runtimeInstallVerified) issues.add('Q90R4 runtime install verification has not passed');
    if (!captureInputPresent) issues.add('MathLive Lab smoke capture input is missing');
    if (!capturePhaseAcceptable) issues.add('capture input is not a Q90R5/Q90R6 MathLive Lab smoke evidence report');
    if (!captureRuntimeSmokePassed) issues.add('capture does not prove Q90R2 lab runtime smoke passed');
    if (!captureOfficialRuntimeLoaded) issues.add('capture does not prove official runtime script loaded');
    if (!captureMathfieldMounted) issues.add('capture does not prove math-field was mounted');
    if (smokeCommandTotal < 6 || smokeCommandPasses < 6) issues.add('capture does not prove all minimum smoke commands passed');
    if (!bridgeCanInsertLatex) issues.add('capture does not prove insertLatex bridge smoke');
    if (!bridgeCanDeleteBackward) issues.add('capture does not prove deleteBackward bridge smoke');
    if (!bridgeCanExportLatex) issues.add('capture does not prove LaTeX export smoke');
    if (!stateAdapterAcceptedExport) issues.add('capture does not prove Q86 state adapter accepted export');
    if (!virtualKeyboardDisabled) issues.add('capture does not keep MathLive virtual keyboard disabled');
    if (!remoteScriptsDisabled) issues.add('capture does not keep remote scripts disabled');
    if (!mainEditorStillLegacy) issues.add('capture does not keep main editor on legacy fallback');
    if (!protectedSurfacesUnchanged) issues.add('capture does not prove protected UI surfaces unchanged');
    if (!fakeCursorPassClaimAbsent) issues.add('capture illegally claims real-device cursor court PASS');
    if (!photomathClaimAbsent) issues.add('capture illegally claims Photomath/Wolfram level');

    final ready = issues.isEmpty;
    return MathLiveLabSmokeEvidenceAuthoringVerdict(
      status: ready
          ? 'MATHLIVE_LAB_SMOKE_EVIDENCE_AUTHORED_FOR_Q90R5_VERIFICATION'
          : 'BLOCKED_MATHLIVE_LAB_SMOKE_EVIDENCE_AUTHORING',
      evidenceMayBeWritten: ready,
      q90r5VerifierMustRunAfterWriting: true,
      q87CursorCourtMayRun: false,
      mainEditorSwitchAllowed: false,
      mainEditorMountAllowed: false,
      legacyEngineRemainsDefault: true,
      legacyEngineRemainsRollback: true,
      physicalLegacyDeletionAllowed: false,
      diagnostic: ready
          ? 'q90r6-evidence-authoring-ready-run-q90r5-verifier-next-no-main-editor-switch'
          : 'q90r6-evidence-authoring-blocked-no-main-editor-switch',
      issues: issues,
    );
  }
}

class MathLiveLabSmokeEvidenceAuthoringVerdict {
  const MathLiveLabSmokeEvidenceAuthoringVerdict({
    required this.status,
    required this.evidenceMayBeWritten,
    required this.q90r5VerifierMustRunAfterWriting,
    required this.q87CursorCourtMayRun,
    required this.mainEditorSwitchAllowed,
    required this.mainEditorMountAllowed,
    required this.legacyEngineRemainsDefault,
    required this.legacyEngineRemainsRollback,
    required this.physicalLegacyDeletionAllowed,
    required this.diagnostic,
    required this.issues,
  });

  final String status;
  final bool evidenceMayBeWritten;
  final bool q90r5VerifierMustRunAfterWriting;
  final bool q87CursorCourtMayRun;
  final bool mainEditorSwitchAllowed;
  final bool mainEditorMountAllowed;
  final bool legacyEngineRemainsDefault;
  final bool legacyEngineRemainsRollback;
  final bool physicalLegacyDeletionAllowed;
  final String diagnostic;
  final List<String> issues;

  bool get isBlocked => !evidenceMayBeWritten;
}
