# V154 Real-Device Key Surface QA Closure Audit

## Scope

V154 is a QA-closure phase after the V150-V153 AST/token migration. It does not claim physical-device PASS. It locks the phone-side inspection surface so high-risk keyboard, MORE, long-press and editor insertion keys cannot be skipped during final QA.

## Locked Critical Surfaces

The new V154 gate requires manual inspection evidence for:

- keycap surface scan for critical math labels
- long-press chip sweep for root/log/trig/calculus/function families
- editor insertion/delete/caret sweep for the same critical labels
- existing log, trig, subscript, MORE, Android navigation-bar, long-expression and no-debug-leak scenarios

## Protected Areas

No intentional runtime UI redesign was made to:

- `lib/features/keyboard/key_config.dart`
- `lib/features/keyboard/bottom_dock.dart`
- `lib/features/keyboard/long_press_popup.dart`
- `lib/features/keyboard/premium_key.dart`
- `lib/features/graph/graph_card.dart`
- `lib/features/history/history_panel.dart`
- `lib/features/solution/solution_steps_panel.dart`
- `lib/features/workspace/editor_viewport.dart`
- `lib/features/editor/render/editor_interaction_layer.dart`

## Truth Boundary

This package was statically prepared in an environment without Flutter/Dart execution. Do not call this PASS unless the user runs:

```bash
flutter clean
flutter pub get
flutter analyze
flutter test
flutter run -d 23106RN0DA
```

and confirms the V154 critical-key surface sweep on a real phone.
