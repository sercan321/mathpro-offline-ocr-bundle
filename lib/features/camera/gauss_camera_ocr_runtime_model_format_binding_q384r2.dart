/// V172-Q384R2 — camera OCR runtime/model-format binding preflight.
///
/// This phase aligns the Q384R1 downloaded PP-FormulaNet-S artifact with the
/// native bridge contract. It deliberately does not claim production OCR
/// inference, does not produce fake LaTeX, and does not mutate Workspace,
/// Solution, Graph, or History.
class GaussCameraOcrRuntimeModelFormatBindingQ384R2Policy {
  const GaussCameraOcrRuntimeModelFormatBindingQ384R2Policy._();

  static const String phase = 'V172-Q384R2-CAMERA-OCR-RUNTIME-MODEL-FORMAT-BINDING-PREFLIGHT';
  static const String sourcePhase = 'V172-Q384R1-CAMERA-OCR-DEFERRED-MODEL-DOWNLOAD-ACTIVATION';
  static const String engine = 'PP-FormulaNet-S';
  static const String artifactFormat = 'paddle-inference-directory';
  static const String primaryModelFileName = 'inference.pdiparams';
  static const String expectedPrimarySha256 = 'b6392296d16e2a9f414c0a751d7ccbd1bd9d8272b68aab72df1d3875f35a7489';
  static const String nativeBridgeMethod = 'deferredPaddleModelRuntimeBindingPreflight';
  static const String runtimeBlockedReason = 'q384r2-paddle-runtime-binding-not-enabled';

  static const bool q384r1InstallPathPassedToNativeBridge = true;
  static const bool paddleInferenceDirectoryPreflightImplemented = true;
  static const bool onnxMissingReasonRetiredForQ384R2ReviewFlow = true;
  static const bool productionInferenceClaimedByQ384R2 = false;
  static const bool fakeLatexCandidateAllowed = false;
  static const bool workspaceAutoImportAllowed = false;
  static const bool solveGraphSolutionHistoryTouched = false;

  static const List<String> requiredArtifactFiles = <String>[
    'config.json',
    'inference.json',
    'inference.yml',
    primaryModelFileName,
  ];
}
