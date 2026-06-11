# V172-Q216 GAUSS Splash Compile Hygiene Repair Audit

## Scope
- Repair user-side Flutter analyze/test blockers in the splash compile path only.
- Preserve the Q215 no-black startup first-frame gate intent.
- Do not redraw, regenerate, or mutate the supplied splash artwork.

## Trigger
User-side logs showed:
- `Future.any` constructor not found in `lib/app/gauss_splash_screen.dart`.
- `runApp` undefined in `lib/main.dart`.

## Changes
- Replaced `Future<void>.any(...)` with `precacheImage(...).timeout(...).catchError(...)`.
- Restored `import 'package:flutter/material.dart';` in `lib/main.dart`.
- Added Q216 policy, test, verifier, manifest envelope, and audit documentation.

## Protected scope
Launcher icon, keyboard, MORE, long-press, Graph runtime behavior, History, Solution, MathLive production editor/bridge, routing, and business logic were not changed.

## Claims
No Flutter analyze/test/run or Android real-device PASS is claimed by the assistant environment.
