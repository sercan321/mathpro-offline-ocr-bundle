# V172-Q91 MathLive Runtime Evidence Closure Audit Report

## Scope

Q91 is a surgical evidence/contract phase. It does not make MathLive the main editor, does not mount MathLive inside the main workspace, does not delete legacy cursor files, and does not modify the protected keyboard, MORE, long-press, AppShell, Graph, History, or Solution surfaces.

## Why this phase exists

The user reported that the isolated MathLive Lab works on the real device. That report is strategically important, but it is not by itself a package-level proof artifact. Q91 records this as an input to the evidence chain and hardens the rule that official runtime verification plus canonical Lab smoke evidence must both exist before Q92 adapter hardening may begin.

## Closure rule

Q91 requires both of the following before the next integration phase can be treated as ready:

1. `node tool/verify_mathlive_runtime.mjs` must verify the official local MathLive runtime bundle.
2. `node tool/verify_mathlive_lab_smoke_evidence.mjs` must verify `docs/evidence/V172_Q90R5_MATHLIVE_LAB_RUNTIME_SMOKE_EVIDENCE.json`.

A user report, screenshot, or successful manual Lab launch may be recorded, but cannot replace those package evidence files.

## No fake PASS

No fake PASS was introduced. The package still blocks Q87 cursor court, MathLive main-editor switch, and physical legacy cursor deletion unless verified runtime/evidence gates exist.

## Protected surfaces

Protected files intentionally untouched:

- `lib/features/keyboard/key_config.dart`
- `lib/features/keyboard/math_keyboard.dart`
- `lib/features/keyboard/bottom_dock.dart`
- `lib/features/keyboard/long_press_popup.dart`
- `lib/features/keyboard/premium_key.dart`
- `lib/features/workspace/math_label.dart`
- `lib/features/workspace/template_tray.dart`
- `lib/app/app_shell.dart`
- `lib/features/solution/solution_steps_panel.dart`
- `lib/features/graph/graph_card.dart`
- `lib/features/history/history_controller.dart`
- `lib/features/history/history_panel.dart`

## Explicit non-goals

- No main editor switch.
- No MathLive main workspace mount.
- No Graph/History/Solution adapter implementation yet.
- No legacy cursor physical deletion.
- No cursor quality PASS claim.
- No Photomath/Wolfram level claim.
- No remote/CDN script allowance.
- No MathLive virtual keyboard enablement.


## Current package evidence status from local static run

- `python3 tool/verify_mathpro_contract.py`: PASS for static contract gates, including Q90R9 and Q91.
- `node tool/verify_mathlive_runtime.mjs`: BLOCKED because official `assets/mathlive/vendor/mathlive/` runtime files are not present in this zip.
- `node tool/verify_mathlive_lab_smoke_evidence.mjs`: BLOCKED because `docs/evidence/V172_Q90R5_MATHLIVE_LAB_RUNTIME_SMOKE_EVIDENCE.json` is not present.
- `node tool/write_mathlive_lab_smoke_evidence.mjs`: BLOCKED because `tool/mathlive_lab_runtime_smoke_capture.json` and verified runtime evidence are not present.

These BLOCKED results are intentional truth gates, not failures hidden as success.

## Next phase

After Q91 evidence closure is actually verified, the next planned phase is Q92: MathLive Graph / History / Solution Adapter Hardening.
