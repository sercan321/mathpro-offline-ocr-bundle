# V172-Q90R2 MathLive Lab Real Runtime Smoke Test Gate Audit Report

## Scope

Q90R2 adds a lab-only runtime smoke gate for the MathLive path. It does not switch the main editor, does not delete the legacy cursor stack, and does not claim a MathLive cursor PASS.

## Added / changed runtime boundaries

- `lib/features/mathlive/mathlive_runtime_smoke_policy.dart`
- `test/v172_q90r2_mathlive_lab_runtime_smoke_test.dart`
- `assets/mathlive/index.html`
- `assets/mathlive/mathlive_bridge.js`
- `assets/mathlive/manifest.json`
- `lib/features/mathlive/mathlive_lab_screen.dart`
- `lib/logic/mathpro_package_contract.dart`
- `pubspec.yaml`
- `README.md`
- `tool/verify_mathpro_contract.py`

## Guarded evidence requirements

The smoke gate requires the official local MathLive runtime installed by the Q90R1 intake path before the isolated lab may be considered ready for Q87 cursor court:

- local `assets/mathlive/vendor/mathlive/mathlive.min.js` must load;
- `<math-field>` custom element must be defined;
- a math-field instance must mount inside the isolated lab host;
- Q85 bridge must execute insert/delete/export smoke commands;
- Q86 state adapter must consume exported state;
- MathLive virtual keyboard must remain disabled;
- remote/CDN scripts remain forbidden;
- protected UI surfaces remain unchanged;
- main editor switch remains blocked.

## Honest limitations

The package does not include a real official MathLive runtime bundle unless the user runs `node tool/install_mathlive_runtime.mjs` or provides a valid local vendor drop with provenance. Q90R2 therefore adds a smoke gate and lab hooks; it does not claim MathLive cursor success.

## Protected surfaces

Protected keyboard, MORE, long-press, app shell, MathLabel, template tray, Solution, Graph, and History files are not part of this phase.
