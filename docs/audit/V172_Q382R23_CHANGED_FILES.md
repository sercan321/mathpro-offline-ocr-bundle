# V172-Q382R23 — Changed Files

## Modified
- `assets/mathlive/mathlive_prod_bridge.js`
- `lib/app/app_shell.dart`
- `lib/features/keyboard/premium_key.dart`
- `lib/features/mathlive/mathlive_main_editor_surface.dart`
- `lib/features/mathlive/mathlive_production_editor_surface.dart`

## Added
- `lib/debug/latency/mathpro_latency_probe_q382r23.dart`
- `lib/debug/latency/mathpro_latency_overlay_q382r23.dart`
- `tool/verify_real_device_latency_instrumentation_v172_q382r23.mjs`
- `docs/audit/V172_Q382R23_CHANGED_FILES.md`
- `docs/audit/V172_Q382R23_REAL_DEVICE_LATENCY_INSTRUMENTATION_AUDIT_REPORT.md`

## Scope boundary
This is measurement-only instrumentation. It does not implement early dispatch, optimistic echo, pan/drag scrolling, payload slimming beyond Q382R22, animation changes, solver debounce, or rebuild refactors.

## Q382R23R1 Analyzer Repair Note

- Replaced invalid Dart `String(...)` constructor-style conversions in `mathpro_latency_probe_q382r23.dart` with `.toString()` conversions.
- Removed unnecessary `dart:ui` import from `mathpro_latency_overlay_q382r23.dart`.
- No performance behavior, keyboard layout, MathLive command semantics, Graph, Solution, OCR, History, Android/Kotlin, or runtime optimization behavior was changed.

