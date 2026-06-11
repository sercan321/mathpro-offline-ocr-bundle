# V172-Q34 Deterministic Slot Geometry Registry Audit Report

## Verdict

CONDITIONAL PASS — Q34 adds a deterministic slot geometry registry and wires it into the existing cursor hit-test/caret path. It does not claim Photomath/Wolfram +95 final PASS and does not claim renderer/SVG per-slot identity.

## Scope

Q34 is P6-locked. It keeps keyboard, key faces, MORE tray, long-press popup, app shell, MathLabel, Solution, Graph, and History files byte-identical to the P6 reference package. The implementation is restricted to cursor/geometry source plus metadata/audit/verifier files.

## What changed

- Added `lib/features/formula_engine/deterministic_slot_geometry_registry.dart`.
- `RenderMappedSlotHitTest` now normalizes resolved slot rectangles through `DeterministicSlotGeometryRegistry.visualRectFor(...)`.
- `EditorCaretOverlay` now asks `DeterministicSlotGeometryRegistry.caretRectFor(...)` for active structural slot caret geometry.
- Package metadata advanced to `0.172.61+172` / `V172-Q34`.
- Static verifier now has a Q34 gate.

## Honest technical limit

`DeterministicSlotGeometryRegistry.rendererSlotIdentityClaimed = false` remains intentional. Q34 is deterministic role geometry, not true renderer/SVG per-slot identity. It reduces conflicting local geometry guesses, but real device proof is still required.

## P6 locked file check

| File | P6 vs Q34 | Q34 SHA256 prefix |
|---|---:|---|
| `lib/features/keyboard/key_config.dart` | SAME | `4ecd7270e29a27d7` |
| `lib/features/keyboard/math_keyboard.dart` | SAME | `f4f2a9acdc226cdc` |
| `lib/features/keyboard/bottom_dock.dart` | SAME | `f75e70c490827bae` |
| `lib/features/keyboard/long_press_popup.dart` | SAME | `d6b2c030bd3e8281` |
| `lib/features/keyboard/premium_key.dart` | SAME | `2d0941666300c4db` |
| `lib/features/workspace/math_label.dart` | SAME | `e7a185deabadfc05` |
| `lib/features/workspace/template_tray.dart` | SAME | `9310d7ae9b61334e` |
| `lib/app/app_shell.dart` | SAME | `df584bf0af59a640` |
| `lib/features/solution/solution_steps_panel.dart` | SAME | `cefded355d74046a` |
| `lib/features/graph/graph_card.dart` | SAME | `ea1010e17627c4f1` |
| `lib/features/history/history_controller.dart` | SAME | `331a6d84dbe4a940` |
| `lib/features/history/history_panel.dart` | SAME | `fad987605894ffaf` |

## Changed files versus P6

Total changed/added/removed files: 23.

See `docs/audit/V172_Q34_FILE_DIFF_VS_P6.csv` for the full diff.

## Required follow-up

Run on the user's machine:

```powershell
flutter pub get
flutter analyze
flutter test
flutter run -d 23106RN0DA
```

Then test cursor placement on `√□`, `x^□`, `x_□`, `log_□(□)`, `a/b`, and `cos(99666655)`.
