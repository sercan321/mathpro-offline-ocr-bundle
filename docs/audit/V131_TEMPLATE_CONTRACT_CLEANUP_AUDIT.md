# V131 Template Contract Cleanup Audit

## Scope
V131 is the first cleanup phase for MathPro keyboard/MORE/long-press template consistency. It targets stale regression failures and the visible key-label imbalance reported on the real device.

## Repairs
- `NodeFactory` now parses function templates before generic postfix templates, preventing inverse trig such as `sin⁻¹(□)` from becoming postfix fragments.
- `NodeFactory` keeps log-base parsing before function parsing so `log(2)(5)` remains a base-log structure.
- `SlotRegistry` now exposes `postfixTarget` for `MathNodeKind.postfix` and keeps filled function/series targets editable.
- Multi-argument function calls such as `f(□,□)` keep separate argument slots while preserving the existing public label.
- `EditorTexSerializer` serializes multi-argument functions as comma-separated math arguments.
- The old widget test expectation that the editor MathJax surface disappears after `C` was updated to the persistent surface contract.
- `MathLabel` limit glyph weight/size was reduced for visual consistency with neighboring calculus keys.

## Preserved contracts
Keyboard positions, tab order, MORE, Ans, ↵, =, long-press order, Graph, History, Solution panel, and MathJax SVG-only commit behavior are unchanged.

## Local limitation
Flutter/Dart are not installed in this container; analyzer/test/run PASS is not claimed.
