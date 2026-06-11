# V172-Q382R32 — ALL_KEY_LATENCY_CLOSURE_AND_TEMPLATE_FAST_PATHS

## Scope
Q382R32 closes the first all-key latency pass for non-linear input families without widening optimistic echo.

Covered families:

- Main keyboard linear/text/operator entries
- Structural templates such as fraction/root/wrapper/postfix templates
- Function templates such as sin/cos/tan/log/lim/sum/integral/Taylor
- MORE template tray entries
- Long-press child selections
- Delete repeat cadence
- Clear priority safety

## What changed

- Added `AllKeyLatencyClosureTemplateFastPathsQ382R32Policy`.
- Wired Q382R29 category debounce to Q382R32 template/MORE/long-press/delete timings.
- Kept template/MORE/long-press entries out of optimistic echo and tap-down dispatch.
- Added Q382R32 coverage fields to the all-key latency court inventory/summary.
- Added a JS-side bounded template payload cache in the production MathLive bridge.

## What did not change

- Keyboard layout/order/labels
- Long-press list contents/order
- MORE/template tray inventory/order
- Q382R27 optimistic echo scope
- MathLive native caret ownership
- OCR/camera
- Graph/Solution/History semantics
- AndroidManifest/MainActivity/Gradle
- Pan/drag-scroll

## Safety notes

Optimistic echo remains linear-only. Template, MORE and long-press entries rely on Q382R28 sequence-safe JS queue, Q382R32 template payload cache, and category-aware downstream debounce.

## Honest limit

This package was statically verified in an environment without Flutter/Dart. Flutter analyze/test/run and real-device latency PASS must be proven by the user-side run.
