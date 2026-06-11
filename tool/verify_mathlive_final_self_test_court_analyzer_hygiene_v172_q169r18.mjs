#!/usr/bin/env node
import fs from 'node:fs';

import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_final_self_test_court_analyzer_hygiene_v172_q169r18.mjs', retiredPhase: 'verify_mathlive_final_self_test_court_analyzer_hygiene_v172_q169r18', reason: 'superseded by Q197/Q203 production-surface architecture and Q204R2 full test-suite migration; old diagnostic/fallback/court markers are no longer allowed in active production source or tests' });

const dart = fs.readFileSync('lib/features/mathlive/mathlive_main_editor_surface.dart', 'utf8');
const policy = fs.readFileSync('lib/features/mathlive/mathlive_final_self_test_court_analyzer_hygiene_policy.dart', 'utf8');
const manifest = fs.readFileSync('assets/mathlive/manifest.json', 'utf8');
const readme = fs.readFileSync('README.md', 'utf8');

const failures = [];
function requireContains(source, needle, label) {
  if (!source.includes(needle)) failures.push(label || needle);
}
function requireNotContains(source, needle, label) {
  if (source.includes(needle)) failures.push(label || `forbidden ${needle}`);
}

requireContains(policy, "phase = 'V172-Q169R18'", 'Q169R18 policy phase');
requireContains(policy, 'repairsUnnecessaryStringEscapes = true', 'Q169R18 analyzer hygiene flag');
requireContains(dart, 'message.contains(\'"phase":"V172-Q169R17"\')', 'unescaped Q169R17 phase detector');
requireContains(dart, 'message.contains(\'"finalSelfTestCourtPhase"\')', 'unescaped court phase detector');
requireContains(dart, 'message.contains(\'"rootCause"\')', 'unescaped rootCause detector');
requireNotContains(dart, "message.contains('\\\"phase\\\":\\\"V172-Q169R17\\\"')", 'escaped Q169R17 detector removed');
requireNotContains(dart, "message.contains('\\\"finalSelfTestCourtPhase\\\"')", 'escaped court phase detector removed');
requireNotContains(dart, "message.contains('\\\"rootCause\\\"')", 'escaped rootCause detector removed');
requireContains(manifest, 'v172Q169R18FinalSelfTestCourtAnalyzerHygiene', 'manifest Q169R18 envelope');
requireContains(readme, 'V172-Q169R18 — MathLive Final Self-Test Court Analyzer Hygiene', 'README Q169R18 note');

if (failures.length) {
  console.error('MATHLIVE_FINAL_SELF_TEST_COURT_ANALYZER_HYGIENE_Q169R18_FAILED');
  for (const failure of failures) console.error(` - ${failure}`);
  process.exit(1);
}

console.log('MATHLIVE_FINAL_SELF_TEST_COURT_ANALYZER_HYGIENE_PACKAGE_READY_BUT_USER_SIDE_FLUTTER_ANALYZE_REQUIRED');
