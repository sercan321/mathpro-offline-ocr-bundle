# V172 Q382R24 — Changed Files

Phase: `Q382R24 — KEYBOARD_LATENCY_CLOSURE_PACK`

## Modified

- `lib/features/keyboard/premium_key.dart`
  - Adds guarded tap-down dispatch for non-destructive keys that do not own long-press alternatives.
  - Keeps `onTap` fallback and suppresses double insert when tap-down already dispatched.
  - Preserves long-press hooks and visual layout.

- `lib/app/app_shell.dart`
  - Adds a debounce boundary for heavy MathLive downstream sync.
  - MathLive WebView remains the visible/native renderer authority; Graph/History/Solution/CalculatorController envelope work is delayed until key input is idle or explicitly flushed by evaluate/graph.
  - Removes duplicate AppShell-side command mapping from the hot key path; clear remains handled explicitly by `label == 'C'`.
  - Uses the synchronous `sendKeyFast` controller path so AppShell does not wait on a returned Future chain before accepting the key.
  - Evaluate/Graph explicitly flush pending MathLive snapshot before consuming the envelope.

- `lib/features/mathlive/mathlive_main_editor_surface.dart`
  - Adds `sendKeyFast(...)` as the synchronous controller entry point while preserving the existing `sendKey(...)` API as a compatibility wrapper.

- `lib/features/mathlive/mathlive_production_editor_surface.dart`
  - Adds Q382R24 fire-and-forget WebView dispatch for insert/delete commands.
  - Keeps clear on the older priority reset path.
  - Suppresses Dart-side synthetic state echo for successful keyboard commands; canonical JS state remains authoritative.
  - Keeps Android bridge timeout and the production command tail symbols present.

- `assets/mathlive/mathlive_prod_bridge.js`
  - Adds Q382R24 bridge markers.
  - Extends native keyboard-event suppression from 24ms to 64ms.
  - Suppresses the extra keyboard settle push after canonical state push.
  - Keeps canonical `notifyFlutterState(...)` after MathLive insert/delete/clear.

- `lib/debug/latency/mathpro_latency_probe_q382r23.dart`
  - Keeps Q382R23 measurement code present but disables it by default in Q382R24 so debug overlay/logging does not become part of the normal rapid-key feel path.

- `lib/debug/latency/mathpro_latency_overlay_q382r23.dart`
  - Keeps the overlay mounted for future measurement phases but gates it off by Q382R24 policy by default.

- `tool/verify_premium_key_feedback_safety_v172_q382r20.mjs`
  - Accepts Q382R24 as an intentional superseding latency closure while still checking that Q382R20 visual feedback safety is preserved.

- `tool/verify_mathlive_keyboard_insertion_state_push_budget_v172_q382r19.mjs`
  - Accepts Q382R24 as an intentional superseding state-push closure while still checking that the Q382R19 insertion budget infrastructure remains present.

## Added

- `lib/features/keyboard/keyboard_latency_closure_q382r24_policy.dart`
- `lib/features/mathlive/mathlive_keyboard_latency_closure_q382r24_policy.dart`
- `tool/verify_keyboard_latency_closure_v172_q382r24.mjs`
- `docs/audit/V172_Q382R24_KEYBOARD_LATENCY_CLOSURE_AUDIT_REPORT.md`
- `docs/audit/V172_Q382R24_CHANGED_FILES.md`

## Protected / Not Changed

- Keyboard layout/order/labels
- Long-press inventories
- MORE/template tray inventory/order
- MathLive native caret authority
- Android bridge timeout
- Graph UI/controller
- Solution UI/logic widgets
- History UI/controller
- OCR/Camera/model download flow
- AndroidManifest / MainActivity / Gradle
- Splash/icon/app startup
- Pan/drag-scroll experiments remain absent
