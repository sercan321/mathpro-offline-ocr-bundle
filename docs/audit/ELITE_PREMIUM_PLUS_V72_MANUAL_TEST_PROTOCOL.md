# MathPro V72 — Manual Test Protocol

Run after installing the V72 package on a real device.

## Long-press cleanup

1. Long-press `□/□`.
   - Expected: no long-press popup opens.
   - Normal tap must still insert a fraction template.

2. Long-press `|□|`.
   - Expected: no long-press popup opens.
   - Normal tap must still insert absolute-value template.

3. Long-press `□!`.
   - Expected: popup opens with only `□C□` and `□P□`.
   - Must not show `Γ(□)`, `Kalan`, or duplicate factorial.

4. Long-press `log`.
   - Expected: popup shows only `log₁₀(□)`, `log₂(□)`, `log_□(□)`.
   - Must not show duplicate `log(□)`.

## Frozen behavior checks

5. Verify core keyboard still shows:
   - `C ⌫ % ÷`
   - `7 8 9 ×`
   - `4 5 6 −`
   - `1 2 3 +`
   - `MORE 0 . Ans`

6. Verify `MORE`, `Ans`, `=`, and `↵` behavior did not drift.

7. Verify solution panel layout is unchanged.
