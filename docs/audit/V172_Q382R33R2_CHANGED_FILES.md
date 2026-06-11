# V172-Q382R33R2 Changed Files

- `lib/features/mathlive/mathlive_full_keyboard_warmup_q382r33_policy.dart`
  - Warmup inventory deduplication is now per dispatch label, not per `origin::tab::label` clone.
- `test/v172_q153_mathlive_flutter_test_contract_repair_test.dart`
  - Updated stale AppShell bridge-marker expectations for the current `sendKeyFast` production route while keeping the retired simple-key fallback blocked.
- `tool/verify_warmup_inventory_and_stale_test_repair_v172_q382r33r2.mjs`
  - Added static verifier for this repair.
- `docs/audit/V172_Q382R33R2_WARMUP_INVENTORY_AND_STALE_TEST_REPAIR.md`
- `docs/audit/V172_Q382R33R2_CHANGED_FILES.md`
