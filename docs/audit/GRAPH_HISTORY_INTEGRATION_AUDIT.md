# MathPro Graph + Premium History Integration Audit

## Scope
Integrated the first production-oriented graph/history layer without changing frozen keyboard layout, tab order, key positions, or long-press maps.

## Graph Layer
- Added graph eligibility classification for explicit x expressions, y=f(x), numeric constant suggestions, implicit pending equations, and non-graphable expressions.
- Added premium Graph Card with header, graph surface, value bar, action chips, close/fullscreen/settings controls.
- Added fullscreen graph page.
- Added constant function suggestion bottom sheet for numeric results.
- Added graph settings sheet with honest first-stage limitations.
- Added CustomPainter graph surface with grid, axes, curve sampling, and trace dot.

## History Layer
- Added hidden-by-default premium history panel.
- History opens via card history icon or downward drag on the question/answer card.
- History hides keyboard while open and restores normal calculator layout when closed.
- Added history controller, models, grouped sections, item cards, long-press actions, and mini graph preview.
- Storage is in-memory in this phase. No persistence dependency was introduced.

## Keyboard Protection
- key_config.dart unchanged.
- math_keyboard.dart unchanged.
- bottom_dock.dart unchanged.
- long_press_popup.dart unchanged.
- MORE, Ans, ↵, = contracts preserved.

## Known Limits
- Advanced implicit graphing is not implemented; it returns a user-facing pending message.
- Advanced graph pan/zoom/trace controls are surfaced honestly with explanatory messages; the current graph renderer uses fixed bounds.
- History persistence is intentionally not added in this phase to avoid dependency drift; items are in-memory.

## Required User-Side Validation
Run:

```powershell
flutter clean
flutter pub get
flutter analyze
flutter test
flutter run -d 23106RN0DA
```

Then manually test:
- x expression opens Graph Card.
- 3+5 after evaluation suggests y=8 constant graph.
- y=sin(x) opens Graph Card.
- x²+y²=1 shows implicit pending message.
- History stays hidden by default and opens from the icon.
- History opens by downward drag on card.
- Keyboard layout/position remains unchanged.
