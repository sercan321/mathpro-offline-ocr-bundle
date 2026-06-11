# V172-Q382R10 Workspace Context Menu Final Analyze/Test Expectation Repair Audit

Q382R10 repairs the remaining user-side analyzer/test expectation issues reported after Q382R9:

1. `test/v172_q277r1_camera_ocr_runtime_premium_regression_log_repair_test.dart` no longer uses `indexOf` to test for containment. It first computes `contains(...)` booleans, then uses `indexOf(...)` only after a marker is known to exist.
2. `test/v172_q239c_formula_crop_scan_frame_test.dart` now accepts the current review-first OCR copy (`OCR review akışı başlar` / pending review copy) rather than requiring the older `OCR sonraki fazda` marker.

Runtime behavior is unchanged. The repair is limited to legacy analyzer/test expectation hygiene. No Flutter analyze/test/run PASS is claimed by the package; the user must rerun logs.
