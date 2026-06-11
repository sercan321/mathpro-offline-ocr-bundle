# V172-P2 Stale-Package Guard and Real-Log Repair Verification

## Purpose
The user-side log showed the opened project was still V172-N (`version: 0.172.14+172`) and still contained the old compile blockers. V172-P2 is a verification/guard package that keeps the P1 real-log repairs and updates package metadata so stale extraction is obvious.

## Real-log blockers guarded
- Nullable `CursorAnchor?` member access in `editor_controller.dart`.
- Duplicate `integralDifferential` const map key in `slot_priority_policy.dart`.
- Direct `source: 'tap-up'` literal in `editor_interaction_layer.dart`.

## Non-goals
- No new cursor phase.
- No loupe/büyüteç.
- No keyboard, MORE, long-press, Graph, History, or Solution edits.

## Required user-side verification
Run:

```powershell
flutter pub get
flutter analyze
flutter test
flutter run -d 23106RN0DA
```
