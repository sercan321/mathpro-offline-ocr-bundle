# V172-Q153 — MathLive Flutter Test Contract Repair

Q153 is a targeted repair for user-side Flutter test failures reported after Q152.

## Repaired

- Restored Q141 compatibility markers required by existing Flutter tests after later bridge/CSS rewrites.
- Rebalanced Q150 popup fit from a too-small 64px chip to an 88px no-clip envelope while keeping compact width policy.
- Added a narrow AppShell fallback so simple one-character MathLive keys such as `x` remain visible to Flutter widget tests where WebView JavaScript does not run. Named templates such as Taylor and 3 Denklem still cannot be written as raw text.
- Hardened the Q152 verifier so user-side generated `.dart_tool/` and `build/` folders created by `flutter pub get` / `flutter test` do not falsely block workspace verification. Delivery ZIP hygiene remains enforced by packaging.

## Not claimed

No Flutter analyze/test/run PASS is claimed by the assistant. No real-device, cursor-fluidity, or Photomath-level PASS is claimed without user evidence.
