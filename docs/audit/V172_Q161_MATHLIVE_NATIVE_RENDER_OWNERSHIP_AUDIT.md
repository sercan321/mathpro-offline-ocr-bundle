# V172-Q161 MathLive Native Render Ownership Audit

## Purpose

Q160 made keyboard input visible through a Flutter mirror, but real-device evidence showed the mirror exposed raw MathLive insert payloads such as `\\sqrt{#0}`. Q161 retires that mirror as a production display path and makes the official MathLive `<math-field>` the only structural renderer.

## Changes

- Added `MathLiveNativeRenderOwnershipPolicy`.
- Removed the `_VisibleMathLiveInputMirror` production overlay from the main editor surface.
- Removed `flutter_math_fork` mirror rendering from `mathlive_main_editor_surface.dart`.
- Retired Q160 mirror policy by setting `enabled = false` and `usesFlutterMathFallback = false`.
- Added bridge-side `documentLatexFromInsertPayload()` sanitization so `#0`, `#?`, and `#@` are converted to document-safe placeholders before any `setLatex()`/value/fallback path.
- Blocked structural templates from visible fallback text when the official math-field is not mounted.
- Preserved `mathfield.insert(...)` as the only place where MathLive insert-control tokens may be used.

## Protected Surface Status

No keyboard layout, key order, MORE inventory, long-press order, Graph UI, History UI, Solution UI, or solver behavior was intentionally changed.

## Claims

Q161 does not claim Flutter analyze/test/run PASS from the assistant environment. It also does not claim real-device, cursor, or Photomath/Wolfram-level PASS without user-side evidence.
