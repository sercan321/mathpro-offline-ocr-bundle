#!/usr/bin/env node
import { readFileSync, existsSync } from 'node:fs';

import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_static_hygiene_runtime_truth_repair_v172_q169r28.mjs', retiredPhase: 'verify_mathlive_static_hygiene_runtime_truth_repair_v172_q169r28', reason: 'superseded by Q197/Q203 production-surface architecture and Q204R2 full test-suite migration; old diagnostic/fallback/court markers are no longer allowed in active production source or tests' });

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

const bridge = text('assets/mathlive/mathlive_bridge.js');
const surface = text('lib/features/mathlive/mathlive_main_editor_surface.dart');
const r8Policy = text('lib/features/mathlive/mathlive_insert_value_failure_reason_court_policy.dart');
const q169r28Policy = text('lib/features/mathlive/mathlive_static_hygiene_runtime_truth_repair_policy.dart');
const manifest = json('assets/mathlive/manifest.json');
const readme = text('README.md');

must(q169r28Policy.includes("phase = 'V172-Q169R28'"), 'Q169R28 policy declares phase');
must(q169r28Policy.includes('keyboardLayoutMutationAllowed = false'), 'Q169R28 policy blocks keyboard layout mutation');
must(q169r28Policy.includes('appShellMutationAllowed = false'), 'Q169R28 policy blocks AppShell mutation');
must(q169r28Policy.includes('premiumVisualPolishAllowed = false'), 'Q169R28 policy blocks premium polish before device proof');
must(q169r28Policy.includes('realDevicePaintPassClaimed = false'), 'Q169R28 policy does not claim device paint pass');
must(q169r28Policy.includes('node tool/install_mathlive_runtime.mjs'), 'Q169R28 records runtime install command');
must(q169r28Policy.includes('v172Q169CurrentRuntimeTruth'), 'Q169R28 records active runtime truth source');

must(bridge.includes("nativePaintOwnershipAuthorityPhase: 'V172-Q169R27'"), 'bridge keeps Q169R27 native paint authority');
must(bridge.includes('q169FailureReasonLegacyAlias'), 'bridge exports legacy failure reason alias');
must(bridge.includes('paint-pending-empty-value'), 'bridge retains Q169R8 legacy paint pending reason marker');
must(bridge.includes('paint-pending-empty-native-value'), 'bridge keeps Q169R27 native paint pending reason');
must(bridge.includes("state.q169FailureReasonLegacyAlias = 'paint-pending-empty-value'"), 'bridge maps native empty paint reason to legacy alias');
must(bridge.includes("setQ169FailureReason('paint-pending-empty-native-value')"), 'bridge still reports strict native paint empty reason');

must(r8Policy.includes("'paint-pending-empty-value'"), 'Q169R8 policy retains legacy paint pending reason');
must(r8Policy.includes("'paint-pending-empty-native-value'"), 'Q169R8 policy recognizes Q169R27 refined native reason');

must(surface.includes('nativePaintOwner'), 'surface parses native paint owner');
must(surface.includes('nativePaintProofValuePath'), 'surface parses native paint proof value path');
must(surface.includes('MathLiveNativePaintOwnershipAuthorityPolicy.nativePaintOwnsSurface'), 'surface requires native paint ownership policy for visible ownership');

must(manifest.v172Q169R28StaticHygieneRuntimeTruthRepair?.phase === 'V172-Q169R28', 'manifest records Q169R28 envelope');
must(manifest.v172Q169R28StaticHygieneRuntimeTruthRepair?.realDevicePaintPassClaimed === false, 'manifest does not claim real-device paint pass');
must(manifest.v172Q169R28StaticHygieneRuntimeTruthRepair?.runtimeInstallCommand === 'node tool/install_mathlive_runtime.mjs', 'manifest records runtime install command');
must(manifest.v172Q169R28StaticHygieneRuntimeTruthRepair?.legacyTopLevelRuntimeFieldsRetainedForStaticContract === true, 'manifest documents legacy top-level fields are static-contract retention');
must(manifest.v172Q169R28StaticHygieneRuntimeTruthRepair?.activeRuntimeTruthSource === 'v172Q169CurrentRuntimeTruth', 'manifest points to active runtime truth source');
must(manifest.v172Q169R8InsertValueFailureReasonCourt?.knownFailureReasons?.includes('paint-pending-empty-native-value'), 'manifest Q169R8 known reasons include native empty paint reason');

must(readme.includes('V172-Q169R28'), 'README documents Q169R28');
must(readme.includes('paint-pending-empty-native-value'), 'README documents native paint pending reason');
must(readme.includes('node tool/install_mathlive_runtime.mjs'), 'README states runtime install command');

const failed = checks.filter((check) => !check.ok);
if (failed.length > 0) {
  console.error('MATHLIVE_STATIC_HYGIENE_RUNTIME_TRUTH_REPAIR_Q169R28_FAILED');
  for (const item of failed) console.error(' - ' + item.message);
  process.exit(1);
}

console.log('MATHLIVE_STATIC_HYGIENE_RUNTIME_TRUTH_REPAIR_PACKAGE_READY_BUT_USER_SIDE_RUNTIME_FLUTTER_AND_DEVICE_EVIDENCE_REQUIRED');
