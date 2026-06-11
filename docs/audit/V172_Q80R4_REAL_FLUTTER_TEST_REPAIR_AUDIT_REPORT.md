# V172-Q80R4 Real Flutter Test Repair Audit Report

Scope: repair the three user-reported Flutter test failures after Q80R3 without changing protected UI/keyboard surfaces.

Repairs:
- Restored V172-B single-argument function typing contract: after filling `sin(□)` with `3`, active structural slot is cleared and the linear caret remains inside the argument at `sin(3|)`, enabling `sin(300)` without re-tapping or exiting outside parentheses.
- Preserved Q75 structural binding for filled structural payload slots such as fractions; only already-filled single function argument open-slot transition uses deterministic in-argument linear caret.
- Restored V172-G scoped backspace source marker `v172g-slotPayloadBackspace` while keeping the same slot-scoped backspace payload path.
- Updated the Q75 test/verifier contract so it no longer contradicts the older V172-B behavior.

Protected surfaces remain unchanged: keyboard, MORE, long-press, app shell, MathLabel, template tray, Solution, Graph, History.

Flutter/Dart were not available in the assistant container; user must rerun `flutter analyze` and `flutter test`.
