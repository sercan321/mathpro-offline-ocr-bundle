# V172-Q353 ONNX Runtime Mobile Dependency Feasibility Gate Audit

## Phase

`V172-Q353-ONNX-RUNTIME-MOBILE-DEPENDENCY-FEASIBILITY-GATE`

## Source phases

- Runtime strategy source: `V172-Q352-ONNX-CONVERSION-EVIDENCE-ACCEPTANCE-RUNTIME-STRATEGY-PIVOT-GATE`
- Verifier hygiene source: `V172-Q352R1-LEGACY-VERIFIER-SUCCESSOR-AWARENESS-HYGIENE-REPAIR`

## Scope

Q353 is a feasibility gate only. It records the ONNX Runtime Mobile path as the next candidate track after the accepted PP-FormulaNet-S ONNX conversion evidence, but it does not add an Android dependency, does not modify Gradle/pubspec/AndroidManifest/MainActivity, and does not run model-load, runtime startup, dummy input, image-to-LaTeX inference, OCR review, or workspace import.

## Feasibility items recorded

- Q352 ONNX conversion evidence remains accepted evidence only.
- Q352R1 legacy verifier successor-awareness repair remains present.
- The 308 MB `pp_formulanet_s.onnx` artifact remains outside the Flutter project ZIP.
- Q354 dependency/build trial requires explicit approval and a selected dependency coordinate/version before Gradle mutation.
- SHA verification, private-storage strategy, timeout/memory/rollback policy, default-off runtime guard, and no-direct-OCR/import policy are required before real model-load work.

## Preserved red lines

Q353 does not modify workspace UI, keyboard layout/order, MORE/template tray, long-press lists, MathLive production route, Graph, Solution, History, splash/icon, solver/evaluator, AndroidManifest, pubspec, Gradle, or MainActivity runtime behavior.

## Runtime/OCR status

- ONNX Runtime dependency: not added.
- Dependency coordinate/version: not selected in package.
- ONNX model bundle: not added.
- ONNX private-storage copy: not added.
- ONNX model load: not attempted.
- Runtime startup/dummy call: not executed.
- Image-to-LaTeX inference: not executed.
- Editable MathLive OCR review: not opened.
- Workspace import: not executed.
- Solve/Graph/Solution/History: not touched.
- OCR PASS: not claimed.

## Next phase constraint

Q354 may only be an explicit Android dependency / ABI build trial after human approval. Q354 must remain default-off and must not load the ONNX model or claim OCR/runtime PASS.
