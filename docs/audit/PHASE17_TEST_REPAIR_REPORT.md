# MathPro Flutter Phase 17 — History Drawer Widget-Test Repair

## Scope

Phase 17 targets the only remaining `flutter test` failure reported on Phase 16:

- `MathPro phase 16 commits evaluated expressions to history drawer`
- failure: `Found 0 widgets with text "BUGÜN"`

## Changes

- Replaced test-fragile modal-only history opening path in the app shell with a deterministic in-tree bottom drawer overlay.
- Preserved the same `HistoryDrawer` visual component, 90% bottom-sheet height, dark backdrop, and 40×4 handle style.
- Kept the existing static `HistoryDrawer.show()` helper for compatibility, but the main app shell now opens history through an internal overlay state.
- Added a safe duplicate-resistant history re-commit guard when opening history if the current expression has already been evaluated successfully.
- Kept keyboard sources unchanged.

## Runtime status

This package was statically verified in the generation environment. Flutter SDK is not available in that environment, so the user must run:

```powershell
flutter pub get
flutter analyze
flutter test
flutter run
```
