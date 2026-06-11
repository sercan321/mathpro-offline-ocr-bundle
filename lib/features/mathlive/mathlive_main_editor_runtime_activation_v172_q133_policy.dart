/// V172-Q133 — Main Editor MathLive Runtime Activation.
///
/// Q133 is intentionally different from the earlier guard-only phases. The
/// legacy Flutter/MathJax cursor overlay did not improve on real device, so the
/// visible main editor can now mount the local official MathLive runtime behind
/// an internal rollback flag. The frozen MathPro keyboard remains external;
/// MathLive virtual keyboard stays disabled; legacy cursor files remain present
/// as rollback; Graph/History/Solution UI files remain untouched.
class MathLiveMainEditorRuntimeActivationV172Q133Policy {
  const MathLiveMainEditorRuntimeActivationV172Q133Policy._();

  static const String phase = 'V172-Q133';
  static const bool mainEditorMathLiveSurfaceImplemented = true;
  static const bool mathLiveEnabledByDefaultForRealDeviceProbe = true;
  static const bool legacyCursorPhysicalDeletionImplementedInThisPackage = false;
  static const bool legacyRollbackRetained = true;
  static const bool keyboardFilesMutated = false;
  static const bool moreLongPressFilesMutated = false;
  static const bool graphHistorySolutionUiFilesMutated = false;
  static const bool mathLiveVirtualKeyboardEnabled = false;
  static const bool remoteScriptLoadingAllowed = false;
  static const bool cursorPassClaimedInThisPackage = false;
  static const bool releasePassClaimedInThisPackage = false;
  static const bool fakeRuntimeEvidenceCreated = false;
  static const String visibleEditorEngine = 'mathliveMainEditorBehindFlag';
  static const String rollbackEditorEngine = 'legacyFlutterSlotEditor';

  static bool get shouldBypassLegacyCaretOverlay => mainEditorMathLiveSurfaceImplemented;

  static bool canRouteMathProKeyboardToMathLive({
    required bool officialRuntimeInstalled,
    required bool mathLiveSurfaceMounted,
    required bool virtualKeyboardDisabled,
    required bool rollbackAvailable,
  }) {
    return mainEditorMathLiveSurfaceImplemented &&
        officialRuntimeInstalled &&
        mathLiveSurfaceMounted &&
        virtualKeyboardDisabled &&
        rollbackAvailable;
  }
}
