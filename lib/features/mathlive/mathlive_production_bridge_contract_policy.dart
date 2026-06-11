/// V172-Q186 — Minimal Production MathLive Bridge Contract Freeze.
///
/// This phase freezes the active production bridge as a small public API:
/// mount, insertLatex, deleteBackward, clear, setLatex, getLatex, focus,
/// keepCaretVisible, and notifyFlutterState. Q169 court/debug/smoke/evidence
/// APIs must not exist on the production bridge, and real WebView runtime
/// devices must not be fed by the old Flutter visible fallback mirror.
class MathLiveProductionBridgeContractPolicy {
  const MathLiveProductionBridgeContractPolicy._();

  static const String phase = 'V172-Q186';
  static const bool minimalPublicApiFrozen = true;
  static const bool executeMathProCommandAllowed = false;
  static const bool exposedScheduleMountAllowed = false;
  static const bool exposedFlushQueueAllowed = false;
  static const bool exposedDiagnosticCourtAllowed = false;
  static const bool exposedRuntimeSmokeAllowed = false;
  static const bool exposedRealDeviceDumpAllowed = false;
  static const bool realDeviceFlutterMirrorFeedsProductionSurface = false;
  static const bool flutterTestMirrorFallbackOnly = true;
  static const bool strictRuntimeMountedRequiresCustomElement = true;
  static const bool keyboardLayoutMutationAllowed = false;
  static const bool graphHistorySolutionMutationAllowed = false;
  static const bool flutterAnalyzePassClaimedByAssistant = false;
  static const bool flutterTestPassClaimedByAssistant = false;
  static const bool flutterRunPassClaimedByAssistant = false;
  static const bool realDevicePremiumPassClaimed = false;

  static const List<String> publicBridgeApi = <String>[
    'mount',
    'insertLatex',
    'deleteBackward',
    'clear',
    'setLatex',
    'getLatex',
    'focus',
    'keepCaretVisible',
    'notifyFlutterState',
  ];

  static const bool flutterControllerQueueMayFlush = true;
}
