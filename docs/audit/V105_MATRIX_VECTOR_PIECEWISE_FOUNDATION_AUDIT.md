# V105 — Matrix / Vector / Piecewise Foundation Audit

## Scope

V105 continues the Core Math Editor Engine direction without adding a solver and without changing keyboard, Graph, History, or Solution panel contracts.

Primary goal: move system-equation / cases-style templates away from plain string preview behavior and into a structural node family that can expose real editable left/right slots, while preserving the matrix/vector cell contracts introduced earlier.

## Repairs

- Added `MathNodeKind.piecewise` as the structural family for system/cases-style templates.
- Added `NodeFactory.piecewiseSystem(...)` with row-aware left/right slots.
- Added parsing for `{□=□;□=□}`, `{x≤1;y≤2}`, and `{□=□;…;□=□}` forms.
- Added slot registry exposure for `systemLeft` and `systemRight` roles.
- Kept n-equation ellipsis rows non-addressable so invisible middle rows do not become fake hit targets.
- Added TeX serialization for piecewise/system nodes using `\begin{cases}...\end{cases}`.
- Added plain serialization for piecewise/system nodes so filled left/right cells remain editable after slot replacement.
- Hardened matrix n-preview plain serialization so `[□ … □; … ; □ … □]` remains compact after a cell edit instead of expanding into fake ellipsis cells.
- Prevented render-mapped hit testing from flattening `systemLeft` / `systemRight` cells onto a single linear placeholder band.
- Added system/cases roles to slot navigation and touch calibration policies.
- Added direct fallback TeX support for filled full-string system expressions.

## Non-goals

- No solver was added.
- No Graph/History/Solution UI changes were made.
- No keyboard layout/key-position/tab-order changes were made.
- No long-press list order or content changes were made.
- No claim is made that this reaches Photomath/WolframAlpha quality. This is a structural foundation repair.

## Test Status

Flutter/Dart SDK was not available in the packaging environment, so `flutter analyze`, `flutter test`, and `flutter run` were not executed here.

User must run:

```bash
flutter analyze
flutter test
flutter run -d 23106RN0DA
```

## Real-device QA focus

1. `{□=□;□=□}` — tap and fill left/right cells independently.
2. `{x≤1;y≤2}` — edit right side of first row; relation must stay `≤`.
3. `{□=□;…;□=□}` — only first/last real rows should be editable; ellipsis row should not act like a hidden giant slot.
4. `[□ … □; … ; □ … □]` — edit top-left cell; compact matrix preview must remain compact.
5. `[□; … ; □]` — edit last vector cell; preview must remain row-aware.
