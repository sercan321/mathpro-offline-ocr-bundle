# V172-Q263-PP-FORMULANET-S-RUNTIME-PROTOTYPE-SMOKE-EVIDENCE-TEMPLATE

## Purpose

Q263 creates the PP-FormulaNet-S runtime prototype smoke evidence template after Q262. The goal is to define exactly what a future real Android runtime smoke must capture before any runtime/inference claim is allowed.

## Static scope

- Records the real-device smoke evidence fields.
- Requires device/API/ABI capture.
- Requires private artifact load and model-format probe evidence.
- Requires bridge input/output envelope evidence.
- Requires latency, peak-memory, timeout/cancellation, memory-pressure, and bridge-error evidence.
- Requires MathLive review evidence and direct solve/Graph/Solution/History block evidence.

## Explicitly not added

- No Paddle runtime.
- No PaddleOCR dependency.
- No JNI/native bridge.
- No MethodChannel runtime binding.
- No PP-FormulaNet-S model binary.
- No production model URL.
- No real network download worker.
- No image-to-LaTeX inference.
- No runtime smoke PASS claim.
- No OCR PASS claim.

## Required future evidence before enabling runtime claims

- realDeviceRuntimeSmokeJson
- realAndroidAbiMatrixCapture
- realPrivateArtifactLoadSmoke
- realModelFormatProbeLog
- realBridgeInvocationSmoke
- realLatencyMeasurement
- realPeakMemoryMeasurement
- realTimeoutCancellationEvidence
- realMathLiveReviewImportEvidence
- realDirectSolveBlockedEvidence
- FlutterAnalyzeTestRunLog

## Safety invariant

Camera output must pass through editable MathLive review and explicit user approval before any workspace import. Direct camera solve, Graph, Solution, and History remain blocked.
