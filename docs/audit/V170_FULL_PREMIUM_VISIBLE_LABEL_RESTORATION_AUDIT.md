# V170 Full Premium Visible Label Restoration Audit

## Scope

V170 fixes a visual product regression where internal AST/template expressions leaked into keycaps, MORE chips and long-press cards. The semantic node system remains active behind the UI, but visible labels are restored to premium user-facing text.

## Restored Contract

- Visible label and hidden template expression are separate.
- Human-readable labels such as Taylor, Kuadratik, EBOB, EKOK, RREF, Rank and 2×2 Matris stay readable.
- Template placeholders such as `□` must not be rendered as visible keyboard/MORE/long-press label text.
- Key positions, tab order, MORE categories and long-press ordering are not changed.
- Graph, History, Solution, EditorViewport and EditorInteractionLayer are not changed.

## Flutter Status

Flutter was not available in the packaging environment. No local analyze/test/run PASS is claimed.
