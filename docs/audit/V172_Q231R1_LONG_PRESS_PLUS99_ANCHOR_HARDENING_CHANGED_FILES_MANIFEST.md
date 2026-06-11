# V172 Q231R1 Changed Files Manifest

## Runtime/source files
- `lib/features/keyboard/keyboard_long_press_anchor.dart`
- `lib/features/keyboard/premium_key.dart`
- `lib/features/keyboard/math_keyboard.dart`
- `lib/features/keyboard/bottom_dock.dart`
- `lib/features/keyboard/long_press_popup.dart`
- `lib/features/keyboard/long_press_plus99_anchor_hardening_policy.dart`
- `lib/features/graph/graph_card.dart`

## Test/verifier/audit files
- `test/v172_q231r1_long_press_plus99_anchor_hardening_test.dart`
- `tool/verify_long_press_plus99_anchor_hardening_v172_q231r1.mjs`
- `tool/verify_long_press_plus99_floating_segment_menu_v172_q231.mjs`
- `tool/verify_workspace_idle_vertical_expansion_v172_q229.mjs`
- `tool/verify_workspace_bottom_gap_optical_match_v172_q229r2.mjs`
- `tool/verify_workspace_card_slot_fill_phantom_gap_fix_v172_q229r4.mjs`
- `docs/audit/V172_Q231R1_LONG_PRESS_PLUS99_ANCHOR_HARDENING_AUDIT_REPORT.md`
- `docs/audit/V172_Q231R1_LONG_PRESS_PLUS99_ANCHOR_HARDENING_CHANGED_FILES_MANIFEST.md`

## Notes
The Q229/Q231 verifier updates are successor-hygiene updates only, so earlier verifiers do not fail after the explicitly requested Q231R1 anchor hardening touches `PremiumKey`, `MathKeyboard`, `BottomDock`, `LongPressPopup`, and the `graph_card.dart` import.
