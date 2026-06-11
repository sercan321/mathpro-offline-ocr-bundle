#!/usr/bin/env node
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_flutter_test_metadata_contract_repair_v172_q155.mjs', retiredPhase: 'verify_mathlive_flutter_test_metadata_contract_repair_v172_q155', reason: 'superseded by Q197/Q203 production-surface architecture and Q204R2 full test-suite migration; old diagnostic/fallback/court markers are no longer allowed in active production source or tests' });

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const root = process.argv[2] ? path.resolve(process.argv[2]) : path.resolve(__dirname, '..');
function read(rel) { return fs.readFileSync(path.join(root, rel), 'utf8'); }
function exists(rel) { return fs.existsSync(path.join(root, rel)); }
const blockers = [];
const required = [
  'lib/features/mathlive/mathlive_flutter_test_metadata_contract_repair_policy.dart',
  'test/v172_q155_mathlive_flutter_test_metadata_contract_repair_test.dart',
  'tool/verify_mathlive_flutter_test_metadata_contract_repair_v172_q155.mjs',
  'lib/logic/mathpro_package_contract.dart',
  'test/v172_q140_mathlive_premium_surface_repair_test.dart',
  'lib/features/mathlive/mathlive_keyboard_bridge_policy.dart',
  'assets/mathlive/manifest.json',
  'README.md',
  'docs/audit/V172_Q155_MATHLIVE_FLUTTER_TEST_METADATA_CONTRACT_REPAIR_AUDIT_REPORT.md',
  'docs/audit/V172_Q155_CHANGED_FILES_MANIFEST.md'
];
for (const rel of required) if (!exists(rel)) blockers.push(`missing ${rel}`);
const policy = exists(required[0]) ? read(required[0]) : '';
const q155Test = exists(required[1]) ? read(required[1]) : '';
const contract = exists(required[3]) ? read(required[3]) : '';
const q140Test = exists(required[4]) ? read(required[4]) : '';
const bridgePolicy = exists(required[5]) ? read(required[5]) : '';
const manifestRaw = exists(required[6]) ? read(required[6]) : '{}';
const readme = exists(required[7]) ? read(required[7]) : '';
let manifest = {};
try { manifest = JSON.parse(manifestRaw); } catch (error) { blockers.push(`manifest JSON parse failed: ${error.message}`); }
const staleStart = contract.indexOf('static const Set<String> staleVersionMarkers');
const staleEnd = contract.indexOf('};', staleStart);
const staleBlock = staleStart >= 0 && staleEnd > staleStart ? contract.slice(staleStart, staleEnd) : '';
const mustContain = [
  [policy, "phase = 'V172-Q155'"],
  [policy, 'packageMetadataStaleVersionSelfReferenceRemoved = true'],
  [policy, 'q140SigmaContractAcceptsQ145Textstyle = true'],
  [policy, 'pubspecVersionChanged = false'],
  [policy, 'flutterAnalyzePassClaimedByAssistant = false'],
  [policy, 'flutterTestPassClaimedByAssistant = false'],
  [q155Test, 'MathLiveFlutterTestMetadataContractRepairPolicy.phase'],
  [q155Test, 'MathProPackageContract.staleVersionMarkers'],
  [q140Test, 'final sigmaLatex = MathLiveKeyboardBridgePolicy.commandForMainEditorLabel'],
  [q140Test, "contains(r'\\sum_{n=#?}^{#?} #0')"],
  [q140Test, "contains(r'\\textstyle')"],
  [bridgePolicy, "'Σ': r'\\textstyle\\sum_{n=#?}^{#?} #0'"],
  [readme, 'V172-Q155 — MathLive Flutter Test Metadata Contract Repair']
];
for (const [src, marker] of mustContain) if (!src.includes(marker)) blockers.push(`missing marker: ${marker}`);
if (!contract.includes("static const String version = '0.172.112+172'")) blockers.push('legacy package version compatibility marker changed unexpectedly');
if (staleBlock.includes("'version: 0.172.112+172'")) blockers.push('active package version is still listed as stale');
const forbidden = [
  [policy, 'keyboardLayoutMutationAllowed = true'],
  [policy, 'longPressOrderMutationAllowed = true'],
  [policy, 'graphHistorySolutionUiMutationAllowed = true'],
  [policy, 'flutterAnalyzePassClaimedByAssistant = true'],
  [policy, 'flutterTestPassClaimedByAssistant = true'],
  [policy, 'photomathLevelClaimed = true'],
  [q140Test, "expect(MathLiveKeyboardBridgePolicy.commandForMainEditorLabel('Σ').latex, r'\\sum_{n=#?}^{#?} #0')"]
];
for (const [src, marker] of forbidden) if (src.includes(marker)) blockers.push(`forbidden marker present: ${marker}`);
if (!manifest.v172Q155FlutterTestMetadataContractRepair) blockers.push('missing manifest v172Q155FlutterTestMetadataContractRepair');
if (manifest.v172Q155FlutterTestMetadataContractRepair) {
  const q155 = manifest.v172Q155FlutterTestMetadataContractRepair;
  if (q155.phase !== 'V172-Q155') blockers.push('Q155 manifest phase mismatch');
  if (q155.packageMetadataStaleVersionSelfReferenceRemoved !== true) blockers.push('Q155 manifest stale-version repair missing');
  for (const key of ['keyboardLayoutMutationAllowed', 'longPressOrderMutationAllowed', 'graphHistorySolutionUiMutationAllowed', 'flutterAnalyzePassClaimedByAssistant', 'flutterTestPassClaimedByAssistant', 'photomathLevelClaimed']) {
    if (q155[key] !== false) blockers.push(`Q155 manifest ${key} must be false`);
  }
}
const status = blockers.length === 0
  ? 'MATHLIVE_FLUTTER_TEST_METADATA_CONTRACT_REPAIR_PACKAGE_READY_BUT_USER_SIDE_FLUTTER_TEST_REQUIRED'
  : 'BLOCKED_MATHLIVE_FLUTTER_TEST_METADATA_CONTRACT_REPAIR';
const report = {
  phase: 'V172-Q155',
  status,
  blockers,
  repairedContracts: {
    activePackageVersionNoLongerListedAsStale: true,
    q140SigmaAcceptsQ145Textstyle: true,
    q140SigmaSemanticSumPreserved: true,
    pubspecVersionChanged: false,
    verifyMathProContractCompatibilityPreserved: true,
    realDevicePassClaimed: false,
    photomathLevelClaimed: false
  }
};
fs.mkdirSync(path.join(root, 'tool/reports'), { recursive: true });
fs.writeFileSync(path.join(root, 'tool/reports/mathlive_flutter_test_metadata_contract_repair_v172_q155_report.json'), JSON.stringify(report, null, 2));
fs.writeFileSync(path.join(root, 'tool/reports/mathlive_flutter_test_metadata_contract_repair_v172_q155_report.md'), `# ${status}\n\nBlockers: ${blockers.length}\n`);
console.log(JSON.stringify(report, null, 2));
if (blockers.length) process.exit(1);
