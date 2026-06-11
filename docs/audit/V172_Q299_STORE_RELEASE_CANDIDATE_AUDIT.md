# V172-Q299 — Store Release Candidate Audit

## Purpose

Q299 adds a contract-only Store Release Candidate Audit gate after Q298. The phase is intentionally evidence-gated and release-blocked. It does not submit the app to Google Play, configure Play Console, publish a privacy policy, complete the Data Safety form, run OCR, invoke a native runtime, or claim store/release readiness.

## Store Audit Scope

The Q299 gate requires evidence for:

- privacy policy URL and in-app access,
- Play Console Data Safety form,
- camera permission purpose limitation,
- model license/source/size disclosure,
- truthful OCR claims without fake accuracy or Photomath-level guarantees,
- real-device screenshots and optional video evidence,
- localized listing review for planned languages,
- content rating / ads / data declarations,
- app-bundle hygiene with no PP-FormulaNet-S model binary in the base APK,
- Q288→Q298 Camera/OCR evidence-chain continuity.

## Runtime Boundary

Q299 does **not** add Paddle/PaddleOCR, JNI, MethodChannel runtime binding, production model download, model binary, private artifact load, runtime startup, dummy runtime call, image-to-LaTeX inference, editable review runtime, workspace import runtime, or Play Store submission.

## Protected Surfaces

Keyboard, MORE/template tray, long-press lists, MathLive production route, MathLive bridge, Graph, Solution, History, AppShell, workspace runtime, camera shell runtime, AndroidManifest, MainActivity, splash/icon, solver/evaluator, camera dependency, and Android toolchain are unchanged.

## Dürüst Sınır

Q299 is static/verifier/fresh-extract only. Flutter analyze/test/run and Android device behavior remain user-side evidence. Store-ready PASS, release PASS, OCR PASS, Data Safety PASS, and privacy-policy PASS are forbidden without real external evidence.
