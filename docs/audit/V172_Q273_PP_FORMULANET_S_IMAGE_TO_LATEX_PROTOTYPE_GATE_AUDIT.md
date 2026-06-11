# V172-Q273 PP-FormulaNet-S Image-to-LaTeX Prototype Gate Audit

Phase: `V172-Q273-PP-FORMULANET-S-IMAGE-TO-LATEX-PROTOTYPE-GATE`
Source phase: `V172-Q272-PP-FORMULANET-S-FIRST-RUNTIME-SMOKE-PROTOTYPE`

This phase installs an Image-to-LaTeX prototype gate for the PP-FormulaNet-S camera/OCR path. It does **not** add a real OCR runtime, does **not** add Paddle/PaddleOCR, does **not** bundle a model, does **not** bind a production model URL, does **not** run image-to-LaTeX inference, and does **not** claim OCR PASS.

## Gate scope

- Cropped image input envelope
- Preprocess metadata envelope
- Runtime candidate response envelope
- Primary LaTeX candidate field
- Alternative LaTeX candidate field
- Confidence, warnings, and engine metadata fields
- MathLive editable review requirement
- Explicit user approval before workspace import
- Direct solve / Graph / Solution / History block

## Runtime constraints

- Runtime feature flag remains default-off.
- Production inference remains disabled.
- Real image-to-LaTeX inference is blocked until real runtime evidence exists.
- Camera output may not bypass MathLive review.

## Protected surfaces

Keyboard, MORE/template tray, long-press, MathLive production editor, Graph, Solution, History, AppShell/main, AndroidManifest/MainActivity, splash, workspace panel, Android toolchain, and camera shell remain protected.
