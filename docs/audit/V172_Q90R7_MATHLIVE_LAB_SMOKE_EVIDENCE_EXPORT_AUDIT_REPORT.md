# V172-Q90R7 MathLive Lab Smoke Evidence Export Guard Audit Report

## Scope

Q90R7 adds a Lab-only copy/export guard for MathLive runtime smoke evidence capture. It does not mount MathLive in the main workspace and does not alter keyboard, MORE, long-press, Graph, History, Solution, app shell, or protected UI surfaces.

## Runtime Decision

The isolated Lab may expose the generated Q90R5/Q90R6 capture JSON for manual copy. The app must not directly write `tool/mathlive_lab_runtime_smoke_capture.json`; the user still pastes the capture and runs the Q90R6 writer plus Q90R5 verifier.

## Red Lines

- Main editor remains legacy/default.
- Legacy cursor files remain fallback/rollback and are not deleted.
- MathLive virtual keyboard remains disabled.
- Remote/CDN scripts remain forbidden.
- No cursor PASS, Photomath, or Wolfram claim is made.
