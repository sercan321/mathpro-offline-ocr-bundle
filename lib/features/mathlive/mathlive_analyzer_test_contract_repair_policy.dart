/// V172-Q169R29 — Analyzer/Test Contract Repair.
///
/// Repairs the user-side Q169R28 evidence without changing runtime ownership:
/// - analyzer info diagnostics in MathLiveMainEditorSurface are removed;
/// - the Q169R24-R27 authority-chain Flutter test can see the explicit
///   real-device paint non-claim marker it requires;
/// - runtime/device/premium success remains unclaimed until real device proof.
class MathLiveAnalyzerTestContractRepairPolicy {
  const MathLiveAnalyzerTestContractRepairPolicy._();

  static const String phase = 'V172-Q169R29';
  static const bool keyboardLayoutMutationAllowed = false;
  static const bool appShellMutationAllowed = false;
  static const bool graphHistorySolutionUiMutationAllowed = false;
  static const bool runtimeBehaviorMutationAllowed = false;
  static const bool premiumVisualPolishAllowed = false;
  static const bool assistantFlutterAnalyzePassClaimed = false;
  static const bool assistantFlutterTestPassClaimed = false;
  static const bool realDevicePaintPassClaimed = false;

  static const String repairedAnalyzePreferFinalField = '_q169SingleCommandBusLocked';
  static const String repairedAnalyzeInterpolationDiagnostic = 'unnecessary_brace_in_string_interps';
  static const String repairedFlutterTestMarker = 'MathLiveNativePaintOwnershipAuthorityPolicy.realDevicePaintPassClaimed';
}
