# V172-Q162 MathLive Native Render Fallback Repair Audit

## Purpose
Q161 correctly retired the Q160 Flutter mirror and blocked raw insert-token leaks such as `\\sqrt{#0}`. Real-device evidence then showed a blank editor when MathLive did not mount or paint. Q162 restores a sanitized WebView-host fallback while keeping raw insert tokens forbidden and keeping the official MathLive `<math-field>` as the preferred structural renderer.

## Changes
- Added `MathLiveNativeRenderFallbackRepairPolicy`.
- Restored Q157/Q159 fallback compatibility markers.
- Allowed sanitized structural fallback only after `#0/#?/#@` are converted to document LaTeX/placeholders.
- Kept Q160 Flutter mirror retired.
- Kept keyboard layout, MORE inventory, long-press order, Graph, History, Solution, and solver behavior unchanged.

## Claims
No real-device PASS, cursor PASS, or Photomath-level PASS is claimed by this package. Q162 is package-side readiness and must be verified on device.
