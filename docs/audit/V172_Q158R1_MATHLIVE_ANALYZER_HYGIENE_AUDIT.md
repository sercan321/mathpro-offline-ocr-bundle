# V172-Q158R1 MathLive Analyzer Hygiene Audit

## Situation

User-side Q157R1 verification showed:

- `flutter test`: `+854 All tests passed`
- `flutter analyze`: one warning, `_lastRuntimeCommandAck` unused in `mathlive_main_editor_surface.dart`

## Repair

Q158R1 keeps Q157R1 runtime command ack telemetry and makes it observable in the returned JavaScript state path:

```dart
source: 'q157-returning-result-command-ack $_lastRuntimeCommandAck'
```

This is intentionally a hygiene-only repair. It does not alter MathLive mappings, keyboard layout, MORE, long-press order, Graph, History, Solution, or solver behavior.

## Claims

- No real-device PASS claimed.
- No cursor PASS claimed.
- No Photomath-level PASS claimed.
- User-side `flutter analyze` and `flutter test` must be rerun.
