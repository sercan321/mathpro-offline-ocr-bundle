# V172-Q304 — Android Native Runtime Bridge Implementation Gate Audit

## Purpose

Q304 returns the product-development OCR path to the Android native/runtime bridge boundary after Q303, but it does **not** implement a real bridge. The phase defines the contract for a future `MainActivity`/MethodChannel/native handler implementation while blocking mutation until Q302 artifact SHA evidence and Q303 real dependency evidence exist.

## Runtime Boundary

Reserved values:

- MethodChannel: `com.mathpro.gauss/pp_formulanet_s_runtime`
- Native handler: `GaussPpFormulaNetSRuntimeHandler`
- Feature flag: `gauss.ppFormulaNetS.androidNativeRuntimeBridge.defaultOff`

The bridge remains default-off and unbound in Q304.

## Explicitly Not Added

- no `MainActivity.kt` mutation
- no `AndroidManifest.xml` mutation
- no `pubspec.yaml` mutation
- no Paddle runtime
- no PaddleOCR dependency
- no JNI/native handler implementation
- no MethodChannel runtime binding
- no Gradle native runtime dependency
- no model binary
- no production download
- no private artifact load
- no runtime startup
- no dummy runtime call
- no image-to-LaTeX inference
- no editable MathLive review launch
- no workspace import
- no automatic Solve / Graph / Solution / History
- no OCR PASS, Camera/OCR runtime PASS, store-ready PASS, or release PASS

## Preconditions Before Future Real Bridge Implementation

- Q302 controlled download log
- Q302 expected SHA256 lock
- Q302 actual SHA256 computation
- expected/actual SHA256 match
- Q303 real runtime dependency version/source evidence
- Q303 build evidence for the dependency
- license compatibility review
- Android ABI matrix
- MethodChannel contract review
- MainActivity binding diff review
- rollback plan
- default-off feature flag
- real-device build log before activation

## Protected Surface Result

Keyboard, MORE/template tray, long-press lists, MathLive production route/bridge, Graph, Solution, History, AppShell, Workspace, Camera shell, AndroidManifest, MainActivity, splash/icon, solver/evaluator, `pubspec.yaml`, camera dependencies, and Android toolchain remain protected and unchanged.
