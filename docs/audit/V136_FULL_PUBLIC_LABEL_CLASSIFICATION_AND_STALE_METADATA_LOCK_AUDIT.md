# V136 — Full Public Label Classification and Stale Metadata Lock Audit

## Scope

V136 continues the keyboard / MORE / long-press template consolidation work after V135.  It does not change keyboard positions, tab order, MORE, Ans, =, ↵, long-press ordering, Graph, History, Solution, EditorViewport layout, or EditorInteractionLayer behavior.

The phase focuses on two stale-risk areas that repeatedly caused regressions:

1. Old V13x tests hard-coded the currently active package version and became stale as the package advanced.
2. Public keyboard/MORE/long-press labels were not all explicitly classified as command, primitive text, or structural math template.

## Changes

- Added `lib/logic/mathpro_package_contract.dart` as the single release metadata contract for tests and audit code.
- Updated V131/V133/V135 metadata tests to read the active version/description/title from `MathProPackageContract` instead of hard-coding the current package version.
- Added `MathKeyInventory.primitiveTextLabels`, `classifiedPublicUiLabels`, `unclassifiedPublicUiLabels`, and `primitiveLabelsOutsidePublicUi`.
- Classified every public keyboard, MORE and long-press label as one of:
  - command label,
  - primitive text/operator/symbol label,
  - PremiumMathKeySpec-backed structural template,
  - MathTemplateContractRegistry-backed structural template.
- Added `test/v136_full_public_label_classification_test.dart`.

## Static verification targets

- `pubspec.yaml` is `0.136.0+136`.
- README head starts with V136.
- Old V131/V132/V133/V134/V135 package versions are not active in `pubspec.yaml`.
- Public UI label scan covers keyboard, MORE and long-press surfaces.
- No public label remains unclassified.
- Primitive labels still route to `InsertTextAction`.
- Commands remain command actions.
- Structural spec/registry labels route to `InsertTemplateAction`.
- MathJax SVG-only commit and assistive MathML purge stay locked.

## Protected files intentionally unchanged

- `lib/features/keyboard/key_config.dart`
- `lib/features/keyboard/bottom_dock.dart`
- `lib/features/keyboard/long_press_popup.dart`
- `lib/features/keyboard/premium_key.dart`
- `lib/features/graph/graph_card.dart`
- `lib/features/history/history_panel.dart`
- `lib/features/solution/solution_steps_panel.dart`
- `lib/features/workspace/editor_viewport.dart`
- `lib/features/editor/render/editor_interaction_layer.dart`

## Local execution note

The package was statically checked in the assistant environment. Flutter/Dart SDK execution was not available there, so `flutter pub get`, `flutter analyze`, `flutter test`, and `flutter run -d 23106RN0DA` must still be run on the user's machine before PASS can be claimed.
