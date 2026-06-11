# MathPro Elite Premium Plus V60 — Editor Slot / Caret / Icon Repair Audit

## Scope
V60 is a targeted UI/UX repair package. It does not add a solver, CAS, handwriting recognition, camera recognition, new keys, new tabs, or new long-press options.

## User-reported issues addressed
1. Android launcher icon looked too small inside the home-screen launcher slot.
2. Solution Steps panel opened too low; there was excessive empty space between workspace and steps.
3. Editor text/caret vertical alignment felt wrong; text sat too high and caret was hard to position.
4. Some structural math boxes/slots were difficult or impossible to tap reliably.

## Runtime files changed
- `lib/features/workspace/editor_viewport.dart`
- `lib/features/workspace/workspace_panel.dart`
- `lib/features/editor/selection_controller.dart`
- `lib/features/editor/node_factory.dart`
- `lib/features/editor/tex_serializer.dart`
- `lib/features/formula_engine/math_layout_engine.dart`
- `lib/features/formula_engine/slot_interaction_calibration_policy.dart`
- Android launcher icon PNG resources
- `assets/branding/mathpro_app_icon_1024.png`

## Product-law compliance
- Keyboard layout unchanged.
- Tab order unchanged.
- `key_config.dart` unchanged.
- `math_keyboard.dart` unchanged.
- MORE / Ans / = / ↵ semantics unchanged.
- Long-press option lists unchanged.
- Solver/CAS not expanded.

## Repair summary
- Enlarged launcher icon foreground by scaling the current V59 icon and regenerating mdpi/hdpi/xhdpi/xxhdpi/xxxhdpi icon resources.
- Centered inline caret vertically with expression area rather than applying baseline lift.
- Reduced function-boundary snap radius so caret placement is less sticky near function parentheses.
- Enlarged structural slot hit targets, especially placeholder/function argument slots.
- Added parser support for derivative-like templates with partially filled arguments, such as `d/dx(88□)`, so remaining boxes stay semantically addressable instead of becoming plain text.
- Added TeX serialization for derivative function-call nodes.
- Increased medium Solution Steps panel minimum height and made the workspace card fill its allocated slot when steps are open, reducing the visible gap.

## Local verification status
Flutter/Dart are not installed in this container. No local `flutter analyze`, `flutter test`, or `flutter run` PASS is claimed.

Required user-side validation:
```bash
flutter pub get
flutter analyze
flutter test
flutter run -d 23106RN0DA
```
