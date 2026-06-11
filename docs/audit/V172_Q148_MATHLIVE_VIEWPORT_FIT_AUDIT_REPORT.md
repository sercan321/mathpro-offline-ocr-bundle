# V172-Q148 — MathLive Viewport Fit / Caret Follow Audit Report

## Scope

Q148 adds package-side runtime behavior to keep long MathLive structural expressions visible inside the phone-sized main editor card. It targets the post-Q145/Q146 risk that Taylor series, sigma/product, limit, integral, fraction, and nested templates can be mathematically correct but still hard to inspect because the active region can move outside the visible WebView host.

## Implemented behavior

- Added adaptive MathLive fit classes: `mathpro-fit-normal`, `mathpro-fit-compact`, `mathpro-fit-dense`, and `mathpro-fit-micro`.
- Added `applyViewportFit()`, `keepCaretVisible()`, and `scheduleViewportFit()` to the MathLive bridge.
- Runs viewport/caret stabilization after runtime mount, keyboard insert/delete/clear, external expression sync, and pointer selection settling.
- Added host and math-field CSS for compact/dense/micro placeholder and caret scaling.
- Added Flutter-side `_keepMathLiveCaretVisible()` bridge call after runtime mount, keyboard command, and external sync.

## Protected surface status

No protected keyboard, MORE, long-press, Graph, History, or Solution UI source files were intentionally modified.

## Truth constraints

- No Flutter analyze/test/run PASS is claimed by this package.
- No real-device cursor PASS is claimed by this package.
- No Photomath-level PASS is claimed by this package.
- Official MathLive runtime still requires the local install step before real-device validation.

## Expected package-side verifier status

`MATHLIVE_VIEWPORT_FIT_PACKAGE_READY_BUT_DEVICE_EVIDENCE_REQUIRED`
