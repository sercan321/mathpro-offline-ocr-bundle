# V172-Q90R3 — Windows MathLive Runtime Installer Path Repair Audit Report

## Scope
This repair is limited to `tool/install_mathlive_runtime.mjs` and the audit manifest. It does not switch the main editor to MathLive, does not delete the legacy cursor engine, and does not modify protected UI/keyboard/Graph/History/Solution surfaces.

## Real bug repaired
The developer-side Node installer used `new URL('..', import.meta.url).pathname` to derive the project root. On Windows this can produce a pathname such as `/C:/Users/...`; resolving that path can become `C:\C:\Users\...`, which caused `mkdir` to fail before npm installation.

## Repair
The installer now derives paths via:

```js
const scriptDir = dirname(fileURLToPath(import.meta.url));
const projectRoot = resolve(scriptDir, '..');
```

This is the Node-supported way to convert a file URL to a local filesystem path across Windows and POSIX environments.

## Claims explicitly not made
- No official MathLive runtime bundle is claimed inside this package.
- No MathLive cursor PASS is claimed.
- No main-editor MathLive switch is claimed.
- No Photomath/Wolfram-level claim is made.
- Legacy cursor engine remains fallback/default until later evidence gates pass.

## Verification performed in this environment
- `node --check tool/install_mathlive_runtime.mjs` passed.
- ZIP integrity check passed after packaging.
- `tool/verify_mathpro_contract.py` passed after fresh extract.
