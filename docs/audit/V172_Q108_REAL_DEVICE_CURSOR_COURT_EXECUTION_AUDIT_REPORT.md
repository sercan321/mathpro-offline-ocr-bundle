# V172-Q108 Real Device MathLive Cursor Court Execution Audit Report

## Scope

Q108 turns the Q94 real-device MathLive cursor court into an execution/capture package. The goal is to reduce repeated phone-side testing by defining a single court package, verifier, capture schema, and audit ledger for the eventual real-device run.

## What Q108 adds

- `lib/features/mathlive/mathlive_real_device_cursor_court_execution_policy.dart`
- `tool/verify_mathlive_real_device_cursor_court_execution.mjs`
- `test/v172_q108_real_device_cursor_court_execution_test.dart`
- `docs/audit/V172_Q108_REAL_DEVICE_CURSOR_COURT_EXECUTION_AUDIT_REPORT.md`
- `docs/audit/V172_Q108_CHANGED_FILES_MANIFEST.md`

The verifier writes:

- `tool/reports/mathlive_real_device_cursor_court_execution_report.json`
- `tool/reports/mathlive_real_device_cursor_court_execution_report.md`

Optional future user-side evidence inputs are:

- `tool/reports/mathlive_real_device_cursor_court_execution_capture.json`
- `tool/reports/mathlive_real_device_cursor_court_flutter_evidence.json`

## Protected-surface result

Protected files intentionally untouched. Q108 does not edit keyboard, MORE, long-press, AppShell, MathLabel, template tray, Graph, History, Solution, or legacy cursor physical implementation files.

## Guard result

Q108 may report package-side readiness, but it cannot claim cursor/device PASS without real evidence. The expected status before real evidence is:

`MATHLIVE_REAL_DEVICE_CURSOR_COURT_EXECUTION_PACKAGE_READY_BUT_DEVICE_EVIDENCE_BLOCKED`

Q108 still blocks:

- MathLive cursor PASS claims
- main-editor switch
- MathLive default activation
- legacy main-path retirement
- legacy cursor physical deletion
- fake Flutter/device/runtime/smoke evidence
- protected UI mutation

## Real evidence still required

The final device court still requires:

- `flutter pub get`
- `flutter analyze`
- `flutter test`
- official runtime verification
- Q101 Lab smoke evidence closure
- Q106 mount-readiness verifier
- Q107 main-keyboard bridge verifier
- real-device MathLive Lab run
- real-device main app run
- all 12 Q94/Q108 cursor scenarios captured with zero blocking failures
