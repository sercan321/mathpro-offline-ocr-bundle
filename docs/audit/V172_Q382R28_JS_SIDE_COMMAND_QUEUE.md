# V172-Q382R28 — JS-side Command Queue

Scope: move hot insert/delete command ordering into the production MathLive JS bridge while keeping Dart nonblocking and preserving native MathLive caret authority.

This phase does **not** expand optimistic echo, does **not** change keyboard layout/order/labels, does **not** change MORE or long-press inventory, and does **not** touch Graph, Solution, History, OCR/camera, AndroidManifest, Gradle, MainActivity, splash/icon, or pan/drag-scroll.

## Implemented

- Added `MathLiveJsSideCommandQueueQ382R28Policy`.
- Dart hot insert/delete dispatch now calls `window.MathProProductionMathLiveBridge.enqueueKeyboardCommand(payload)` when Q382R28 policy allows it.
- Clear remains a priority direct path and is not placed into the JS-side queue.
- JS bridge owns a bounded sequence-safe queue for `insertLatex` and `deleteBackward`.
- Queue drain processes a bounded number of commands per tick and preserves existing `insertLatex` / `deleteBackward` command semantics.
- Existing canonical MathLive state push and Q382R23 latency fields remain active.

## Not Claimed

- No Flutter analyze/test/run PASS claimed by the assistant.
- No real-device latency PASS claimed.
- No WhatsApp-level PASS claimed.
