# V172-Q167 MathLive AppShell Command Bus Hard Binding Audit

Q167 responds to real-device evidence where the overlay showed `Q165 KEY:<label> SEND:Flutter`, proving the MathPro keyboard tap reached Flutter while the editor remained visually blank.

The repair hard-binds AppShell key handling to the MathLive surface by passing a sanitized immediate fallback expression to `MathLiveMainEditorRuntimeController.markKeyboardTap(...)`, then reports whether `sendKey(...)` reached the attached surface as `SEND:Bridge` or remained queued. The WebView/MathLive bridge remains the preferred source when it returns a non-empty value.

No keyboard layout, key order, MORE inventory/order, long-press order/source, MathLive template mapping meaning, Graph UI, History UI, Solution UI, or solver behavior was changed. No real-device/cursor/Photomath PASS is claimed without user-side evidence.
