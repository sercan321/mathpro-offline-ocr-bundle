# GRAPH HISTORY V18 — REAL FLUTTER TEST REPAIR REPORT

## Input

The user ran `flutter pub get`, `flutter analyze`, and `flutter test` on V17.

Observed result:

- `flutter pub get`: completed.
- `flutter analyze`: `No issues found!`.
- `flutter test`: failed with runtime/widget-test failures.

## Failure classes repaired

1. `GraphCard` action overflow
   - Source: `lib/features/graph/graph_card.dart`.
   - Problem: `_GraphActions` used a single horizontal `Row` that overflowed by 138 px in the premium motion contract test.
   - Repair: replaced the rigid action row with a wrapping action rail using `Wrap` with stable spacing.

2. History entry ID collision
   - Source: `lib/features/history/history_controller.dart`.
   - Problem: `_newId()` used only `DateTime.now().microsecondsSinceEpoch`, which can collide during rapid unit tests.
   - Runtime symptom: delete/restore and persistence restore tests collapsed multiple entries into one logical ID.
   - Repair: added a static monotonic suffix to the microsecond timestamp.

3. Keyboard still discoverable during open history panel
   - Source: `lib/app/app_shell.dart`.
   - Problem: the outgoing `BottomDock` child could remain in the tree during `AnimatedSwitcher` history transition and keep `MORE` discoverable.
   - Repair: when history is visible, the keyboard dock is removed immediately with a zero-height sentinel. Normal keyboard rendering remains animated when visible.

4. Scrollable drawer action tap test drift
   - Source: `test/graph_history_regression_test.dart`.
   - Problem: test tapped `Sonucu kullan` without scrolling it into view in a scrollable history drawer.
   - Repair: test now calls `ensureVisible` before tapping the action.

5. Frozen Cebir keyboard contract drift in graph widget test
   - Source: `test/widget_test.dart`.
   - Problem: test expected `Ans` after switching to `Cebir`; the frozen Cebir expanded grid uses `MORE`, `=`, and `↵` as the relevant bottom markers.
   - Repair: test now checks `MORE`, `=`, and `↵`.

## Keyboard source protection

The following files were not edited:

- `lib/features/keyboard/key_config.dart`
- `lib/features/keyboard/math_keyboard.dart`
- `lib/features/keyboard/bottom_dock.dart`
- `lib/features/keyboard/long_press_popup.dart`

## Validation limit

Flutter/Dart are unavailable in the packaging environment. This is a static/package repair. The required validation on the user's machine is:

```powershell
flutter pub get
flutter analyze
flutter test
flutter run -d 23106RN0DA
```
