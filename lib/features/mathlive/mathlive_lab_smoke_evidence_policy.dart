/// V172-Q90R5 — MathLive Lab Runtime Smoke Evidence Harness.
///
/// This is a lab-only evidence gate. It does not switch the main editor, does
/// not delete the legacy cursor stack, and does not claim MathLive cursor PASS.
/// It only validates that a runtime-smoke report captured from the isolated
/// MathLive Lab is strong enough to proceed to the later Q87 real-device cursor
/// court.
class MathLiveLabSmokeEvidencePolicy {
  const MathLiveLabSmokeEvidencePolicy._();

  static const String phase = 'V172-Q90R5';
  static const String verifierScript = 'tool/verify_mathlive_lab_smoke_evidence.mjs';
  static const String evidenceTemplate = 'docs/evidence/V172_Q90R5_MATHLIVE_LAB_RUNTIME_SMOKE_EVIDENCE_TEMPLATE.json';
  static const int minimumSmokeCommands = 6;
  static const bool mainEditorSwitchAllowed = false;
  static const bool mainEditorMountAllowed = false;
  static const bool legacyEngineRemainsDefault = true;
  static const bool legacyEngineRemainsRollback = true;
  static const bool physicalLegacyDeletionAllowed = false;
  static const bool cursorPassClaimAllowedFromSmokeEvidence = false;
  static const bool requiresQ90R4InstallVerification = true;
  static const bool requiresQ90R2RuntimeSmoke = true;
  static const bool requiresRealDeviceCourtAfterSmoke = true;
  static const bool remoteScriptsAllowed = false;
  static const bool mathLiveVirtualKeyboardMustStayDisabled = true;

  static MathLiveLabSmokeEvidenceVerdict evaluate({
    required bool installVerified,
    required bool evidenceFilePresent,
    required bool evidencePhaseIsQ90R5,
    required bool runtimeSmokePhaseIsQ90R2,
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
  }) {
    final issues = <String>[];
    if (!installVerified) issues.add('Q90R4 runtime install verification has not passed');
    if (!evidenceFilePresent) issues.add('runtime smoke evidence file is missing');
    if (!evidencePhaseIsQ90R5) issues.add('evidence phase is not V172-Q90R5');
    if (!runtimeSmokePhaseIsQ90R2) issues.add('runtime smoke phase is not V172-Q90R2');
    if (!officialRuntimeScriptLoaded) issues.add('official local MathLive runtime script was not loaded');
    if (!mathfieldElementDefined) issues.add('math-field custom element is not defined');
    if (!mathfieldInstanceMounted) issues.add('math-field instance was not mounted in isolated lab');
    if (!labRuntimeSmokePassed) issues.add('Q90R2 lab runtime smoke did not pass');
    if (smokeCommandTotal < minimumSmokeCommands || smokeCommandPasses < minimumSmokeCommands) {
      issues.add('minimum smoke command evidence is incomplete');
    }
    if (!bridgeCanInsertLatex) issues.add('Q85 bridge insertLatex smoke failed');
    if (!bridgeCanDeleteBackward) issues.add('Q85 bridge deleteBackward smoke failed');
    if (!bridgeCanExportLatex) issues.add('Q85 bridge export LaTeX smoke failed');
    if (!stateAdapterAcceptedExport) issues.add('Q86 state adapter did not accept exported state');
    if (!virtualKeyboardDisabled) issues.add('MathLive virtual keyboard is not disabled');
    if (!remoteScriptsDisabled) issues.add('remote/CDN scripts are not disabled');
    if (!mainEditorStillLegacy) issues.add('main editor is not still legacy during smoke evidence');
    if (!protectedSurfacesUnchanged) issues.add('protected UI surfaces changed during smoke evidence');

    final ready = issues.isEmpty;
    return MathLiveLabSmokeEvidenceVerdict(
      status: ready
          ? 'MATHLIVE_LAB_SMOKE_EVIDENCE_READY_FOR_Q87_CURSOR_COURT'
          : 'BLOCKED_MATHLIVE_LAB_SMOKE_EVIDENCE',
      evidenceVerified: ready,
      q87CursorCourtMayRun: ready,
      mainEditorSwitchAllowed: false,
      mainEditorMountAllowed: false,
      legacyEngineRemainsDefault: true,
      legacyEngineRemainsRollback: true,
      physicalLegacyDeletionAllowed: false,
      diagnostic: ready
          ? 'q90r5-lab-smoke-evidence-ready-for-q87-cursor-court-no-main-editor-switch'
          : 'q90r5-lab-smoke-evidence-blocked-no-main-editor-switch',
      issues: issues,
    );
  }
}

class MathLiveLabSmokeEvidenceVerdict {
  const MathLiveLabSmokeEvidenceVerdict({
    required this.status,
    required this.evidenceVerified,
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
  final bool evidenceVerified;
  final bool q87CursorCourtMayRun;
  final bool mainEditorSwitchAllowed;
  final bool mainEditorMountAllowed;
  final bool legacyEngineRemainsDefault;
  final bool legacyEngineRemainsRollback;
  final bool physicalLegacyDeletionAllowed;
  final String diagnostic;
  final List<String> issues;

  bool get isBlocked => !evidenceVerified;
}
