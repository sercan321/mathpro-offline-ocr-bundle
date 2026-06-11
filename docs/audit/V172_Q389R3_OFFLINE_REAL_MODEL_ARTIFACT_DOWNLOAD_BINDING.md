# V172-Q389R3_OFFLINE — Device-only Formula OCR real model artifact download binding

## Scope
This phase hardens the offline-only Formula OCR path after Q389R2_OFFLINE. It does not reintroduce backend OCR, ML Kit, text OCR fallback, or fake LaTeX candidates.

## Product target
Camera capture must route to a verified device-only PP-FormulaNet_plus Paddle Lite `.nb` runtime bundle. The user-facing `Modeli indir` action installs the complete bundle into app-private storage. After verified install, OCR uses local device inference only.

## Surgical repairs
- Fixed the camera shell duplicate `backgroundColor` argument that could break Flutter analysis/compile.
- `Modeli indir` now calls the Q389R3 offline installer entrypoint while preserving the Q389R2 compatibility alias.
- Native OCR blocked-reason logic now treats a verified `.nb` artifact as model-ready even when the legacy Paddle inference directory is absent.
- Native user-facing copy now reports Q389R3 offline bundle readiness errors instead of legacy inference-directory errors.
- Native decoder sidecar list includes PP-FormulaNet_plus tokenizer/vocab JSON names.
- Native OCR engine labels now use PP-FormulaNet_plus rather than the older PP-FormulaNet-S wording.

## Protected surfaces
Keyboard/Q382 ordering, keyboard layout, MORE/template tray, long-press menus, Graph, Solution, History, solver, MathLive caret authority, AndroidManifest, splash, icon, and startup flow are not changed.

## No false claims
This package does not claim Android device PASS, OCR PASS, or formula-recognition accuracy PASS. A real hosted `.nb` bundle manifest and device log are still required before claiming actual inference success.
