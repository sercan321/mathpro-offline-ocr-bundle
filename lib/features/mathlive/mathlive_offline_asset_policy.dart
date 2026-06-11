/// V172-Q83 — Offline MathLive Asset Foundation.
///
/// This policy only establishes the offline asset boundary. It intentionally
/// does not claim a real MathLive runtime is already bundled, does not create a
/// main-editor switch, and does not enable MathLive's virtual keyboard.
class MathLiveOfflineAssetPolicy {
  const MathLiveOfflineAssetPolicy._();

  static const String phase = 'V172-Q83';
  static const String assetRoot = 'assets/mathlive/';
  static const String indexHtmlAsset = 'assets/mathlive/index.html';
  static const String bridgeJsAsset = 'assets/mathlive/mathlive_bridge.js';
  static const String cssAsset = 'assets/mathlive/mathlive.css';
  static const String manifestAsset = 'assets/mathlive/manifest.json';

  static const List<String> requiredAssetPaths = <String>[
    indexHtmlAsset,
    bridgeJsAsset,
    cssAsset,
    manifestAsset,
  ];

  static const bool offlineAssetRootDeclared = true;
  static const bool realMathLiveRuntimeBundled = false;
  static const bool labScreenImplemented = false;
  static const bool mainEditorSwitchAllowed = false;
  static const bool cdnDependencyAllowed = false;
  static const bool remoteScriptLoadingAllowed = false;
  static const bool mathLiveVirtualKeyboardEnabled = false;
  static const bool mathLiveMayReplaceMathProKeyboard = false;
  static const bool protectedUiSurfaceMutationAllowed = false;
  static const bool flutterAnalyzePassClaimedByAssistant = false;
  static const bool flutterTestPassClaimedByAssistant = false;
  static const bool flutterRunPassClaimedByAssistant = false;
  static const bool realDeviceMathLivePassClaimed = false;

  static bool assetsAreSufficientForLabBootstrap({
    required bool indexHtmlPresent,
    required bool bridgeJsPresent,
    required bool cssPresent,
    required bool manifestPresent,
    required bool usesRemoteScripts,
  }) {
    return indexHtmlPresent &&
        bridgeJsPresent &&
        cssPresent &&
        manifestPresent &&
        !usesRemoteScripts;
  }

  static bool mayClaimRealMathLiveRuntime({
    required bool officialRuntimeAssetPresent,
    required bool mathFieldConstructsOnDevice,
    required bool realDeviceFocusPasses,
  }) {
    return officialRuntimeAssetPresent && mathFieldConstructsOnDevice && realDeviceFocusPasses;
  }
}
