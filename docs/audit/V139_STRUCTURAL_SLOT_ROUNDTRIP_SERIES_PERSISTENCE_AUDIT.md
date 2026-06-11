# V139 Structural Slot Round-Trip and Series Persistence Audit

## Scope

V139 continues the MathPro keyboard / MORE / long-press unification work by hardening structural slot round-tripping. The goal is to prevent public templates that already render as mathematical structures from degrading into raw text after the user fills a slot.

## Non-negotiable contracts preserved

- Keyboard key positions were not changed.
- Tab order was not changed.
- MORE, Ans, = and ↵ semantics were not changed.
- Long-press ordering was not changed.
- Graph, History, Solution, EditorViewport and EditorInteractionLayer were not modified.
- MathJax remains SVG-only with assistive MathML disabled/purged.

## Repairs

- Package metadata advanced to V139.
- EditorCommands function-call plain serialization now supports multi-argument function nodes instead of assuming a single `arg` slot.
- `f(□,□)` can round-trip through slot replacement as `f(x,□)` and parse back as a multi-argument FunctionCallNode.
- `(f∘g)(□)` can round-trip through slot replacement as `(f∘g)(x)` and still serialize through `\circ` rather than degrading into `fog` or raw text.
- Taylor/Maclaurin/geometric/binomial/exp filled-form series strings produced by structural editing can parse back into SeriesNode structures.
- EditorTexSerializer now treats `f`, `g`, and `h` as mathematical function names rather than `\operatorname{f}`-style generic operators, preserving prior public test expectations.

## Added regression gate

`test/v139_structural_slot_roundtrip_series_persistence_test.dart`

This test locks:

- current V139 metadata;
- multi-argument function slot round-trip;
- composition-call slot round-trip;
- Taylor slot edits remaining SeriesNode structures;
- filled Maclaurin/geometric series forms parsing back as SeriesNode structures.

## Local execution note

Flutter/Dart were not available in the packaging environment, so no local `flutter analyze`, `flutter test`, or `flutter run` PASS is claimed. The user must run the standard command sequence on their machine.
