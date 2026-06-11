# V172-Q80R2 Real Flutter Test Contract Repair Audit Report

## Trigger

The user provided a real `flutter test` log showing 32 failures after the Q80R2 analyze repair. The remaining failures were not broad runtime crashes; they were concentrated in stale test expectations and release metadata drift:

- `pubspec.yaml` description did not exactly match `MathProPackageContract.pubspecDescription`.
- Older Q38-Q40 lineage tests still required `Native SlotBox Painter` lineage to remain visible in `nextPhase`.
- Q54/Q55 tests still expected the pre-Q71 nearest structural fallback to select nearby slots, which contradicts the current no-nearest native SlotBox law.
- Q56/Q58/Q73/Q76/Q79 tests still expected older source identifiers even though later native lane specializers now own those deterministic measured hits.

## Repair Scope

Cursor/test/contract only. Protected UI files were not modified.

## Runtime Safety Decision

The repair does not re-enable nearest-distance structural fallback. Q54/Q55 tests were updated to assert that nearest fallback remains blocked. This preserves the user's current cursor red line: no guessing, no nearest fallback, no detached linear caret inside measured structural geometry.

## Evidence Limits

The assistant environment still has no Flutter/Dart SDK, so this report does not claim `flutter analyze`, `flutter test`, or real-device PASS. The repair is based on the user's real log and static package verification.
