# V172-Q382R26 — CARET_CONTEXT_BRIDGE

## Scope

This phase adds explicit native MathLive caret context to the MathLive → Flutter state payload.
It is a prerequisite for any future safe optimistic linear echo, but it does not enable optimistic echo.

## Added/Changed

- `assets/mathlive/mathlive_prod_bridge.js`
  - Adds `CARET_CONTEXT_BRIDGE_PHASE = V172-Q382R26`.
  - Adds `caretContext` to production state snapshots.
  - Reads public MathLive caret signals only (`position`, `lastOffset`, `selection` when available).
  - Does not read private shadow DOM caret internals.

- `lib/features/mathlive/mathlive_state_adapter.dart`
  - Adds `MathLiveCaretContextBridgeQ382R26Policy`.
  - Adds `MathLiveCaretContextSnapshot`.
  - Parses nested `caretContext` payload into `MathLiveEditorStateSnapshot`.
  - Exposes `mayAllowOptimisticLinearAppend` as a future gate.

- `test/v172_q382r26_caret_context_bridge_test.dart`
  - Verifies parsing and safety gates.

- `tool/verify_caret_context_bridge_v172_q382r26.mjs`
  - Static verifier for Q382R26 markers and safety constraints.

## Explicit Non-Goals

- No optimistic expression echo.
- No keyboard layout/order/label change.
- No MORE/template tray change.
- No long-press list change.
- No Graph/Solution/History/OCR/Android change.
- No pan/drag-scroll revival.
- No private MathLive shadow DOM caret probe.

## Future Gate

A future optimistic echo phase may only use the linear echo path when:

- `caretContext.trusted == true`
- `selectionCollapsed == true`
- `caretAtDocumentEnd == true`
- `insidePlaceholder == false`
- `insideTemplate == false`
