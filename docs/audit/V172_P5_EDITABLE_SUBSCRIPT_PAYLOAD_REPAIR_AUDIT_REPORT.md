# V172-P5 Editable Subscript Payload Repair Audit

## Scope
Focused real-log repair for the remaining Flutter test failure after P4: `EditorCommands.selectedSlotPayload('x_□', activeSlotId: subscriptSlot.id)` returned null, while the regression contract expects the explicit editable subscript placeholder payload `□`.

## Runtime Change
`lib/features/editor/editor_commands.dart` now treats open placeholder payloads conservatively as before, except for the explicit editable `subscript` slot role where `□` is returned. Fixed display atoms such as `x₈` remain non-editable because they do not expose editable registry slots.

## Protected Areas
Keyboard, MORE, long-press maps, Graph, History, and Solution files were not edited. No loupe and no green debug overlay were introduced.

## Test Truth
Flutter is not available in this environment. User-side `flutter pub get` and `flutter analyze` were already PASS in the uploaded log; `flutter test` must be rerun by the user on this package.
