# V172-Q87 MathLive Cursor Court / Runtime Proof Gate Audit Report

## Scope

Q87 adds a lab-only proof gate for evaluating MathLive cursor quality. It does not switch the main editor, does not bundle/claim an official MathLive runtime, does not enable MathLive virtual keyboard, and does not mutate protected UI surfaces.

## Added contract

- `lib/features/mathlive/mathlive_cursor_court_policy.dart`
- `test/v172_q87_mathlive_cursor_court_test.dart`
- `assets/mathlive/manifest.json` now records `cursorCourtPhase = V172-Q87`.
- `assets/mathlive/mathlive_bridge.js` now exports Q87 cursor-court metadata in the local lab state.

## Evidence gate

A MathLive cursor PASS is forbidden until all of the following are true:

- `flutter analyze` passes.
- `flutter test` passes.
- `flutter run -d <device>` launches the lab on a real device.
- Official MathLive runtime is actually bundled locally.
- MathLive Lab runs on the real device.
- Q85 keyboard bridge passes on device.
- Q86 state adapter emits valid state.
- MathLive virtual keyboard remains disabled.
- Remote scripts/CDN remain disabled.
- Protected keyboard/MORE/long-press/AppShell/Graph/History/Solution surfaces remain unchanged.
- At least 20/22 manual cursor scenarios pass.
- Blocking failures equal zero.

## Non-goals

- No main editor switch.
- No Graph/History/Solution adapter mutation.
- No deletion of the legacy cursor fallback.
- No Photomath/Wolfram-level claim.
- No fake real-device PASS.
