# V172-Q214 GAUSS Splash Android Resource-Link Repair Audit

## Trigger

User-side `flutter run` failed during `:app:processDebugResources` with Android resource linking error:

`style attribute 'android:attr/postSplashScreenTheme' not found`

## Repair

Removed the unavailable framework-scoped style item from:

`android/app/src/main/res/values-v31/styles.xml`

Q212 GAUSS splash artwork remains wired through the native launch background and Flutter branded splash handoff. Q211 launcher icon remains unchanged.

## Non-goals

- No launcher icon change.
- No splash artwork redraw/regeneration.
- No keyboard/MORE/long-press change.
- No Graph runtime behavior change.
- No History/Solution change.
- No MathLive production runtime change.
- No Flutter/Android PASS claim without user-side logs.
