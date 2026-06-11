# V172-Q186 Production MathLive Bridge Contract Audit Report

## Scope

Q186 is a contract-freeze phase for the active production MathLive bridge. It does not redesign the keyboard, MORE tray, long-press UI, Graph, History, Solution, or solver layer.

## Baseline

Baseline package: V172-Q185 Production MathLive HTML Finalization.

## Implemented

- Replaced the production bridge export with a minimal frozen public API:
  - `mount()`
  - `insertLatex()`
  - `deleteBackward()`
  - `clear()`
  - `setLatex()`
  - `getLatex()`
  - `focus()`
  - `keepCaretVisible()`
  - `notifyFlutterState()`
- Removed the public production bridge dependency on `executeMathProCommand()` and public `getState()`.
- Kept queue handling internal to the bridge; queue internals are not public API.
- Updated the production Flutter surface to call the minimal bridge functions directly.
- Added a production state compatibility getter so the existing runtime controller can flush queued keys without entering the old Q169 court/debug surface.
- Tightened production-mounted detection so a bare `<math-field>` DOM node is not enough; runtime/custom-element evidence and mounted instance evidence are both required.
- Gated the old AppShell visible fallback mirror to Flutter widget-test runtimes only. Real WebView runtimes now send the key to MathLive without pre-writing the fallback mirror into `CalculatorController`.
- Added a Q186 policy file, Flutter policy test, Node verifier, manifest envelope, and README phase note.
- Updated the Q184/Q185 static verifiers so they validate the Q186 minimal direct bridge API instead of the superseded `executeMathProCommand()` export.

## Explicit non-goals

- No keyboard layout mutation.
- No MORE inventory/order mutation.
- No long-press order mutation.
- No Graph/History/Solution UI mutation.
- No solver behavior mutation.
- No fake Flutter analyze/test/run PASS.
- No fake real-device or Photomath/Wolfram premium PASS.

## Runtime evidence status

Assistant-side Flutter/Dart execution is unavailable in this environment, so this package is only statically verified here. Android real-device premium evidence must be produced by the user with Flutter installed.
