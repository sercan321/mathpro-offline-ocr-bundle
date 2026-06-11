# MathPro V73 — Issue Closure Matrix

This matrix summarizes the issues collected from the user and how the V67-V72 implementation phases addressed them. V73 adds audit proof only.

| # | Issue | Addressed in | Status | Notes |
|---:|---|---|---|---|
| 1 | Workspace / solution panel / keyboard width mismatch | V68 | Static implemented; device verification required | Shared width rail repair and regression test were added. |
| 2 | Long expression cannot be inspected left/right | V69 | Static implemented; device verification required | Viewport navigation was enabled for long/nested/slot expressions. |
| 3 | Cursor movement hard in nested structures | V69 | Static implemented; device verification required | Navigation/pan separation and tap-first behavior were adjusted. |
| 4 | Visible `□` slots not reliably tappable | V69/V71 | Static implemented; device verification required | Slot hit-testing/render path improved; manual real-device tap test still required. |
| 5 | `ln()` / `sin()` / `log()` delete as broken text fragments | V70 | Static implemented; device verification required | Atomic delete path added before fallback delete. |
| 6 | `x₁`, `x₂`, `x□` subscript spacing poor | V71 | Static implemented; device verification required | Premium MathLabel normalization added. |
| 7 | `y^(n)` derivative-order style is not premium | V71 | Partially normalized; device verification required | Render normalization exists, deeper semantic nth-derivative conversion should be manually verified and may need a later focused phase if not sufficient. |
| 8 | Broad keyboard/MORE math notation quality | V71 | Static implemented; device verification required | MathLabel/TeX normalization path expanded. |
| 9 | Duplicate/wrong log templates | V71/V72 | Static implemented; device verification required | Log visuals normalized; duplicate `log(□)` removed from long-press. |
| 10 | `%` appears as blank/space | V70 | Static implemented; device verification required | TeX serializers escape `%` as `\%`. |
| 11 | `+`, `−`, `×`, `÷` stack side by side | V70 | Static implemented; device verification required | Consecutive basic operator replacement added. |
| 12 | Fraction long-press unnecessary | V72 | Static implemented; device verification required | Fraction long-press map entry removed. |
| 13 | Inverse trig should show as `sin⁻¹`, `cos⁻¹`, `tan⁻¹` | V71 | Static implemented; device verification required | MathLabel and TeX normalization added. |
| 14 | Root spacing and indexed-root display poor | V71 | Static implemented; device verification required | Root MathLabel normalization added. |
| 15 | Factorial long-press should only be `□C□`, `□P□` | V72 | Static implemented; device verification required | Long-press map now contains only these two options. |
| 16 | Absolute value long-press unnecessary | V72 | Static implemented; device verification required | Absolute-value long-press map entry removed. |

## Closure status

V73 is not a claimed runtime PASS because Flutter and a device are unavailable in this environment. It is a static/audit closure package ready for local `flutter analyze`, `flutter test`, and real-device regression.
