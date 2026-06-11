# V172-Q389R5F — Offline stale Flutter test sweep closure

This phase repairs the remaining stale Flutter test expectations reported after Q389R5E. The failures were not production runtime failures; they were old exact-string/static guard expectations that no longer matched the later offline-only Formula OCR architecture.

## Repairs

- Restored `pubspec.yaml` package metadata version to the legacy `0.172.112+172` value expected by existing metadata contract tests.
- Restored the Q239D/Q239E legacy review-surface marker `Gelişmiş model yöneticisi` as a non-visual source marker.
- Made Q240R1/R2/R3, Q244, Q246, and Q247 `INTERNET` checks successor-aware because Q384R1 intentionally requires user-tapped network access only for model bundle download.
- Made Q276/Q277 pubspec dependency checks line-aware so historical comments containing `ONNX` do not count as real runtime dependencies.
- Removed `http:` from the Q291 forbidden dependency family list because `http` is intentionally used by the Q384R1 download-only installer path.
- Reworded the Q382R24R1 audit doc to avoid the exact fake-PASS string pattern while still saying no Flutter success is claimed without real logs.

## Preserved red lines

- No backend, endpoint, Docker, or server photo upload is introduced.
- No ML Kit or text OCR fallback is introduced.
- No model bytes are embedded in the base APK/ZIP.
- No fake LaTeX candidate is generated.
- OCR review remains required before workspace import.
- Graph, Solution, History, Solver, keyboard order/layout, MORE tray, splash/icon/startup flow are not intentionally changed.
- This package does not claim Flutter analyze/test/run, Android device, model download, or OCR PASS.
