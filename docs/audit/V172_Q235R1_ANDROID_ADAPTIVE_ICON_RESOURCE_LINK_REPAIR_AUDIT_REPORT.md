# V172-Q235R1 Android Adaptive Icon Resource-Link Repair

## Trigger
User-side `flutter run` failed in `:app:processDebugResources` because adaptive icon XML referenced `@drawable-nodpi/ic_launcher_foreground`.

## Repair
- `android/app/src/main/res/mipmap-anydpi-v26/ic_launcher.xml`
- `android/app/src/main/res/mipmap-anydpi-v26/ic_launcher_round.xml`

now reference:

`@drawable/ic_launcher_foreground`

## Non-changes
- Splash artwork unchanged.
- Q235 `BoxFit.contain` unchanged.
- Keyboard, long-press, MORE, MathLive, Graph, Workspace, Solution, History, solver unchanged.

## PASS claims
No assistant-side Flutter analyze/test/run or Android real-device PASS is claimed.
