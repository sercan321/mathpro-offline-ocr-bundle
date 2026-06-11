# V172-Q387R3 — Paddle Lite `.nb` Artifact Acquisition / Conversion Protocol

## Scope

Q387R3 is not an OCR PASS phase. It is the production handoff protocol between the Q387R2 guarded `.nb` download/install worker and the future Q388 real Paddle Lite inference proof.

Q387 established that the current Android Paddle Lite Java API line must not blindly load `inference.pdiparams`. Q387R1 defined the strict `.nb` evidence contract. Q387R2 created the worker that can download and install a verified `.nb`. Q387R3 defines the exact acquisition/conversion evidence required before a production `.nb` source may be bound to that worker.

## Current decision

No verified production PP-FormulaNet-S Android Paddle Lite `.nb` binary is bundled or bound by this phase.

Current blocked reason:

```text
q387r3-verified-paddle-lite-nb-artifact-not-acquired
```

Q388 real inference remains blocked until Q387R3 evidence exists.

## Required evidence for the next handoff

A candidate `.nb` artifact may be bound to Q387R2 only when all of the following exist:

- source model id: `pp_formulanet_s`
- source model revision / provenance
- source inference files list: `config.json`, `inference.json`, `inference.yml`, `inference.pdiparams`
- conversion tool: `paddle_lite_opt`
- conversion tool version compatible with the bundled Android Paddle Lite runtime/JAR line
- Android target: `android-arm64-v8a`
- exact conversion command, using either `--model_dir` or `--model_file` + `--param_file`, plus `--optimize_out`
- conversion log digest
- output `.nb` file name
- output `.nb` SHA256
- output `.nb` size
- HTTPS download URL
- conversion provenance text
- proof that the `.nb` is not bundled in the base APK/AAB

## Guardrails

Q387R3 does not:

- invent a `.nb` URL
- invent a SHA256
- invent conversion success
- bundle `.nb`, `.pdiparams`, `.pdmodel`, `.onnx`, `.tflite`, or `.safetensors` files in the base app
- reintroduce ONNX Runtime
- claim Android OCR PASS
- claim Flutter analyze/test/build PASS
- touch keyboard/Q382 ordering
- touch MORE/template tray
- touch long-press inventory
- touch Graph, History, Solution, or Solver semantics

## Expected next phase

The next phase is only allowed when real conversion/acquisition evidence is available:

```text
Q387R4 — Bind verified .nb production source into Q387R2 model download/install path
```

If the verified `.nb` artifact cannot be produced, the correct decision is not to fake OCR. The project must either obtain a compatible Paddle Lite `.nb`, adjust the runtime stack to a runtime that supports the available artifact format, or choose another free/offline OCR architecture while preserving the download-only APK contract.
