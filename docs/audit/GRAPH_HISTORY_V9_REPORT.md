# MathPro Graph / Premium History V9 — Persistence Hardening Report

## Scope

Faz 9 focused only on premium history persistence hardening. The graph painter, fullscreen graph, graph settings, history drawer and history item interaction work from V3–V8 was preserved.

## Main changes

- Replaced bare-list local history storage with a schema-versioned V2 envelope.
- Preserved V1 bare-list migration support.
- Added corruption-safe restore behavior.
- Bounded local persistence to 80 entries.
- Added `restoreCompleted` and `persistCompleted` futures to the history controller.
- Prevented async restore from notifying listeners after controller disposal.
- Updated stale regression contracts that still expected `shared_preferences` to be absent.
- Added persistence regression coverage for calculation, graph, error, pinned state, graph viewport metadata and trace state.

## Keyboard protection

The following keyboard-critical files were not edited in this phase:

- `lib/features/keyboard/key_config.dart`
- `lib/features/keyboard/math_keyboard.dart`
- `lib/features/keyboard/bottom_dock.dart`
- `lib/features/keyboard/long_press_popup.dart`

## Test honesty

Flutter/Dart SDK was not available in the delivery environment. `flutter pub get`, `flutter analyze`, `flutter test` and `flutter run` were not executed here. Static checks and package hygiene checks were performed instead.
