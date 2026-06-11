# V172-Q78 Fraction Function Root Log Native SlotBox Specialization Audit Report

Active version: `0.172.109+172`

Q78 is cursor/editor-only. It specializes fraction, function, root and log SlotBox families inside the native input surface introduced by Q71-Q76 and extended for integrals in Q77. It does not modify keyboard layout, key order, MORE, Ans, ↵, =, long-press popup, app shell, MathLabel, template tray, Solution, Graph, or History.

## Runtime change

- Adds `NativeFractionFunctionRootLogSlotBoxSpecializationPolicy`.
- Routes overlapping measured SlotBox candidates for numerator/denominator, function arguments, root index/body, and log base/argument through deterministic native lane scoring.
- Selection remains gated by authoritative `SlotGeometryBundle.hitRect`; Q78 does not introduce nearest-distance or visual-only guessing.
- Empty structural slots keep the existing exclusive `|□` leading-caret law.

## Evidence boundary

Q78 does not claim Flutter analyze/test/run PASS from this assistant environment. Flutter and Dart are unavailable here. Q78 also does not claim full native math renderer completion, true AST-slot-to-SVG identity, real-device +95 PASS, or Photomath/Wolfram parity. Those remain evidence-gated by user-side Flutter logs and device testing.
