# V172-Q114 Lab Vendor Asset Bundle Repair Audit

Purpose: ensure the official local MathLive vendor runtime installed under `assets/mathlive/vendor/mathlive/` is included in Flutter asset bundling for the isolated MathLive Lab after `flutter clean` and rebuild.

Changes:
- `pubspec.yaml`: added explicit `assets/mathlive/vendor/mathlive/` asset directory.
- `tool/install_mathlive_runtime.mjs`: retained Node 24 / Windows-safe npm invocation and direct private `package.json` writer instead of `npm init -y`.

Non-changes / red lines:
- Keyboard, MORE, long-press, Ans, ↵, = were not modified.
- AppShell, Graph, History, Solution, MathLabel, and template tray were not modified.
- MathLive was not made default and was not mounted in the main workspace.
- Legacy cursor was not retired or deleted.
- No fake smoke/device/runtime evidence was written.

Expected user sequence:
1. `node tool/install_mathlive_runtime.mjs`
2. `node tool/verify_mathlive_runtime.mjs`
3. `node tool/verify_mathlive_official_runtime_bundle.mjs`
4. `flutter clean`
5. `flutter pub get`
6. `flutter run -t lib/main_mathlive_lab.dart -d 23106RN0DA`
