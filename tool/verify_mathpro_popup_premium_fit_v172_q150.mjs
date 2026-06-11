#!/usr/bin/env node
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const root = process.argv[2] ? path.resolve(process.argv[2]) : path.resolve(__dirname, '..');
function read(rel) { return fs.readFileSync(path.join(root, rel), 'utf8'); }
function exists(rel) { return fs.existsSync(path.join(root, rel)); }
const blockers = [];
const required = [
  'lib/features/keyboard/premium_popup_fit_policy.dart',
  'lib/features/keyboard/long_press_popup.dart',
  'lib/features/workspace/template_tray.dart',
  'lib/features/keyboard/key_config.dart',
  'lib/features/keyboard/math_keyboard.dart',
  'lib/features/keyboard/bottom_dock.dart',
  'lib/features/keyboard/premium_key.dart',
  'assets/mathlive/manifest.json',
  'test/v172_q150_mathpro_popup_premium_fit_test.dart',
  'docs/audit/V172_Q150_MATHPRO_POPUP_PREMIUM_FIT_AUDIT_REPORT.md',
  'docs/audit/V172_Q150_CHANGED_FILES_MANIFEST.md'
];
for (const rel of required) if (!exists(rel)) blockers.push(`missing ${rel}`);
const policy = exists(required[0]) ? read(required[0]) : '';
const longPress = exists(required[1]) ? read(required[1]) : '';
const moreTray = exists(required[2]) ? read(required[2]) : '';
const keyConfig = exists(required[3]) ? read(required[3]) : '';
const mathKeyboard = exists(required[4]) ? read(required[4]) : '';
const bottomDock = exists(required[5]) ? read(required[5]) : '';
const premiumKey = exists(required[6]) ? read(required[6]) : '';
const manifest = exists(required[7]) ? read(required[7]) : '';
const test = exists(required[8]) ? read(required[8]) : '';
const mustContain = [
  [policy, "phase = 'V172-Q150'"],
  [policy, 'visualFitOnly = true'],
  [policy, 'keyboardLayoutMutationAllowed = false'],
  [policy, 'longPressOrderMutationAllowed = false'],
  [policy, 'moreCategoryMutationAllowed = false'],
  [policy, 'mathLiveTemplateMutationAllowed = false'],
  [policy, 'photomathLevelClaimed = false'],
  [policy, 'longPressPanelMaxHeight = 64.0'],
  [policy, 'longPressChipHeight = 48.0'],
  [policy, "testContractRepairPhase = 'V172-Q153'"],
  [policy, 'moreTrayChipHeightRegular = 32.0'],
  [longPress, 'PremiumPopupFitPolicy.longPressPanelMaxHeight'],
  [longPress, 'PremiumPopupFitPolicy.desiredLongPressPanelWidth'],
  [longPress, 'PremiumPopupFitPolicy.longPressChipWidthFor'],
  [longPress, 'PremiumPopupFitPolicy.longPressMathFontSize'],
  [moreTray, 'PremiumPopupFitPolicy.moreTrayHeaderHeightCompact'],
  [moreTray, 'PremiumPopupFitPolicy.moreChipMaxWidth'],
  [moreTray, 'PremiumPopupFitPolicy.moreChipMinWidth'],
  [manifest, 'v172Q150MathProPopupPremiumFit'],
  [manifest, 'longPressPanelMaxHeightPx'],
  [test, 'PremiumPopupFitPolicy.phase']
];
for (const [src, marker] of mustContain) if (!src.includes(marker)) blockers.push(`missing marker: ${marker}`);
const forbidden = [
  [policy, 'keyboardLayoutMutationAllowed = true'],
  [policy, 'longPressOrderMutationAllowed = true'],
  [policy, 'moreCategoryMutationAllowed = true'],
  [policy, 'mathLiveTemplateMutationAllowed = true'],
  [policy, 'realDevicePassClaimed = true'],
  [policy, 'photomathLevelClaimed = true'],
  [longPress, 'panelMinHeight = 116'],
  [longPress, 'panelMaxHeight = 126'],
];
for (const [src, marker] of forbidden) if (src.includes(marker)) blockers.push(`forbidden marker present: ${marker}`);
const requiredRows = [
  "['C', '⌫', '%', '÷']",
  "['7', '8', '9', '×']",
  "['4', '5', '6', '−']",
  "['1', '2', '3', '+']",
  "['MORE', '0', '.', 'Ans']"
];
const compactKeyConfig = keyConfig.replace(/\s+/g, '');
for (const row of requiredRows) {
  if (!compactKeyConfig.includes(row.replace(/\s+/g, ''))) blockers.push(`keyboard row drift: ${row}`);
}
for (const marker of ["'Temel'", "'Cebir'", "'Kalkülüs'", "'Kompleks'", "'Lineer Cebir'", 'longPressMap']) {
  if (!keyConfig.includes(marker)) blockers.push(`key_config missing protected marker: ${marker}`);
}
for (const [name, src] of [['math_keyboard', mathKeyboard], ['bottom_dock', bottomDock], ['premium_key', premiumKey]]) {
  if (src.includes('V172-Q150') || src.includes('PremiumPopupFitPolicy')) {
    blockers.push(`${name} contains Q150 visual-fit mutation marker`);
  }
}
const status = blockers.length === 0
  ? 'MATHPRO_POPUP_PREMIUM_FIT_PACKAGE_READY_BUT_DEVICE_EVIDENCE_REQUIRED'
  : 'BLOCKED_MATHPRO_POPUP_PREMIUM_FIT';
const report = {
  phase: 'V172-Q150',
  status,
  blockers,
  contract: {
    longPressPanelMaxHeightPx: 64,
    longPressChipHeightPx: 48,
    moreTrayChipHeightRegularPx: 32,
    keyboardLayoutMutationAllowed: false,
    longPressOrderMutationAllowed: false,
    moreCategoryMutationAllowed: false,
    mathLiveTemplateMutationAllowed: false,
    realDevicePassClaimed: false,
    photomathLevelClaimed: false
  }
};
fs.mkdirSync(path.join(root, 'tool/reports'), { recursive: true });
fs.writeFileSync(path.join(root, 'tool/reports/mathpro_popup_premium_fit_v172_q150_report.json'), JSON.stringify(report, null, 2));
fs.writeFileSync(path.join(root, 'tool/reports/mathpro_popup_premium_fit_v172_q150_report.md'), `# ${status}\n\nBlockers: ${blockers.length}\n`);
console.log(JSON.stringify(report, null, 2));
if (blockers.length) process.exit(1);
