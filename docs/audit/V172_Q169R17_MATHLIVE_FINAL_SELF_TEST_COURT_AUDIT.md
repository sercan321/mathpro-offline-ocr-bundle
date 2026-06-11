# V172-Q169R17 MathLive Final Self-Test Court Audit

Purpose: replace repeated micro device-install loops with a single real-device root-cause court for the remaining MathLive `JS:fire` / readback / value / paint failure.

Scope:
- Adds `runQ169FinalSelfTestCourt(...)` JS endpoint.
- Adds `MathLiveFinalSelfTestCourtPolicy`.
- Dart calls the final court after post-fire refresh/compact readback cannot produce decisive INSERT/VALUE/PAINT state.
- Async channel messages containing the court report are consumed by the main editor surface.

Non-goals:
- No native paint PASS claim.
- No Q170 premium visual polish.
- No keyboard/MORE/long-press/AppShell/Graph/History/Solution mutation.
