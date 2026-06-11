# V172 Q231R1 Long-Press +99 Anchor Hardening Audit Report

## Scope
Q231R1 hardens the Q231 floating segment menu without changing long-press option inventories, option order, keyboard layout, MORE content, MathLive behavior, workspace layout, graph behavior, solution behavior, history behavior, or solver/evaluator logic.

## Root Issues Addressed
1. Q231 inferred the popup anchor from `KeyConfig` row ratios; Q231R1 measures the actual pressed key geometry at runtime.
2. Pointer alignment now uses actual key-center x when available, with the old row-ratio method retained only as fallback.
3. Multi-option horizontal overflow now receives a premium fade-edge / rail affordance so clipped partial chips are visually suppressed rather than appearing as broken fragments.
4. `onDismissed` is now wired inside `LongPressPopup` through a translucent outside-tap layer in the popup strip.
5. Hidden MathLabel identity anchors are now zero-sized so they remain available for compatibility without inflating visible chip layout.
6. `graph_card.dart` no longer imports `graph_painter.dart` directly; it imports `graph_curve_painter.dart`, which exports `GraphExpressionEvaluator`, preserving behavior while removing the direct import complaint.

## Changed Runtime Files
- `lib/features/keyboard/keyboard_long_press_anchor.dart`
- `lib/features/keyboard/premium_key.dart`
- `lib/features/keyboard/math_keyboard.dart`
- `lib/features/keyboard/bottom_dock.dart`
- `lib/features/keyboard/long_press_popup.dart`
- `lib/features/keyboard/long_press_plus99_anchor_hardening_policy.dart`
- `lib/features/graph/graph_card.dart`

## Preserved Contracts
- Keyboard layout/order/size unchanged.
- Long-press source map and ordering unchanged.
- MORE/template tray unchanged.
- MathLive production editor and bridge unchanged.
- Workspace, Graph behavior, Solution, History, AppShell, Android startup/splash unchanged.
- Real-device +99 PASS not claimed without screenshots.

## Verification
Static verifier: `node tool/verify_long_press_plus99_anchor_hardening_v172_q231r1.mjs`
Expected status: `LONG_PRESS_PLUS99_ANCHOR_HARDENING_Q231R1_STATIC_READY_BUT_FLUTTER_ANALYZE_TEST_AND_ANDROID_LONG_PRESS_SCREENSHOT_QA_REQUIRED`

Flutter/Dart/Android runtime results must be supplied from a real Flutter environment.
