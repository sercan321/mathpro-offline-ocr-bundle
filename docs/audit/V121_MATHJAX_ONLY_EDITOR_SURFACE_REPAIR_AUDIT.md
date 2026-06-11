# V121 — MathJax-Only Editor Surface Repair Audit

## Scope

This repair targets only the visible editor math surface. It keeps the frozen keyboard, key positions, tab order, MORE/Ans/= semantics, Graph, History and Solution panel behavior unchanged.

## Defect Addressed

The previous package exposed MathJax in the editor, but the old Flutter interaction layer could still paint visible slot highlights/carets over the WebView/SVG math. This created real-device overlay clashes and kept the duplicate/stacked-render risk open.

## Implemented Repairs

- `EditorInteractionLayer` now separates slot interaction from visible overlay painting.
- Slot hit-testing remains active through `SlotHitTesting.hitTest` and the linear placeholder fallback.
- Visible legacy slot overlay defaults to disabled through `paintVisibleSlotOverlay = false`.
- The old `_InlineCaret` widget was removed from `editor_viewport.dart`, so it cannot paint a Flutter caret over the MathJax editor surface.
- `MathJaxRenderSurface` now declares the V121 contract: legacy editor overlay suppression, render epoch guard, and single DOM math container.
- MathJax JS rendering now uses `MathJax.tex2svgPromise(tex, {display: true})` and `math.replaceChildren(node)` instead of staging visible content through a second DOM body.
- Stale asynchronous MathJax renders are ignored through an epoch guard.

## Guardrails Preserved

- Keyboard layout and key order not changed.
- `MORE`, `Ans`, `=`, and `↵` semantics not changed.
- Graph UI not changed.
- History UI not changed.
- Solution panel UI not changed.
- Long-press option lists not changed.
- No solver or feature-expansion work included.

## Verification Status

Flutter/Dart SDK is not available in the assistant container. Therefore no local `flutter analyze`, `flutter test`, or `flutter run` PASS is claimed for this package.

User/device verification remains required:

```bash
flutter pub get
flutter analyze
flutter test
flutter run -d 23106RN0DA
```

## Real-Device Acceptance Targets

- Same expression must not appear twice in the editor.
- No cyan/green slot highlight/caret should overlay the MathJax formula.
- No `Seçim / Aktif alan` card should appear.
- `tan(tan(□))`, `log₂(5)`, `lim`, `Σ`, roots and nested expressions should render as a single MathJax surface.
