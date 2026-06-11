import '../mathlive/mathlive_cursor_court_policy.dart';
import 'math_editor_adapter.dart';

/// V172-Q88 — Main Editor Engine Switch Behind Flag.
///
/// This is only the rollback-safe switch contract. It does not enable MathLive
/// as the default editor and it does not replace the main editor. The legacy
/// Flutter SlotBox editor remains the active fallback until Q87 evidence,
/// rollback support, Graph/History/Solution adapter readiness, and protected
/// surface integrity are all proven.
class MathEditorEngineSwitchPolicy {
  const MathEditorEngineSwitchPolicy._();

  static const String phase = 'V172-Q88';
  static const String switchName = 'MainEditorEngineSwitchBehindFlag';

  static const MathEditorEngineKind defaultEngine = MathEditorEngineKind.legacyFlutterSlotEditor;
  static const MathEditorEngineKind rollbackEngine = MathEditorEngineKind.legacyFlutterSlotEditor;
  static const MathEditorEngineKind candidateEngine = MathEditorEngineKind.mathLive;

  static const bool featureFlagImplemented = true;
  static const bool mathLiveMainEditorEnabledByDefault = false;
  static const bool mainEditorSwitchedToMathLive = false;
  static const bool legacyFallbackAvailable = true;
  static const bool rollbackFlagRequired = true;
  static const bool graphHistorySolutionAdaptersRequired = true;
  static const bool q87CursorCourtRequired = true;
  static const bool officialRuntimeRequired = true;
  static const bool labRealDeviceEvidenceRequired = true;
  static const bool keyboardBridgeRequired = true;
  static const bool stateAdapterRequired = true;
  static const bool virtualKeyboardMustRemainDisabled = true;
  static const bool remoteScriptsMustRemainDisabled = true;
  static const bool protectedUiSurfaceMutationAllowed = false;
  static const bool keyboardMutationAllowed = false;
  static const bool graphHistorySolutionMutationAllowed = false;
  static const bool fakeMathLivePassClaimAllowed = false;
  static const bool photomathLevelClaimAllowedWithoutEvidence = false;

  static MathEditorEngineSelection resolveEngine({
    required MathEditorEngineKind requestedEngine,
    required bool mathLiveFlagEnabled,
    required bool q87CourtPassed,
    required bool officialRuntimeBundled,
    required bool labRunsOnDevice,
    required bool keyboardBridgePasses,
    required bool stateAdapterPasses,
    required bool graphHistorySolutionAdaptersReady,
    required bool rollbackFlagAvailable,
    required bool protectedSurfacesUnchanged,
    required bool virtualKeyboardDisabled,
    required bool remoteScriptsDisabled,
  }) {
    if (requestedEngine == MathEditorEngineKind.legacyFlutterSlotEditor) {
      return const MathEditorEngineSelection(
        requestedEngine: MathEditorEngineKind.legacyFlutterSlotEditor,
        selectedEngine: MathEditorEngineKind.legacyFlutterSlotEditor,
        switchAllowed: true,
        fallbackUsed: false,
        rollbackAvailable: true,
        diagnostic: 'q88-legacy-default-engine',
        issues: <String>[],
      );
    }

    final issues = <String>[];
    if (!mathLiveFlagEnabled) issues.add('mathlive editor feature flag is disabled');
    if (!q87CourtPassed) issues.add('Q87 MathLive cursor court has not passed');
    if (!officialRuntimeBundled) issues.add('official MathLive runtime is not bundled');
    if (!labRunsOnDevice) issues.add('MathLive Lab has not passed on the real device');
    if (!keyboardBridgePasses) issues.add('Q85 keyboard bridge has not passed');
    if (!stateAdapterPasses) issues.add('Q86 state adapter has not passed');
    if (!graphHistorySolutionAdaptersReady) issues.add('Graph/History/Solution adapters are not ready');
    if (!rollbackFlagAvailable) issues.add('rollback flag is not available');
    if (!protectedSurfacesUnchanged) issues.add('protected UI surfaces changed');
    if (!virtualKeyboardDisabled) issues.add('MathLive virtual keyboard is not disabled');
    if (!remoteScriptsDisabled) issues.add('remote scripts are not disabled');

    if (issues.isNotEmpty) {
      return MathEditorEngineSelection(
        requestedEngine: requestedEngine,
        selectedEngine: rollbackEngine,
        switchAllowed: false,
        fallbackUsed: true,
        rollbackAvailable: rollbackFlagAvailable || legacyFallbackAvailable,
        diagnostic: 'q88-mathlive-switch-blocked-legacy-fallback',
        issues: issues,
      );
    }

    return const MathEditorEngineSelection(
      requestedEngine: MathEditorEngineKind.mathLive,
      selectedEngine: MathEditorEngineKind.mathLive,
      switchAllowed: true,
      fallbackUsed: false,
      rollbackAvailable: true,
      diagnostic: 'q88-mathlive-switch-allowed-behind-flag',
      issues: <String>[],
    );
  }

  static MathEditorEngineSelection resolveFromCourtVerdict({
    required MathLiveCursorCourtVerdict verdict,
    required bool mathLiveFlagEnabled,
    required bool graphHistorySolutionAdaptersReady,
    required bool rollbackFlagAvailable,
    required bool officialRuntimeBundled,
    required bool labRunsOnDevice,
    required bool keyboardBridgePasses,
    required bool stateAdapterPasses,
    required bool protectedSurfacesUnchanged,
    required bool virtualKeyboardDisabled,
    required bool remoteScriptsDisabled,
  }) {
    return resolveEngine(
      requestedEngine: MathEditorEngineKind.mathLive,
      mathLiveFlagEnabled: mathLiveFlagEnabled,
      q87CourtPassed: verdict.mayClaimMathLiveCursorPass,
      officialRuntimeBundled: officialRuntimeBundled,
      labRunsOnDevice: labRunsOnDevice,
      keyboardBridgePasses: keyboardBridgePasses,
      stateAdapterPasses: stateAdapterPasses,
      graphHistorySolutionAdaptersReady: graphHistorySolutionAdaptersReady,
      rollbackFlagAvailable: rollbackFlagAvailable,
      protectedSurfacesUnchanged: protectedSurfacesUnchanged,
      virtualKeyboardDisabled: virtualKeyboardDisabled,
      remoteScriptsDisabled: remoteScriptsDisabled,
    );
  }
}

class MathEditorEngineSelection {
  const MathEditorEngineSelection({
    required this.requestedEngine,
    required this.selectedEngine,
    required this.switchAllowed,
    required this.fallbackUsed,
    required this.rollbackAvailable,
    required this.diagnostic,
    required this.issues,
  });

  final MathEditorEngineKind requestedEngine;
  final MathEditorEngineKind selectedEngine;
  final bool switchAllowed;
  final bool fallbackUsed;
  final bool rollbackAvailable;
  final String diagnostic;
  final List<String> issues;

  bool get selectedLegacy => selectedEngine == MathEditorEngineKind.legacyFlutterSlotEditor;
  bool get selectedMathLive => selectedEngine == MathEditorEngineKind.mathLive;
}
