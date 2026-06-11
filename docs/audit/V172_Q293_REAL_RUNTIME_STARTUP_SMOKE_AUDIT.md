# V172-Q293 — First Real Runtime Startup Smoke Audit

## Scope

Q293 adds the guarded contract for the first future PP-FormulaNet-S runtime startup smoke. It is deliberately a startup-smoke boundary, not a runtime implementation and not OCR inference.

## Runtime Boundary

Q293 does not add Paddle runtime, PaddleOCR dependency, JNI binding, MethodChannel runtime binding, native handler implementation, model binary, production download, real private artifact load, model format probe execution, runtime warmup execution, image-to-LaTeX inference, or direct camera-to-workspace/solve/Graph/Solution/History behavior.

The runtime startup feature flag remains default-off:

`gauss.ppFormulaNetS.firstRealRuntimeStartupSmoke.defaultOff`

The package records that startup is blocked until Q292 real private artifact load evidence, verified private artifact path, expected/actual SHA256 match, model format probe, native runtime package, Android ABI, memory/latency budget, and real-device startup evidence exist.

## Safety Rules

- OCR output must remain review-only through editable MathLive review.
- User approval is mandatory before any future workspace import.
- Direct solve, Graph, Solution, and History from camera output remain blocked.
- No OCR, runtime smoke, store-ready, release, or premium PASS is claimed.

## Protected Surface

Q293 does not modify keyboard, MORE/template tray, long-press lists, MathLive production route, MathLive bridge, Graph, Solution, History, AppShell, workspace runtime, camera shell runtime, AndroidManifest, MainActivity, splash/icon, solver/evaluator, pubspec dependencies, camera dependency, or Android toolchain.

## Verification Intent

The Q293 verifier checks the new manifest envelope, policy/test/audit files, successor-aware verifier markers, absence of forbidden runtime/model artifacts, unchanged camera/toolchain dependencies, and protected hash preservation.
