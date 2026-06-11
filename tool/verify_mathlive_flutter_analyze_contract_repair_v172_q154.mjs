#!/usr/bin/env node
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_flutter_analyze_contract_repair_v172_q154.mjs', retiredPhase: 'verify_mathlive_flutter_analyze_contract_repair_v172_q154', reason: 'superseded by Q197/Q203 production-surface architecture and Q204R2 full test-suite migration; old diagnostic/fallback/court markers are no longer allowed in active production source or tests' });

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const root = process.argv[2] ? path.resolve(process.argv[2]) : path.resolve(__dirname, '..');
function read(rel) { return fs.readFileSync(path.join(root, rel), 'utf8'); }
function exists(rel) { return fs.existsSync(path.join(root, rel)); }
const blockers = [];
const required = [
  'lib/features/mathlive/mathlive_flutter_analyze_contract_repair_policy.dart',
  'test/v172_q154_mathlive_flutter_analyze_contract_repair_test.dart',
  'test/v172_q153_mathlive_flutter_test_contract_repair_test.dart',
  'test/v172_q140_mathlive_premium_surface_repair_test.dart',
  'assets/mathlive/mathlive_bridge.js',
  'assets/mathlive/main_editor.html',
  'assets/mathlive/manifest.json',
  'README.md',
  'docs/audit/V172_Q154_MATHLIVE_FLUTTER_ANALYZE_CONTRACT_REPAIR_AUDIT_REPORT.md',
  'docs/audit/V172_Q154_CHANGED_FILES_MANIFEST.md'
];
for (const rel of required) if (!exists(rel)) blockers.push(`missing ${rel}`);
const policy = exists(required[0]) ? read(required[0]) : '';
const q154Test = exists(required[1]) ? read(required[1]) : '';
const q153Test = exists(required[2]) ? read(required[2]) : '';
const q140Test = exists(required[3]) ? read(required[3]) : '';
const bridge = exists(required[4]) ? read(required[4]) : '';
const html = exists(required[5]) ? read(required[5]) : '';
const manifestRaw = exists(required[6]) ? read(required[6]) : '{}';
let manifest = {};
try { manifest = JSON.parse(manifestRaw); } catch (error) { blockers.push(`manifest JSON parse failed: ${error.message}`); }
const mustContain = [
  [policy, "phase = 'V172-Q154'"],
  [policy, 'flutterAnalyzePassClaimedByAssistant = false'],
  [policy, 'flutterTestPassClaimedByAssistant = false'],
  [q154Test, 'MathLiveFlutterAnalyzeContractRepairPolicy.phase'],
  [q153Test, "contains(r'/(^|\\/)build(\\/|$)/')"],
  [q153Test, "contains(r'/(^|\\/)\\.dart_tool(\\/|$)/')"],
  [q140Test, "contains(r'\\lim_{x\\to #?} #0')"],
  [bridge, 'q140-after-insert-focus-restored'],
  [bridge, 'q140-pointerdown-focus-restored'],
  [html, 'touch-action: manipulation'],
  [html, 'touch-action: auto']
];
for (const [src, marker] of mustContain) if (!src.includes(marker)) blockers.push(`missing marker: ${marker}`);
const forbidden = [
  [policy, 'keyboardLayoutMutationAllowed = true'],
  [policy, 'longPressOrderMutationAllowed = true'],
  [policy, 'graphHistorySolutionUiMutationAllowed = true'],
  [policy, 'flutterAnalyzePassClaimedByAssistant = true'],
  [policy, 'flutterTestPassClaimedByAssistant = true'],
  [policy, 'photomathLevelClaimed = true'],
  [q153Test, "contains('/(^|\\\\/)build(\\\\/|$)/')"],
  [q153Test, "contains('/(^|\\\\/)\\\\.dart_tool(\\\\/|$)/')"]
];
for (const [src, marker] of forbidden) if (src.includes(marker)) blockers.push(`forbidden marker present: ${marker}`);
if (!manifest.v172Q154FlutterAnalyzeContractRepair) blockers.push('missing manifest v172Q154FlutterAnalyzeContractRepair');
const status = blockers.length === 0
  ? 'MATHLIVE_FLUTTER_ANALYZE_CONTRACT_REPAIR_PACKAGE_READY_BUT_USER_SIDE_FLUTTER_TEST_REQUIRED'
  : 'BLOCKED_MATHLIVE_FLUTTER_ANALYZE_CONTRACT_REPAIR';
const report = {
  phase: 'V172-Q154',
  status,
  blockers,
  repairedContracts: {
    q153DartDollarStringEscaped: true,
    q140MarkersRestored: true,
    q140LimitExpectationEvolvedForQ145Textstyle: true,
    touchActionCompatibilityMarkerRestored: true,
    keyboardLayoutMutationAllowed: false,
    longPressOrderMutationAllowed: false,
    realDevicePassClaimed: false,
    photomathLevelClaimed: false
  }
};
fs.mkdirSync(path.join(root, 'tool/reports'), { recursive: true });
fs.writeFileSync(path.join(root, 'tool/reports/mathlive_flutter_analyze_contract_repair_v172_q154_report.json'), JSON.stringify(report, null, 2));
fs.writeFileSync(path.join(root, 'tool/reports/mathlive_flutter_analyze_contract_repair_v172_q154_report.md'), `# ${status}\n\nBlockers: ${blockers.length}\n`);
console.log(JSON.stringify(report, null, 2));
if (blockers.length) process.exit(1);
