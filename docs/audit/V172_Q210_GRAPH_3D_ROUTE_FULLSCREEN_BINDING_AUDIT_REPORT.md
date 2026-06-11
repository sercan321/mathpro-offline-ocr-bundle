# V172-Q210 Graph 3D Route / Fullscreen Binding Audit Report

## Scope

Q210 is a surgical continuation of Q209. Q209 introduced the first real package-side `GraphSurface3D` custom painter, but 3D routing was still incomplete. Q210 binds the 3D surface to the graph-opening path and fullscreen path without touching protected keyboard, MORE, long-press, MathLive production editor, History UI, or Solution UI surfaces.

## Implemented

- Added 3D graph eligibility for `z = f(x,y)` style input.
- Added raw `x/y` surface eligibility for input such as `x^2 + y^2` and `sin(x) + cos(y)`.
- Added `GraphExpression.preferredRenderMode` and `displayExpressionFor(GraphRenderMode)` so 3D-capable expressions can auto-open as `3D` and label as `z = ...`.
- Updated preview header/value bar to use render-mode-aware display text and correct 3D x/y ranges.
- Updated fullscreen graph page to receive initial 2D/3D mode, render `GraphSurface3D`, expose a compact 2D/3D toggle, keep trace overlay 2D-only, and return mode state to AppShell.
- Hardened Q209 3D painter clamp calls with `.toDouble()` for analyzer type safety risk around `Color.lerp` and glow radius.
- Updated Q208/Q209 verifier successor lists to recognize Q210.
- Added Q210 static verifier, policy, test, manifest envelope, changed-files manifest, and protected hash manifest.

## Explicitly not implemented / not claimed

- No keyboard layout/key order/MORE/long-press change.
- No MathLive production editor mutation.
- No History UI or Solution UI mutation.
- No real Android 3D PASS claimed.
- No Flutter analyze/test PASS claimed by assistant because Flutter/Dart are unavailable in this environment.
- No interactive 3D rotation/shading engine claimed; Q210 is a route/fullscreen binding phase on top of the Q209 3D surface foundation.

## Required user-side validation

```text
flutter pub get
flutter analyze
flutter test
flutter run -d <device>
```

On device, manually verify:

```text
z = x^2 + y^2
x^2 + y^2
sin(x) + cos(y)
y = x^2
```

Expected:

- `z = x^2 + y^2`, `x^2 + y^2`, and `sin(x)+cos(y)` open as 3D surface candidates.
- `y = x^2` remains 2D by default.
- Preview 2D/3D toggle works.
- Fullscreen preserves the preview mode and can render the 3D surface.
- Returning from fullscreen preserves the chosen render mode.
