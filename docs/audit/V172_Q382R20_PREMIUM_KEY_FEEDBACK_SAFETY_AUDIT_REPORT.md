# V172-Q382R20 PremiumKey Animation/Input Feedback Safety Audit

## Goal
Reduce keyboard hot-path visual feedback cost without changing command semantics.

## Surgical Change
`PremiumKey` no longer uses `AnimatedContainer` for pressed decoration transitions. The key uses a static `Container` and keeps only one lightweight `AnimatedScale` feedback with a 48ms duration.

## Preserved Behavior
- Command dispatch remains on `GestureDetector.onTap`.
- `onTapDown` remains feedback/haptic only.
- Long-press start/end/action callbacks are preserved.
- Key labels, ordering, layout, variants, long-press indicators, and visual content are unchanged.
- Q382R19 MathLive keyboard insertion state push budget is preserved.
- Q382R13/R14/R16 pan experiments are not reintroduced.

## Explicit Non-Goals
- No `onTapDown` early command dispatch.
- No keyboard layout or label changes.
- No MathLive bridge change.
- No OCR/Camera, Graph, Solution, Result, History, Android, Gradle, or solver changes.
