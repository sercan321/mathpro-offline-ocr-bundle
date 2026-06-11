# V172-Q264 — PP-FormulaNet-S Runtime Prototype Evidence Intake Gate Audit

## Scope
Q264 adds the intake and validation gate for a future real-device runtime prototype smoke evidence JSON/log set. It does not add a runtime, native bridge, download worker, model bytes, or image-to-LaTeX inference.

## Source phase
`V172-Q263-PP-FORMULANET-S-RUNTIME-PROTOTYPE-SMOKE-EVIDENCE-TEMPLATE`

## Added
- `lib/features/camera/gauss_pp_formulanet_s_runtime_prototype_evidence_intake_gate_policy.dart`
- `lib/features/camera/gauss_pp_formulanet_s_runtime_prototype_evidence_intake_gate.dart`
- `test/v172_q264_pp_formulanet_s_runtime_prototype_evidence_intake_gate_test.dart`
- `tool/verify_pp_formulanet_s_runtime_prototype_evidence_intake_gate_v172_q264.mjs`

## Evidence intake fields
- device id
- app version phase
- Android API / ABI
- runtime candidate
- private artifact path
- artifact SHA256
- model-format probe result
- bridge input/output hashes
- bridge invocation status
- latency and peak-memory measurements
- timeout/cancellation status
- bridge error code
- MathLive review opened evidence
- direct-solve blocked evidence
- Flutter analyze/test/run log reference

## Explicit non-goals
- No Paddle runtime.
- No PaddleOCR dependency.
- No JNI/native bridge.
- No MethodChannel runtime binding.
- No model binary.
- No production URL or network download worker.
- No image-to-LaTeX inference.
- No runtime smoke PASS claim.
- No OCR PASS claim.

## Safety
Camera output must continue to flow through editable MathLive review and explicit user approval before any workspace import. Direct camera solve, Graph, Solution, and History remain blocked.
