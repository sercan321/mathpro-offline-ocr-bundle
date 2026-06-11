# V172 Q367 — First Real Image-to-LaTeX Inference Audit

Q367 adds an explicit-invocation-only first real image-to-LaTeX inference bridge after Q366 dummy runtime-call execution.

The bridge validates ONNX Runtime availability, private storage model size/SHA, and a caller-provided source image path. It decodes and resizes the image into a generic NCHW float32 tensor and attempts an ONNX Runtime session run only when explicitly invoked.

Q367 does not auto-run from startup, camera, workspace, Solve, Graph, Solution, or History. It does not bundle the ONNX model and does not claim OCR pass, image-to-LaTeX pass, review pass, workspace import pass, store-ready pass, or release-ready pass.
