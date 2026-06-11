# V172-Q169R18 MathLive Final Self-Test Court Analyzer Hygiene Audit

## Purpose

Repair the user-side `flutter analyze` info diagnostics caused by unnecessary escaped double quotes inside single-quoted Dart string literals in the Q169R17 final self-test court bridge-message detector.

## Scope

Changed:

- `lib/features/mathlive/mathlive_main_editor_surface.dart`
- `lib/features/mathlive/mathlive_final_self_test_court_analyzer_hygiene_policy.dart`
- `assets/mathlive/manifest.json`
- `README.md`
- `tool/verify_mathlive_final_self_test_court_analyzer_hygiene_v172_q169r18.mjs`
- Q169R18 audit docs

Protected surfaces are unchanged.

## Non-goals

- No keyboard layout change.
- No MORE or long-press order change.
- No AppShell mutation.
- No Graph, History, Solution, or solver mutation.
- No native MathLive paint success claim.
- No change to Q169R17 court runtime behavior.

## Expected user-side result

The previous `flutter analyze` info diagnostics at `mathlive_main_editor_surface.dart:427` and `:428` for `unnecessary_string_escapes` should no longer appear.
