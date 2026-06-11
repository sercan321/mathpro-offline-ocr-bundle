# V118.4 — MathJax No-Blank Update Repair Audit

## Scope
Targeted repair for the reported real-device issue: after tapping/updating an expression, the editor math area becomes blank for 1-2 seconds before the MathJax render appears.

## Root Cause
V118.3 intentionally hid the WebView whenever the expression changed. This removed the old legacy/ugly frame, but it also hid the last good MathJax SVG while the next TeX was being staged/typeset.

## Repair
- Keep the last confirmed MathJax SVG visible during expression updates.
- Only show the premium ghost/blank holder before the first successful MathJax render.
- Continue staging new TeX off-screen in `mathpro-stage`.
- Swap the visible SVG only after `MathJax.typesetPromise(...)` completes.
- Keep legacy text/flutter_math fallback out of the editor surface.
- If a later render fails after a previous render exists, keep the previous confirmed MathJax frame instead of blanking the editor.

## Files Changed
- `pubspec.yaml`
- `lib/features/editor/render/mathjax_render_surface.dart`
- `test/v118_local_mathjax_real_render_surface_test.dart`

## Preserved Contracts
No keyboard, tab, MORE, Ans, ↵, =, long-press list, Graph, History, or Solution panel files were modified.

## Expected Device Behavior
- Initial first render may show the neutral premium ghost until MathJax becomes ready.
- After the first successful render, expression edits should keep the last good MathJax expression visible until the next expression is ready.
- The old bad legacy renderer must not be shown.
- The editor should no longer turn blank for every tap/key update.

## Not Claimed
Flutter analyze/test/run were not executed in this environment. Device PASS must come from user-side logs and screenshots/video.
