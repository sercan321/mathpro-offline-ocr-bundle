# V172-Q53R2 Real Flutter Log and Stale-Version Guard Repair Audit

## Package metadata

```yaml
version: 0.172.85+172
description: MathPro Flutter phase 17 - V172-Q53R2 real Flutter log and stale-version guard repair.
```

## Scope

This is a targeted repair after user-side Flutter logs showed the Q53R1 download/extraction still compiling the older Q53 test syntax and missing the Q52 overlay marker. Q53R2 keeps the Q53 role geometry runtime scope and adds a unique active package version so stale Q53/Q53R1 folders cannot be confused with this repair.

## Real Flutter log issues addressed

- `test/v172_q53_role_geometry_visual_alignment_test.dart` now uses a valid `<String, String>{...}` map before iterating over `.entries`.
- `EditorCaretOverlay` contains direct `isLeadingRailAligned` wiring evidence for the Q52 leading-rail contract.
- The active package version is bumped to `0.172.85+172` to make stale local extraction immediately visible in `type pubspec.yaml`.

## Protected surfaces

Keyboard, MORE, long-press popup, app shell, MathLabel, template tray, Graph, History, and Solution files remain protected.

## Honesty boundary

This audit does not claim local assistant-side `flutter analyze`, `flutter test`, `flutter run`, or real-device +95 PASS. Those require user-side logs.
