/// V172-Q90R7 — MathLive Lab Smoke Evidence Export UX Guard.
///
/// Q90R6 can author canonical evidence from a copied Lab capture. Q90R7 adds
/// the missing in-app export/copy guard for that capture: the isolated Lab may
/// expose a copyable JSON payload, but it still cannot write project files,
/// switch the main editor, delete legacy cursor files, enable remote scripts, or
/// claim cursor/Photomath/Wolfram PASS.
class MathLiveLabSmokeEvidenceExportPolicy {
  const MathLiveLabSmokeEvidenceExportPolicy._();

  static const String phase = 'V172-Q90R7';
  static const String copyButtonKey = 'mathlive-lab-q90r7-copy-evidence';
  static const String copiedStatusKey = 'mathlive-lab-q90r7-copy-status';
  static const String capturePreviewKey = 'mathlive-lab-q90r7-evidence-preview';
  static const String manualCaptureInput = 'tool/mathlive_lab_runtime_smoke_capture.json';
  static const String writerScript = 'tool/write_mathlive_lab_smoke_evidence.mjs';
  static const bool labOnly = true;
  static const bool mainEditorSwitchAllowed = false;
  static const bool mainEditorMountAllowed = false;
  static const bool appMayWriteProjectEvidenceFile = false;
  static const bool userMustPasteCaptureIntoToolFile = true;
  static const bool legacyEngineRemainsDefault = true;
  static const bool legacyEngineRemainsRollback = true;
  static const bool physicalLegacyDeletionAllowed = false;
  static const bool cursorPassClaimAllowedFromExport = false;
  static const bool photomathLevelClaimAllowedFromExport = false;
  static const bool remoteScriptsAllowed = false;
  static const bool mathLiveVirtualKeyboardMustStayDisabled = true;

  static MathLiveLabSmokeEvidenceExportVerdict evaluate({
    required bool captureGenerated,
    required bool captureContainsQ90R5EvidencePhase,
    required bool captureContainsQ90R6AuthoringPhase,
    required bool copyActionAvailable,
    required bool appWritesProjectFile,
    required bool virtualKeyboardDisabled,
    required bool remoteScriptsDisabled,
    required bool mainEditorStillLegacy,
    required bool protectedSurfacesUnchanged,
    required bool fakeCursorPassClaimAbsent,
    required bool photomathClaimAbsent,
  }) {
    final issues = <String>[];
    if (!captureGenerated) issues.add('Lab evidence capture has not been generated');
    if (!captureContainsQ90R5EvidencePhase) issues.add('capture does not contain Q90R5 evidence phase');
    if (!captureContainsQ90R6AuthoringPhase) issues.add('capture does not contain Q90R6 authoring phase');
    if (!copyActionAvailable) issues.add('copy/export action is not available in the isolated Lab');
    if (appWritesProjectFile) issues.add('Lab app must not write project evidence files directly');
    if (!virtualKeyboardDisabled) issues.add('MathLive virtual keyboard must stay disabled');
    if (!remoteScriptsDisabled) issues.add('remote scripts must stay disabled');
    if (!mainEditorStillLegacy) issues.add('main editor must remain legacy during evidence export');
    if (!protectedSurfacesUnchanged) issues.add('protected UI surfaces must remain unchanged');
    if (!fakeCursorPassClaimAbsent) issues.add('export illegally claims real-device cursor PASS');
    if (!photomathClaimAbsent) issues.add('export illegally claims Photomath/Wolfram level');

    final ready = issues.isEmpty;
    return MathLiveLabSmokeEvidenceExportVerdict(
      status: ready
          ? 'MATHLIVE_LAB_SMOKE_EVIDENCE_CAPTURE_COPY_READY'
          : 'BLOCKED_MATHLIVE_LAB_SMOKE_EVIDENCE_EXPORT',
      captureMayBeCopied: ready,
      writerScriptMustRunAfterCopy: true,
      q90r5VerifierMustRunAfterWriting: true,
      q87CursorCourtMayRun: false,
      mainEditorSwitchAllowed: false,
      mainEditorMountAllowed: false,
      legacyEngineRemainsDefault: true,
      legacyEngineRemainsRollback: true,
      physicalLegacyDeletionAllowed: false,
      diagnostic: ready
          ? 'q90r7-copy-capture-ready-user-must-paste-tool-file-run-q90r6-writer-q90r5-verifier'
          : 'q90r7-copy-capture-blocked-no-main-editor-switch',
      issues: issues,
    );
  }
}

class MathLiveLabSmokeEvidenceExportVerdict {
  const MathLiveLabSmokeEvidenceExportVerdict({
    required this.status,
    required this.captureMayBeCopied,
    required this.writerScriptMustRunAfterCopy,
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
  final bool captureMayBeCopied;
  final bool writerScriptMustRunAfterCopy;
  final bool q90r5VerifierMustRunAfterWriting;
  final bool q87CursorCourtMayRun;
  final bool mainEditorSwitchAllowed;
  final bool mainEditorMountAllowed;
  final bool legacyEngineRemainsDefault;
  final bool legacyEngineRemainsRollback;
  final bool physicalLegacyDeletionAllowed;
  final String diagnostic;
  final List<String> issues;

  bool get isBlocked => !captureMayBeCopied;
}
