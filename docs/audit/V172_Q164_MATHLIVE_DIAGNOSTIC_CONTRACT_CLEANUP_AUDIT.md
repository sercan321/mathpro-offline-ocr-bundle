# V172-Q164 MathLive Diagnostic Contract Cleanup Audit

## Scope
Q164 is a narrow cleanup phase after Q163. It fixes analyzer interpolation hygiene and restores static compatibility markers expected by legacy Q140/Q161 tests while preserving the Q163 real-device diagnostic bridge.

## Changes
- Replaced string concatenation in the Q163 key-command diagnostic reason with Dart interpolation.
- Restored the Q140 `if (!insertIntoMathfield(latex))` marker in the active bridge insert path.
- Restored the Q161 `visibleFallbackMayRenderStructuralTemplates` marker on the surface without changing the policy's protected behavior.
- Added Q164 policy, test, verifier, and manifest envelope.

## Non-goals
- No keyboard layout/key order changes.
- No MORE or long-press order changes.
- No Graph/History/Solution UI changes.
- No claim of real-device, cursor, or Photomath-level pass.

## Required next evidence
Run `flutter analyze`, `flutter test`, `node tool/verify_mathlive_diagnostic_contract_cleanup_v172_q164.mjs`, then run on the real device and report the Q163 diagnostic overlay.
