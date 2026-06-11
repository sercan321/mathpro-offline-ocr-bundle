/// V172-Q81 — Legacy Cursor Freeze & Architecture Lock.
///
/// This policy is intentionally conservative. The real-device screenshots after
/// Q80 proved that the custom Flutter SlotBox cursor stack can pass unit tests
/// while still feeling unreliable on a phone. Q81 therefore freezes that stack
/// as a legacy/fallback editor path and prevents new large cursor patches from
/// being treated as the primary product direction. The next candidate editor
/// engine must be evaluated behind a MathEditorAdapter/MathLive lab path first.
class LegacyCursorFreezePolicy {
  // ignore: unused_element
  const LegacyCursorFreezePolicy._();

  static const String version =
      'mathpro-v172q81-legacy-cursor-freeze-architecture-lock-v1';

  static const String legacyEngineName = 'LegacyFlutterSlotEditor';
  static const String candidateEngineName = 'MathLiveEditorAdapter';
  static const String adapterContractName = 'MathEditorAdapter';

  /// The existing Flutter cursor stack is not deleted in Q81. It remains a
  /// fallback/safety path until a replacement engine passes a real-device court.
  static const bool legacyCursorEngineDeleted = false;
  static const bool legacyCursorEngineFrozenAsFallback = true;
  static const bool legacyCursorEnginePrimaryFutureDirection = false;

  /// Q81 must not introduce another geometry/overlay cursor rewrite. Further
  /// work should go through the adapter/lab path unless a regression must be
  /// repaired surgically.
  static const bool newLargeFlutterCursorPatchAllowed = false;
  static const bool evidencedRegressionRepairOnly = true;
  static const bool mathLiveDirectMainEditorSwitchAllowed = false;
  static const bool mathLiveLabRequiredBeforeMainEditor = true;
  static const bool mathEditorAdapterRequiredBeforeEngineSwitch = true;

  /// Product red lines. These are repeated here because the legacy freeze only
  /// makes sense if the existing premium shell remains untouched.
  static const bool keyboardSurfaceMutationAllowed = false;
  static const bool moreSurfaceMutationAllowed = false;
  static const bool longPressSurfaceMutationAllowed = false;
  static const bool appShellMutationAllowed = false;
  static const bool graphHistorySolutionMutationAllowed = false;
  static const bool solutionPanelMutationAllowed = false;
  static const bool mathLiveVirtualKeyboardMayReplaceMathProKeyboard = false;
  static const bool cdnDependencyAllowedForMathLive = false;

  /// Q81 is an architecture lock, not a fake improvement claim.
  static const bool flutterAnalyzePassClaimedByAssistant = false;
  static const bool flutterTestPassClaimedByAssistant = false;
  static const bool flutterRunPassClaimedByAssistant = false;
  static const bool realDeviceMathLivePassClaimed = false;
  static const bool photomathLevelClaimAllowedWithoutEvidence = false;

  static const List<String> allowedNextArchitectureSteps = <String>[
    'Q82 MathEditorAdapter Contract',
    'Q83 Offline MathLive Asset Foundation',
    'Q84 MathLive Lab Screen',
    'Q85 MathPro Keyboard to MathLive JS Bridge',
    'Q86 MathLive State Adapter',
    'Q87 Real Device MathLive Cursor Court',
  ];

  static const List<String> legacyCursorRetirementGates = <String>[
    'MathLive lab loads offline on a real Android device',
    'MathPro frozen keyboard can command MathLive without using MathLive virtual keyboard',
    'LaTeX state round-trips from MathLive to MathPro without breaking History',
    'Graph eligibility receives normalized MathLive input',
    'Solution/evaluate input receives normalized MathLive input',
    'Real device MathLive cursor court passes without critical focus bugs',
    'Legacy fallback can still be re-enabled before final retirement',
  ];

  static bool mayApplyFlutterCursorPatch({required bool hasUserDeviceEvidence}) {
    return evidencedRegressionRepairOnly && hasUserDeviceEvidence;
  }

  static bool maySwitchMainEditorToMathLive({
    required bool adapterContractExists,
    required bool offlineLabPasses,
    required bool realDeviceCourtPasses,
    required bool protectedSurfacesUnchanged,
  }) {
    return adapterContractExists &&
        offlineLabPasses &&
        realDeviceCourtPasses &&
        protectedSurfacesUnchanged;
  }

  static String architectureVerdict({
    required bool adapterContractExists,
    required bool offlineLabPasses,
    required bool realDeviceCourtPasses,
    required bool protectedSurfacesUnchanged,
  }) {
    if (!adapterContractExists) {
      return 'HOLD: MathEditorAdapter contract must exist before any engine switch';
    }
    if (!offlineLabPasses) {
      return 'HOLD: MathLive must pass an offline Lab/POC before main editor integration';
    }
    if (!realDeviceCourtPasses) {
      return 'HOLD: MathLive cursor court evidence is required before replacing the main editor';
    }
    if (!protectedSurfacesUnchanged) {
      return 'REJECT: protected keyboard/UI/Graph/History/Solution surfaces changed';
    }
    return 'CANDIDATE: MathLive may be reviewed for controlled main-editor integration behind an engine flag';
  }
}
