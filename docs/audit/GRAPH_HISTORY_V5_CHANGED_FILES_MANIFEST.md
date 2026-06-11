# MathPro Graph / History V5 — Changed Files Manifest

Scope: Faz 5 — Graph Settings Sheet validation and premium settings behavior hardening.

## Modified runtime files

- `lib/features/graph/graph_settings_sheet.dart`
  - Rebuilt the settings sheet into a premium, validated settings surface.
  - Added compact live graph preview.
  - Added finite numeric parsing, range validation, preset chips, color labels, and premium error presentation.
  - Preserved all settings actions as real runtime behavior; no dead settings buttons were added.

- `lib/features/graph/graph_models.dart`
  - Added `GraphViewportPolicy` as a shared viewport validation/sanitization authority.
  - Centralized finite range, min/max ordering, too-narrow, too-wide, and unreadably huge viewport checks.

- `lib/features/graph/graph_fullscreen_page.dart`
  - Reused `GraphViewportPolicy` for fullscreen gesture/settings sanitization.
  - Preserved V4 fullscreen graph pan, pinch zoom, double-tap reset, back-state preservation and trace controls.

- `lib/app/app_shell.dart`
  - Sanitized graph settings and preview zoom updates through `GraphViewportPolicy`.
  - No keyboard, tab, long-press, `MORE`, `Ans`, `↵`, or `=` contracts were touched.

## Modified test/documentation files

- `test/graph_history_regression_test.dart`
  - Added graph viewport validation tests.
  - Added widget coverage for invalid settings rejection and valid settings application.

- `README.md`
  - Updated package description from V4 fullscreen hardening to V5 graph settings hardening.

- `docs/audit/GRAPH_HISTORY_V5_CHANGED_FILES_MANIFEST.md`
- `docs/audit/GRAPH_HISTORY_V5_FINAL_AUDIT_REPORT.md`
- `docs/audit/GRAPH_HISTORY_V5_KNOWN_LIMITATIONS.md`
- `docs/audit/GRAPH_HISTORY_V5_RELEASE_HYGIENE_REPORT.md`
- `docs/audit/GRAPH_HISTORY_V5_STATIC_CHECK.md`
- `docs/audit/GRAPH_HISTORY_V5_CONTENTS.txt`

## Files intentionally not changed

- `lib/features/keyboard/key_config.dart`
- `lib/features/keyboard/math_keyboard.dart`
- `lib/features/keyboard/bottom_dock.dart`
- `lib/features/keyboard/long_press_popup.dart`

Keyboard SHA256 remained unchanged during V5 static verification.
