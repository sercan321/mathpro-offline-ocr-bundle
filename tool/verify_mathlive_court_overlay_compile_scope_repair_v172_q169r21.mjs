#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';
import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_court_overlay_compile_scope_repair_v172_q169r21.mjs', retiredPhase: 'verify_mathlive_court_overlay_compile_scope_repair_v172_q169r21', reason: 'superseded by Q197/Q203 production-surface architecture and Q204R2 full test-suite migration; old diagnostic/fallback/court markers are no longer allowed in active production source or tests' });

const root = process.cwd();
const surfacePath = path.join(root, 'lib/features/mathlive/mathlive_main_editor_surface.dart');
const policyPath = path.join(root, 'lib/features/mathlive/mathlive_court_overlay_compile_scope_repair_policy.dart');
const surface = fs.readFileSync(surfacePath, 'utf8');
const policy = fs.readFileSync(policyPath, 'utf8');
const failures = [];
function requireContains(source, needle, label) {
  if (!source.includes(needle)) failures.push(`${label} missing: ${needle}`);
}
function requireNotContains(source, needle, label) {
  if (source.includes(needle)) failures.push(`${label} forbidden: ${needle}`);
}
requireContains(policy, "phase = 'V172-Q169R21'", 'Q169R21 policy phase');
if (!surface.includes('if (_q169CourtOverlayLocked && this.mounted) {') && !surface.includes('if (_q169CourtOverlayLocked && mounted) {')) failures.push('court overlay lifecycle guard missing mounted check');
requireContains(surface, 'final runtimeMountedFromSnapshot = snapshot.runtime.contains', 'renamed runtime mounted local');
requireContains(surface, 'if (runtimeMountedFromSnapshot != _runtimeMounted || _runtimeBlocked) {', 'renamed runtime mounted comparison');
requireContains(surface, 'if (runtimeMountedFromSnapshot) {', 'renamed runtime mounted branch');
requireNotContains(surface, 'final mounted = snapshot.runtime.contains', 'pre-declaration mounted shadowing local');
// Q169R22 analyzer hygiene may use unqualified mounted after local shadowing was removed.
requireContains(surface, 'COURT_RAW:compact CHANNEL:ok ROOT:compact-state-received-awaiting-court-result', 'Q169R20 court compact overlay ownership marker preserved');
requireContains(surface, 'MathLiveChannelPushSelfTestHardBindingPolicy.isCompactStatePayload(message)', 'Q169R20 compact payload classifier preserved');
if (failures.length) {
  console.error('MATHLIVE_COURT_OVERLAY_COMPILE_SCOPE_REPAIR_Q169R21_FAILED');
  for (const failure of failures) console.error(` - ${failure}`);
  process.exit(1);
}
console.log('MATHLIVE_COURT_OVERLAY_COMPILE_SCOPE_REPAIR_PACKAGE_READY_BUT_USER_SIDE_FLUTTER_ANALYZE_REQUIRED');
