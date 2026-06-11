# MathPro Final Repair V2 — Professional UI / Editor / Keyboard Audit

## Scope
This repair addresses the user's reported regressions after the prior package:

1. History surface still appearing.
2. Bounded integral long-press glyph clipped / half-visible.
3. `tan(□)` / function argument boxes still difficult to tap.
4. Bottom row (`MORE 0 . Ans`) still colliding with Android navigation / gesture bar.
5. Workspace/editor should remain wider, centered, and premium.

## Runtime history removal
Runtime code was checked for the removed history implementation. The current app runtime has no `HistoryStore`, no `HistoryDrawer`, no `history_handle`, no `features/history` import, and no `shared_preferences` dependency.

Static runtime check result: `runtime_history_shared_prefs_hits=0`.

## Integral long-press repair
The previous long-press popup envelope was too short for the custom bounded integral glyph. The popup was enlarged and the `∫ₐᵇ` glyph was rebuilt with a larger non-clipped visual box.

Key facts:
- `KeyConfig.getLongPressOptions('∫', ...)` remains `['∫', '∫ₐᵇ', '∮']`.
- The popup filters out the pressed key itself, so visible options are `∫ₐᵇ` and `∮`.
- `∬` is not in integral long-press.
- `∫ₐᵇ` still inserts the structural template `∫_{□}^{□}(□)d□`.

## Function/tan slot tap repair
Function argument slots were too close to generic 44 px targets. This repair promotes function arguments to large mobile targets:

- `functionArgument` registry priority: `120`.
- `functionArgument` minimum touch size: `66`.
- Function visual bounds expanded over the parenthesis/argument region.
- Slop increased to `left/right 34`, `top/bottom 30`.
- Priority policy gives `functionArgument` an explicit structural bonus.

## Android navigation repair
The previous bottom inset trusted `MediaQuery.viewPadding` / `padding` only. Some Android gesture-navigation devices can report zero while still drawing a gesture bar. This repair uses:

- `viewPadding.bottom`
- `padding.bottom`
- `systemGestureInsets.bottom`
- strict fallback guard: `30.0`
- final clamp: `24.0..72.0`

This is intended to keep the `MORE / 0 / . / Ans` row above the navigation/gesture area instead of behind it.

## Workspace/editor repair
The editor area remains enlarged:

- Workspace editor share increased.
- Viewport minimum height increased.
- Canvas width increased for stronger center-origin behavior.
- Render max width/height increased to reduce cramped feel.

## Preserved product law
These were not changed:

- Tab names/order: `Temel`, `Cebir`, `Kalkülüs`, `Kompleks`, `Lineer Cebir`.
- Basic keyboard row: `MORE 0 . Ans`.
- Expanded keyboard row: `MORE 0 . = ↵`.
- `MORE` remains `MORE`.
- `Ans` remains one-tap answer insertion.
- `↵` remains command/evaluate.
- `=` remains literal text insert.

## Command evidence
Not run in this ChatGPT environment because Flutter/Dart SDK is not installed:

- `flutter analyze`: NOT RUN
- `flutter test`: NOT RUN
- `flutter run`: NOT RUN

No fake PASS is claimed.
