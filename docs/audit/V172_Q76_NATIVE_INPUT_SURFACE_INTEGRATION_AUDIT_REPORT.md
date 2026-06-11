# V172-Q76 Native Input Surface Integration Audit Report

## Scope

Q76 is a cursor/editor-only integration phase. It connects the Q71-Q75 native SlotBox pieces through one runtime frame for the editor input surface.

## What Q76 changes

Before Q76, `EditorInteractionLayer` independently assembled slot rects, bundle geometry, hit-test inputs, overlay rects, and fallback suppression inputs. That was better than the old nearest-fallback path, but the architecture still allowed drift because several local variables represented the same conceptual surface.

Q76 introduces:

```dart
NativeSlotBoxInputSurfaceIntegrationPolicy.buildFrame(...)
NativeSlotBoxInputSurfaceFrame
```

The frame owns:

- `mappedVisualRects`
- `geometryBundles`
- `authorityVisualRects`
- native structural `hitTest(...)`
- legacy placeholder fallback permission
- detached linear fallback blocking

`EditorInteractionLayer` now uses that frame for pointer handling and overlay geometry.

## Why this matters for the cursor goal

The user-facing goal is deterministic cursor placement: no guessed nearest slot, no random detached linear caret, and no separate geometry paths for what the user sees, taps, and edits.

Q76 does not solve every real-device cursor defect by itself. Its value is architectural: it makes the editor input surface consume one SlotBox geometry authority instead of reassembling related geometry in separate branches.

## Protected surface status

No keyboard, MORE tray, long-press popup, app shell, MathLabel, template tray, Solution, Graph, or History runtime file was edited in this phase.

## Verification performed in assistant environment

- ZIP source fresh-extracted before work.
- Protected file hashes were captured before and after.
- `python3 tool/verify_mathpro_contract.py .` completed without hard failures after Q76 changes.
- Package hygiene was checked for forbidden build/cache/binary artifacts.

## Not performed

The assistant environment does not have Flutter/Dart installed. Therefore Q76 does not include assistant-side evidence for:

```powershell
flutter pub get
flutter analyze
flutter test
flutter run -d 23106RN0DA
```

These must still be run by the user before accepting any Flutter/device PASS claim.
