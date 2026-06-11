# V172-Q280 — Native/Runtime Bridge Implementation Behind Flag Audit

Q280 installs a Dart-side native/runtime bridge envelope and guarded façade for the future PP-FormulaNet-S runtime path.

This phase is intentionally default-off and evidence-gated. It does not add a native Android handler, JNI binding, Paddle/PaddleOCR dependency, model binary, production URL, downloader, or image-to-LaTeX inference.

## Safety position

- PP-FormulaNet-S remains the selected primary candidate.
- Text OCR fallback remains text fallback only.
- Bridge flag is not enabled by default.
- Runtime invocation is blocked while the flag is off.
- Native handler binding is deferred.
- OCR output must still enter editable MathLive review first.
- Explicit user approval remains mandatory before any workspace import.
- Direct solve, Graph, Solution, and History writes from camera/OCR remain blocked.

## Protected surfaces

Keyboard, MORE/template tray, long-press lists, MathLive production route, Graph, Solution, History, AppShell, workspace runtime, camera shell runtime, solver/evaluator, splash/icon, Android manifest, MainActivity, camera dependencies, and Android toolchain were not changed.

## No PASS claim

Q280 is static/verifier-ready only. It does not claim Flutter analyze/test/run PASS, Android real-device PASS, native bridge PASS, OCR PASS, runtime PASS, or release PASS.

Explicit runtime exclusions: no Paddle runtime, no PaddleOCR dependency, no native handler, no JNI binding, no production inference.
