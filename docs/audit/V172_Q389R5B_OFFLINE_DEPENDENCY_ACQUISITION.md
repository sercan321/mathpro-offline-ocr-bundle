# V172-Q389R5B OFFLINE DEPENDENCY ACQUISITION

Purpose: remove the manual blocker where the user does not already have PP-FormulaNet_plus-L inference files or paddle_lite_opt.

This phase adds a Windows PowerShell acquisition helper only. It does not bundle model bytes, does not add backend/ML Kit/text OCR fallback, and does not claim OCR PASS.

Flow:

1. Download the official Hugging Face model snapshot for `PaddlePaddle/PP-FormulaNet_plus-L` with Python `huggingface_hub`.
2. Validate that model/param/decoder/preprocess sidecars exist.
3. Locate `paddle_lite_opt` from a user path, PATH, optional pip `paddlelite`, or an explicitly supplied official Paddle-Lite asset URL.
4. Write `q389r5b_offline_prerequisites_report.json` containing the exact Q389R5A bundle factory command.

If paddle_lite_opt cannot be acquired automatically, the script fails with a precise report and retry command; it does not fake `.nb` conversion.
