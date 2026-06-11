/// V172-Q382R33R3 — Key ordering regression repair.
///
/// Q382R24/Q382R28 allowed hot insert/delete commands to be accepted
/// synchronously and delivered to the WebView without awaiting state echo.
/// That is still the right performance contract, but WebView JavaScript calls
/// must not arrive at the JS-side queue out of sequence.  This policy keeps the
/// UI non-blocking while requiring the Dart dispatch tail to serialize the
/// enqueue call itself for commands that are also handled by the Q382R28
/// JS-side command queue.
class MathLiveKeyOrderingRegressionQ382R33R3Policy {
  const MathLiveKeyOrderingRegressionQ382R33R3Policy._();

  static const String phase = 'V172-Q382R33R3';
  static const String contract = 'q382r33r3-key-ordering-regression-repair-active';

  static const bool preservesKeyboardLayoutOrderLabels = true;
  static const bool preservesMoreInventory = true;
  static const bool preservesLongPressLists = true;
  static const bool preservesMathLiveNativeCaretAuthority = true;
  static const bool preservesOptimisticEchoScope = true;
  static const bool preservesQ384DownloadOnlyOcrContract = true;

  /// Insert/delete payloads that are sent to the Q382R28 JS queue are still
  /// accepted synchronously by Flutter, but the WebView enqueue JavaScript call
  /// itself must travel through the existing production dispatch tail.  This
  /// prevents a later fast tap (for example `7`) from reaching JS before an
  /// earlier fast tap (for example `8`).
  static const bool serializeDartDispatchBeforeJsSideQueue = true;

  static const bool staleFlutterSnapshotGuardEnabled = true;
  static const bool optimisticEchoScopeExpanded = false;
  static const bool templateOptimisticEchoAllowed = false;
  static const bool panDragScrollReintroduced = false;

  static bool mustSerializeJsSideQueueDispatch({required bool commandUsesJsSideQueue}) {
    return serializeDartDispatchBeforeJsSideQueue && commandUsesJsSideQueue;
  }

  static const bool flutterAnalyzePassClaimedByAssistant = false;
  static const bool flutterTestPassClaimedByAssistant = false;
  static const bool realDevicePassClaimed = false;
}
