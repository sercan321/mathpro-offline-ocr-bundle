# MathPro Graph / Premium History V9 — Changed Files Manifest

- `README.md`
  - Updated package status from V8 to V9 and documented the persistence storage contract.

- `lib/features/history/history_storage.dart`
  - Added schema-versioned V2 envelope persistence.
  - Added V1 legacy restore/migration support.
  - Added bounded/corruption-safe decode behavior.
  - Added testable encode/decode helpers.

- `lib/features/history/history_controller.dart`
  - Added restore/persist futures.
  - Added persistence-disabled restored state.
  - Added async dispose safety.
  - Switched history limit to the storage contract constant.

- `test/graph_history_regression_test.dart`
  - Added persistence restore test with SharedPreferences mock storage.
  - Added schema envelope/corruption/bounded decode test.

- `test/core_editor_regression_test.dart`
  - Updated stale no-persistence expectations to the current explicit persistence dependency decision.

- `docs/audit/GRAPH_HISTORY_V9_REPORT.md`
  - Added V9 audit summary.

- `docs/audit/GRAPH_HISTORY_V9_CHANGED_FILES_MANIFEST.md`
  - Added changed-file manifest.

- `docs/audit/GRAPH_HISTORY_V9_RELEASE_HYGIENE_REPORT.md`
  - Added release hygiene report.

- `docs/audit/GRAPH_HISTORY_V9_STATIC_CHECK.txt`
  - Added static check summary.
