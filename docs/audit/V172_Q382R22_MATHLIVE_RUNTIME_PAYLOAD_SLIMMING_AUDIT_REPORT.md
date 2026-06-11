# V172-Q382R22 — MathLive Runtime Payload Slimming Audit Report

## Scope
This phase reduces the hot MathPro keyboard command payload sent from Dart to the production MathLive JavaScript bridge. The previous runtime command payload carried many policy/phase fields that the JavaScript insert/delete/clear hot path did not consume. Q382R22 keeps those historical markers outside the runtime JSON command payload and sends only the command fields used by the bridge.

## Runtime payload after Q382R22
Required fields:
- `label`
- `action`
- `latex`
- `sequence`

Optional bounded field:
- `lastAnswer`, only when non-empty

## Preserved behavior
- Serial production command queue is preserved.
- `androidBridgeCommandTimeout` is preserved.
- Q382R19 keyboard insertion state-push budget is preserved.
- Native MathLive caret authority is preserved.
- Slot/template semantics are preserved.
- Keyboard layout/order/labels and long-press lists are untouched.
- MORE, Graph, Solution, Result, History, OCR/Camera, Android/Kotlin, Gradle, solver, and splash/icon are untouched.
- Q382R13/Q382R14/Q382R16 pan experiments remain removed.

## Compatibility notes
Older phase/verifier markers remain in source comments/assert references, but not in the hot runtime JSON command payload. This keeps traceability without paying per-key JSON encode/decode overhead for policy metadata that JavaScript does not need for insertion.

## Honest boundary
This is a static/code-level optimization phase. Flutter analyze/test/run and real-device latency PASS require the user's local Flutter SDK and device evidence.
