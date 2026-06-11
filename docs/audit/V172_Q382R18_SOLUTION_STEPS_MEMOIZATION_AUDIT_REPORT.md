# V172-Q382R18 — Solution Steps Memoization Audit Report

## Goal
Reduce keyboard-driven rebuild cost without changing solver, Solution Steps semantics, MathLive bridge, keyboard layout, OCR, Graph, History, Android, or workspace visual behavior.

## Surgical scope
- `lib/app/app_shell.dart`: route Solution Steps snapshot creation through a memoized helper.
- `lib/features/solution/solution_steps_memoization_q382r18_policy.dart`: static policy marker.
- `tool/verify_solution_steps_memoization_v172_q382r18.mjs`: regression verifier.

## Runtime behavior
- When Solution Steps panel is closed, AppShell returns a lightweight closed-panel snapshot and does not call `SolutionStepsComposer.compose` on every keyboard rebuild.
- When Solution Steps panel is open, AppShell calls `SolutionStepsComposer.compose` for authoritative output.
- When open-panel semantic inputs are unchanged, AppShell reuses the cached `SolutionStepsSnapshot`.
- Cache key covers expression, result, unsupported reason, selected action id/label/kind, and unsupported handler support flags.

## Protected areas
No changes were made to keyboard layout/order/labels, MORE/template tray, long-press lists, MathLive bridge, Graph, Result, History, OCR/Camera, AndroidManifest, MainActivity, Gradle, solver/evaluator semantics, splash/icon, or app startup.

## Honest limit
This phase reduces redundant Solution Steps composition work. It does not yet implement MathLive state-push coalescing, PremiumKey animation/cadence tuning, AppShell rebuild splitting, or real-device FPS measurement.
