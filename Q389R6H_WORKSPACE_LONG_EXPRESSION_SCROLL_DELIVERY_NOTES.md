# Q389R6H — Workspace Long Expression Scroll / Caret Visibility

## Scope

This phase continues after Q389R6G. It does **not** implement Fotomath-style long-press cursor drag yet. It prepares the safe base for that later phase by making long expressions stay readable and horizontally scrollable.

## Runtime files touched

- `assets/mathlive/main_editor_prod.html`
- `assets/mathlive/mathlive_prod_bridge.js`

## Added contract files

- `lib/features/workspace/workspace_long_expression_scroll_policy_q389r6h.dart`
- `test/q389r6h_workspace_long_expression_scroll_contract_test.dart`
- `tool/verify_workspace_long_expression_scroll_q389r6h.mjs`

## Behavior target

- Keep Q389R6G compact editor scale for normal expressions.
- For longer expressions, apply compact/dense/scroll fit classes.
- Do not shrink below a readable minimum: `clamp(21px, 5.75vw, 28px)`.
- After that minimum, allow horizontal overflow scrolling.
- Hide the scrollbar to keep the premium surface clean.
- Add `scroll-padding-inline: 24px` so caret edges do not feel clipped.
- Use MathLive's public `position`/`lastOffset` when available to keep the visible horizontal area near the caret.
- Preserve native MathLive caret ownership.

## Explicit non-goals

- No long-press cursor drag implementation in this phase.
- No legacy Flutter cursor revival.
- No keyboard layout or ordering changes.
- No OCR/camera/Android native changes.
- No Graph 2D/3D changes.
- No solver/CAS changes.

## Evidence boundary

Static verification is included. Real Flutter analyze/test/release/device PASS must come from user-side logs.
