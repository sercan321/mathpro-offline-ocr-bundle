# V172-Q90R8 MathLive Lab Real Device Access Guard Audit Report

## Scope
Q90R8 provides a direct, isolated MathLive Lab entrypoint for real-device evidence review.

## What changed
- Added `lib/main_mathlive_lab.dart` so the Lab can be launched with `flutter run -t lib/main_mathlive_lab.dart -d 23106RN0DA`.
- Registered `/mathlive-lab` in `MathProApp` without changing the default `home` route.
- Added `MathLiveLabRealDeviceAccessPolicy` to encode the gate.

## What did not change
- Main editor remains legacy/default.
- MathLive is not mounted in the main workspace.
- Legacy cursor files are not deleted.
- MathLive virtual keyboard remains disabled.
- Remote/CDN scripts remain forbidden.
- No cursor PASS, Photomath, or Wolfram-level claim is made.
- Protected keyboard/MORE/long-press/AppShell/Graph/History/Solution surfaces remain locked.

## Next gate
Run the isolated Lab entrypoint on the real device, produce Lab evidence, then continue to the existing Q90R5/Q90R6/Q90R7 evidence chain before any Q87 cursor court.
