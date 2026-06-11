# MathPro Solution Panel V31 — Changed Files Manifest

## Runtime files changed
- `lib/app/app_shell.dart`
  - Added in-workspace solution panel state: `closed / medium / expanded`.
  - Wires solution steps open/close/expand callbacks into `WorkspacePanel`.
  - Keeps keyboard dock height logic unchanged.
  - Closes solution panel before opening History so History behavior remains isolated.

- `lib/features/workspace/workspace_panel.dart`
  - Adds top action icon for solution steps.
  - Adds three-dot placeholder icon with no user-facing menu/function.
  - Adds modest expression/result card shrink behavior when solution panel is open.
  - Adds same-screen scrollable solution panel slot below the card.

- `lib/features/solution/solution_step_models.dart`
  - New source-of-truth state/model/composer for solution panel content.
  - Composer is honest about current solver limits and does not fake symbolic step solving.

- `lib/features/solution/solution_steps_panel.dart`
  - New premium dark glass/teal-cyan solution steps panel.
  - Includes handle, header, close/expand controls, and internal scrollable step list.

## Test files changed
- `test/widget_test.dart`
  - Adds widget coverage for solution panel open/close behavior.
  - Adds widget coverage for medium/expanded state preserving card and keyboard context.
  - Adds composer honesty coverage for unsupported symbolic expressions.

## Metadata changed
- `pubspec.yaml`
  - Version bumped to `0.31.0+31`.

## Explicitly unchanged/frozen areas
- Keyboard source files were not edited.
- Graph runtime source files were not edited.
- History runtime source files were not edited.
