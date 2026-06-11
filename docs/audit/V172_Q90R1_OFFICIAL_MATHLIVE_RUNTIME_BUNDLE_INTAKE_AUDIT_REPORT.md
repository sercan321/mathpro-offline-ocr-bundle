# V172-Q90R1 Official MathLive Runtime Bundle Intake Guard Audit Report

## Scope

Q90R1 prepares the official MathLive runtime intake gate. It does not fake a
bundled runtime and does not switch the main editor.

## Implemented

- Added `MathLiveRuntimeBundlePolicy`.
- Added `tool/install_mathlive_runtime.mjs` for developer-side npm intake.
- Added local vendor slot `assets/mathlive/vendor/mathlive/`.
- Extended `assets/mathlive/manifest.json` with Q90R1 provenance fields.
- Extended the lab bridge state with Q90R1 runtime-bundle markers.

## Explicit non-claims

- The official MathLive runtime is not bundled by this assistant package.
- No MathLive cursor PASS is claimed.
- No main-editor MathLive switch is performed.
- MathLive virtual keyboard remains disabled.
- Remote/CDN script loading remains forbidden.
- Protected keyboard/UI/Graph/History/Solution files remain locked.

## Required developer action before runtime proof

Run `node tool/install_mathlive_runtime.mjs` on a machine with npm/network access,
then run Flutter analyze/test/run and the MathLive Lab real-device cursor court.
