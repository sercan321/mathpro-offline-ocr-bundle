# V172-Q382R25 Changed Files

## Added

- `lib/debug/latency/mathpro_all_key_latency_court_q382r25_policy.dart`
- `lib/debug/latency/mathpro_all_key_latency_court_q382r25.dart`
- `tool/verify_all_key_latency_court_v172_q382r25.mjs`
- `docs/audit/V172_Q382R25_ALL_KEY_LATENCY_COURT_AND_INVENTORY.md`
- `docs/audit/V172_Q382R25_CHANGED_FILES.md`

## Modified

- `lib/app/app_shell.dart`
  - Adds debug-only court scheduling through an `assert` block.
  - Uses the existing MathLive key path for direct bridge court dispatch.

- `lib/debug/latency/mathpro_latency_probe_q382r23.dart`
  - Keeps the Q382R23 probe default-off, but enables it when the explicit
    `MATHPRO_LATENCY_COURT=true` dart-define is present.

- `lib/debug/latency/mathpro_latency_overlay_q382r23.dart`
  - Keeps the overlay default-off, but allows it during the explicit court run.

## Not Modified

- `lib/features/keyboard/key_config.dart`
- `lib/features/keyboard/math_keyboard.dart`
- `lib/features/keyboard/bottom_dock.dart`
- `lib/features/keyboard/premium_key.dart`
- `lib/features/workspace/template_tray.dart`
- `assets/mathlive/mathlive_prod_bridge.js`
- `android/`
- Graph/Solution/History/OCR sources
