# V172-C Changed Files Manifest

## Runtime

1. `lib/features/editor/cursor_anchor.dart`
   - Adds the canonical CursorAnchor model.
2. `lib/features/editor/interaction_context.dart`
   - Carries `CursorAnchor? cursorAnchor` in editor interaction snapshots.
3. `lib/features/editor/render/editor_controller.dart`
   - Resolves linear and structural cursor anchors when building snapshots.
4. `lib/features/editor/selection_controller.dart`
   - Emits structural slot anchors for active slot selections.
5. `lib/features/workspace/editor_caret_overlay.dart`
   - Uses CursorAnchor as the first source for visible caret placement.
6. `lib/features/workspace/editor_viewport.dart`
   - Uses CursorAnchor for inline caret target/active canvas target decisions.

## Tests

7. `test/core_editor_regression_test.dart`
   - Adds V172-C linear and structural CursorAnchor regression tests.
8. `test/widget_test.dart`
   - Adds V172-C overlay/anchor priority regression test.

## Documentation

9. `README.md`
10. `pubspec.yaml`
11. `docs/audit/V172_C_CURSOR_ANCHOR_AUDIT_REPORT.md`
12. `docs/audit/V172_C_CHANGED_FILES_MANIFEST.md`
13. `docs/audit/V172_C_SELF_CHECK_REPORT.md`
