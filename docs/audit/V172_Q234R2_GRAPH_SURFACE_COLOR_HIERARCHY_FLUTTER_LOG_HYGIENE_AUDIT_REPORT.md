# V172-Q234R2 Graph Surface Color Hierarchy Flutter Log Hygiene Audit

Q234R2 responds to the user-side Flutter log after Q234R1. It is not a new graph rendering phase and does not rewrite the Q234 surface renderer.

User-side blockers addressed:
- `flutter analyze` reported 13 info-level issues.
- `flutter test` failed Q156 because the old test expected the pre-Q231 bounded integral envelope threshold of 104 while the active Q231 compact popup successor uses 98 and requires >=96.
- `flutter test` failed Q210 because the old test still expected stale 3D color clamp source markers instead of Q234 surface-first markers.
- `flutter test` failed Q225 because the old test still expected the pre-Q234 Turkish unavailable text marker.
- `flutter test` failed Q222 because the Q234 function color picker made Apply scroll below the small widget-test viewport.

Surgical changes:
- Updated stale Flutter tests to accept Q234/Q231 successors.
- Updated Q210 verifier to accept Q234 surface-first successor markers.
- Compacted GraphSettingsSheet vertical rhythm and made Q222 test scroll to Apply.
- Applied analyzer-only const/null-aware cleanup in graph color hierarchy, Q234 tests, and LongPressPopup.

Protected-area note:
`lib/features/keyboard/long_press_popup.dart` changed only for analyzer hygiene: const edge inset, null-aware anchorCenterX expression, and const divider construction. No long-press inventory, order, popup geometry policy constants, selection behavior, keyboard layout, or input logic was changed.

No fake PASS:
Assistant environment still cannot run Flutter/Dart, so real `flutter analyze`, `flutter test`, `flutter run`, and Android screenshots must be produced by the user.
