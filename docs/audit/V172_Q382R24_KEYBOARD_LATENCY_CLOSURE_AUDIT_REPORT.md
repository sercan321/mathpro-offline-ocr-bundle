# V172 Q382R24 — Keyboard Latency Closure Pack Audit Report

## Scope

Q382R23 real-device measurements showed high perceived input latency. The most damaging areas were:

- tap-up dispatch variance on some keys,
- heavy Flutter-side downstream frame/rebuild work after MathLive state pushes,
- debug latency overlay/logging overhead remaining visible during normal feel tests,
- extra Dart synthetic state echoes and JS settle pushes after keyboard commands,
- bridge queue/tail waiting spikes on rapid input.

Q382R24 is a single surgical closure pack. It does **not** claim real-device latency PASS. It changes only hot input cadence and downstream timing boundaries.

## What changed

### 1. Guarded tap-down dispatch

`PremiumKey` now dispatches on `onTapDown` only when the key is safe:

- no long-press alternatives,
- not `MORE`,
- not `↵`,
- not `C`,
- not `⌫`,
- key behavior is text/structure/wrapper/postfix insert.

The existing `onTap` path remains as fallback. A `_tapDownDispatched` guard prevents double insert.

### 2. Debug latency instrumentation default-off

Q382R23 instrumentation is still present for future measurement phases, but Q382R24 disables it by default through `KeyboardLatencyClosureQ382R24Policy.latencyProbeEnabledByDefault = false`.

This prevents the overlay and `[Q382R23_LATENCY]` logging from becoming part of normal rapid-key feeling tests.

### 3. Downstream sync debounce

MathLive remains the visible/native editor authority. On normal keyboard state pushes, AppShell no longer immediately builds the full finalized Graph/History/Solution/CalculatorController envelope on every key.

Instead, AppShell stores the latest MathLive snapshot and applies heavy downstream sync after a short idle debounce. Evaluate and Graph flush the pending snapshot first, so explicit actions still consume current MathLive state.

### 4. Fire-and-forget production command dispatch

For insert/delete keyboard commands, the production surface schedules the WebView JavaScript command immediately without serial Future-tail waiting. Clear remains on the older priority reset path.

The existing command-tail field and Android timeout remain in the file for compatibility and non-fast paths, but the hot insert/delete path no longer waits behind the tail before WebView receives the command.

### 5. Canonical-only JS keyboard state push

Q382R19 reduced state spam to canonical + settle. Q382R24 tightens this further for keyboard commands:

- canonical state push remains,
- extra settle push is suppressed,
- native input/selection noise suppression window increases from 24ms to 64ms.

## What did not change

- Keyboard layout/order/labels did not change.
- Long-press option lists did not change.
- MORE/template tray did not change.
- MathLive native caret remains the authority.
- Android bridge timeout remains present.
- Q382R19/Q382R22/Q382R23 phase markers remain present.
- Graph/Solution/History/OCR/Android/Kotlin/Gradle were not intentionally modified.
- Pan/drag-scroll experiments were not reintroduced.

## Expected effect

The package targets the largest observed categories without requiring the user to test many small ZIPs:

- safe keys start dispatch earlier,
- bridge queue spikes should decrease for insert/delete,
- heavy controller/Graph/History/Solution envelope work is removed from every-key state pushes,
- debug overlay/logging no longer pollutes the normal rapid-key feel test,
- JS state pushes after keyboard insert are reduced to canonical state.

Real-device latency PASS is not claimed until the user runs the package on device.
