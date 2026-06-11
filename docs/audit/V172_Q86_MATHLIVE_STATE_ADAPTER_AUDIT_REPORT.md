# V172-Q86 MathLive State Adapter Audit Report

## Scope

Q86 adds a lab-only MathLive State Adapter. The adapter consumes local bridge output from `assets/mathlive/mathlive_bridge.js` and converts either JSON bridge state or legacy raw LaTeX strings into a `MathEditorOutputState`-compatible shape.

## Explicit Non-Claims

- Q86 does not bundle the official MathLive runtime.
- Q86 does not switch the main editor to MathLive.
- Q86 does not enable MathLive virtual keyboard.
- Q86 does not add CDN or remote script loading.
- Q86 does not claim real-device MathLive cursor PASS.
- Q86 does not mutate protected keyboard, app shell, Graph, History, Solution, MathLabel, or template tray surfaces.

## Runtime Boundary

Added state adapter:

- `lib/features/mathlive/mathlive_state_adapter.dart`

Lab-only bridge/state wiring:

- `assets/mathlive/mathlive_bridge.js` now posts JSON state via `JSON.stringify(getState())`.
- `MathLiveLabScreen` parses bridge events using `MathLiveStateAdapter.parseBridgeMessage(...)`.
- The adapter outputs normalized LaTeX, plain text, optional MathJSON, focus/selection metadata, and a diagnostic source.

## Protection Gates

Q86 keeps the same protected surface lock:

- keyboard config and layout untouched
- MORE untouched
- long-press untouched
- app shell untouched
- Graph/History/Solution untouched
- main editor switch disabled

## Next Gate

Q87 must be a MathLive cursor court or state/runtime proof gate. No main-editor switch is permitted until a real MathLive runtime is bundled, lab focus works on device, keyboard bridge passes, state adapter is verified, and protected surfaces remain unchanged.
