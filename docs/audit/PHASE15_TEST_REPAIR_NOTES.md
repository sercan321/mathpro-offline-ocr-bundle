> HISTORICAL / SUPERSEDED NOTE: This file documents an older Phase 15/16 test-repair state. It is not the current Graph + Premium History runtime contract. The retired `mathpro-history-handle` key mentioned below must not be reintroduced into `lib/`; current authoritative truth is `GRAPH_HISTORY_V17_AUTHORITATIVE_INDEX.md` and README V17.

# MathPro Flutter Phase 17 — History Test Repair Notes

## Purpose
Phase 17 targets the last real user-side `flutter test` failure from Phase 14:

- `MathPro phase 14 commits evaluated expressions to history drawer`
- Expected `BUGÜN`, but no matching widget was found.

## Changes
- Moved `mathpro-history-handle` key to the tappable `GestureDetector` surface instead of the inner 40×4 visual bar.
- Kept the visual handle itself at 40×4 to preserve the reference UI.
- Made `HistoryStore.addItem()` update in-memory history synchronously before asynchronous persistence.
- Updated the history drawer widget test to use deterministic fixed pumps after opening the modal sheet; Phase 17 removed the remaining `pumpAndSettle()` timeout risk.

## Non-changes
The frozen keyboard files were intentionally not modified.

## Required user-side verification
```powershell
flutter pub get
flutter analyze
flutter test
flutter run
```
