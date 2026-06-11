# V172-Q169R28 Static Hygiene / Runtime Truth Pre-Device Repair Audit

Q169R28 was created after a deep inspection of the Q169R27 package. The inspection found one concrete static package-hygiene failure: `tool/verify_mathlive_insert_value_failure_reason_court_v172_q169r8.mjs` still required the legacy `paint-pending-empty-value` marker while Q169R27 correctly refined the runtime reason to `paint-pending-empty-native-value` for native paint proof reads.

## What changed

- Kept Q169R27's strict native paint proof reason: `paint-pending-empty-native-value`.
- Added a compatibility alias marker/state field for Q169R8: `q169FailureReasonLegacyAlias = paint-pending-empty-value`.
- Extended the Q169R8 policy/manifest documentation so both the legacy reason and the stricter native reason are known.
- Added Q169R28 package verifier and Flutter static test coverage.
- Added a static Flutter test for the Q169R24→Q169R27 authority chain.

## What did not change

- No keyboard layout change.
- No MORE inventory/order change.
- No long-press order change.
- No AppShell change.
- No BottomDock change.
- No Graph/History/Solution UI change.
- No solver change.
- No premium visual polish.
- No fake official runtime files were added.
- No Flutter analyze/test/run PASS is claimed from the assistant environment.
- No Android PAINT:ok / MathLive fully took over claim is made without real-device evidence.

## Runtime truth

Official MathLive vendor files are still installed by:

```powershell
node tool/install_mathlive_runtime.mjs
```

This package remains blocked from Q170 premium visual polish until real-device evidence shows:

```text
COURT_SINGLE_SOURCE MOUNT:ok INSERT:ok VALUE:ok CHANNEL:ok PAINT:ok ROOT:none
```
