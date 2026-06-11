# V118 — Local MathJax Real Render Surface Audit

## Scope

This package implements the requested **KaTeX/MathJax-class real math render surface** for the editor input area. It does not change the keyboard, tab order, MORE, Ans, ↵, =, Graph, History, Solution panel, or long-press option order.

## Product change

The editor input math surface now follows this path:

`MathPro expression -> canonical expression -> TeX -> local MathJax SVG -> WebView`

This is not the earlier native visual-surface attempt. It is a real local MathJax WebView renderer for the editor role of `MathRenderSurface`.

## CDN / network status

- CDN: not used.
- Local MathJax asset: `assets/mathjax/tex-svg.js`.
- Internet permission: not added.

## Implemented files

- Added `webview_flutter: 4.7.0`.
- Added local MathJax SVG bundle: `assets/mathjax/tex-svg.js`.
- Registered the asset in `pubspec.yaml`.
- Added `lib/features/editor/render/mathjax_render_surface.dart`.
- Added `lib/features/editor/render/math_render_surface_role.dart`.
- Rewired `lib/features/editor/render/math_render_surface.dart` so editor role is forced through `MathJaxRenderSurface`.
- Reduced visible active-slot highlight size in `editor_interaction_layer.dart`; hit targets can remain usable, but visible focus should no longer cover formulas as a large green block.
- Added `test/v118_local_mathjax_real_render_surface_test.dart`.

## Protected surfaces

The following sacred contract files were not changed from the V116 base package:

- `lib/features/keyboard/key_config.dart`
- `lib/features/keyboard/math_keyboard.dart`
- `lib/features/keyboard/bottom_dock.dart`
- `lib/features/keyboard/long_press_popup.dart`
- `lib/features/solution/solution_steps_panel.dart`
- `lib/features/history/history_panel.dart`
- `lib/features/graph/graph_card.dart`

## Verification limits

Flutter/Dart SDK is not available in this execution environment, so this package was not locally run with:

- `flutter pub get`
- `flutter analyze`
- `flutter test`
- `flutter run -d 23106RN0DA`

The real Android WebView integration must be verified on the user's machine/device.

## Real-device acceptance checks

- `lim_y → 8(8)` must not appear as raw text in the editor input surface.
- `Σ_{...}^{...}` must not appear as raw text/TeX in the editor input surface.
- nested root/ln expressions must visibly use MathJax-style math output rather than the old stacked Flutter fallback composition.
- active slot focus must not appear as a large green block covering the formula.
