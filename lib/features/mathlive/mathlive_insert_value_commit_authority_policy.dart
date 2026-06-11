/// V172-Q169R26 — MathLive Insert/Value Commit Authority.
///
/// After Q169R24/Q169R25, the app must not treat Flutter fallback text as a
/// successful math editor command. A MathLive command is successful only when the
/// official math-field produces a non-empty native value or a transparent root
/// cause explains the failure.
class MathLiveInsertValueCommitAuthorityPolicy {
  static const String phase = 'V172-Q169R26';
  static const String expectedNativeValueReadMarker = 'q169r26-native-value';
  static const String expectedCommandFallbackMarker = 'q169R26TryExecuteCommandInsert';
  static const String successRoot = 'none';
  static const String valueEmptyRoot = 'mathfield-value-empty';
  static const String directCommitEmptyFailure = 'direct-value-commit-empty-after-write';
}
