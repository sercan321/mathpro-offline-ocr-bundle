import 'dart:io' show Platform;

/// V172-Q198 — Production platform-view policy.
///
/// Production MathLive WebView availability is no longer borrowed from the old
/// lab policy. Flutter tests still skip platform views, while real Android/iOS
/// builds may mount the production WebView.
abstract final class MathLiveProductionPlatformViewPolicy {
  static const String phase = 'V172-Q198';
  static const bool usesLabPolicyForProductionWebView = false;
  static const bool flutterTestMustSkipPlatformView = true;
  static const int maxQueuedKeyboardCommands = 24;

  static bool get isFlutterTestRuntime {
    try {
      return Platform.environment.containsKey('FLUTTER_TEST') ||
          Platform.resolvedExecutable.toLowerCase().contains('flutter_tester');
    } catch (_) {
      return false;
    }
  }

  static bool get canUseProductionWebView => !isFlutterTestRuntime;
}
