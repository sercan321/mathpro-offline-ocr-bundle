# V172-Q169R4 MathLive MF:true Bridge Dispatch Repair Audit

## Trigger

User real-device screenshot showed:

`Q169 KEY:√□ SEND:Queued JS:queued MF:true INSERT:false VALUE:empty PAINT:pending`

That proves the math-field existence/mount signal reached Flutter, but the command path could still be kept behind the queued branch.

## Repair

- Added `MathLiveMfTrueBridgeDispatchRepairPolicy`.
- Updated MathLive surface readiness so `MF:true` / math-field existence or mount can dispatch bridge commands when the WebView controller is attached.
- Updated queue flush readiness so `MF:true` forces queued labels to retry rather than staying at `SEND:Queued`.
- Preserved Q169 diagnostics and prior static compatibility markers.

## Non-goals

- No keyboard layout/key order/MORE/long-press changes.
- No AppShell/Graph/History/Solution UI changes.
- No solver changes.
- No real-device PASS or Photomath-level claim.

## Expected real-device evidence

`Q169 KEY:... SEND:Bridge JS:ok MF:true INSERT:true VALUE:non-empty PAINT:ok`
