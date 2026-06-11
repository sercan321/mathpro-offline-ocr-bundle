# V172-Q382R3 — Workspace Context Menu Solution Intent Injection Repair

## Scope
Q382R3 is a surgical repair over Q382R2. It does not add a new feature. It repairs a deterministic correctness risk in selected workspace math-action metadata routing into the Solution steps list.

## Problem found
Q382R2 injected the selected-action intent step by checking `!injected.contains(intentStep)`. `SolutionStep` does not define value equality, so `contains` uses object identity. Because the code created one `intentStep` object but never added value-equivalent equality semantics, the guard was fragile and could allow repeated insertion when iterating over multiple downstream steps.

## Repair
`SolutionStepsComposer._withSelectedActionIntentStep` now uses an explicit `intentStepInjected` boolean. The selected-action metadata step is inserted once before the first downstream step with `index > 1`; if no such step exists, it is appended once.

## Preserved behavior
- Selected action metadata still routes to Solution snapshots.
- Unsupported handler actions still produce limitation metadata only.
- Fake factor/root/trig/calculus/complex outputs remain blocked.
- Keyboard, MORE/template tray, long-press, MathLive production assets, Q381R1 OCR, Graph, History, splash/icon, solver/evaluator, pubspec, Gradle, AndroidManifest and native OCR code are unchanged.

## Evidence expected
Static verifier: `node tool/verify_workspace_expression_context_menu_solution_intent_injection_v172_q382r3.mjs`.
