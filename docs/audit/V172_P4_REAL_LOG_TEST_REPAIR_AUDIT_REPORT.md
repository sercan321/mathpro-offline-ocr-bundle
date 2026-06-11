# V172-P4 Real-Log Test Repair Audit

## Scope
Targeted repair for the user-provided Flutter test log after V172-P3.

## Repairs
- `ⁿ√(□)` exposes only `sqrtValue`; fixed symbolic root index is not a false editable slot while radicand is open.
- `SlotHitTesting.version` preserves V66 compatibility while keeping the V172-J no-loupe path.
- `x_□` exposes both `subscriptBase` and `subscript`; fixed subscript atoms remain non-editable.
- Calculus caret-rail visibility targets for tiny slots are at least 44 px.
- V98 source literal compatibility keeps `source: 'tap-down'` while avoiding `source: 'tap-up'`.

## Red Lines
Keyboard/MORE/Ans/=/↵/long-press/Graph/History/Solution files were not intentionally modified. No loupe or green debug overlay path was enabled.
