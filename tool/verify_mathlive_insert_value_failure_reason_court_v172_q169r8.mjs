#!/usr/bin/env node
import { readFileSync, existsSync } from 'node:fs';

import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_insert_value_failure_reason_court_v172_q169r8.mjs', retiredPhase: 'verify_mathlive_insert_value_failure_reason_court_v172_q169r8', reason: 'superseded by Q197/Q203 production-surface architecture and Q204R2 full test-suite migration; old diagnostic/fallback/court markers are no longer allowed in active production source or tests' });

const checks = [];
function must(condition, message) {
  checks.push({ ok: !!condition, message });
}
function text(path) {
  if (!existsSync(path)) return '';
  return readFileSync(path, 'utf8');
}

const bridge = text('assets/mathlive/mathlive_bridge.js');
const surface = text('lib/features/mathlive/mathlive_main_editor_surface.dart');
const policy = text('lib/features/mathlive/mathlive_insert_value_failure_reason_court_policy.dart');
const manifest = text('assets/mathlive/manifest.json');

must(bridge.includes("insertValueFailureReasonCourtPhase: 'V172-Q169R8'"), 'bridge records Q169R8 phase');
must(bridge.includes('function setQ169FailureReason'), 'bridge has explicit failure reason setter');
must(bridge.includes('function readMathfieldValueDetailed'), 'bridge reads value with path/error details');
must(bridge.includes('lastValueApiPath'), 'bridge exports value API path');
must(bridge.includes('lastInsertPath'), 'bridge exports insert path');
must(bridge.includes('lastPaintRectState'), 'bridge exports paint rect state');
must(bridge.includes('value-api-empty-after-insert'), 'bridge can report value-api-empty-after-insert');
must(bridge.includes('insert-api-missing'), 'bridge can report insert API missing');
must(bridge.includes('insert-throw'), 'bridge can report insert throw');
must(bridge.includes('direct-value-commit-empty-after-write'), 'bridge can report direct value commit empty after write');
must(bridge.includes('paint-pending-empty-value'), 'bridge can report paint pending empty value');
must(bridge.includes('q169r8-failure-reason-court'), 'bridge tags Q169R8 failure reason court path');
must(!bridge.includes('rawInsertTokensMayBeUserVisible: true'), 'raw insert tokens are not allowed user-visible');

must(surface.includes('FAIL:$fail'), 'diagnostic overlay includes failure reason');
must(surface.includes('PATH:$valuePath'), 'diagnostic overlay includes value API path');
must(surface.includes('q169FailureReason'), 'surface parses q169FailureReason');
must(surface.includes('lastValueApiPath'), 'surface parses lastValueApiPath');
must(surface.includes('maxLines: 3'), 'diagnostic overlay can show failure reason without hiding key state');

must(policy.includes("phase = 'V172-Q169R8'"), 'policy exists for Q169R8');
must(policy.includes('keyboardLayoutMutationAllowed = false'), 'policy blocks keyboard layout mutation');
must(policy.includes('appShellMutationAllowed = false'), 'policy blocks AppShell mutation');
must(policy.includes('realDevicePassClaimed = false'), 'policy does not claim device pass');

const parsed = JSON.parse(manifest);
must(parsed.v172Q169R8InsertValueFailureReasonCourt?.phase === 'V172-Q169R8', 'manifest records Q169R8 envelope');
must(parsed.v172Q169R8InsertValueFailureReasonCourt?.realDevicePassClaimed === false, 'manifest does not claim real-device pass');
must(parsed.v172Q169R8InsertValueFailureReasonCourt?.rawInsertTokensMayBeUserVisible === false, 'manifest forbids raw token visibility');

const failed = checks.filter((check) => !check.ok);
if (failed.length > 0) {
  console.error('MATHLIVE_INSERT_VALUE_FAILURE_REASON_COURT_Q169R8_FAILED');
  for (const item of failed) console.error(' - ' + item.message);
  process.exit(1);
}

console.log('MATHLIVE_INSERT_VALUE_FAILURE_REASON_COURT_PACKAGE_READY_BUT_REAL_DEVICE_PAINT_EVIDENCE_REQUIRED');
