# MathPro Graph / History V6 — Changed Files Manifest

## Modified runtime files

- `lib/app/app_shell.dart`
  - Added history-aware transition builder.
  - Animated workspace height when history opens/closes.
  - Preserved graph, keyboard, editor, and history routing contracts.

- `lib/features/history/history_panel.dart`
  - Reworked premium drawer chrome.
  - Added upward swipe-to-close behavior.
  - Added count / pinned / persistence status metadata.
  - Improved search field animation and clear behavior.
  - Polished empty/search-empty states.
  - Kept history hidden-by-default behavior unchanged.

- `lib/features/history/history_item_card.dart`
  - Added stable per-entry keys for regression tests.
  - Added pinned accent border and soft card shadow.
  - Kept edit/copy/pin/delete/graph-open actions intact.

- `lib/features/history/history_style.dart`
  - Added shared drawer animation constants, panel/card radius, highlight, and shadow tokens.

## Modified test file

- `test/graph_history_regression_test.dart`
  - Added Premium History Drawer widget tests for panel rendering, search, item selection, close button, upward swipe close, and absence of the old crude history handle.

## Modified documentation / audit files

- `README.md`
- `docs/audit/GRAPH_HISTORY_V6_FINAL_AUDIT_REPORT.md`
- `docs/audit/GRAPH_HISTORY_V6_CHANGED_FILES_MANIFEST.md`
- `docs/audit/GRAPH_HISTORY_V6_RELEASE_HYGIENE_REPORT.md`
- `docs/audit/GRAPH_HISTORY_V6_STATIC_CHECK.md`
- `docs/audit/GRAPH_HISTORY_V6_KNOWN_LIMITATIONS.md`
- `docs/audit/GRAPH_HISTORY_V6_CONTENTS.txt`

## Intentionally untouched keyboard files

- `lib/features/keyboard/key_config.dart`
- `lib/features/keyboard/math_keyboard.dart`
- `lib/features/keyboard/bottom_dock.dart`
- `lib/features/keyboard/long_press_popup.dart`
