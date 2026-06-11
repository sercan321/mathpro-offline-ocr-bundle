# V172-Q244R2 — Camera Regression Flutter Compile Hygiene Repair Audit

## Scope

Q244R2 repairs the user-side Q244R1 Flutter analyze/test compile failure in
`lib/features/workspace/workspace_panel.dart` where stale `muted` references
remained after the Q244R1 analyzer hygiene edit removed the `_CardIconButton`
optional parameter.

## What changed

- Replaced the inactive `_CardIconButton` gradient alpha expression with the
  previous default value `0.040`.
- Replaced the inactive `_CardIconButton` border alpha expression with the
  previous default value `0.27`.
- Added Q244R2 policy/test/verifier/audit metadata.
- Hardened the Q244R1 verifier so stale `muted` references cannot pass again.

## What did not change

- No keyboard layout mutation.
- No MORE/template tray mutation.
- No long-press mutation.
- No MathLive production HTML/bridge/surface mutation.
- No Graph, Result, Solution, or History runtime mutation.
- No splash/startup or launcher icon mutation.
- No OCR runtime, model binary, model URL, Text OCR fallback, PaddleOCR, Pix2Text, ONNX,
  background worker, direct workspace import, or direct solve.

## Honest boundary

This package is statically verified in the assistant environment. Flutter/Dart
are unavailable there, so real `flutter analyze`, `flutter test`, and Android
camera behavior must still be rerun by the user.
