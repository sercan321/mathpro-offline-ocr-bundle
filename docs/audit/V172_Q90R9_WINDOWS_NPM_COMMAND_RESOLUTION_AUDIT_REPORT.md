# V172-Q90R9 Windows NPM Command Resolution Repair

Q90R9 repairs the developer-side MathLive runtime installer so Windows uses
`npm.cmd` before falling back to `npm`. If npm is unavailable, the installer now
emits `BLOCKED_NPM_NOT_FOUND` with manual vendor-drop guidance instead of a raw
spawnSync ENOENT stack.

Protected keyboard, app shell, Graph, History, Solution and legacy cursor runtime
surfaces are intentionally unchanged.
