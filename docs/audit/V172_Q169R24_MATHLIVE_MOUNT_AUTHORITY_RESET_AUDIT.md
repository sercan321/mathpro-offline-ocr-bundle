# V172-Q169R24 MathLive Mount Authority Reset Audit

Q169R24 was created from Q169R23 after real-device evidence showed `Q169 KEY:5 SEND:Flutter JS:pending MF:false`, proving that the old Flutter key diagnostic/fallback path could still own the visible surface before MathLive mount authority was established.

Implemented changes:
- MathLive mount/readiness diagnostic is the initial visible authority.
- The runtime controller no longer requires MF:true before attempting command dispatch; it can enter the surface and force mount/court first.
- `sendMathProKey()` now forces mount/court before bridge dispatch when MF is not authoritative.
- Old visible Flutter fallback overlay is blocked while the court/mount authority overlay is locked.
- Old `Q169 KEY` diagnostic no longer overwrites the mount authority overlay while locked.

No protected keyboard/MORE/long-press/AppShell/Graph/History/Solution files were changed.
