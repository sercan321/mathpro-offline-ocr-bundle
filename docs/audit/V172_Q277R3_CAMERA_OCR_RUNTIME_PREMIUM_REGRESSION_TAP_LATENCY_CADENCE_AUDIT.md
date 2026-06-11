# V172-Q277R3 — Camera/OCR Runtime Premium Regression Tap Latency Cadence Audit

## Source Evidence

User-side Q277R2 device QA reported that the UI surfaces remained visually intact, but rapid MathPro key taps felt slightly delayed before appearing in the workspace. This phase is a real-device micro repair for keyboard tap-to-MathLive cadence only.

## Scope

- Reduce Flutter-side command-tail waiting after each MathLive production key dispatch.
- Keep native MathLive `<math-field>` as the renderer/caret authority.
- Avoid redundant Dart-side post-dispatch state refresh after every normal key.
- Preserve bridge state pushed from the production JS bridge.

## Intentionally Changed Protected Surface

`lib/features/mathlive/mathlive_production_editor_surface.dart` changed intentionally because the reported latency is inside the MathLive production command tail. This is a narrow performance/cadence repair, not a route change.

## Not Changed

- Keyboard layout, key order, key inventory.
- MORE/template tray content or order.
- Long-press lists or popup inventories.
- `assets/mathlive/mathlive_prod_bridge.js`.
- Graph, Solution, History runtime/UI.
- AppShell keyboard routing.
- Workspace runtime behavior outside the MathLive production surface.
- Camera shell or OCR review/import safety.
- Solver/evaluator behavior.
- Android Manifest/MainActivity/toolchain/camera dependencies.

## Runtime/OCR Boundary

No real OCR runtime, Paddle/PaddleOCR dependency, JNI/native binding, MethodChannel runtime binding, model binary, production model URL, download worker, or image-to-LaTeX inference was added. No OCR PASS, Camera/OCR runtime PASS, tap-latency PASS, premium final PASS, or release PASS is claimed without user-side retest.
