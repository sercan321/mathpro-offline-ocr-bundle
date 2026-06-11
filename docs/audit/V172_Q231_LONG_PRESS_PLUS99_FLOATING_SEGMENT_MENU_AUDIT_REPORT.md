# V172-Q231 Long-Press +99 Floating Segment Menu Audit Report

## Scope
Q231 is a visual/geometry-only long-press popup phase. It does not add new keyboard options, reorder long-press entries, mutate key input behavior, or alter MORE, MathLive, Workspace, Graph, Solution, History, Splash, Android startup, or evaluator behavior.

## What changed
- `LongPressPopup` was redesigned from a large card-like popup into a compact dark-glass floating segment menu.
- Long-press options now sit inside one capsule surface with subtle segment dividers.
- A small pointer is rendered below the capsule.
- Placement uses source-key inference, centered anchoring, left/right edge clamp, and pointer clamp.
- Popup opens with a short fade/scale animation.
- Popup sizing constants were tightened for a compact premium envelope.

## What did not change
- Keyboard layout, key order, key sizes, tab order, MORE button, Ans/= / Enter / C / backspace.
- Long-press option inventory and order in `KeyConfig.longPressMap`.
- MathLive production editor/bridge.
- Workspace, Graph, Solution, History, AppShell, Android startup/splash.

## Honest boundary
Flutter/Dart and a real Android device were not available in the assistant environment, so no real `flutter analyze`, `flutter test`, `flutter run`, or +99 real-device PASS is claimed.
