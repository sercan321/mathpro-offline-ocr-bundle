# V172-Q169R29 Analyzer/Test Contract Repair Audit

Q169R29 repairs the exact user-side Q169R28 evidence:

- `flutter analyze` reported five info diagnostics in `mathlive_main_editor_surface.dart`.
- `flutter test` failed in `test/v172_q169r24_r27_mathlive_authority_chain_test.dart` because the native paint policy did not expose the explicit `realDevicePaintPassClaimed = false` marker required by that test.

This phase is intentionally narrow. It does not change keyboard layout, MORE, long-press order, BottomDock, AppShell, Graph UI, History UI, Solution UI, solver behavior, MathLive command semantics, native insert semantics, or native paint success conditions. It does not claim assistant-side Flutter analyze/test/run PASS and does not claim Android PAINT:ok.

## Repairs

- `_q169SingleCommandBusLocked` is now `final` to satisfy `prefer_final_fields`.
- Two diagnostic string templates now use analyzer-clean interpolation for `_q169LastNativePaintState` and `_q169LastFailureReason`.
- `MathLiveNativePaintOwnershipAuthorityPolicy.realDevicePaintPassClaimed = false` is added as an explicit non-claim marker.
- Q169R29 policy, Flutter test, Node verifier, README note, and manifest envelope are added.

## Required user-side evidence remains

```powershell
flutter clean
flutter pub get
node tool/install_mathlive_runtime.mjs
flutter analyze
flutter test
flutter run -d 23106RN0DA
```

Q170 premium visual polish remains blocked until real-device evidence shows `MOUNT:ok INSERT:ok VALUE:ok CHANNEL:ok PAINT:ok ROOT:none` or an equally explicit single-source court result.
