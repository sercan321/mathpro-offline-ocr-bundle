# V172-Q247 Winner Engine Selection Audit

Q247 is a selection-gate phase over Q246. It creates the evidence boundary for choosing a future camera math OCR winner, but it does not claim or bind a winner.

## Source Phase

- Source phase: V172-Q246 OCR Engine Real Benchmark Package
- Source package SHA256: `a7c58a1cb90583a6e0ae0bd6cf6790107ade1fb4664a7a67437538b190c55330`

## Q247 Scope

Q247 defines the hard gates that must be satisfied before the project may move toward Q248 deferred model download planning:

- real Q246/Q240R3-compatible benchmark report,
- at least 30 real sample results,
- editable MathLive review required for every OCR candidate,
- direct solve/evaluate blocked,
- license cleared for distribution,
- offline-after-install proof,
- deferred model size budget,
- median latency budget,
- plain text OCR fallback-only enforcement.

## Candidate Policy

The candidate field remains unchanged:

- PP-FormulaNet-S
- PP-FormulaNet_plus-S
- Pix2Text MFR ONNX
- UniMERNet tiny
- TexTeller
- Plain text OCR fallback

Text OCR fallback is fallback-only. It must not be selected as the primary formula recognizer for integral, derivative, fraction, radical, limit, sigma, matrix, or nested mathematical layout recognition.

## Explicit Non-Claims

Q247 does not add Text OCR fallback, PaddleOCR, Pix2Text, ONNX, TexTeller, UniMERNet, model binaries, production model URLs, background download workers, inference runtime, MathLive production bridge calls, direct workspace import, direct solve, direct Graph, direct Solution, or direct History writes.

Q247 does not claim real OCR accuracy, real benchmark PASS, Android real-device OCR PASS, Flutter analyze PASS, Flutter test PASS, Flutter run PASS, premium final PASS, or release PASS.

## Runtime Preservation

Keyboard, MORE, long-press, MathLive production editor, workspace runtime, camera shell runtime, Graph, Solution, History, splash, launcher icon, Android manifest runtime behavior, MainActivity runtime behavior, camera dependency, Kotlin plugin, and AGP were not changed by Q247.

## Next Phase

The next planned phase is Q248 Deferred Model Download Runtime. Q248 must not start as a production OCR runtime binding unless Q247 evidence gates are satisfied. If real benchmark evidence is still absent, Q248 may only create a guarded/deferred download shell and must continue to block inference.
