# PREMIUM_KEYBOARD_V40_GLYPH_AFFORDANCE — Implementation Report

## Purpose

This package repairs the device-visible keyboard quality issue reported after V30/V39: integral/summation/structural keys still looked too text-like and users could not clearly tell which keys supported long-press alternatives.

## Applied changes

1. Replaced weak text-like renderings with compact structural glyph renderers for:
   - `∫□dx`
   - `Σ`
   - `d/dx`
   - `√□`
   - `□!`
   - `|□|`
   - `lim`

2. Kept hidden compatibility text for test/widget finders on custom-rendered labels where needed.

3. Rebuilt long-press indicator as a visible premium corner badge:
   - small rounded capsule,
   - accent-tinted border/background,
   - two brighter dots,
   - shown only through the existing `hasLongPress` path.

4. Expanded the indicator surface rule so every key that truly has long-press options gets a visible affordance.

5. Updated `keyboardLayoutVersion` and `pubspec.yaml` version to V40.

## Explicit non-goals

- No new solver behavior.
- No graph/history changes.
- No keyboard tab reordering.
- No key-position changes.
- No long-press option contract changes.

## Expected device result

- Long-press-capable keys should now be easier to identify at a glance.
- Integral/root/factorial/absolute-value structural keys should look less like raw text and more like premium math input controls.
- Existing test contracts for labels are preserved through hidden text compatibility.

## Flutter execution status

Flutter/Dart is not installed in this container, so no local `flutter analyze`, `flutter test`, or `flutter run` PASS is claimed. User-side validation is required.
