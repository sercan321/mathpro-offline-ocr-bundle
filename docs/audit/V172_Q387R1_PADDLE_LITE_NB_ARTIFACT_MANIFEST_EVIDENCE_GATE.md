# V172-Q387R1 — Paddle Lite `.nb` Artifact Manifest / Evidence Gate

## Purpose

Q387 proved the current Android Paddle Lite binding must not blindly pass the downloaded Paddle inference-directory `inference.pdiparams` file to `MobileConfig.setModelFromFile(...)`. The current `PaddlePredictor.jar` exposes `setModelFromFile` and `setModelFromBuffer`, but no usable `setModelDir` path was accepted.

Q387R1 therefore creates the strict evidence gate for a real Paddle Lite optimized `.nb` model artifact. This phase does **not** invent a model URL, does **not** claim a converted `.nb` exists, and does **not** bundle a model in the base APK/AAB.

## Required real artifact contract

A future Q387R2 download/install phase may proceed only after a real candidate provides:

- `artifactKind`: `paddle-lite-optimized-nb`
- file extension: `.nb`
- HTTPS download URL
- 64-character SHA256
- declared size above the minimum guard
- conversion/source provenance for PP-FormulaNet-S
- download-only storage contract
- no `.nb` file committed into the Flutter/Android project tree

Runtime-side verified `.nb` installs must include a private-storage manifest named:

```text
q387r1_paddle_lite_nb_manifest.json
```

The native bridge validates this manifest next to the `.nb` file before it allows `MobileConfig.setModelFromFile(.nb)` to run.

## New blocked reasons

- `q387r1-real-paddle-lite-nb-artifact-evidence-required`
- `q387r1-nb-file-name-required`
- `q387r1-nb-file-extension-required`
- `q387r1-nb-download-url-required`
- `q387r1-nb-sha256-required`
- `q387r1-nb-size-required`
- `q387r1-conversion-provenance-required`
- `q387r1-nb-must-not-be-bundled-in-base-app`
- `q387r1-nb-manifest-missing`
- `q387r1-nb-manifest-invalid`
- `q387r1-nb-sha256-mismatch`
- `q387r1-nb-artifact-kind-mismatch`

## Native runtime protection

Q386/Q387 previously allowed a `.nb` candidate path to be selected. Q387R1 hardens that path: a `.nb` file is not considered ready unless its adjacent `q387r1_paddle_lite_nb_manifest.json` exists, declares `paddle-lite-optimized-nb`, names the exact file, declares a valid SHA256, and the native SHA check matches the real file.

Only then can the bridge select:

```text
q387r1-setModelFromFile-verified-paddle-lite-nb
```

Otherwise it blocks before model-load with a Q387R1 blocked reason and still produces no fake LaTeX candidate.

## Explicit non-claims

Q387R1 does not claim:

- OCR/image-to-LaTeX PASS
- Android real-device PASS
- Flutter analyze/test/run PASS
- `.nb` conversion success
- a production `.nb` URL or SHA
- APK/AAB size improvement
- Q382 real-device ordering PASS

## Scope protection

No keyboard layout/order/labels, MORE/template tray, long-press inventory, Graph, History, Solution/Solver semantics, splash/icon, or Q382 ordering pipeline behavior is intentionally changed.

## Result

Q387R1 moves the project from “`.nb` required” to “`.nb` evidence contract enforced.” The next phase must either provide a real converted/pre-optimized `.nb` URL + SHA + size + provenance, or remain blocked honestly.
