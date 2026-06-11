# V172-Q313R1 — Flutter Log Repair: Q295 Path Escape / Q152 Successor-Aware Test

Q313R1 is a surgical user-log repair phase created after user-side `flutter analyze` and `flutter test` exposed two real blockers:

1. `lib/features/camera/gauss_first_real_image_to_latex_inference.dart` contained malformed Windows backslash path literals in Q295 request-envelope getters.
2. `test/v172_q152_mathlive_final_premium_package_freeze_test.dart` still expected Q152 to remain the active/current manifest phase, even though later Q313 lineage is the current package truth.

This phase repairs only those log blockers and analyzer hygiene reported by the user. It does **not** add Paddle/PaddleOCR, does **not** bind MethodChannel/JNI/native runtime, does **not** download or bundle a model, does **not** run OCR, does **not** open MathLive review, does **not** import workspace, and does **not** claim Flutter/Android/OCR/store/release PASS.

Protected runtime/UI surfaces remain unchanged.
