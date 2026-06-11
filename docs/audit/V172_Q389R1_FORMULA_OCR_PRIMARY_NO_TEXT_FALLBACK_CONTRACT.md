# V172-Q389R1 — Formula OCR Primary / No Plain-Text Fallback Contract

Q389R1 removes plain text OCR fallback from the active camera OCR direction. The camera OCR product target is formula-recognition / image-to-LaTeX only: PP-FormulaNet_plus / formula-recognition is the primary engine family.

Active contract:

- Primary OCR engine family: PP-FormulaNet_plus / formula-recognition image-to-LaTeX.
- Plain text OCR fallback runtime dependency: absent.
- Flutter text-recognition dependency: absent.
- Android text-recognition dependency: absent.
- Plain-text OCR fallback behavior: disabled from the active contract.
- Workspace import remains review-first and explicit-user-approved.
- Solve, Graph, Solution, and History remain blocked from automatic camera output.
- No model binary is bundled in the base APK/AAB/project ZIP.
- ONNX Runtime is not reintroduced.
- No OCR PASS, Android real-device PASS, Flutter analyze/test PASS, or formula-recognition accuracy PASS is claimed by this package.

Protected surfaces intentionally untouched: Q382 keyboard ordering, keyboard layout, MORE/template tray, long-press inventory, Graph, Solution, History, Solver, MathLive caret authority, AndroidManifest, Gradle ABI policy beyond the active dependency contract, splash, icon, and startup.

Q389R1 is a cleanup/contract phase before the real premium formula-recognition runtime binding. It does not fake complex formula OCR and does not restore any simple text OCR fallback.
