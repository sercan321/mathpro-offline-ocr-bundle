# V172-Q114R1 — Flutter Analyze Repair Audit Report

## Scope
Surgical repair for user-provided `flutter analyze` output after Q114.

## User-reported issues addressed
- `unused_element` warnings for stale private helper functions in `mathlive_graph_history_solution_adapter_policy.dart`.
- `prefer_const_declarations` warning in `mathlive_real_device_cursor_court_execution_policy.dart`.
- `undefined_named_parameter` errors in Q104/Q105 tests caused by using `plainText` and `evaluateRequested` named arguments on `MathLiveEditorStateSnapshot.fromLatex`.

## Changes
- Q104/Q105 tests now use `MathLiveEditorStateSnapshot.fromJson` when explicit `plainText` and `evaluateRequested` evidence is needed.
- Removed unused private legacy normalization helper functions from Q92 adapter because Q102 normalizer is now the source of truth.
- Converted the Q108 `q94` scenario list reference to `const`.

## Non-goals / protected constraints
- No MathLive default/main editor activation.
- No main workspace mount.
- No legacy cursor retirement or deletion.
- No Graph/History/Solution UI mutation.
- No keyboard, MORE, long-press, Ans, ↵, or = behavior changes.
- No fake runtime/smoke/device evidence.

## Evidence in assistant container
- `python3 tool/verify_mathpro_contract.py`: PASS.
- `node --check tool/*.mjs`: PASS.
- `node --check assets/mathlive/mathlive_bridge.js`: PASS.
- `node tool/verify_release_freeze_clean_full_zip_guard.mjs`: expected BLOCKED because real release evidence is absent.

Flutter/Dart is unavailable in the assistant container, so local `flutter analyze` could not be rerun here. This patch directly targets the exact analyzer findings supplied by the user.
