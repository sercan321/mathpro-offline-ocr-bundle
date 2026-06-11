# V172-Q382 Workspace Expression Context Menu / Semantic Math Action Intent Shell Audit

Baseline: V172-Q381R1 Camera OCR Runtime Risk Repair.

Q382 adds a premium floating expression context menu to the workspace expression area through a safe expression hit-zone. The menu is an OverlayEntry, not a layout panel, so it does not resize the workspace, push the keyboard, or compress Graph/Solution/History/MORE surfaces.

Implemented contracts:
- Kopyala, Yapıştır, Kes, Tümünü Seç, Temizle editor actions.
- Conservative expression classifier for numeric, polynomial, rational, trig, log/exp, radical, absolute value, complex, calculus, system, matrix and unsupported shells.
- Semantic math action resolver for factor, expand, roots, domain, trig/log solve, complex form, derivative/integral/limit and related intents.
- Selected math action chip: `İşlem: ...` with explicit clear affordance.
- Solution metadata routing through `SolutionStepsComposer` using selectedActionId/selectedActionLabel/selectedExpressionKind.
- No fake solver result: selected action only adds intent metadata and an explicit limitation step when no real handler is proven.
- Q381R1 OCR review-first and no-auto-Solve/Graph/Solution/History contracts preserved.

Flutter/Android runtime PASS is not claimed by this audit. Real device screenshot/video remains required for final UX court.
