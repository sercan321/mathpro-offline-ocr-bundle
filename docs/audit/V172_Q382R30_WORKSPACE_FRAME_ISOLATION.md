# V172 Q382R30 — Workspace Frame Isolation

## Scope

Q382R30 isolates the hot expression/result frame from the structural Workspace shell so ordinary MathLive key updates do not rebuild the full WorkspacePanel/card/layout tree when the structure is unchanged.

This phase is intentionally narrow:

- No keyboard layout/order/label change.
- No MORE/template inventory change.
- No long-press list change.
- No optimistic echo scope expansion.
- No MathLive JS command semantic change.
- No Graph/Solution/History/OCR/Android/Gradle/MainActivity change.
- No pan/drag-scroll code.

## What changed

Added `WorkspaceFrameHotSnapshotQ382R30` and `WorkspaceFrameIsolationQ382R30Policy`.

AppShell now owns a `ValueNotifier<WorkspaceFrameHotSnapshotQ382R30>` containing only:

- expressionText
- resultText
- statusText

The calculator listener updates this notifier when the hot frame changes. The Workspace structural shell uses `_WorkspaceStructuralKeyQ382R30` and a cached widget to avoid rebuilding the full WorkspacePanel when only the hot expression/result frame changes.

WorkspacePanel now confines expression/result rebuilds to:

- `_Q382R30ExpressionFrameSection`
- `_Q382R30ResultFrameSection`

These are backed by `ValueListenableBuilder<WorkspaceFrameHotSnapshotQ382R30>` so MathLive surface props/result display can update without rebuilding the entire workspace layout/card/tray/graph/solution shell.

## Safety

Solution panel content is still recomputed when the solution panel is open, because Q382R30 includes solution expression/result/status in the structural key only for open solution panel state. When the solution panel is closed, expensive solution snapshot recomposition remains outside the hot key frame path.

Graph, MORE, history, OCR/camera, keyboard input inventory, MathLive native caret authority, Q382R27 optimistic echo gating, and Q382R28 JS-side command queue are preserved.

## Verification

Run:

```powershell
node tool/verify_workspace_frame_isolation_v172_q382r30.mjs
```

Then run the full verifier chain before Flutter analyze/test/run.
