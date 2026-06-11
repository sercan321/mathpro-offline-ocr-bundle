#!/usr/bin/env node
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_popup_envelope_final_rebalance_v172_q156.mjs', retiredPhase: 'verify_mathlive_popup_envelope_final_rebalance_v172_q156', reason: 'historical verifier superseded by the Q197/Q203 production-surface architecture and Q204R2/Q204R3 suite hygiene; active production verification is handled by the declared preserved verifier suite' });

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const root = process.argv[2] ? path.resolve(process.argv[2]) : path.resolve(__dirname, '..');
const blockers = [];
function exists(rel) { return fs.existsSync(path.join(root, rel)); }
function read(rel) { return fs.readFileSync(path.join(root, rel), 'utf8'); }

const required = [
  'lib/features/keyboard/premium_popup_fit_policy.dart',
  'lib/features/keyboard/long_press_popup.dart',
  'lib/features/keyboard/key_config.dart',
  'lib/features/keyboard/math_keyboard.dart',
  'lib/features/mathlive/mathlive_popup_envelope_final_rebalance_policy.dart',
  'test/v172_q156_mathlive_popup_envelope_final_rebalance_test.dart',
  'assets/mathlive/manifest.json',
  'docs/audit/V172_Q156_MATHLIVE_POPUP_ENVELOPE_FINAL_REBALANCE_AUDIT_REPORT.md',
  'docs/audit/V172_Q156_CHANGED_FILES_MANIFEST.md'
];
for (const rel of required) if (!exists(rel)) blockers.push(`missing ${rel}`);

const policy = exists(required[0]) ? read(required[0]) : '';
const longPress = exists(required[1]) ? read(required[1]) : '';
const keyConfig = exists(required[2]) ? read(required[2]) : '';
const mathKeyboard = exists(required[3]) ? read(required[3]) : '';
const q156Policy = exists(required[4]) ? read(required[4]) : '';
const test = exists(required[5]) ? read(required[5]) : '';
const manifest = exists(required[6]) ? read(required[6]) : '';

const mustContain = [
  [policy, "envelopeFinalRebalancePhase = 'V172-Q156'"],
  [policy, 'longPressPanelMinHeight = 60.0'],
  [policy, 'longPressPanelMaxHeight = 64.0'],
  [policy, 'longPressChipHeight = 48.0'],
  [policy, 'longPressBoundedIntegralChipWidth = 98.0'],
  [longPress, 'PremiumPopupFitPolicy.longPressPanelMinHeight'],
  [longPress, 'PremiumPopupFitPolicy.longPressBoundedIntegralChipWidth'],
  [q156Policy, "phase = 'V172-Q156'"],
  [q156Policy, 'keyboardLayoutMutationAllowed = false'],
  [q156Policy, 'longPressOrderMutationAllowed = false'],
  [q156Policy, 'photomathLevelClaimed = false'],
  [test, 'LongPressPopup.panelMinHeight'],
  [test, 'greaterThanOrEqualTo(58)'],
  [test, 'LongPressPopup.boundedIntegralChipWidth'],
  [test, 'greaterThanOrEqualTo(96)'],
  [manifest, 'v172Q156PopupEnvelopeFinalRebalance']
];
for (const [src, marker] of mustContain) if (!src.includes(marker)) blockers.push(`missing marker: ${marker}`);

const forbidden = [
  [policy, 'keyboardLayoutMutationAllowed = true'],
  [policy, 'longPressOrderMutationAllowed = true'],
  [policy, 'moreCategoryMutationAllowed = true'],
  [policy, 'mathLiveTemplateMutationAllowed = true'],
  [q156Policy, 'realDevicePassClaimed = true'],
  [q156Policy, 'photomathLevelClaimed = true'],
  [mathKeyboard, 'V172-Q156'],
  [keyConfig, 'V172-Q156']
];
for (const [src, marker] of forbidden) if (src.includes(marker)) blockers.push(`forbidden marker present: ${marker}`);

const protectedRows = [
  "['C', '⌫', '%', '÷']",
  "['7', '8', '9', '×']",
  "['4', '5', '6', '−']",
  "['1', '2', '3', '+']",
  "['MORE', '0', '.', 'Ans']"
];
const compactKeyConfig = keyConfig.replace(/\s+/g, '');
for (const row of protectedRows) {
  if (!compactKeyConfig.includes(row.replace(/\s+/g, ''))) blockers.push(`keyboard row drift: ${row}`);
}

const status = blockers.length === 0
  ? 'MATHLIVE_POPUP_ENVELOPE_FINAL_REBALANCE_PACKAGE_READY_BUT_DEVICE_EVIDENCE_REQUIRED'
  : 'BLOCKED_MATHLIVE_POPUP_ENVELOPE_FINAL_REBALANCE';
const report = {
  phase: 'V172-Q156',
  status,
  blockers,
  contract: {
    longPressPanelMinHeightPx: 60,
    longPressPanelMaxHeightPx: 64,
    longPressChipHeightPx: 48,
    longPressBoundedIntegralChipWidthPx: 98,
    keyboardLayoutMutationAllowed: false,
    longPressOrderMutationAllowed: false,
    moreInventoryMutationAllowed: false,
    mathLiveTemplateMutationAllowed: false,
    graphHistorySolutionMutationAllowed: false,
    realDevicePassClaimed: false,
    photomathLevelClaimed: false
  }
};
fs.mkdirSync(path.join(root, 'tool/reports'), { recursive: true });
fs.writeFileSync(path.join(root, 'tool/reports/mathlive_popup_envelope_final_rebalance_v172_q156_report.json'), JSON.stringify(report, null, 2));
fs.writeFileSync(path.join(root, 'tool/reports/mathlive_popup_envelope_final_rebalance_v172_q156_report.md'), `# ${status}\n\nBlockers: ${blockers.length}\n`);
console.log(JSON.stringify(report, null, 2));
if (blockers.length) process.exit(1);
