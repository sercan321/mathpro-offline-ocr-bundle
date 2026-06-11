# V137 Public Math Label Visual Profile Contract Audit

## Scope

V137 continues the keyboard/MORE/long-press unification work without changing key positions, tab order, MORE, Ans, =, ↵, long-press ordering, Graph, History, Solution, EditorViewport, or EditorInteractionLayer.

## Repair

- Added `lib/logic/math_key_visual_contract.dart` as the central visual profile contract for public math labels.
- Connected `MathLabel._styleFor` to `MathKeyVisualContract.profileFor` so compact fallback text labels no longer depend on stale local buckets such as `bigOps`, `boundedOps`, or `functions`.
- Added a regression test to require every public keyboard, MORE, and long-press label to have a visual profile family.
- Locked high-risk labels (`lim`, `∫□dx`, `∫ₐᵇ`, `Σ`, `Π`, `Taylor`, `□!`, `□ᵀ`, `□C□`, `f∘g`, `log_□(□)`, `sin⁻¹(□)`) to compact non-heavy profiles.
- Updated package metadata to V137 through `MathProPackageContract`.

## Non-goals

- No key position changes.
- No long-press ordering changes.
- No Graph/History/Solution changes.
- No solver work.
- No device PASS claim without the user's real logs.
