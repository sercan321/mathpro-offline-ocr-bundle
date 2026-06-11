# V172-Q134 — Main Editor MathLive Hard-Mount Audit

Q134 is a real main-editor hard-mount repair after Q133 did not visibly change the phone behavior. It stops silently falling back to the failed legacy Flutter cursor surface when the official MathLive runtime is absent. The expression area is now either a real local MathLive `<math-field>` surface or an explicit runtime-blocked panel telling the user to install the official runtime.

This package does not delete legacy cursor files, does not mutate keyboard/MORE/long-press files, does not claim cursor PASS, and does not claim release PASS. Legacy `EditorViewport` remains present only as rollback code; the active Q134 expression surface is `MathLiveMainEditorSurface`.

Device validation is still required. If the user still sees the exact old legacy cursor after this package, the likely causes are stale APK/cache/wrong ZIP installed, or the main application build did not include this Q134 package. If the MathLive runtime is missing, the expression card should visibly show a MathLive runtime blocked message instead of the old cursor.
