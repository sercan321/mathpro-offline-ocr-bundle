#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';
import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_channel_push_self_test_hard_binding_v172_q169r19.mjs', retiredPhase: 'verify_mathlive_channel_push_self_test_hard_binding_v172_q169r19', reason: 'superseded by Q197/Q203 production-surface architecture and Q204R2 full test-suite migration; old diagnostic/fallback/court markers are no longer allowed in active production source or tests' });

const root = process.cwd();
const read = (p) => fs.readFileSync(path.join(root, p), 'utf8');
const dart = read('lib/features/mathlive/mathlive_main_editor_surface.dart');
const js = read('assets/mathlive/mathlive_bridge.js');
const manifest = read('assets/mathlive/manifest.json');
const policy = read('lib/features/mathlive/mathlive_channel_push_self_test_hard_binding_policy.dart');
const failures = [];
function has(source, needle, label) { if (!source.includes(needle)) failures.push(`missing ${label}: ${needle}`); }
function not(source, needle, label) { if (source.includes(needle)) failures.push(`forbidden ${label}: ${needle}`); }
has(policy, "phase = 'V172-Q169R19'", 'policy phase');
has(dart, "import 'mathlive_channel_push_self_test_hard_binding_policy.dart';", 'Dart policy import');
has(dart, "channelPushSelfTestHardBindingPhase = 'V172-Q169R19'", 'Dart phase const');
has(dart, 'MathLiveChannelPushSelfTestHardBindingPolicy.shouldConsumeChannelPush(message)', 'Dart consumes channel-push court');
has(dart, '_requestQ169R19VisibleSelfTestCourt', 'Dart visible court request');
has(dart, 'runQ169FinalSelfTestCourtAndPush', 'Dart calls channel-push court API');
has(policy, 'COURT MOUNT:pending INSERT:pending VALUE:pending CHANNEL:push PAINT:pending ROOT:awaiting-channel-push-root-cause', 'policy pending visible court summary');
has(dart, 'MathLiveChannelPushSelfTestHardBindingPolicy.courtPendingSummary', 'Dart uses pending visible court summary');
has(js, "channelPushSelfTestHardBindingPhase: 'V172-Q169R19'", 'JS bridge phase');
has(js, 'function postQ169ChannelPushState', 'JS compact channel push function');
has(js, 'function runQ169FinalSelfTestCourtAndPush', 'JS visible court push function');
has(js, 'window.MathProMathLiveState.postMessage(JSON.stringify(payload))', 'JS posts compact payload');
has(js, "runQ169FinalSelfTestCourtAndPush('q169r19-initial-visible-self-test-court-channel-push')", 'JS initial automatic court');
has(js, 'postQ169ChannelPushState(getQ169CompactState', 'JS posts compact state after insert');
has(js, 'runQ169FinalSelfTestCourtAndPush: runQ169FinalSelfTestCourtAndPush', 'JS exports visible court API');
has(manifest, 'v172Q169R19ChannelPushSelfTestHardBinding', 'manifest envelope');
has(manifest, 'returningResultIsAuxiliaryOnly', 'manifest auxiliary returning-result');
not(dart, 'MathLiveChannelPushSelfTestHardBindingPolicy.courtPendingSummary;\n    return true;', 'court pending only without JS request');
if (failures.length) {
  console.error('MATHLIVE_CHANNEL_PUSH_SELF_TEST_HARD_BINDING_Q169R19_FAILED');
  for (const f of failures) console.error(' - ' + f);
  process.exit(1);
}
console.log('MATHLIVE_CHANNEL_PUSH_SELF_TEST_HARD_BINDING_PACKAGE_READY_BUT_REAL_DEVICE_ROOT_CAUSE_EVIDENCE_REQUIRED');
