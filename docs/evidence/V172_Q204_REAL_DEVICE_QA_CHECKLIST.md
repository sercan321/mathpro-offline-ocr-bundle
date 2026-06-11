# V172-Q204 — Real Device QA Checklist

Use this checklist after extracting `MathProFlutterPhase17.zip` and running the commands in the project root.

## Terminal evidence

- `flutter clean`
- `flutter pub get`
- `node tool/verify_mathlive_real_device_evidence_intake_v172_q204.mjs`
- `node tool/verify_mathlive_final_static_production_freeze_v172_q203.mjs`
- `python tool/verify_mathpro_contract.py`
- `flutter analyze`
- `flutter test`
- `flutter run -d 23106RN0DA`

## Real-device scenarios

Record screenshots or video for the following:

- App launches to the MathLive production editor.
- Repeated key taps do not freeze or leave a stuck key image.
- Caret moves by tapping several different expression positions.
- Fraction, root, power, sigma, product, integral, limit, Taylor, and Maclaurin render as mathematical templates, not raw text.
- Open placeholders do not produce fake Graph/History/Solution results.
- C, backspace, Ans, equals, and enter remain responsive.

Do not mark PASS unless the actual terminal log and real-device evidence support it.
