/// V172-Q247 — Winner Engine Selection.
///
/// This phase creates the selection gate for the future camera math OCR winner.
/// It does not select a winner without real Q246 benchmark evidence, does not
/// bind an OCR runtime, and does not add model bytes, downloads, MathLive bridge
/// calls, workspace import, solve, graph, solution, or history writes.
class GaussWinnerEngineSelectionPolicy {
  const GaussWinnerEngineSelectionPolicy._();

  static const phase = 'V172-Q247-WINNER-ENGINE-SELECTION';
  static const closesOverPhase = 'V172-Q246-OCR-ENGINE-REAL-BENCHMARK-PACKAGE';
  static const sourcePackageSha256 = 'a7c58a1cb90583a6e0ae0bd6cf6790107ade1fb4664a7a67437538b190c55330';

  static const q246RealBenchmarkPackagePreserved = true;
  static const winnerSelectionGateImplemented = true;
  static const realBenchmarkEvidenceRequired = true;
  static const externalLabReportRequired = true;
  static const q240r3IntakeGateRequired = true;
  static const minimumCaseCoverageRequired = 30;
  static const mathLiveEditableReviewRequired = true;
  static const deferredModelDownloadStillRequired = true;
  static const baseApkMustNotCarryModelBytes = true;
  static const plainTextOcrFallbackDisabled = true;
  static const primaryFormulaRecognizerRequired = true;
  static const noWinnerSelectedWithoutRealBenchmark = true;

  static const benchmarkWinnerSelected = false;
  static const selectedWinnerEngineLabel = 'none';
  static const selectedFallbackEngineLabel = 'none';
  static const realOcrRuntimeAdded = false;
  static const textOcrFallbackRuntimeAdded = false;
  static const paddleRuntimeAdded = false;
  static const pix2TextRuntimeAdded = false;
  static const onnxRuntimeAdded = false;
  static const texTellerRuntimeAdded = false;
  static const uniMerNetRuntimeAdded = false;
  static const modelBinaryBundledInBaseApp = false;
  static const productionModelUrlBound = false;
  static const backgroundDownloadWorkerImplemented = false;
  static const productionInferenceAllowed = false;
  static const productionRuntimeBindingAllowed = false;
  static const cameraRuntimeShellChanged = false;
  static const workspaceRuntimeChanged = false;
  static const mathLiveProductionBridgeCalled = false;
  static const directWorkspaceImportImplemented = false;
  static const directSolveFromCameraAllowed = false;
  static const directGraphFromCameraAllowed = false;
  static const directSolutionFromCameraAllowed = false;
  static const directHistoryFromCameraAllowed = false;
  static const androidToolchainModernizationDeferredToQ253 = true;
  static const cameraDependencyChanged = false;
  static const androidSettingsGradleChanged = false;
  static const androidManifestChanged = false;
  static const mainActivityChanged = false;
  static const keyboardMutationAllowed = false;
  static const longPressMutationAllowed = false;
  static const moreMutationAllowed = false;
  static const mathLiveProductionMutationAllowed = false;
  static const graphMutationAllowed = false;
  static const solutionMutationAllowed = false;
  static const historyMutationAllowed = false;
  static const splashLauncherMutationAllowed = false;

  static const flutterAnalyzePassClaimedByAssistant = false;
  static const flutterTestPassClaimedByAssistant = false;
  static const flutterRunPassClaimedByAssistant = false;
  static const androidRealDeviceBenchmarkPassClaimedByAssistant = false;
  static const realEngineAccuracyPassClaimedByAssistant = false;

  static const nextPlannedPhase = 'V172-Q248-DEFERRED-MODEL-DOWNLOAD-RUNTIME';
}
