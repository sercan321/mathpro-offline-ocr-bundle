/// V172-Q87 — MathLive Cursor Court / Runtime Proof Gate.
///
/// This policy does not switch the main editor and does not claim that a real
/// MathLive runtime is bundled. It defines the evidence gate that must be passed
/// before MathLive can be promoted from the isolated lab/POC path toward the
/// main editor. The gate is intentionally strict because the previous custom
/// Flutter cursor stack passed static tests but failed on real phone screenshots.
class MathLiveCursorCourtPolicy {
  const MathLiveCursorCourtPolicy._();

  static const String phase = 'V172-Q87';
  static const String courtName = 'MathLiveCursorCourt';
  static const String protectedLegacyFallback = 'LegacyFlutterSlotEditor';
  static const String candidateEngine = 'MathLiveEditorAdapter';

  static const bool labOnly = true;
  static const bool mainEditorSwitchAllowed = false;
  static const bool mainEditorSwitchAllowedBeforeCourt = false;
  static const bool mathLiveVirtualKeyboardEnabled = false;
  static const bool mathLiveVirtualKeyboardMayReplaceMathProKeyboard = false;
  static const bool officialMathLiveRuntimeBundled = false;
  static const bool remoteScriptLoadingAllowed = false;
  static const bool cdnDependencyAllowed = false;
  static const bool protectedUiSurfaceMutationAllowed = false;
  static const bool graphHistorySolutionMutationAllowed = false;
  static const bool legacyCursorEngineDeleted = false;
  static const bool realDeviceMathLiveCursorPassClaimed = false;
  static const bool photomathLevelClaimAllowedWithoutEvidence = false;
  static const bool wolframLevelClaimAllowedWithoutEvidence = false;
  static const bool flutterAnalyzePassClaimedByAssistant = false;
  static const bool flutterTestPassClaimedByAssistant = false;
  static const bool flutterRunPassClaimedByAssistant = false;

  static const int requiredScenarioCount = 22;
  static const int minimumPassingScenarios = 20;
  static const int maximumBlockingFailures = 0;

  static const List<MathLiveCursorCourtScenario> requiredScenarios = <MathLiveCursorCourtScenario>[
    MathLiveCursorCourtScenario(id: 'fraction-numerator-denominator', label: 'Fraction numerator and denominator cursor targeting'),
    MathLiveCursorCourtScenario(id: 'sqrt-body', label: 'Square-root body cursor targeting'),
    MathLiveCursorCourtScenario(id: 'indexed-root-index-body', label: 'Indexed-root index and body separation'),
    MathLiveCursorCourtScenario(id: 'power-exponent', label: 'Superscript / power exponent cursor targeting'),
    MathLiveCursorCourtScenario(id: 'subscript-index', label: 'Subscript cursor targeting'),
    MathLiveCursorCourtScenario(id: 'log-base-argument', label: 'Log base and argument separation'),
    MathLiveCursorCourtScenario(id: 'function-argument-sin300', label: 'Single-argument function typing such as sin(300)'),
    MathLiveCursorCourtScenario(id: 'nested-ln-sqrt', label: 'Nested ln/sqrt cursor movement'),
    MathLiveCursorCourtScenario(id: 'integral-lower-upper-body', label: 'Integral lower, upper, and body cursor lanes'),
    MathLiveCursorCourtScenario(id: 'integral-differential', label: 'Integral differential d□ cursor lane'),
    MathLiveCursorCourtScenario(id: 'backspace-fraction', label: 'Backspace inside fraction without destroying surrounding structure'),
    MathLiveCursorCourtScenario(id: 'delete-function', label: 'Delete inside function argument without leaving half tokens'),
    MathLiveCursorCourtScenario(id: 'long-expression-scroll', label: 'Long expression horizontal scroll without cursor jump'),
    MathLiveCursorCourtScenario(id: 'tap-after-scroll', label: 'Tap after scroll hits intended math position'),
    MathLiveCursorCourtScenario(id: 'selection-range', label: 'Selection range stays inside mathfield geometry'),
    MathLiveCursorCourtScenario(id: 'android-focus-retention', label: 'Android WebView focus is retained after MathPro keyboard commands'),
    MathLiveCursorCourtScenario(id: 'mathpro-keyboard-bridge', label: 'Frozen MathPro keyboard command bridge reaches the lab surface'),
    MathLiveCursorCourtScenario(id: 'virtual-keyboard-disabled', label: 'MathLive virtual keyboard remains disabled'),
    MathLiveCursorCourtScenario(id: 'latex-export', label: 'LaTeX export stays synchronized with the visible mathfield'),
    MathLiveCursorCourtScenario(id: 'state-adapter-export', label: 'Q86 state adapter receives valid lab bridge state'),
    MathLiveCursorCourtScenario(id: 'offline-runtime-boundary', label: 'No remote script/CDN dependency is used'),
    MathLiveCursorCourtScenario(id: 'protected-surfaces-unchanged', label: 'Keyboard, MORE, long-press, Graph, History, Solution, and app shell remain untouched'),
  ];

  static bool get scenarioListIsComplete => requiredScenarios.length == requiredScenarioCount;

  static bool canOpenCourt({
    required bool labScreenOpen,
    required bool stateAdapterValid,
    required bool keyboardBridgeAvailable,
    required bool usesRemoteScripts,
    required bool protectedSurfacesUnchanged,
  }) {
    return labOnly &&
        labScreenOpen &&
        stateAdapterValid &&
        keyboardBridgeAvailable &&
        !usesRemoteScripts &&
        protectedSurfacesUnchanged &&
        !mainEditorSwitchAllowed &&
        !mathLiveVirtualKeyboardEnabled;
  }

  static MathLiveCursorCourtVerdict evaluateEvidence({
    required bool flutterAnalyzePassed,
    required bool flutterTestPassed,
    required bool flutterRunOnDevicePassed,
    required bool officialRuntimeBundled,
    required bool labRunsOnDevice,
    required bool keyboardBridgePasses,
    required bool stateAdapterValid,
    required bool virtualKeyboardDisabled,
    required bool remoteScriptsDisabled,
    required bool protectedSurfacesUnchanged,
    required int passedScenarios,
    required int totalScenarios,
    required int blockingFailures,
  }) {
    final issues = <String>[];
    if (!flutterAnalyzePassed) issues.add('flutter analyze evidence missing or failed');
    if (!flutterTestPassed) issues.add('flutter test evidence missing or failed');
    if (!flutterRunOnDevicePassed) issues.add('flutter run -d device evidence missing or failed');
    if (!officialRuntimeBundled) issues.add('official MathLive runtime is not bundled');
    if (!labRunsOnDevice) issues.add('MathLive Lab has not run on the real device');
    if (!keyboardBridgePasses) issues.add('MathPro keyboard bridge has not passed on device');
    if (!stateAdapterValid) issues.add('Q86 state adapter output is not valid');
    if (!virtualKeyboardDisabled) issues.add('MathLive virtual keyboard is not disabled');
    if (!remoteScriptsDisabled) issues.add('remote scripts/CDN are not disabled');
    if (!protectedSurfacesUnchanged) issues.add('protected UI surfaces changed');
    if (totalScenarios < requiredScenarioCount) issues.add('manual scenario count is incomplete');
    if (passedScenarios < minimumPassingScenarios) issues.add('manual cursor scenario pass count is below threshold');
    if (blockingFailures > maximumBlockingFailures) issues.add('blocking cursor/focus failure exists');

    final passed = issues.isEmpty;
    return MathLiveCursorCourtVerdict(
      status: passed ? 'PASS' : 'BLOCKED',
      mayClaimMathLiveCursorPass: passed,
      maySwitchMainEditorToMathLive: false,
      passedScenarios: passedScenarios,
      totalScenarios: totalScenarios,
      blockingFailures: blockingFailures,
      issues: issues,
    );
  }

  static bool maySwitchMainEditorAfterCourt({
    required bool courtPassed,
    required bool graphHistorySolutionAdaptersReady,
    required bool rollbackFlagAvailable,
  }) {
    return courtPassed && graphHistorySolutionAdaptersReady && rollbackFlagAvailable;
  }
}

class MathLiveCursorCourtScenario {
  const MathLiveCursorCourtScenario({required this.id, required this.label});

  final String id;
  final String label;
}

class MathLiveCursorCourtVerdict {
  const MathLiveCursorCourtVerdict({
    required this.status,
    required this.mayClaimMathLiveCursorPass,
    required this.maySwitchMainEditorToMathLive,
    required this.passedScenarios,
    required this.totalScenarios,
    required this.blockingFailures,
    required this.issues,
  });

  final String status;
  final bool mayClaimMathLiveCursorPass;
  final bool maySwitchMainEditorToMathLive;
  final int passedScenarios;
  final int totalScenarios;
  final int blockingFailures;
  final List<String> issues;

  bool get isBlocked => status == 'BLOCKED';
}
