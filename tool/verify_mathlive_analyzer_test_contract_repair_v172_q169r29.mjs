#!/usr/bin/env node
import { readFileSync, existsSync } from 'node:fs';

import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_analyzer_test_contract_repair_v172_q169r29.mjs', retiredPhase: 'verify_mathlive_analyzer_test_contract_repair_v172_q169r29', reason: 'superseded by Q197/Q203 production-surface architecture and Q204R2 full test-suite migration; old diagnostic/fallback/court markers are no longer allowed in active production source or tests' });

const checks = [];
function must(condition, message) {
  checks.push({ ok: !!condition, message });
}
function text(path) {
  if (!existsSync(path)) return '';
  return readFileSync(path, 'utf8');
}
function json(path) {
  return JSON.parse(text(path));
}

const surface = text('lib/features/mathlive/mathlive_main_editor_surface.dart');
const paintPolicy = text('lib/features/mathlive/mathlive_native_paint_ownership_authority_policy.dart');
const q169r29Policy = text('lib/features/mathlive/mathlive_analyzer_test_contract_repair_policy.dart');
const q169r24r27Test = text('test/v172_q169r24_r27_mathlive_authority_chain_test.dart');
const manifest = json('assets/mathlive/manifest.json');
const readme = text('README.md');

must(q169r29Policy.includes("phase = 'V172-Q169R29'"), 'Q169R29 policy declares phase');
must(q169r29Policy.includes('keyboardLayoutMutationAllowed = false'), 'Q169R29 blocks keyboard layout mutation');
must(q169r29Policy.includes('appShellMutationAllowed = false'), 'Q169R29 blocks AppShell mutation');
must(q169r29Policy.includes('runtimeBehaviorMutationAllowed = false'), 'Q169R29 does not change runtime behavior');
must(q169r29Policy.includes('premiumVisualPolishAllowed = false'), 'Q169R29 blocks premium visual polish');
must(q169r29Policy.includes('assistantFlutterAnalyzePassClaimed = false'), 'Q169R29 does not claim assistant-side analyze pass');
must(q169r29Policy.includes('assistantFlutterTestPassClaimed = false'), 'Q169R29 does not claim assistant-side test pass');
must(q169r29Policy.includes('realDevicePaintPassClaimed = false'), 'Q169R29 does not claim real-device paint pass');

must(surface.includes('final bool _q169SingleCommandBusLocked = true;'), 'surface fixes prefer_final_fields analyzer issue');
must(!surface.includes('PAINT:${_q169LastNativePaintState} ROOT:${_q169LastFailureReason}'), 'surface removes unnecessary interpolation braces for native paint summary');
must(surface.includes('PAINT:$_q169LastNativePaintState ROOT:$_q169LastFailureReason'), 'surface keeps diagnostic summary with analyzer-clean interpolation');

must(paintPolicy.includes('realDevicePaintPassClaimed = false'), 'native paint policy exposes non-claim marker required by Flutter test');
must(q169r24r27Test.includes('realDevicePaintPassClaimed = false'), 'Q169R24-R27 authority-chain test still checks non-claim marker');
must(manifest.v172Q169R29AnalyzerTestContractRepair?.phase === 'V172-Q169R29', 'manifest records Q169R29 envelope');
must(manifest.v172Q169R29AnalyzerTestContractRepair?.realDevicePaintPassClaimed === false, 'manifest does not claim real-device paint pass');
must(readme.includes('V172-Q169R29'), 'README documents Q169R29');

const failed = checks.filter((check) => !check.ok);
if (failed.length > 0) {
  console.error('MATHLIVE_ANALYZER_TEST_CONTRACT_REPAIR_Q169R29_FAILED');
  for (const item of failed) console.error(' - ' + item.message);
  process.exit(1);
}

console.log('MATHLIVE_ANALYZER_TEST_CONTRACT_REPAIR_PACKAGE_READY_BUT_USER_SIDE_FLUTTER_AND_DEVICE_EVIDENCE_REQUIRED');
