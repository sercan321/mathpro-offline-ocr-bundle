import 'mathlive_runtime_bundle_policy.dart';

/// V172-Q90R2 — MathLive Lab Real Runtime Smoke Test Gate.
///
/// This is still a lab/proof gate. It does not switch the main editor and it
/// does not claim that MathLive is bundled by the assistant. It defines the
/// exact runtime-smoke evidence required after `tool/install_mathlive_runtime.mjs`
/// installs the official local MathLive assets.
class MathLiveRuntimeSmokePolicy {
  const MathLiveRuntimeSmokePolicy._();

  static const String phase = 'V172-Q90R2';
  static const String labRoute = '/mathlive-lab';
  static const int minimumSmokeCommands = 6;
  static const bool mainEditorSwitchAllowed = false;
  static const bool mainEditorMountAllowed = false;
  static const bool legacyEngineRemainsDefault = true;
  static const bool legacyEngineRemainsRollback = true;
  static const bool mathLiveVirtualKeyboardMustStayDisabled = true;
  static const bool remoteScriptsAllowed = false;
  static const bool officialRuntimeClaimAllowedWithoutSmoke = false;
  static const bool cursorPassClaimAllowedWithoutRealDeviceCourt = false;
  static const bool graphHistorySolutionAdapterRequiredBeforeSwitch = true;

  static const List<String> requiredSmokeCommands = <String>[
    'insert:7',
    'insert:fraction',
    'insert:sqrt',
    'insert:power',
    'deleteBackward',
    'exportState',
  ];

  static MathLiveRuntimeSmokeVerdict evaluate({
    required MathLiveRuntimeBundleVerdict bundleVerdict,
    required bool labScreenLoaded,
    required bool localRuntimeScriptLoaded,
    required bool mathfieldElementDefined,
    required bool mathfieldInstanceMounted,
    required bool bridgeCanInsertLatex,
    required bool bridgeCanDeleteBackward,
    required bool bridgeCanExportLatex,
    required bool stateAdapterAcceptedExport,
    required bool virtualKeyboardDisabled,
    required bool remoteScriptsDisabled,
    required bool protectedSurfacesUnchanged,
    required int smokeCommandPasses,
    required int smokeCommandTotal,
  }) {
    final issues = <String>[];
    if (!bundleVerdict.readyForLab) issues.add('official MathLive runtime bundle is not ready for lab');
    if (!labScreenLoaded) issues.add('MathLive Lab screen did not load');
    if (!localRuntimeScriptLoaded) issues.add('local vendor mathlive.min.js script did not load');
    if (!mathfieldElementDefined) issues.add('math-field custom element is not defined');
    if (!mathfieldInstanceMounted) issues.add('math-field instance was not mounted inside the isolated lab host');
    if (!bridgeCanInsertLatex) issues.add('Q85 keyboard bridge cannot insert LaTeX into the lab runtime');
    if (!bridgeCanDeleteBackward) issues.add('Q85 keyboard bridge cannot delete backward inside the lab runtime');
    if (!bridgeCanExportLatex) issues.add('lab runtime cannot export LaTeX state');
    if (!stateAdapterAcceptedExport) issues.add('Q86 state adapter did not accept the exported MathLive state');
    if (!virtualKeyboardDisabled) issues.add('MathLive virtual keyboard is not disabled');
    if (!remoteScriptsDisabled) issues.add('remote/CDN scripts are not disabled');
    if (!protectedSurfacesUnchanged) issues.add('protected UI surfaces changed');
    if (smokeCommandTotal < minimumSmokeCommands) issues.add('smoke command total is below the minimum command count');
    if (smokeCommandPasses < smokeCommandTotal || smokeCommandPasses < minimumSmokeCommands) {
      issues.add('not all required lab smoke commands passed');
    }

    final ready = issues.isEmpty;
    return MathLiveRuntimeSmokeVerdict(
      status: ready ? 'MATHLIVE_LAB_RUNTIME_SMOKE_READY_FOR_CURSOR_COURT' : 'BLOCKED_MATHLIVE_LAB_RUNTIME_SMOKE',
      labRuntimeSmokePassed: ready,
      mainEditorSwitchAllowed: false,
      cursorCourtMayRun: ready,
      diagnostic: ready
          ? 'q90r2-mathlive-lab-runtime-smoke-ready-for-q87-court'
          : 'q90r2-mathlive-lab-runtime-smoke-blocked-no-main-editor-switch',
      issues: issues,
    );
  }
}

class MathLiveRuntimeSmokeVerdict {
  const MathLiveRuntimeSmokeVerdict({
    required this.status,
    required this.labRuntimeSmokePassed,
    required this.mainEditorSwitchAllowed,
    required this.cursorCourtMayRun,
    required this.diagnostic,
    required this.issues,
  });

  final String status;
  final bool labRuntimeSmokePassed;
  final bool mainEditorSwitchAllowed;
  final bool cursorCourtMayRun;
  final String diagnostic;
  final List<String> issues;

  bool get isBlocked => status == 'BLOCKED_MATHLIVE_LAB_RUNTIME_SMOKE';
  bool get readyForCursorCourt => status == 'MATHLIVE_LAB_RUNTIME_SMOKE_READY_FOR_CURSOR_COURT';
}
