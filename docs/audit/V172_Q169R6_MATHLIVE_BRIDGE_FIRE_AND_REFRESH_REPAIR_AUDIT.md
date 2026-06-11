# V172-Q169R6 MathLive Bridge Fire-and-Refresh Repair Audit

Real-device Q169R5 evidence advanced from `SEND:Queued` to `SEND:Bridge`, but remained at `JS:pending MF:true INSERT:false VALUE:empty PAINT:pending`. Q169R6 keeps the returning-result bridge path when it works, but prevents that acknowledgement from blocking command execution. If the returning-result path times out or returns empty, the same command is fired through `runJavaScript`, then short state refresh probes and async MathProMathLiveState channel messages are consumed for Q169 diagnostics.

No keyboard layout, MORE inventory/order, long-press source/order, AppShell, Graph UI, History UI, Solution UI, or solver behavior is changed. No real-device native-paint PASS is claimed.
