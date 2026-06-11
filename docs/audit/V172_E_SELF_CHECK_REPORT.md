# V172-E Self-Check / Anti-Fake-Success Report

## Repeated Previous Phase Checks

Before and after V172-E edits, the package was checked for these facts:

- V172-A `lib/features/workspace/editor_caret_overlay.dart` exists.
- V172-A overlay path remains wired through `EditorViewport`.
- V172-B tests remain present.
- V172-C `CursorAnchor` code remains present.
- V172-D tests remain present.
- `paintVisibleSlotOverlay=true` was not added as production code.
- The old green `mathpro-active-slot-highlight` key remains only in the dormant `_SlotBox` path and tests; it was not re-enabled.

## Protected Hash Check

The following protected files were SHA-256 checked against the V172-D baseline and remained unchanged:

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

## Anti-Deception Guard

This package intentionally does not claim that:

- V172-E is a complete +95 cursor engine.
- Flutter analyze/test/run passed locally.
- Real-device UX has been visually accepted.
- MathJax renderer-derived geometry sync is complete.

Flutter/Dart were unavailable in the packaging environment, so the user must run the Flutter command block on the target machine.
