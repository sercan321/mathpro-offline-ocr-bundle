/// V172-Q277R3 — MathLive Production Tap Latency Cadence Repair.
///
/// User-side real-device evidence after Q277R2 showed that the UI, keyboard,
/// camera, MathLive route, Graph, Solution, and History remained visually intact,
/// but rapid key taps felt slightly delayed before appearing in the workspace.
///
/// This policy authorizes a narrow production MathLive command-tail cadence
/// repair only. It does not change keyboard layout, MORE, long-press inventories,
/// OCR review/import safety, Graph/Solution/History behavior, solver behavior,
/// model download, runtime inference, or the native MathLive bridge contract.
class MathLiveProductionTapLatencyCadencePolicy {
  const MathLiveProductionTapLatencyCadencePolicy._();

  static const String phase =
      'V172-Q277R3-CAMERA-OCR-RUNTIME-PREMIUM-REGRESSION-TAP-LATENCY-CADENCE';
  static const String sourcePhase =
      'V172-Q277R2-CAMERA-OCR-RUNTIME-PREMIUM-REGRESSION-ANALYZER-HYGIENE';

  static const bool userReportedTapToWorkspaceLatency = true;
  static const bool repairModeIsRealDeviceLatencyMicroRepair = true;

  static const bool keyboardLayoutChanged = false;
  static const bool moreTemplateTrayChanged = false;
  static const bool longPressListsChanged = false;
  static const bool graphSolutionHistoryRuntimeChanged = false;
  static const bool cameraOcrReviewSafetyChanged = false;
  static const bool solverEvaluatorChanged = false;
  static const bool splashIconChanged = false;

  static const bool protectedMathLiveProductionSurfaceChanged = true;
  static const bool mathLiveProductionBridgeJsChanged = false;
  static const bool mathLiveProductionRouteChanged = false;
  static const bool legacyFlutterCursorRouteReintroduced = false;

  static const bool commandTailMayAwaitFlutterStateEcho = false;
  static const bool emitOptimisticStateBeforeJsDispatch = false;
  static const bool awaitPostDispatchFlutterStateEcho = false;
  static const bool redundantDartStateRefreshAfterEveryKeyDispatch = false;
  static const bool webViewJavaScriptDispatchRemainsSerial = true;
  static const bool nativeMathLiveRemainsRendererAuthority = true;

  static const bool realOcrRuntimeAdded = false;
  static const bool paddleRuntimeAdded = false;
  static const bool paddleOcrDependencyAdded = false;
  static const bool nativeBridgeImplementationAdded = false;
  static const bool methodChannelRuntimeBindingAdded = false;
  static const bool modelBinaryBundledInBaseApp = false;
  static const bool realImageToLatexInferenceExecuted = false;

  static const bool flutterAnalyzePassClaimedByAssistant = false;
  static const bool flutterTestPassClaimedByAssistant = false;
  static const bool flutterRunPassClaimed = false;
  static const bool androidRealDevicePassClaimed = false;
  static const bool tapLatencyPassClaimed = false;
  static const bool ocrPassClaimed = false;
  static const bool cameraOcrRuntimePassClaimed = false;
  static const bool premiumFinalPassClaimed = false;
  static const bool releasePassClaimed = false;

  static const List<String> repairedIssues = <String>[
    'realDeviceKeyboardTapToWorkspaceLatencyReducedByNonAwaitingStateEcho',
    'redundantDartPostDispatchStateRefreshRemovedForNormalKeyCadence',
  ];

  static const List<String> requiredUserSideRetest = <String>[
    'flutter clean',
    'flutter pub get',
    'flutter analyze',
    'flutter test',
    'flutter run -d 23106RN0DA',
    'real-device rapid keyboard tap cadence check',
  ];
}
