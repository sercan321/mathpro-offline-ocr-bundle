import 'dart:io' show Platform;

import 'mathlive_offline_asset_policy.dart';

/// V172-Q84 — isolated MathLive Lab screen policy.
///
/// This policy deliberately keeps MathLive away from the main editor. Q84 only
/// creates a laboratory surface that can load the local Q83 bootstrap asset and
/// report state through a bridge. It does not bundle/claim the official
/// MathLive runtime and it does not replace MathPro's frozen keyboard.
class MathLiveLabScreenPolicy {
  const MathLiveLabScreenPolicy._();

  static const String phase = 'V172-Q84';
  static const String labScreenName = 'MathLiveLabScreen';
  static const String webViewAssetPath = MathLiveOfflineAssetPolicy.indexHtmlAsset;
  static const String bridgeGlobal = 'MathProMathLiveOfflineBridge';

  static const bool labScreenImplemented = true;
  static const bool isolatedLabOnly = true;
  static const bool mainEditorSwitchAllowed = false;
  static const bool protectedUiSurfaceMutationAllowed = false;
  static const bool mathLiveVirtualKeyboardEnabled = false;
  static const bool mathLiveMayReplaceMathProKeyboard = false;
  static const bool cdnDependencyAllowed = false;
  static const bool remoteScriptLoadingAllowed = false;
  static const bool realMathLiveRuntimeBundled = false;
  static const bool realDeviceMathLiveCursorPassClaimed = false;
  static const bool flutterAnalyzePassClaimedByAssistant = false;
  static const bool flutterTestPassClaimedByAssistant = false;
  static const bool flutterRunPassClaimedByAssistant = false;

  /// Platform views are skipped in flutter tests. Real Android/iOS runtime may
  /// load the WebView asset, but Q84 still cannot claim real MathLive cursor
  /// quality because the official runtime is not bundled yet.
  static bool get isFlutterTestRuntime {
    try {
      return Platform.environment.containsKey('FLUTTER_TEST') ||
          Platform.resolvedExecutable.toLowerCase().contains('flutter_tester');
    } catch (_) {
      return false;
    }
  }

  static bool get canUseRuntimeWebView => !isFlutterTestRuntime;

  static bool canOpenLab({
    required bool offlineAssetsDeclared,
    required bool usesRemoteScripts,
    required bool protectedSurfacesUnchanged,
  }) {
    return labScreenImplemented &&
        isolatedLabOnly &&
        offlineAssetsDeclared &&
        !usesRemoteScripts &&
        protectedSurfacesUnchanged &&
        !mainEditorSwitchAllowed &&
        !mathLiveVirtualKeyboardEnabled;
  }

  static bool mayClaimRealMathLiveCursorPass({
    required bool officialRuntimeBundled,
    required bool labRunsOnDevice,
    required bool cursorCourtPasses,
    required bool keyboardBridgePasses,
  }) {
    return officialRuntimeBundled && labRunsOnDevice && cursorCourtPasses && keyboardBridgePasses;
  }
}
