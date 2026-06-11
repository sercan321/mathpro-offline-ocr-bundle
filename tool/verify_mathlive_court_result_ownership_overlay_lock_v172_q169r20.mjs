#!/usr/bin/env node
import fs from 'node:fs';

import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_court_result_ownership_overlay_lock_v172_q169r20.mjs', retiredPhase: 'verify_mathlive_court_result_ownership_overlay_lock_v172_q169r20', reason: 'superseded by Q197/Q203 production-surface architecture and Q204R2 full test-suite migration; old diagnostic/fallback/court markers are no longer allowed in active production source or tests' });

const bridge = fs.readFileSync('assets/mathlive/mathlive_bridge.js', 'utf8');
const surface = fs.readFileSync('lib/features/mathlive/mathlive_main_editor_surface.dart', 'utf8');
const policy = fs.readFileSync('lib/features/mathlive/mathlive_channel_push_self_test_hard_binding_policy.dart', 'utf8');
const manifest = fs.readFileSync('assets/mathlive/manifest.json', 'utf8');

const failures = [];
function requireContains(label, haystack, needle) {
  if (!haystack.includes(needle)) failures.push(`${label}: missing ${needle}`);
}
function requireNotContains(label, haystack, needle) {
  if (haystack.includes(needle)) failures.push(`${label}: forbidden ${needle}`);
}

requireContains('bridge', bridge, "payload.channelPushOwnershipPhase = 'V172-Q169R20'");
requireContains('bridge', bridge, "payload.channelPushKind = isCourtPayload ? 'court' : 'compact'");
requireContains('bridge', bridge, 'Q169R20 compatibility marker');
requireContains('surface', surface, "static const String courtOverlayOwnershipPhase = 'V172-Q169R20'");
requireContains('surface', surface, 'bool _q169CourtOverlayLocked = false');
requireContains('surface', surface, 'MathLiveChannelPushSelfTestHardBindingPolicy.isCompactStatePayload(message)');
requireContains('surface', surface, 'COURT_RAW:compact CHANNEL:ok ROOT:compact-state-received-awaiting-court-result');
requireContains('surface', surface, 'MathLiveChannelPushSelfTestHardBindingPolicy.hasCompleteCourtFields(rawJson)');
requireContains('surface', surface, 'courtPayloadMissingFieldsSummary');
requireContains('surface', surface, 'if (!_q169CourtOverlayLocked)');
requireContains('policy', policy, "static const String ownershipPhase = 'V172-Q169R20'");
requireContains('policy', policy, 'static bool isCourtResultPayload(String message)');
requireContains('policy', policy, 'static bool isCompactStatePayload(String message)');
requireContains('policy', policy, 'static bool hasCompleteCourtFields(String message)');
requireContains('policy', policy, 'COURT_RAW:waiting');
requireContains('policy', policy, 'COURT_RAW:received CHANNEL:parse-fail ROOT:court-payload-missing-result-fields');
requireContains('manifest', manifest, 'v172Q169R20CourtResultOwnershipOverlayLock');
requireContains('manifest', manifest, 'compactPayloadMayNotEnterCourtParser');

requireNotContains('surface', surface, "'COURT MOUNT:unknown INSERT:unknown VALUE:unknown CHANNEL:fail PAINT:unknown ROOT:channel-push-request-failed'");

if (failures.length) {
  console.error('MATHLIVE_COURT_RESULT_OWNERSHIP_OVERLAY_LOCK_Q169R20_FAILED');
  for (const failure of failures) console.error(` - ${failure}`);
  process.exit(1);
}
console.log('MATHLIVE_COURT_RESULT_OWNERSHIP_OVERLAY_LOCK_PACKAGE_READY_BUT_REAL_DEVICE_COURT_EVIDENCE_REQUIRED');
