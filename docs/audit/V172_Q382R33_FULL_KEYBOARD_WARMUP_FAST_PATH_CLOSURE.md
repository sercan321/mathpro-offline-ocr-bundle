# V172-Q382R33 — Full Keyboard Warmup & Fast Path Closure

Purpose: reduce cold-start latency for the full keyboard/MORE/long-press/template surface without expanding optimistic echo and without changing any keyboard inventory.

Implemented:
- Added `MathLiveFullKeyboardWarmupQ382R33Policy`.
- Built warmup inventory from existing `KeyConfig`, `KeyConfig.longPressMap`, and `ActionUtils.morePanelCategories`.
- Called WebView warmup once after production MathLive mount/page finish.
- Added `mathproWarmupAllKeys` / `q382r33WarmupAllKeys` to the production JS bridge.
- Warmup fills the Q382R32 document/template payload cache only; it does not insert, delete, clear, set value, or mutate the visible editor.
- Added MORE chip metric cache and keep-alive marker.
- Added long-press panel width cache and startup prewarm hook.

Preserved:
- Keyboard layout/order/labels.
- Long-press option lists and ordering.
- MORE inventory and category ordering.
- Q382R27 optimistic echo scope.
- Template slot/caret behavior.
- Graph, History, Solution, Solver, OCR, AndroidManifest, Gradle, MainActivity, splash/icon.
- No pan/drag-scroll/global touch capture.

Limits:
- This phase does not claim Flutter analyze/test/run PASS in the assistant environment.
- Real-device latency must be measured by the user/device logs.
