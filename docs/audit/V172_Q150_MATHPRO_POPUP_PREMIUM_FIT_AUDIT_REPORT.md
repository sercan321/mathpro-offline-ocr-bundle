# V172-Q150 MathPro Popup Premium Fit Audit

Q150 is a visual-fit repair for the MathPro long-press popup and MORE template tray. It targets the real-device screenshot issue where popup cards appeared oversized, clipped at the side, and visually inconsistent with the premium MathLive editor repair line.

## Scope

- Add `PremiumPopupFitPolicy` as a visual-fit-only contract.
- Reduce long-press panel/chip sizing, horizontal gap, and visual font scale through policy-driven constants.
- Reduce MORE tray chip/category/header sizing and clamp chip widths for phone-sized surfaces.
- Preserve keyboard row order, tab names, MORE, Ans, `↵`, `=`, long-press option order, and template semantics.
- Do not claim Flutter analyze/test/run, real-device visual PASS, cursor PASS, or Photomath-level PASS.

## Protected Contract

Q150 intentionally avoids changing `key_config.dart`, `math_keyboard.dart`, `bottom_dock.dart`, and `premium_key.dart`. It makes visual-only popup/tray fit changes to `long_press_popup.dart` and `template_tray.dart`; these changes do not alter option inventory, order, selection labels, or MathLive template mappings.

## Evidence Status

Package-side static checks can verify the visual-fit contract and source wiring. Real-device screenshots are still required before any premium visual PASS claim.
