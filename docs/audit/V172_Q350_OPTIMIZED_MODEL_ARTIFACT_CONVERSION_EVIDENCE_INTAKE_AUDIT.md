# V172 Q350 Optimized Model Artifact / Conversion Evidence Intake Audit

Phase: `V172-Q350-OPTIMIZED-MODEL-ARTIFACT-CONVERSION-EVIDENCE-INTAKE`

Q350 is an evidence-intake phase after Q349 blocked real model load. It does not load a model and does not run OCR.

## Scope

- Adds an external evidence intake protocol for Paddle Lite optimized PP-FormulaNet-S artifacts.
- Adds prepare/capture scripts for `../MathProOcrArtifacts/PP-FormulaNet-S-PaddleLite-Optimized`.
- Records that Q315 `inference.pdiparams` SHA evidence exists but is not accepted alone for Android Paddle Lite model-load.

## Non-goals

- No model binary bundled into the Flutter project.
- No model loader implementation.
- No model load.
- No runtime startup, dummy call, image-to-LaTeX, OCR review, or workspace import.
- No MainActivity, Gradle, pubspec, AndroidManifest, workspace, keyboard, MORE, long-press, MathLive, Graph, Solution, History, splash, icon, or solver changes.
- No Flutter/Android/OCR PASS claim.
