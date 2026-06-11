# MathPro Core Editor Engine — Phase F Audit

## Scope

Phase F was delivered on top of the latest ZIP available in this execution environment: `MathProFlutterPhase17_CoreEditor_PhaseC_FULL.zip`.

Because Phase D/E ZIP artifacts were not present in the current filesystem when this turn started, the package first re-applies the Phase D/E contracts and then adds Phase F. This avoids regressing the priority hit-test and user-safe selection/caret layers.

## Implemented

### Phase D contract restored

- Added depth-aware `SlotEntry.depth`.
- Added `SlotPriorityPolicy`.
- Replaced pure priority sorting with combined score:
  - visual intent,
  - invisible hit containment,
  - role priority,
  - node depth,
  - distance penalty,
  - critical small-slot bonus.
- Kept 44x44 invisible hit targets from Phase C.

### Phase E contract restored

- Added `MathProSelectionState`.
- Added `MathProSelectionController`.
- Added `MathProCaretController`.
- `EditorSnapshot` now normalizes stale slot ids.
- Toolbar selection label remains user-safe: `Aktif alan`.
- Raw technical roles like `sqrtValue` and `integralBody` remain internal only.
- Active slot shows soft highlight plus thin blinking caret.

### Phase F added

- Added `MathViewportCoordinateTransform`.
- Added `MathViewportSlotHitTesting`.
- Added viewport → canvas inverse transform path for pan/zoom correctness.
- Added canvas → viewport rect transform helpers for renderer/hitbox synchronization.
- Updated interaction layer so it can explicitly handle either:
  - canvas-local coordinates, or
  - viewport-local coordinates transformed back to canvas.
- Refined `InteractiveViewer` suppression logic:
  - simple slot taps are not suppressed by interaction start alone,
  - suppression happens only after a real pan/zoom matrix delta.

## Frozen areas checked

Keyboard files were hash-compared against Phase C before packaging.

Result: no keyboard file changed.

Frozen product decisions preserved:

- `MORE` remains `MORE`.
- `Ans` remains directly visible.
- `↵` remains evaluation/enter behavior.
- `=` remains literal equality symbol.
- Tab names and keyboard source files were not modified.
- Long-press map files were not modified.

## User-facing debug policy

No user-facing debug label was added.

Still forbidden in UI:

- `Aktif slot:`
- raw `sqrtValue`
- raw `integralBody`
- raw `slotId`
- green debug rectangles

Internal slot role strings still exist in engine code and tests because the engine must identify slot roles internally. They are not displayed as UI labels.

## Tests added/extended

The widget/unit test file now includes assertions for:

- Phase D overlapping hit-target arbitration.
- Phase D deeper nested slot preference.
- Phase E user-safe selection label normalization.
- Phase E stale active slot cleanup.
- Phase E caret rect remaining inside the visual slot.
- Phase F viewport tap inverse transform after pan/zoom.
- Phase F transformed visual/hit rect round-trip synchronization.

## Commands not executed in this environment

Flutter SDK is not installed in this sandbox, so these were not run here:

```powershell
flutter pub get
flutter analyze
flutter test
flutter run -d 23106RN0DA
```

Run them locally before treating the package as device-verified.

## Outcome

Phase F is implemented as a code-level foundation for pan/zoom coordinate correctness. It is not a real-device PASS until manual Android testing confirms slot selection after pan/zoom.
