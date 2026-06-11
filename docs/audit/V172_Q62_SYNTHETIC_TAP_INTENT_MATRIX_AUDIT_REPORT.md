# V172-Q62 Synthetic Tap Intent Matrix Audit Report

Q62 introduces an automatic synthetic tap intent matrix for the existing MathPro cursor motor. It simulates phone-like taps around core structural slots before the next real-device checkpoint. It is not a real-device PASS and it does not claim Photomath/Wolfram completion.

## Scope

- Simulate 20 tap points per structural slot scenario.
- Verify exact structural hits resolve to the intended slot.
- Verify near-slot/template-region taps resolve structurally before detached linear fallback.
- Preserve the Q61 golden geometry court and the Q52/Q57 `|□` leading-rail law.
- Require a 20-attempt / 19-correct / 0.95 synthetic threshold before calling a scenario +95-candidate.

## Protected surfaces

Keyboard, key faces, MORE, long-press popup, app shell, MathLabel, template tray, Solution, Graph and History remain protected and unchanged by Q62.

## Honest limit

Q62 is a code-level synthetic tap court. Flutter analyze/test and real-device Pixel QA are still required before any +95 cursor PASS claim.
