# V172-Q156 Changed Files Manifest

## Modified

- `lib/features/keyboard/premium_popup_fit_policy.dart`
- `assets/mathlive/manifest.json`
- `README.md`

## Added

- `lib/features/mathlive/mathlive_popup_envelope_final_rebalance_policy.dart`
- `test/v172_q156_mathlive_popup_envelope_final_rebalance_test.dart`
- `tool/verify_mathlive_popup_envelope_final_rebalance_v172_q156.mjs`
- `docs/audit/V172_Q156_MATHLIVE_POPUP_ENVELOPE_FINAL_REBALANCE_AUDIT_REPORT.md`
- `docs/audit/V172_Q156_CHANGED_FILES_MANIFEST.md`

## Protected Surface Statement

Q156 intentionally avoids keyboard layout/source mutation. It does not modify `key_config.dart`, `math_keyboard.dart`, `bottom_dock.dart`, `long_press_popup.dart`, `premium_key.dart`, `math_label.dart`, `template_tray.dart`, `graph_card.dart`, `history_controller.dart`, `history_panel.dart`, or `solution_steps_panel.dart`.

The only keyboard-area file changed is the existing Q150 visual-fit policy file, and only two numeric popup envelope constants were rebalanced to restore legacy no-clip test thresholds.
