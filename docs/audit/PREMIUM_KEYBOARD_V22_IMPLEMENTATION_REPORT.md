# PREMIUM KEYBOARD V22 — Implementation Report

## Scope
V22 is a premium keyboard hardening phase. It does not redesign the keyboard layout again. It locks the V19–V21 keyboard decisions with deterministic widget keys, semantics labels, and a static/widget-test contract that should catch future accidental drift.

## What changed

### 1. Premium key contract hardening
`PremiumKey` now exposes deterministic widget keys for every visible key using the `mathpro-premium-key-*` prefix. This gives future tests a stable selector that does not depend only on rendered text.

It also exposes semantic labels for critical template keys:
- `□/□` → kesir şablonu
- `√□` → karekök şablonu
- `□^□` → üs şablonu
- `{□=□` → denklem sistemi şablonu
- `[□ □]` → matris şablonu
- `[□]` → vektör şablonu
- `□!` → faktöriyel
- `↵` → hesapla
- `⌫` → sil

### 2. Long-press popup hardening
Long-press options now expose deterministic widget keys using the `mathpro-long-press-option-*` prefix and semantic button labels. This makes the long-press surface easier to test and safer for accessibility without changing the selected options or the keyboard distribution.

### 3. MORE panel hardening
MORE categories and template chips now expose stable keys:
- `mathpro-more-category-*`
- `mathpro-more-chip-*`

The visual category/chip behavior remains the same; this is a testability/accessibility hardening change.

### 4. Keyboard layout version bump
`keyboardLayoutVersion` was bumped to `v36-premium-keyboard-contract-locked` to mark the contract-hardening state.

### 5. Regression test lock
Added `test/premium_keyboard_v22_contract_test.dart` with checks for:
- every tab preserving the fixed 8×5 grid,
- the fixed bottom core staying present,
- visible surfaces staying symbolic/Turkish rather than raw English labels like `system`, `matrix`, `vector`, `mod`, `gcd`, `lcm`, `prime?`,
- critical visible keys remaining structural/template-like,
- MORE panel retaining Turkish labels (`Kalan`, `EBOB`, `EKOK`, `Asal mı?`, etc.),
- variants such as `x²`, `≤`, `y′`, `∫ₐᵇ` staying behind long-press rather than drifting into visible surfaces.

## Files intentionally not changed
- Graph runtime
- History runtime
- Solver/runtime math engine
- Android project files
- Keyboard key distribution from V21

## Test honesty
This environment does not have Flutter/Dart installed. Therefore no real local `flutter analyze`, `flutter test`, or `flutter run` pass is claimed. Static file checks, package hygiene checks, and ZIP integrity checks were performed here. The user must run Flutter commands locally.
