# V172-Q146 MathLive Runtime Sync Binding Audit Report

## Scope

Q146 binds the current MathLive main-editor snapshot to the runtime data path that feeds CalculatorController, Graph eligibility, History payloads, and Solution/evaluator candidates.

This phase is a real integration repair, not a guard-only document phase. It does not mutate protected keyboard, MORE, long-press, Graph, History, or Solution UI files and does not claim real-device, cursor, or Photomath-level PASS without user-side evidence.

## Implemented

- Added `MathLiveRuntimeSyncBindingPolicy` and `MathLiveRuntimeSyncEnvelope`.
- The envelope combines Q102 normalization, Q103 graph eligibility, Q104 history payload, and Q105 solution/evaluator candidate data.
- `AppShell` now stores the last MathLive runtime envelope and uses it for controller expression sync, evaluation expression selection, history expression selection, and graph eligibility routing.
- Runtime graph routing now uses the MathLive snapshot-derived normalized expression instead of stale Flutter shadow text.
- Runtime history recording now uses the MathLive snapshot-derived history expression while still relying on the existing protected `HistoryController` API.
- Solution/evaluator candidate routing remains honest: unsupported/open-slot/advanced expressions are preserved without fake solution generation.

## Explicit Non-Changes

- No keyboard layout change.
- No key order change.
- No MORE/Ans/↵/= behavior change.
- No long-press source-of-truth change.
- No `graph_card.dart` mutation.
- No `history_controller.dart` mutation.
- No `history_panel.dart` mutation.
- No `solution_steps_panel.dart` mutation.
- No fake solver/graph/result evidence.
- No real-device or Photomath-level PASS claim.

## Verification Status

Package-side static verification is available through:

```powershell
node tool/verify_mathlive_runtime_sync_binding_v172_q146.mjs
```

Flutter/Dart and real-device verification must be run on the user's machine.
