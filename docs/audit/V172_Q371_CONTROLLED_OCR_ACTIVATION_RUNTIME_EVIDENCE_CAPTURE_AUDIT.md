# V172-Q371 Controlled OCR Activation / Runtime Evidence Capture Audit

## Scope
Q371 adds a single explicit-invocation-only native bridge that collects evidence from the existing Q364-Q369 camera/OCR bridge chain.

## What Q371 prepares
- Q364 private-storage ONNX model activation evidence capture.
- Q365 ONNX model-load smoke evidence capture.
- Q366 dummy runtime-call evidence capture.
- Q367 image-to-LaTeX evidence capture.
- Q368 editable MathLive review handoff evidence capture.
- Q369 approved workspace import envelope evidence capture.

## Red lines preserved
- No automatic startup OCR.
- No automatic camera-flow OCR.
- No automatic workspace import.
- No direct OCR-to-Solve/Graph/Solution/History.
- Editable MathLive review remains required before import.
- Explicit user approval remains required before import.

## Intentional change
`android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt` changes only to add the explicit method-channel bridge `controlledOcrActivationRuntimeEvidenceCapture`.

## Not claimed
Q371 does not claim Flutter/Android/model-load/dummy-call/image-to-LaTeX/OCR/review/import/store/release PASS.
