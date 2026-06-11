# Graph + Premium History V12 Manual Device Checklist

Run after extracting the full ZIP on the Flutter development machine.

## Commands

```powershell
flutter pub get
flutter analyze
flutter test
flutter run -d 23106RN0DA
```

## Manual UI checks

1. App opens without overflow.
2. Keyboard remains bottom-docked and does not collide with Android navigation bar.
3. Tabs remain: Temel, Cebir, Kalkülüs, Kompleks, Lineer Cebir.
4. Temel layout remains 20 keys with `MORE` and `Ans` in the bottom row.
5. Expanded tabs remain 8 × 5 grids.
6. `=` inserts literal equality; `↵` evaluates.
7. Integral long-press still shows `∫`, `∫ₐᵇ`, `∮`; no `∬` return.
8. `sin(x)` opens graph preview.
9. `3 + 5` does not auto-open graph; after evaluation graph icon suggests `y = 8`.
10. `x² + y² = 1` shows the advanced-mode pending message.
11. Graph preview can close, reset, trace toggle, zoom, settings apply, and open fullscreen.
12. Fullscreen graph supports pan/pinch/double-tap reset and returns state to preview.
13. History is hidden by default.
14. History opens via icon and card drag, closes via button and upward drag.
15. History item tap restores calculation or graph appropriately.
16. Delete, undo, clear-all, pin/unpin, copy, and result-use actions work.
17. Close/reopen app and confirm persisted history remains, including graph metadata and pinned state.
