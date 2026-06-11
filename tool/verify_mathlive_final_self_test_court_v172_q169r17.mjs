#!/usr/bin/env node
import fs from 'node:fs';

import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_final_self_test_court_v172_q169r17.mjs', retiredPhase: 'verify_mathlive_final_self_test_court_v172_q169r17', reason: 'superseded by Q197/Q203 production-surface architecture and Q204R2 full test-suite migration; old diagnostic/fallback/court markers are no longer allowed in active production source or tests' });

const js = fs.readFileSync('assets/mathlive/mathlive_bridge.js', 'utf8');
const dart = fs.readFileSync('lib/features/mathlive/mathlive_main_editor_surface.dart', 'utf8');
const policy = fs.readFileSync('lib/features/mathlive/mathlive_final_self_test_court_policy.dart', 'utf8');
const manifest = fs.readFileSync('assets/mathlive/manifest.json', 'utf8');
const readme = fs.readFileSync('README.md', 'utf8');

const failures = [];
function requireContains(source, needle, label) {
  if (!source.includes(needle)) failures.push(label || needle);
}
function requireNotContains(source, needle, label) {
  if (source.includes(needle)) failures.push(label || `forbidden ${needle}`);
}

requireContains(policy, "phase = 'V172-Q169R17'", 'Q169R17 policy phase');
requireContains(policy, 'courtTimeout', 'Q169R17 court timeout');
requireContains(policy, 'runCourtAfterPostFireRefreshTimeout', 'Q169R17 post-fire court gate');
requireContains(dart, "import 'mathlive_final_self_test_court_policy.dart';", 'Dart imports Q169R17 policy');
requireContains(dart, "finalSelfTestCourtPhase = 'V172-Q169R17'", 'Dart phase constant');
requireContains(dart, '_q169R17FinalSelfTestCourtJson', 'Dart final court readback method');
requireContains(dart, '_applyQ169FinalSelfTestCourtJson', 'Dart final court apply method');
requireContains(dart, 'runQ169FinalSelfTestCourt', 'Dart calls final court JS endpoint');
requireContains(dart, 'COURT MOUNT:', 'visible court diagnostic summary');
requireContains(dart, 'finalSelfTestCourtPhase', 'Dart consumes async final court channel report');
requireContains(js, "finalSelfTestCourtPhase: 'V172-Q169R17'", 'JS state/bridge final court phase');
requireContains(js, 'function runQ169FinalSelfTestCourt(reason)', 'JS final self-test endpoint');
requireContains(js, 'function classifyQ169FinalSelfTestCourt(report)', 'JS final court root classifier');
requireContains(js, 'MOUNT', 'JS/static MOUNT marker');
requireContains(js, 'INSERT', 'JS/static INSERT marker');
requireContains(js, 'VALUE', 'JS/static VALUE marker');
requireContains(js, 'CHANNEL', 'JS/static CHANNEL marker');
requireContains(js, 'PAINT', 'JS/static PAINT marker');
requireContains(js, 'ROOT_CAUSE', 'JS/static ROOT_CAUSE marker');
requireContains(js, 'runQ169FinalSelfTestCourt: runQ169FinalSelfTestCourt', 'JS exports final court endpoint');
requireContains(js, 'window.MathProMathLiveState.postMessage(JSON.stringify(report))', 'JS pushes compact court report over Flutter channel');
requireContains(manifest, 'v172Q169R17FinalSelfTestCourt', 'manifest Q169R17 envelope');
requireContains(manifest, 'runQ169FinalSelfTestCourt', 'manifest final court endpoint');
requireContains(readme, 'V172-Q169R17 — MathLive Final Self-Test Court', 'README Q169R17 notes');
requireNotContains(dart, "import 'mathlive_final_self_test_court_policy.dart';\nimport 'mathlive_final_self_test_court_policy.dart';", 'duplicate Q169R17 import');

if (failures.length) {
  console.error('MATHLIVE_FINAL_SELF_TEST_COURT_Q169R17_FAILED');
  for (const failure of failures) console.error(` - ${failure}`);
  process.exit(1);
}

console.log('MATHLIVE_FINAL_SELF_TEST_COURT_PACKAGE_READY_BUT_REAL_DEVICE_ROOT_CAUSE_EVIDENCE_REQUIRED');
