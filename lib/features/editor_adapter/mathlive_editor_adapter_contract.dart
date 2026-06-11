import 'math_editor_adapter.dart';

/// V172-Q82/Q86 — Future MathLive adapter contract.
///
/// Q82 defines the adapter boundary. Q83 adds the offline asset foundation. Q86 adds a lab-only state adapter boundary.
/// This class is not a WebView implementation and does not claim that a real
/// MathLive runtime is already bundled. It records the exact constraints the
/// future implementation must satisfy before any main-editor switch.
class MathLiveEditorAdapterContract {
  const MathLiveEditorAdapterContract._();

  static const String engineName = 'MathLiveEditorAdapter';
  static const MathEditorEngineKind engineKind = MathEditorEngineKind.mathLive;

  static const bool implementationBundled = false;
  static const bool mayReplaceMainEditorNow = false;
  static const bool requiresOfflineAssets = true;
  static const bool requiresIsolatedLabScreen = true;
  static const bool requiresKeyboardBridge = true;
  static const bool requiresStateAdapter = true;
  static const bool requiresRealDeviceCursorCourt = true;
  static const bool labStateAdapterImplemented = true;

  static const bool mathLiveVirtualKeyboardEnabled = false;
  static const bool mathLiveVirtualKeyboardMayReplaceMathProKeyboard = false;
  static const bool cdnDependencyAllowed = false;
  static const bool remoteScriptLoadingAllowed = false;
  static const bool protectedKeyboardMutationAllowed = false;
  static const bool protectedGraphHistorySolutionMutationAllowed = false;

  static const String webViewAssetPath = 'assets/mathlive/index.html';
  static const String bridgeAssetPath = 'assets/mathlive/mathlive_bridge.js';
  static const String styleAssetPath = 'assets/mathlive/mathlive.css';
  static const String manifestAssetPath = 'assets/mathlive/manifest.json';

  static const Map<String, String> commandExamples = <String, String>{
    '7': 'insert("7")',
    '+': 'insert("+")',
    'fraction': r'insert("\\frac{}{}")',
    'sqrt': r'insert("\\sqrt{}")',
    'power': 'insert("^{}")',
    'subscript': 'insert("_{}")',
    'sin': r'insert("\\sin\\left(\\right)")',
    'logBase': r'insert("\\log_{}\\left(\\right)")',
    'backspace': 'executeCommand("deleteBackward")',
    'equals': 'insert("=")',
    'enter': 'MathPro evaluate bridge',
    'ans': 'insert(lastAnswer)',
  };

  static bool mayStartMathLiveLab({
    required bool offlineAssetsDeclared,
    required bool usesRemoteScripts,
    required bool protectedSurfacesUnchanged,
  }) {
    return offlineAssetsDeclared && !usesRemoteScripts && protectedSurfacesUnchanged;
  }

  static bool maySwitchMainEditor({
    required bool adapterImplemented,
    required bool offlineLabPasses,
    required bool keyboardBridgePasses,
    required bool stateAdapterPasses,
    required bool realDeviceCourtPasses,
    required bool protectedSurfacesUnchanged,
  }) {
    return adapterImplemented &&
        offlineLabPasses &&
        keyboardBridgePasses &&
        stateAdapterPasses &&
        realDeviceCourtPasses &&
        protectedSurfacesUnchanged;
  }
}
