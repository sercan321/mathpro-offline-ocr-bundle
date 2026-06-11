# V172-A Changed Files Manifest

## Runtime

- `lib/features/workspace/editor_viewport.dart`
  - Inserts `EditorCaretOverlay` between the math render surface and the interaction layer.
  - Keeps `EditorInteractionLayer.paintVisibleSlotOverlay` disabled.

- `lib/features/workspace/editor_caret_overlay.dart`
  - New visual-only overlay for the production caret.
  - Resolves linear caret rects from `MathProCaretController.inlineCaretRectForExpression`.
  - Resolves active slot caret rects through `MathLayoutEngine` + `RenderMappedSlotHitTest` + `MathProCaretController.caretRectForSlot`.
  - Paints only a thin blinking caret line; no green focus box or debug fill.

## Tests

- `test/widget_test.dart`
  - Adds V172-A regression coverage for visible premium caret and no legacy green slot highlight.

## Metadata / Docs

- `pubspec.yaml`
  - Bumps package version to `0.172.0+172`.

- `README.md`
  - Updates package identity and verification instructions for V172-A.

- `docs/audit/V172_A_PREMIUM_CURSOR_OVERLAY_AUDIT_REPORT.md`
- `docs/audit/V172_A_CHANGED_FILES_MANIFEST.md`
- `docs/audit/V172_A_RELEASE_HYGIENE_REPORT.md`
