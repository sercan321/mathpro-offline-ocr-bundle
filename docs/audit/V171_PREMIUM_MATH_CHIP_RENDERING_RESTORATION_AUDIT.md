# V171 Premium Math Chip Rendering Restoration Audit

## Scope

V171 restores the long-press math-chip rendering contract without changing keyboard layout, tab order, MORE categories, long-press option order, Graph, History, Solution, EditorViewport or EditorInteractionLayer.

## Problem

V170 restored visible labels but over-corrected long-press chips into a text-only path. This broke the V76 visual consistency contract that symbolic long-press options must route through the math-chip branch while ordinary names remain text.

## Repair

- Reintroduced the `isMathish` branch in `long_press_popup.dart`.
- Kept `_mathishChipLabels` active and used.
- Kept visible labels user-facing via `UnifiedMathPreviewPolicy.visibleDisplayLabel`.
- Removed the `mathLabel = false` dead-code pattern in `template_tray.dart`.
- Preserved hidden compatibility anchors without showing raw `□`/template text.

## Verification Status

Flutter was not available in the packaging environment. `flutter analyze`, `flutter test`, and device run must be executed by the user.
