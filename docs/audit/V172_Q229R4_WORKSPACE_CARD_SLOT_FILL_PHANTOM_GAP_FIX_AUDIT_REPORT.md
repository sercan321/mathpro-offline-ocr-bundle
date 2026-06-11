# V172-Q229R4 — Workspace Card Slot Fill / Phantom Gap Root Fix Audit Report

## Scope

Q229R4 is a workspace layout root-fix phase.  It does not add solver features and does not change keyboard, MathLive production editor, Graph engine, Solution engine, MORE/template tray content, History, AppShell coordination, Android startup, or evaluator behavior.

## Root Cause

The parent layout allocated a taller `cardSlotHeight`, but `_PremiumQuestionAnswerCard` calculated a smaller `cardVisualHeight`.  The visual card was aligned at the top of its slot, so the unused lower part of the slot looked like a workspace-keyboard gap.

Legacy cap examples removed from the workspace visual height route:

- `templateTrayOpen` max `292`
- idle max `316`
- idle max `348`
- Graph/default `0.76` cap family

## Runtime Change

`_PremiumCardMetrics.cardHeight()` now returns the usable slot height directly.  Small premium breathing room remains controlled by `_PremiumCardMetrics.margins()`, not by capping the card visual surface.

The non-solution result flex now applies whenever the card is tall enough, not only during idle expansion:

```dart
final resultFlex = !stepsPanelOpen && cardVisualHeight >= 260 ? 3 : 2;
```

## Representative Slot/Visual Measurements

These are static representative calculations after the Q229R4 rule:

| State | cardSlotHeight | cardVisualHeight | Difference | Meaning |
|---|---:|---:|---:|---|
| Idle | 520 | 507 | 13 | 8 top + 5 bottom margin only |
| MORE | 360 | 340 | 20 | 12 top + 8 bottom margin only; old 292 cap removed |
| Graph | 360 | 340 | 20 | Graph uses MORE/Solution rhythm; old 316/348 cap removed |
| Solution | 360 | 341 | 19 | 12 top + 7 bottom margin only |

## Protected Surface Result

Protected/non-target files were verified by hash in the Q229R4 verifier:

- Keyboard files unchanged
- MORE/template tray unchanged
- MathLive production files unchanged
- Solution panel/model files unchanged
- Graph runtime files unchanged
- History files unchanged
- AppShell/main unchanged
- Android startup files unchanged

## Evidence Boundary

Assistant environment has no Flutter/Dart runtime.  Q229R4 is static/verifier/fresh-extract ready only.  Flutter analyze/test/run and Android pixel QA must be proven on the user's machine.
