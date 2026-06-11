# V172 Q382R21 — AppShell Rebuild Granularity Audit Report

## Purpose

Reduce keyboard input hot-path rebuild cost without changing keyboard behavior, MathLive bridge semantics, graph, solution, OCR, history, or Android/Kotlin code.

## Surgical Change

`AppShell` no longer wraps the entire scaffold/body/dock in a merged calculator/history `AnimatedBuilder`.

Instead:

- `Scaffold`, `LayoutBuilder`, `AnimatedSwitcher`, `HistoryPanel`, and `BottomDock` remain in the shell build path.
- `WorkspacePanel` is moved behind `_buildCalculatorWorkspace()`.
- `_buildCalculatorWorkspace()` is the only subtree listening to `_calculator` through `AnimatedBuilder(animation: _calculator)`.
- `BottomDock` is outside the calculator AnimatedBuilder, so rapid MathLive key input does not rebuild the keyboard dock.
- `HistoryPanel` remains controller-driven internally and is not placed in the calculator hot path.

## Preserved Contracts

- Keyboard `onKeyPressed: _handleKeyPressed` remains unchanged.
- BottomDock active tab behavior remains unchanged.
- History open/close and selection callbacks remain unchanged.
- WorkspacePanel still receives the same calculator state, graph state, solution snapshot, MathLive controller, OCR import callback, and context menu callbacks.
- Q382R18 SolutionSteps memoization remains active.
- Q382R19 MathLive state push budget remains active.
- Q382R20 PremiumKey feedback safety remains active.
- Q382R13/Q382R14/Q382R16 direct-pan experiments remain removed.

## Expected Performance Effect

Calculator updates from fast keyboard input rebuild the workspace subtree that needs expression/result state, but no longer rebuild the keyboard dock and history container at the same cadence.

## Deliberately Not Changed

- No `onTapDown` command dispatch change.
- No MathLive bridge command queue change.
- No Android timeout change.
- No `MainActivity.kt` change.
- No OCR/camera change.
- No graph/solution/history semantics change.
- No keyboard layout or long-press list change.
