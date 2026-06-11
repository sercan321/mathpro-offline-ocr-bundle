/// V172-Q169R8 — MathLive Insert/Value Failure Reason Court.
///
/// This is a diagnostic/guard policy only. It does not change keyboard layout,
/// MORE inventory, long-press order, AppShell, Graph, History, Solution, or
/// solver behavior. It exists because real-device evidence reached:
///
///   Q169 KEY:□/□ SEND:Bridge JS:fire MF:true INSERT:false VALUE:empty PAINT:pending
///
/// After Q169R8, the visible diagnostic must expose why insert/value/paint did
/// not commit, for example FAIL:insert-throw, FAIL:value-api-empty-after-insert,
/// FAIL:paint-rect-zero, plus PATH:<value-api-path>.
class MathLiveInsertValueFailureReasonCourtPolicy {
  const MathLiveInsertValueFailureReasonCourtPolicy._();

  static const String phase = 'V172-Q169R8';
  static const String realDeviceFailureObserved =
      'Q169 KEY:□/□ SEND:Bridge JS:fire MF:true INSERT:false VALUE:empty PAINT:pending';

  static const bool exposeFailureReasonInDiagnostic = true;
  static const bool exposeValueApiPathInDiagnostic = true;
  static const bool exposeInsertPathInBridgeState = true;
  static const bool exposePaintRectStateInBridgeState = true;
  static const bool preserveQ169R7ValueCommitGuard = true;

  static const bool keyboardLayoutMutationAllowed = false;
  static const bool moreInventoryMutationAllowed = false;
  static const bool longPressOrderMutationAllowed = false;
  static const bool graphHistorySolutionUiMutationAllowed = false;
  static const bool appShellMutationAllowed = false;
  static const bool realDevicePassClaimed = false;
  static const bool photomathLevelClaimed = false;

  static const List<String> expectedFailureReasonExamples = <String>[
    'insert-throw',
    'insert-api-missing',
    'value-api-empty-after-insert',
    'direct-value-commit-empty-after-write',
    'paint-rect-zero',
    'paint-pending-empty-value',
    'paint-pending-empty-native-value',
  ];
}
