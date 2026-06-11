# V172-Q139R1 MathLive Migration Widget-Test Compatibility Repair

- Restores Q88 static bridge marker `mainEditorSwitchBehindFlag: true` as a compatibility marker.
- Adds `mathpro-editor-math-render-surface` to the MathLive-only surface wrapper so older widget tests can locate the active editor area.
- Adds controller-side shadow expression updates for MathPro keyboard input while MathLive remains the visible main editor.
- Does not restore legacy cursor overlay, legacy hit-test painting, or physical legacy cursor deletion.
- Does not touch keyboard layout, MORE, long-press lists, Graph UI, History UI, or Solution UI.
