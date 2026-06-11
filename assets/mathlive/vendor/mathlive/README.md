# MathLive official runtime vendor slot

V172-Q90R1 prepares this directory as the local vendor slot for the official
MathLive npm runtime. The assistant environment did not have network access, so
this package does not contain `mathlive.min.js` and does not claim that the real
runtime is bundled.

On a developer machine, run:

```bash
node tool/install_mathlive_runtime.mjs
```

The installer copies the official npm package files into this directory and
writes `runtime_manifest.json`. Until those files are present and verified, the
main editor must remain on `legacyFlutterSlotEditor` and MathLive cursor PASS
must remain unclaimed.
