# V172-Q173 Native Template Command Normalizer Audit

## Scope
Q173 is a runtime MathLive command-normalization phase. It does not change the frozen MathPro keyboard layout, key order, MORE inventory/order, long-press order, AppShell, Graph, History, Solution, or solver behavior.

## Problem proven before Q173
Real-device screenshots showed that MathLive was no longer blocked at runtime/mount, but structural templates could look non-premium when multiple template keys were pressed rapidly. The most visible symptom was repeated radical insertion becoming nested `sqrt(sqrt(sqrt(□)))` rather than separate native MathLive radical templates.

## Repair
- Added Q173 runtime-only native template normalizer in `assets/mathlive/mathlive_bridge.js`.
- Kept Dart keyboard template maps intact for existing legacy tests.
- Added a guard that moves the caret to the MathLive field end before inserting another structural template when the previous structural template still contains an empty placeholder.
- Normalized heavy wrappers such as `\sin\left(#0\right)` and `\frac{d}{dx}\left(#0\right)` into cleaner MathLive-native runtime payloads.
- Extended Q171 visual template families with `radical` and `function` categories.
- Preserved Q172 popup no-clip legacy thresholds.

## Evidence
Fresh browser probe showed:
- `nativePaintState: ok`
- `nativePaintOwner: mathlive-native-field`
- repeated radical command produced sibling radicals, not nested radicals
- calculus/function/power/radical sequence stayed native MathLive-rendered

## Non-claims
- No Flutter analyze/test/run pass is claimed in this environment.
- No Android real-device premium final pass is claimed.
- No Photomath/Wolfram-level claim is made.
