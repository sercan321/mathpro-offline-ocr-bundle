# V172-Q177 Viewport Static Marker Contract Repair

Q177 repairs the user-side Flutter test failure where `v172_q148_mathlive_viewport_fit_test.dart` expected `V172-Q148: premium viewport fit` in `assets/mathlive/main_editor.html`.

Scope:
- Restore the Q148 viewport-fit static HTML marker.
- Preserve Q175 default MathLive renderer purity.
- Do not reintroduce MathLive private glyph class styling.
- Do not mutate AppShell, keyboard layout/order, MORE, long-press order, Graph, History, or Solution surfaces.

No Flutter/analyze/test/run PASS is claimed from the assistant environment. No real-device premium PASS is claimed.
