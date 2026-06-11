# V172-Q71 Native SlotBox Input Surface Foundation Audit Report

## Scope

Q71 is a cursor/editor-only phase. It does not change keyboard layout, key order, MORE, Ans, ↵, =, long-press popup/order, app shell, MathLabel, template tray, Solution, Graph, or History.

## Runtime change

- Added `NativeSlotBoxInputSurfacePolicy` as the Q71 cursor law source.
- Structural slot selection now requires the authoritative SlotGeometryBundle / SlotBox hit rect.
- Removed nearest-distance slot inference from `SlotHitTesting.hitTest`.
- Disabled structural nearest-bundle inference in `StructuralIntentResolverPolicy`.
- Set broad template-region inflation to `0.0` so template suppression follows measured geometry rather than a guessed envelope.
- Blocked legacy linear placeholder fallback in `EditorInteractionLayer` whenever real geometry bundles exist.

## Product law

- No nearest structural guessing.
- No X-order linear placeholder guessing while SlotGeometryBundle geometry exists.
- Empty structural slot caret remains exclusive `|□`.
- Full native renderer / true AST-to-SVG node identity is not claimed.
- Real-device +95 PASS is not claimed.

## Verification

- `python3 tool/verify_mathpro_contract.py .` completed without hard failures.
- Protected UI/keyboard files were compared against the uploaded baseline and remained byte-for-byte identical.
- Flutter/Dart are not available in the assistant container, so `flutter analyze`, `flutter test`, and `flutter run` were not executed here.
