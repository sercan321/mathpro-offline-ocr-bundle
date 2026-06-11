# V172-Q51 Structural Placeholder Restoration Repair Audit Report

## Outcome

CONDITIONAL PASS — Q51 repairs the structural placeholder restoration defect shown by real-device screenshots: half templates such as `9⁄`, `9/`, `sin()`, `√()`, and `∫(□)d` must not remain as final editor expressions after deletion. Q51 does not claim final `|□` caret leading-rail optical alignment, Flutter analyze/test PASS, real-device PASS, or Photomath/Wolfram +95 PASS from the assistant environment.

## Active package identity

```yaml
description: MathPro Flutter phase 17 - V172-Q51 structural placeholder restoration repair.
version: 0.172.81+172
```

## Scope

Q51 touched only structural editor, formula-engine policy, parser/serializer, controller backspace restoration, test/verifier, metadata, and audit files.

Protected visual/UI surfaces remain out of scope:

- keyboard layout and key config
- key faces / premium key rendering
- MORE tray
- long-press popup
- app shell
- MathLabel
- template tray
- Solution panel
- Graph
- History

## Runtime changes

- Added `StructuralPlaceholderRestorationPolicy` as the central post-edit restoration law.
- Added `EditorCommands.restoreStructuralPlaceholders` wrapper so restoration is reachable from editor command paths.
- Wired restoration into selected-slot insert/backspace/clear serialization paths.
- Wired restoration into linear backspace fallback so raw deletion cannot leave `sin()`, `9⁄`, `√()`, or `d` differential remnants when the result is structurally restorable.
- Updated `NodeFactory._slotNodeFromToken` so an empty token becomes a real placeholder node instead of an empty box.
- Updated plain serialization for empty function/root/integral/log slots so empty boxes serialize back to `□`.

## Explicit non-claims

- Q51 does not implement final `|□` leading-rail caret polish. That remains Q52.
- Q51 does not claim full native math renderer.
- Q51 does not claim stable AST slot → SVG node identity.
- Q51 does not claim Flutter analyze/test PASS from the assistant environment.
- Q51 does not claim real-device +95 PASS.

## Static verifier

`python3 tool/verify_mathpro_contract.py` completed without hard failures in the assistant environment.

## Required user-side validation

```powershell
flutter pub get
flutter analyze
flutter test
flutter run -d 23106RN0DA
```

Then manually verify:

- `9⁄6` → delete denominator → `9⁄□`
- `9⁄6` → delete numerator → `□⁄6`
- `sin(300)` → delete argument → `sin(□)`
- `ln(123)` → delete argument → `ln(□)`
- `√(8)` → delete radicand → `√(□)` or equivalent restored placeholder rendering
- integral differential deletion does not leave bare `d`
