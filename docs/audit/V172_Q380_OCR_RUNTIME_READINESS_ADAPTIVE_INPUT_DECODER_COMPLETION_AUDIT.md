# V172 Q380 OCR Runtime Readiness / Adaptive Input Decoder Completion Audit

Q380 repairs the software-level gaps found after Q379 inspection:

- Q378 camera flow now routes to the Q380 adaptive decoder bridge.
- Native OCR execution preflights private model storage before inference.
- Explicit `modelSourcePath` can trigger Q364 private-storage activation, but no automatic startup/camera copy is performed.
- ONNX input metadata shape is read when available.
- NCHW, NHWC, and CHW float32 image tensor layouts are supported with safe fallback dimensions for unknown dynamic axes.
- String, ASCII/codepoint, token-id vocabulary, and float-logit vocabulary argmax decoder paths are supported.
- No fake LaTeX is invented when output is unreadable.
- Editable MathLive review and explicit user approval remain mandatory before workspace import.
- Direct OCR-to-workspace, Solve, Graph, Solution, and History remain blocked.

No ONNX model is bundled in the ZIP and no Android/OCR PASS is claimed by this package.
