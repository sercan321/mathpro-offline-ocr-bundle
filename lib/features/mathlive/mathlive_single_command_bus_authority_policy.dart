/// V172-Q169R25 — MathLive Single Command Bus Authority.
///
/// The main editor must not present AppShell/CalculatorController fallback text
/// as if it were the active math renderer while MathLive mount/command/court
/// authority is locked. Keyboard taps may be recorded as pending intent, but the
/// visible surface is owned by MathLive boot/court/channel state until a real
/// MathLive bridge result arrives.
class MathLiveSingleCommandBusAuthorityPolicy {
  static const String phase = 'V172-Q169R25';

  /// Prevents q157/q165 fallback writes from painting a fake expression after an
  /// empty WebView acknowledgement. Real-device diagnostics must show mount or
  /// court state instead of a synthetic Flutter expression.
  static const bool blocksVisibleFallbackAfterEmptyAck = true;

  /// Prevents CalculatorController/AppShell mirror expressions from being pushed
  /// back into the MathLive field while the single command bus is active.
  static const bool blocksExternalControllerMirrorSync = true;

  /// Prevents the local Flutter fallback overlay from appearing above the
  /// WebView/court surface while MathLive is supposed to own rendering.
  static const bool blocksFlutterVisibleFallbackOverlay = true;

  /// Old Q169 KEY diagnostics are allowed only as historical compatibility
  /// markers; they must not own the visible surface during this phase.
  static const bool blocksOldQ169KeyDiagnosticOwnership = true;

  static const String expectedVisibleAuthorityPrefix = 'MATHLIVE_BOOT';
}
