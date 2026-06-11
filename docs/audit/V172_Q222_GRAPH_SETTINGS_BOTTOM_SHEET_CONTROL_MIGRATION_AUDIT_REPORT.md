# V172-Q222 Graph Settings Bottom Sheet Control Migration Audit

Q222 activates the focused premium Graph Settings bottom sheet while preserving the Q221 canvas-first mini graph panel. Mode, graph window, trace and reset view controls are available in the sheet instead of returning large text controls to the mini panel.

No keyboard, MORE, long-press, MathLive production editor/bridge, History, Solution, splash/startup, launcher icon, solver or graph runtime evaluator behavior is intentionally changed. `lib/app/app_shell.dart` has a narrow settings binding change only so the sheet can receive and apply the active render mode.

Assistant-side checks are static/fresh-extract/verifier only. Flutter analyze/test/run and Android visual PASS are not claimed without user-side logs.
