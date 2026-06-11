# MathPro Flutter Phase 2 — Static Verification

## Verification summary

Static verification was performed against the React Native reference ZIP and the Phase 1 Flutter package.

## Verified unchanged product decisions

- Tab labels remain: `Temel`, `Cebir`, `Kalkülüs`, `Kompleks`, `Lineer Cebir`.
- Basic core keyboard remains:
  - `C ⌫ % ÷`
  - `7 8 9 ×`
  - `4 5 6 −`
  - `1 2 3 +`
  - `MORE 0 . Ans`
- Expanded fixed bottom row remains: `MORE 0 . = ↵`.
- `Cebir` still uses special fixed row `C ⌫ % frac ^` as in the React Native config.
- Long-press maps remain present for `^`, `√`, `!`, `sin()`, `cos()`, `tan()`, `ln(□)`, `∫`, `d/dx`, `lim`, complex keys, and linear algebra keys.

## Zip hygiene

Excluded from final package:

- `build/`
- `.dart_tool/`
- `.pytest_cache/`
- `__pycache__/`
- `.pyc`
- temporary editor files

## Build status

No Flutter SDK execution was available. Build/runtime status must be checked locally.

## Local static source check executed here

A Python-only static source check was executed because Flutter/Dart SDK was unavailable.

Checks performed:

- required project files exist
- no `mathpro_flutter_phase1` package imports remain
- locked tab labels exist in `key_config.dart`
- locked basic keyboard rows exist in `key_config.dart`
- required long-press map anchors exist
- no forbidden cache/build/temp files exist in source tree
- no nested `Positioned` misuse remains around the long-press indicator

Result: all static source checks passed.

This is not a substitute for `flutter analyze` or device testing.

## Frozen keyboard row source anchors checked

- `basic_1`: `['C', '⌫', '%', '÷']`
- `basic_2`: `['7', '8', '9', '×']`
- `basic_3`: `['4', '5', '6', '−']`
- `basic_4`: `['1', '2', '3', '+']`
- `basic_5`: `['MORE', '0', '.', 'Ans']`
- `fixed_1`: `['C', '⌫', '%', '÷', 'frac']`
- `fixed_2`: `['7', '8', '9', '×', '√']`
- `fixed_3`: `['4', '5', '6', '−', '!']`
- `fixed_4`: `['1', '2', '3', '+', '| |']`
- `fixed_5`: `['MORE', '0', '.', '=', '↵']`
- `cebir_1`: `['x', 'y', 'z', '∫', 'd/dx']`
- `cebir_2`: `['lim', 'Σ', 'Π', 'ln(□)', 'e']`
- `cebir_3`: `['sin()', 'cos()', 'tan()', '()', 'π']`
- `cebir_fixed_1_override`: `['C', '⌫', '%', 'frac', '^']`
- `kalk_1`: `['x', 'y', 't', null, null]`
- `kalk_2`: `['dy/dx', null, null, null, '∞']`
- `kalk_3_head`: `['∂/∂x', 'dx']`
- `komp_1`: `['z', 'i', 'π', 'θ', 'e']`
- `komp_2`: `['Re()', 'Im()', 'arg()', 'conj()', 'cis()']`
- `komp_3_head`: `['|z|', 'z̄']`
- `lin_1`: `['A', 'B', 'b', 'x', 'λ']`
- `lin_2`: `['matrix', 'vector', 'ᵀ', '·', '‖ ‖']`
- `lin_3_head`: `['I', 'A⁻¹']`

Result: all frozen keyboard row anchors were found in `key_config.dart`.
