# V172-Q190R5 Template Payload Surgical Repair Audit Report

## Status

Q190R5 is a surgical code-level repair for the active production MathLive template payload path. It does not claim Flutter analyze/test/run PASS, Android real-device PASS, premium symbol PASS, caret PASS, final release PASS, or physical legacy cleanup.

## Baseline

`V172-Q190R4 — Production Bridge Queue Focus Repair`

## Problem Closed by This Phase

Q190R4 correctly refused raw/half template fallback when `#0`, `#?`, or `#@` insert-control payloads failed to commit. However, critical structural templates were still dispatched from Flutter with those historical insert-control tokens. If MathLive did not commit the native insert path, Q190R4 would fail loudly instead of producing an editable document placeholder template.

## Surgical Fix

Q190R5 adds a production-only conversion step before the WebView command crosses the bridge:

```text
#@ -> \placeholder{}
#0 -> \placeholder{}
#? -> \placeholder{}
```

The historical command map remains compatible with previous static tests. The active production payload now uses explicit MathLive document placeholders. The JavaScript bridge repeats the same conversion as a hard safety gate.

## Files Modified

- `README.md`
- `assets/mathlive/manifest.json`
- `assets/mathlive/mathlive_prod_bridge.js`
- `lib/features/mathlive/mathlive_keyboard_bridge_policy.dart`
- `lib/features/mathlive/mathlive_main_editor_surface.dart`

## Files Added

- `lib/features/mathlive/mathlive_template_payload_surgical_repair_policy.dart`
- `test/v172_q190r5_template_payload_surgical_repair_test.dart`
- `tool/verify_mathlive_template_payload_surgical_repair_v172_q190r5.mjs`
- `docs/audit/V172_Q190R5_TEMPLATE_PAYLOAD_SURGICAL_REPAIR_AUDIT_REPORT.md`
- `docs/audit/V172_Q190R5_TEMPLATE_PAYLOAD_SURGICAL_REPAIR_CHANGED_FILES_MANIFEST.md`
- `docs/audit/V172_Q190R5_PROTECTED_FILE_HASH_MANIFEST.md`

## Protected Files

Protected keyboard/MORE/long-press/Graph/History/Solution files are unchanged against Q190R4 baseline. See `docs/audit/V172_Q190R5_PROTECTED_FILE_HASH_MANIFEST.md`.

## Verification

Static verifier:

```bash
node tool/verify_mathlive_template_payload_surgical_repair_v172_q190r5.mjs
```

Expected result:

```text
MATHLIVE_TEMPLATE_PAYLOAD_SURGICAL_REPAIR_Q190R5_STATIC_READY_BUT_FLUTTER_ANALYZE_AND_ANDROID_RETEST_REQUIRED
```

## Remaining External Evidence

Flutter analyze/test/run and Android device behavior must still be proven on the user's machine.
