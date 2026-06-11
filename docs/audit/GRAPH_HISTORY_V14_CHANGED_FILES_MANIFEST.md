# GRAPH_HISTORY_V14_CHANGED_FILES_MANIFEST
Generated: 2026-05-10

## Changed source files

1. `lib/features/graph/graph_painter.dart`
   - Replaced `0` with `0.0` in trace x clamping to keep the inferred type as `double`.

2. `lib/features/history/history_panel.dart`
   - Replaced `0` / `-88` with `0.0` / `-88.0` in drawer drag offset clamping to keep `_dragOffset` assignment type-safe.

## Changed documentation / tests

3. `README.md`
   - Updated title/scope from V13 to V14.
   - Added Deep Re-Audit / Numeric Type Safety V14 section.

4. `docs/audit/GRAPH_HISTORY_V8_STATIC_CHECK.txt`
   - Corrected stale PASS wording to NOT RUN / PASS not claimed.

5. `test/graph_history_v14_static_contract_test.dart`
   - Added static regression lock for the V14 numeric type repairs and audit wording honesty.

6. `docs/audit/GRAPH_HISTORY_V14_DEEP_AUDIT_REPORT.md`
   - Added authoritative V14 deep audit report.

7. `docs/audit/GRAPH_HISTORY_V14_CHANGED_FILES_MANIFEST.md`
   - This manifest.

8. `docs/audit/GRAPH_HISTORY_V14_RELEASE_HYGIENE_REPORT.md`
   - Added release hygiene report.

9. `docs/audit/GRAPH_HISTORY_V14_STATIC_CHECK.txt`
   - Added static check evidence.

10. `docs/audit/GRAPH_HISTORY_V14_CONTENTS.txt`
    - Added package contents listing.

## Not changed

The following frozen keyboard files were not edited:

- `lib/features/keyboard/key_config.dart`
- `lib/features/keyboard/math_keyboard.dart`
- `lib/features/keyboard/bottom_dock.dart`
- `lib/features/keyboard/long_press_popup.dart`
