# Phase 4 History Behavior Audit

## React Native History V2 blueprint

The reference ZIP contains:

- `context/HistoryContext.tsx`
- `components/history/HistoryDrawerV2.tsx`
- `components/history/HistoryHeader.tsx`
- `components/history/HistoryEmpty.tsx`
- `components/history/HistoryItem.tsx`
- `lib/haptics.ts`

## Flutter counterpart

Implemented counterpart:

- `HistoryEntry` and `HistorySection` in `history_model.dart`
- `HistoryStore` in `history_store.dart`
- storage wrapper in `storage_service.dart`
- drawer shell in `history_drawer.dart`
- header, empty state, and item tile in `history_widgets.dart`

## Preserved behavior decisions

- Storage key direction: `calc-history-v2`
- Max entries: 500
- Newest item inserted at the front
- Newest three duplicate-expression suppression
- Sections: `SABİTLENENLER`, `BUGÜN`, `DÜN`, `BU HAFTA`, `DAHA ESKİ`
- Pin/unpin by long press
- Delete by swipe-to-left visual route
- Load expression by tapping an item
- Clear all action available from drawer header
- Storage failure must not crash the calculator surface

## Intentional Flutter translation differences

- RN MMKV was translated to a safe `SharedPreferences` wrapper.
- RN BottomSheet/FlashList/Reanimated were translated to `showModalBottomSheet`, `ListView.builder`, and Flutter animation widgets.
- Two RN-side history pathways were not duplicated. Flutter uses one canonical `HistoryStore`.

## Not claimed

- No real device drawer test was run in this environment.
- No native persistence test was run in this environment.
- No `flutter analyze` result is claimed.
