# MathPro Flutter Phase 12 — Changed Files Manifest

This is a full project package, not a patch package. It was built from the physically verified Phase 10 full package.

## Product-law preservation

The frozen keyboard sources were not changed from Phase 10:

- lib/features/keyboard/key_config.dart
- lib/features/keyboard/math_keyboard.dart
- lib/features/keyboard/premium_key.dart
- lib/features/keyboard/bottom_dock.dart
- lib/features/keyboard/long_press_popup.dart
- lib/features/keyboard/long_press_indicator.dart

## Phase 12 hardening changes

- pubspec.yaml updated to `mathpro_flutter_phase12`, version `0.12.0+12`.
- test/widget_test.dart imports updated to Phase 12 and additional regression tests added.
- README.md and docs/audit/RUN_INSTRUCTIONS.md updated with VS Code instructions.
- android/gradlew, android/gradlew.bat, and android/gradle/wrapper/gradle-wrapper.properties added as Android build bootstrap scripts.
- lib/features/editor/slot_registry.dart now avoids duplicate placeholder overlay targets when a structural parent already owns that slot.
- lib/features/formula_engine/slot_engine_self_check.dart now checks duplicate slot IDs and duplicate node/slot/role targets.
- lib/features/formula_engine/math_layout_engine.dart version bumped and documentation updated for de-duplicated slot layout.
- lib/app/app_shell.dart now derives selection content state from EditorCommands.selectedSlotPayload instead of hardcoded false.
- lib/features/editor/editor_commands.dart includes conservative structural selected-slot payload extraction for identifiable filled slots while still protecting empty/open slots.
- lib/logic/evaluator_bridge.dart now accepts π and ∞ at the pre-normalization regex layer, removing the prior π normalization inconsistency.

## Still not claimed

- Flutter SDK was not available in the packaging environment; `flutter pub get`, `flutter analyze`, `flutter test`, and `flutter run` were not executed here.
- Slot layout is still approximate; it is cleaner and de-duplicated but not renderer-derived glyph bounds yet.
- iOS project files are not included in this Android-focused package.
