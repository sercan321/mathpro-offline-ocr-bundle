# V172-Q144 MathLive Main Editor State Authority Audit Report

## Phase

V172-Q144 — MathLive Main Editor State Authority

## Purpose

Q144 prevents the main MathLive editor from being overwritten by raw Flutter-side key labels after a semantic MathLive template has already been inserted. This targets the real-device symptom where named options such as `Taylor` / `{3 denklem` can appear as plain text even though the MathLive bridge has a template mapping for them.

## Repairs

- Added `MathLiveMainEditorStateAuthorityPolicy`.
- AppShell no longer pre-mutates `CalculatorController` with raw key labels on the MathLive main-editor path.
- MathLive bridge snapshots are the authority for the expression sent back to CalculatorController.
- The same authoritative expression selector is used by AppShell and the MathLive surface to avoid echo loops.
- Q102 normalization was extended to convert MathLive placeholders and `#@/#0/#?` markers into MathPro slot placeholders for controller payloads.
- The duplicate `indexed` local declaration in the sqrt normalizer was removed while editing the normalizer.

## Red Lines Preserved

- Keyboard layout was not changed.
- Key order was not changed.
- MORE / Ans / ↵ / = contracts were not changed.
- Long-press source-of-truth files were not changed.
- Graph / History / Solution UI files were not changed.
- No real-device PASS or Photomath-level PASS is claimed.

## Manual Device Evidence Still Required

Q144 is package-side behavior repair. Real device validation is still required after all planned phases are complete.
