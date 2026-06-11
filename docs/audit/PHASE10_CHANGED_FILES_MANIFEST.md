# MathPro Flutter Phase 10 — Changed Files Manifest

Phase 10 is a full package built from the physically verified Phase 9 full package. It is not a patch package.

## Product-law preserved files

The following keyboard files were intentionally kept byte-identical to Phase 9:

- `lib/features/keyboard/key_config.dart`
- `lib/features/keyboard/math_keyboard.dart`
- `lib/features/keyboard/premium_key.dart`
- `lib/features/keyboard/bottom_dock.dart`
- `lib/features/keyboard/long_press_popup.dart`
- `lib/features/keyboard/long_press_indicator.dart`

## Main modified source files

- `pubspec.yaml`
  - package identity updated to `mathpro_flutter_phase12`
  - version updated to `0.12.0+12`

- `lib/state/calculator_controller.dart`
  - selection clear now preserves expression
  - copy/cut/duplicate no longer operate on the whole expression for an empty slot highlight
  - paste targets the active open slot when possible
  - template insertion can focus the first/preferred open slot

- `lib/features/editor/render/editor_controller.dart`
  - removed automatic primary-slot active-state fallback
  - visual active state now follows explicit calculator state

- `lib/logic/action_utils.dart`
  - added `TemplateSpec` source-of-truth
  - reference premium templates centralized
  - template focus roles added for structural insertion

- `lib/features/workspace/template_tray.dart`
  - premium labels now read from `ActionUtils.premiumTemplates`

- `lib/features/workspace/selection_toolbar.dart`
  - copy/cut/duplicate disabled when the lightweight selection has no payload

- `lib/features/editor/node_factory.dart`
  - structural parsing improved for Phase 10 premium templates

- `lib/features/editor/render/math_tex_serializer.dart`
  - TeX replacements added for Phase 10 premium template forms

- `test/widget_test.dart`
  - updated to Phase 10 package import
  - added regression tests for selection clear preservation and premium template slot focus

- `README.md`
  - VS Code quick start added

- `docs/audit/RUN_INSTRUCTIONS.md`
  - simple VS Code / terminal run instructions added

- `android/README.md`
  - Android tooling note added

- `android/local.properties.template`
  - local SDK path example added without committing machine-specific local paths

## New audit files

- `docs/audit/PHASE10_CHANGED_FILES_MANIFEST.md`
- `docs/audit/PHASE10_REFERENCE_REGRESSION_AUDIT.md`
- `docs/audit/PHASE10_STATIC_VERIFICATION.md`
- `docs/audit/PHASE10_TEST_REPORT.md`
- `docs/audit/PHASE10_RELEASE_HYGIENE_REPORT.md`
