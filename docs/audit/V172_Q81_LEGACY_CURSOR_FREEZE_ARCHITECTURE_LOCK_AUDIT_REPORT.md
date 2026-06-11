# V172-Q81 Legacy Cursor Freeze & Architecture Lock Audit Report

## Outcome
Q81 freezes the current Flutter SlotBox cursor stack as a legacy/fallback editor path and prevents more broad custom cursor patching from being treated as the primary product direction.

## Scope
- Added `LegacyCursorFreezePolicy`.
- Added a focused Q81 contract test.
- Added this audit report and a changed-files manifest.
- Added a package-contract rule describing the freeze.

## Protected Surfaces
The following must remain untouched by Q81 and future MathLive POC work unless explicitly authorized: keyboard layout, MORE, long-press, Ans, ↵, literal `=`, AppShell, Graph, History, Solution, and the premium visual shell.

## Architecture Rule
The existing cursor engine is not deleted. It remains fallback. MathLive may only advance through an adapter/lab/court path: MathEditorAdapter contract, offline assets, isolated MathLive Lab, keyboard-to-JS bridge, state adapter, real-device cursor court, then controlled engine switch behind a flag.

## Truth Boundary
Q81 does not claim Flutter analyze/test/run PASS, MathLive PASS, Photomath PASS, or real-device PASS.
