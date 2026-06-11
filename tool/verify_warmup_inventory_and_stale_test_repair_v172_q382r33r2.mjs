#!/usr/bin/env node
import fs from 'node:fs';

const read = (p) => fs.readFileSync(p, 'utf8');
const must = (p, needle) => {
  const text = read(p);
  if (!text.includes(needle)) {
    console.error(`FAIL verify_warmup_inventory_and_stale_test_repair_v172_q382r33r2: ${p} missing ${needle}`);
    process.exit(1);
  }
};
const mustNot = (p, needle) => {
  const text = read(p);
  if (text.includes(needle)) {
    console.error(`FAIL verify_warmup_inventory_and_stale_test_repair_v172_q382r33r2: ${p} still contains ${needle}`);
    process.exit(1);
  }
};

must('lib/features/mathlive/mathlive_full_keyboard_warmup_q382r33_policy.dart', 'Q382R33R2: warmup is per dispatch label');
must('lib/features/mathlive/mathlive_full_keyboard_warmup_q382r33_policy.dart', 'if (!seen.add(trimmed)) return;');
mustNot('lib/features/mathlive/mathlive_full_keyboard_warmup_q382r33_policy.dart', "final key = '$origin::$activeTab::$trimmed';");
must('test/v172_q153_mathlive_flutter_test_contract_repair_test.dart', "contains('_mathLiveMainEditor.sendKeyFast')");
must('test/v172_q153_mathlive_flutter_test_contract_repair_test.dart', "contains('_mathLiveMainEditor.markKeyboardTap')");
must('test/v172_q153_mathlive_flutter_test_contract_repair_test.dart', "contains('MathLiveKeyboardBridgePolicy.commandForMainEditorLabel')");
must('docs/audit/V172_Q382R33R2_WARMUP_INVENTORY_AND_STALE_TEST_REPAIR.md', 'V172-Q382R33R2');
must('docs/audit/V172_Q382R33R2_CHANGED_FILES.md', 'mathlive_full_keyboard_warmup_q382r33_policy.dart');

// Protected sources must not be mutated by the R33R2 marker.
for (const p of [
  'lib/features/keyboard/key_config.dart',
  'lib/logic/action_utils.dart',
  'android/app/build.gradle',
  'android/settings.gradle',
]) {
  if (fs.existsSync(p)) mustNot(p, 'Q382R33R2');
}

console.log('PASS verify_warmup_inventory_and_stale_test_repair_v172_q382r33r2');
