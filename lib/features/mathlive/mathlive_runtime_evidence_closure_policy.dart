/// V172-Q91 — MathLive Runtime Evidence Closure Guard.
///
/// Q91 does not switch the main editor, delete the legacy cursor engine, or
/// claim MathLive cursor quality. It converts the user's real-device Lab report
/// into a strict evidence-closure gate: the report is useful only when the
/// official local MathLive runtime verification and canonical Lab smoke evidence
/// are both present and verified.
class MathLiveRuntimeEvidenceClosurePolicy {
  const MathLiveRuntimeEvidenceClosurePolicy._();

  static const String phase = 'V172-Q91';
  static const String canonicalEvidencePath =
      'docs/evidence/V172_Q90R5_MATHLIVE_LAB_RUNTIME_SMOKE_EVIDENCE.json';
  static const String runtimeVerifierScript = 'tool/verify_mathlive_runtime.mjs';
  static const String smokeEvidenceVerifierScript =
      'tool/verify_mathlive_lab_smoke_evidence.mjs';
  static const String nextAdapterPhase = 'V172-Q92';

  static const bool labOnly = true;
  static const bool userRealDeviceReportMayBeRecorded = true;
  static const bool userRealDeviceReportAloneClosesEvidence = false;
  static const bool officialRuntimeVerificationRequired = true;
  static const bool canonicalSmokeEvidenceRequired = true;
  static const bool canonicalSmokeEvidenceMayBeFaked = false;
  static const bool mainEditorSwitchAllowed = false;
  static const bool mainEditorMountAllowed = false;
  static const bool graphHistorySolutionAdapterWorkAllowed = false;
  static const bool legacyEditorRemainsDefault = true;
  static const bool legacyEditorRemainsRollback = true;
  static const bool physicalLegacyDeletionAllowed = false;
  static const bool remoteScriptsAllowed = false;
  static const bool mathLiveVirtualKeyboardEnabled = false;
  static const bool protectedUiSurfaceMutationAllowed = false;
  static const bool cursorPassClaimAllowed = false;
  static const bool photomathLevelClaimAllowed = false;
  static const bool wolframLevelClaimAllowed = false;

  static MathLiveRuntimeEvidenceClosureVerdict evaluate({
    required bool userReportedLabWorksOnRealDevice,
    required bool officialRuntimeInstallVerified,
    required bool canonicalSmokeEvidencePresent,
    required bool canonicalSmokeEvidenceVerified,
    required bool remoteScriptsDisabled,
    required bool virtualKeyboardDisabled,
    required bool mainEditorStillLegacy,
    required bool protectedSurfacesUnchanged,
    required bool fakeCursorPassClaimAbsent,
  }) {
    final issues = <String>[];
    if (!userReportedLabWorksOnRealDevice) {
      issues.add('user real-device MathLive Lab report is not recorded');
    }
    if (!officialRuntimeInstallVerified) {
      issues.add('Q90R4 official runtime install verification has not passed');
    }
    if (!canonicalSmokeEvidencePresent) {
      issues.add('canonical Q90R5 Lab smoke evidence file is missing');
    }
    if (!canonicalSmokeEvidenceVerified) {
      issues.add('canonical Q90R5 Lab smoke evidence has not verified');
    }
    if (!remoteScriptsDisabled) issues.add('remote/CDN scripts are not disabled');
    if (!virtualKeyboardDisabled) {
      issues.add('MathLive virtual keyboard is not disabled');
    }
    if (!mainEditorStillLegacy) {
      issues.add('main editor changed before Q91 evidence closure');
    }
    if (!protectedSurfacesUnchanged) {
      issues.add('protected UI surfaces changed during Q91');
    }
    if (!fakeCursorPassClaimAbsent) {
      issues.add('Q91 contains a fake cursor/Photomath/Wolfram PASS claim');
    }

    final closed = issues.isEmpty;
    return MathLiveRuntimeEvidenceClosureVerdict(
      status: closed
          ? 'MATHLIVE_RUNTIME_EVIDENCE_CLOSURE_READY_FOR_Q92'
          : 'BLOCKED_MATHLIVE_RUNTIME_EVIDENCE_CLOSURE',
      issues: issues,
      evidenceClosureReady: closed,
      q92AdapterHardeningMayBegin: closed,
      q87CursorCourtMayRun: false,
      mainEditorSwitchAllowed: false,
      physicalLegacyDeletionAllowed: false,
    );
  }
}

class MathLiveRuntimeEvidenceClosureVerdict {
  const MathLiveRuntimeEvidenceClosureVerdict({
    required this.status,
    required this.issues,
    required this.evidenceClosureReady,
    required this.q92AdapterHardeningMayBegin,
    required this.q87CursorCourtMayRun,
    required this.mainEditorSwitchAllowed,
    required this.physicalLegacyDeletionAllowed,
  });

  final String status;
  final List<String> issues;
  final bool evidenceClosureReady;
  final bool q92AdapterHardeningMayBegin;
  final bool q87CursorCourtMayRun;
  final bool mainEditorSwitchAllowed;
  final bool physicalLegacyDeletionAllowed;

  bool get isBlocked => !evidenceClosureReady;
}
