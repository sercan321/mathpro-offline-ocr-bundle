# V172-Q135-Q139 — MathLive Full Main Editor Migration Audit

This batch stops treating the legacy cursor as something to patch. The normal workspace expression area is migrated to a mandatory MathLive main editor surface. Legacy cursor overlay/hit-test code remains in the repository only as rollback code and must not be the active main expression path.

## What changed

- `WorkspacePanel` no longer silently falls back to `EditorViewport` when `useMathLiveMainEditor` is true.
- `MathLiveMainEditorSurface` loads the WebView controller before the asset load so `onPageFinished` can run runtime mount/sync against the active controller.
- The surface now retries official MathLive mount, focuses the math-field, and exposes a small MathLive badge so real-device screenshots can confirm that the new path is visible.
- Keyboard layout files are untouched; AppShell still routes protected MathPro keyboard labels through the MathLive bridge when MathLive main editor mode is active.
- Runtime-missing state shows an explicit blocked panel instead of reusing the old cursor surface.

## What did not change

- No keyboard layout mutation.
- No MORE mutation.
- No long-press mutation.
- No Graph/History/Solution UI mutation.
- No physical deletion of legacy cursor files in this batch.
- No cursor/device/release PASS claim without user-side evidence.

## Real-device acceptance

The main expression area must visibly show the MathLive path or a MathLive-runtime-blocked panel. The old detached Flutter caret must not remain visible in the normal workspace. If the old cursor is still visible, the device is almost certainly running an old/stale build or a route outside the migrated WorkspacePanel.
