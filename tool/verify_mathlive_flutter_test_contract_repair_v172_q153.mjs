#!/usr/bin/env node
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_flutter_test_contract_repair_v172_q153.mjs', retiredPhase: 'verify_mathlive_flutter_test_contract_repair_v172_q153', reason: 'historical verifier superseded by the Q197/Q203 production-surface architecture and Q204R2/Q204R3 suite hygiene; active production verification is handled by the declared preserved verifier suite' });

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const root = process.argv[2] ? path.resolve(process.argv[2]) : path.resolve(__dirname, '..');
function read(rel) { return fs.readFileSync(path.join(root, rel), 'utf8'); }
function exists(rel) { return fs.existsSync(path.join(root, rel)); }
const blockers = [];
const required = [
  'lib/features/mathlive/mathlive_flutter_test_contract_repair_policy.dart',
  'test/v172_q153_mathlive_flutter_test_contract_repair_test.dart',
  'assets/mathlive/mathlive_bridge.js',
  'assets/mathlive/main_editor.html',
  'lib/features/keyboard/premium_popup_fit_policy.dart',
  'lib/app/app_shell.dart',
  'tool/verify_mathlive_final_premium_package_freeze_v172_q152.mjs',
  'assets/mathlive/manifest.json',
  'README.md',
  'docs/audit/V172_Q153_MATHLIVE_FLUTTER_TEST_CONTRACT_REPAIR_AUDIT_REPORT.md',
  'docs/audit/V172_Q153_CHANGED_FILES_MANIFEST.md'
];
for (const rel of required) if (!exists(rel)) blockers.push(`missing ${rel}`);
const policy = exists(required[0]) ? read(required[0]) : '';
const test = exists(required[1]) ? read(required[1]) : '';
const bridge = exists(required[2]) ? read(required[2]) : '';
const html = exists(required[3]) ? read(required[3]) : '';
const popup = exists(required[4]) ? read(required[4]) : '';
const appShell = exists(required[5]) ? read(required[5]) : '';
const q152Verifier = exists(required[6]) ? read(required[6]) : '';
const manifestRaw = exists(required[7]) ? read(required[7]) : '{}';
let manifest = {};
try { manifest = JSON.parse(manifestRaw); } catch (error) { blockers.push(`manifest JSON parse failed: ${error.message}`); }
const mustContain = [
  [policy, "phase = 'V172-Q153'"],
  [policy, 'flutterTestPassClaimedByAssistant = false'],
  [policy, 'photomathLevelClaimed = false'],
  [test, 'MathLiveFlutterTestContractRepairPolicy.phase'],
  [bridge, 'q141-touchend-selection-synced'],
  [html, 'min-height: 72px'],
  [popup, "testContractRepairPhase = 'V172-Q153'"],
  [popup, 'longPressChipHeight = 48.0'],
  [popup, 'longPressPanelMaxHeight = 64.0'],
  [appShell, '_syncMathLiveSimpleKeyFallbackForTests'],
  [appShell, '_isMathLiveSimpleControllerFallbackLabel'],
  [appShell, "source: 'V172-Q153-mathlive-simple-key-test-fallback'"],
  [q152Verifier, 'userSideGeneratedPathPatterns'],
  [q152Verifier, 'userSideGeneratedPathsIgnoredForWorkspaceVerification']
];
for (const [src, marker] of mustContain) if (!src.includes(marker)) blockers.push(`missing marker: ${marker}`);
const forbidden = [
  [policy, 'keyboardLayoutMutationAllowed = true'],
  [policy, 'longPressOrderMutationAllowed = true'],
  [policy, 'moreInventoryMutationAllowed = true'],
  [policy, 'graphHistorySolutionUiMutationAllowed = true'],
  [policy, 'namedTemplateRawFallbackAllowed = true'],
  [policy, 'realDevicePassClaimed = true'],
  [policy, 'photomathLevelClaimed = true'],
  [appShell, "command.label == 'Taylor'"],
  [appShell, 'rawNamedTemplateTextFallbackAllowed = true']
];
for (const [src, marker] of forbidden) if (src.includes(marker)) blockers.push(`forbidden marker present: ${marker}`);
if (!manifest.v172Q153FlutterTestContractRepair) blockers.push('missing manifest v172Q153FlutterTestContractRepair');
if (manifest.v172Q153FlutterTestContractRepair) {
  const q153 = manifest.v172Q153FlutterTestContractRepair;
  if (q153.phase !== 'V172-Q153') blockers.push('Q153 manifest phase mismatch');
  if (q153.flutterTestPassClaimedByAssistant !== false) blockers.push('Q153 must not claim Flutter test PASS');
  if (q153.realDevicePassClaimed !== false) blockers.push('Q153 must not claim real-device PASS');
  if (q153.photomathLevelClaimed !== false) blockers.push('Q153 must not claim Photomath PASS');
}
const status = blockers.length === 0
  ? 'MATHLIVE_FLUTTER_TEST_CONTRACT_REPAIR_PACKAGE_READY_BUT_USER_SIDE_FLUTTER_TEST_REQUIRED'
  : 'BLOCKED_MATHLIVE_FLUTTER_TEST_CONTRACT_REPAIR';
const report = {
  phase: 'V172-Q153',
  status,
  blockers,
  repairedContracts: {
    q141StaticMarkers: true,
    q150PopupNoClipEnvelope: true,
    q152UserSideGeneratedPathHandling: true,
    graphSimpleKeyFallbackForWidgetTests: true,
    keyboardLayoutMutationAllowed: false,
    longPressOrderMutationAllowed: false,
    realDevicePassClaimed: false,
    photomathLevelClaimed: false
  }
};
fs.mkdirSync(path.join(root, 'tool/reports'), { recursive: true });
fs.writeFileSync(path.join(root, 'tool/reports/mathlive_flutter_test_contract_repair_v172_q153_report.json'), JSON.stringify(report, null, 2));
fs.writeFileSync(path.join(root, 'tool/reports/mathlive_flutter_test_contract_repair_v172_q153_report.md'), `# ${status}\n\nBlockers: ${blockers.length}\n`);
console.log(JSON.stringify(report, null, 2));
if (blockers.length) process.exit(1);
