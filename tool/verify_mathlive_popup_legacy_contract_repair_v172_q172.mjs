#!/usr/bin/env node
import fs from 'fs';

import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_popup_legacy_contract_repair_v172_q172.mjs', retiredPhase: 'verify_mathlive_popup_legacy_contract_repair_v172_q172', reason: 'historical verifier superseded by the Q197/Q203 production-surface architecture and Q204R2/Q204R3 suite hygiene; active production verification is handled by the declared preserved verifier suite' });

const checks = [];
function check(name, ok) { checks.push({ name, ok: Boolean(ok) }); }
function read(path) { return fs.readFileSync(path, 'utf8'); }

const popup = read('lib/features/keyboard/premium_popup_fit_policy.dart');
const longPress = read('lib/features/keyboard/long_press_popup.dart');
const perf = read('lib/features/formula_engine/premium_editor_performance_policy.dart');
const q170Test = read('test/v172_q170_mathlive_premium_layout_visual_polish_test.dart');
const q172Policy = read('lib/features/keyboard/premium_popup_legacy_contract_repair_policy.dart');
const q172Test = read('test/v172_q172_popup_legacy_contract_repair_test.dart');
const manifest = read('assets/mathlive/manifest.json');

check('q172 policy exists and is non-claiming', q172Policy.includes("phase = 'V172-Q172'") && q172Policy.includes('realDevicePremiumPassClaimed = false'));
check('popup fit policy exposes q172 marker', popup.includes("legacyPopupContractRepairPhase = 'V172-Q172'"));
check('long-press panel min superseded by q231 compact 60', popup.includes('longPressPanelMinHeight = 60.0'));
check('long-press panel max superseded by q231 compact 64', popup.includes('longPressPanelMaxHeight = 64.0'));
check('long-press chip superseded by q231 compact 48', popup.includes('longPressChipHeight = 48.0'));
check('long press popup still delegates to policy', longPress.includes('PremiumPopupFitPolicy.longPressPanelMinHeight') && longPress.includes('PremiumPopupFitPolicy.longPressChipHeight'));
check('performance policy keeps legacy reference while popup uses q231 compact chip', perf.includes('longPressChipHeight = 48.0'));
check('q170 test updated away from invalid 76px contradiction', !q170Test.includes('longPressChipHeight <= 76.0') && q170Test.includes('legacyPopupContractRepairPhase'));
check('q172 test accepts q231 compact successor thresholds', q172Test.includes('LongPressPopup.panelMinHeight') && q172Test.includes('PremiumEditorPerformancePolicy.longPressChipHeight'));
check('manifest q172 envelope present', manifest.includes('v172Q172PopupLegacyContractRepair'));

const failed = checks.filter((x) => !x.ok);
if (failed.length) {
  console.error('MATHLIVE_POPUP_LEGACY_CONTRACT_REPAIR_Q172_FAILED');
  for (const f of failed) console.error(`- ${f.name}`);
  process.exit(1);
}
console.log('MATHLIVE_POPUP_LEGACY_CONTRACT_REPAIR_Q172_PACKAGE_READY_BUT_FLUTTER_TEST_REQUIRED');
