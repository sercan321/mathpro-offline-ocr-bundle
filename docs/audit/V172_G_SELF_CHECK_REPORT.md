# V172-G Self-Check / Anti-Fake-Success Report

## Incoming Package Truth

The incoming ZIP was checked before editing and was still V172-F (`0.172.5+172`). V172-G files were not present. Therefore V172-H was not skipped; V172-G was implemented first.

## Previous Phase Verification

- V172-A caret overlay file exists.
- V172-A overlay path remains wired through `EditorViewport`.
- V172-B function-continuity tests remain present.
- V172-C `CursorAnchor` code remains present.
- V172-D fraction / power / subscript tests remain present.
- V172-E log / root / nested-function tests remain present.
- V172-F long-expression auto-scroll tests remain present.
- Searched for production `paintVisibleSlotOverlay: true`; none was introduced.
- The old green `mathpro-active-slot-highlight` was not re-enabled for production cursor feedback.

## Protected File Hash Check

The following protected files were SHA-256 checked and remain unchanged:

```text
4ecd7270e29a27d75bdd80d36aa5b6f1064a2c3a1d3360c3edd4856432d0f1a2  lib/features/keyboard/key_config.dart
f4f2a9acdc226cdc9838a265a96f2539a5b9ecf1f4feccd5fbb76745370b7ad2  lib/features/keyboard/math_keyboard.dart
f75e70c490827baeeb6b71a59ccddeaabcdcafe851726d953db9ada0066022c8  lib/features/keyboard/bottom_dock.dart
d6b2c030bd3e82819dff7ab66edaa5ac20855c19db72940c742b229cdede4081  lib/features/keyboard/long_press_popup.dart
cefded355d74046a1d5252deebc06b0a8841a39265f5736d7f65865e092be08b  lib/features/solution/solution_steps_panel.dart
ea1010e17627c4f1754a5e8ba2dc18004adbb98121ebd7da8a8cd876de8c1e4f  lib/features/graph/graph_card.dart
331a6d84dbe4a940f185a69bc5623c6aaa0f2b16f4198f2149a4f4b375be3f51  lib/features/history/history_controller.dart
fad987605894ffafc0069fa80f560908c6f529a05da81d2165e924524728537b  lib/features/history/history_panel.dart
```

## Anti-Fake-Success Checks

- V172-G regression tests were added.
- No claim is made that Flutter analyze/test/run passed locally.
- No claim is made that V172-G completes the +95 cursor engine.
- No claim is made that real-device visual QA passed.
- No claim is made that Matrix/System cursor work has started.

## Required User-Side Verification

Run on the target Flutter machine:

```powershell
flutter pub get
flutter analyze
flutter test
flutter run -d 23106RN0DA
```
