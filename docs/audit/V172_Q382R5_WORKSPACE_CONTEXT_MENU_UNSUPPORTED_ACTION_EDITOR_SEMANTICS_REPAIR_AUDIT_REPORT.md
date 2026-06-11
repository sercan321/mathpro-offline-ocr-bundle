# V172-Q382R5 Workspace Context Menu Unsupported Action / Editor Semantics Repair Audit

## Scope
Q382R5 is a surgical repair on top of Q382R4. It does not add a new solver, graph engine, OCR runtime, keyboard layout, MathLive production bridge, or history feature. It closes correctness risks found in the Q382 workspace expression context menu shell.

## Repairs
- Actions that require an unproven solver handler are disabled before selection.
- Unsupported math intents can no longer be selected as if a real handler exists.
- If unsupported selected-action metadata is ever routed into Solution, stale generic calculator result text is suppressed with `—` and a limitation path.
- Editor menu labels now describe actual whole-expression behavior: `Tümünü Değiştir`, `Tümünü Kes`, and `Tümünü Hedefle`.
- `Tümünü Hedefle` now paints a visible target chip instead of being invisible state only.
- The menu no longer truncates semantic actions with `take(7)`; internal scrolling owns overflow.
- MathLive context-menu sync result is checked, and a safe message is shown if controller sync is pending.
- Safe-area max-height logic now uses actual available safe height while keeping Q382R1 compatibility markers.

## Preserved Red Lines
- Keyboard layout, key order, MORE/template tray, bottom dock, premium keys, and long-press inventories unchanged.
- MathLive production HTML/JS assets unchanged.
- Q381R1 camera/OCR native bridge and review-first import safety unchanged.
- Graph, History, splash/icon, solver/evaluator, Gradle, pubspec, and AndroidManifest unchanged.

## Evidence Limits
Assistant environment has no Flutter/Dart/Android SDK. No `flutter analyze`, `flutter test`, `flutter run`, real-device context-menu PASS, or OCR PASS is claimed.
