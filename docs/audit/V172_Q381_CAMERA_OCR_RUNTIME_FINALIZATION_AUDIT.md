# V172 Q381 — Camera OCR Runtime Finalization / Crop-Model-Vocab-Review Completion

Q381 closes the software-solvable gaps found after Q380 inspection:

- camera crop acceptance now passes rotation metadata and model source path into the OCR binding;
- native OCR bridge creates a real cropped OCR input image from the centered scan frame;
- rotation is applied before OCR preprocessing;
- model private-storage preflight remains enforced;
- vocabulary sidecar files next to the model source can be copied into app-private model storage;
- Q380 adaptive input + decoder path is reused after crop/model/vocab preflight;
- blocked reasons are mapped to user-facing review messages;
- direct OCR-to-workspace/Solve/Graph/Solution/History remains blocked.

No OCR PASS, Android PASS, store PASS, or release PASS is claimed by this package.
