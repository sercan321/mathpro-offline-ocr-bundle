#!/usr/bin/env node
import fs from 'node:fs';

import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_native_paint_ownership_authority_v172_q169r27.mjs', retiredPhase: 'verify_mathlive_native_paint_ownership_authority_v172_q169r27', reason: 'superseded by Q197/Q203 production-surface architecture and Q204R2 full test-suite migration; old diagnostic/fallback/court markers are no longer allowed in active production source or tests' });

const bridge = fs.readFileSync('assets/mathlive/mathlive_bridge.js', 'utf8');
const surface = fs.readFileSync('lib/features/mathlive/mathlive_main_editor_surface.dart', 'utf8');
const policy = fs.readFileSync('lib/features/mathlive/mathlive_native_paint_ownership_authority_policy.dart', 'utf8');
const manifest = fs.readFileSync('assets/mathlive/manifest.json', 'utf8');

const failures = [];
function requireContains(name, source, needle) {
  if (!source.includes(needle)) failures.push(`${name} missing ${needle}`);
}
function requireNotContains(name, source, needle) {
  if (source.includes(needle)) failures.push(`${name} must not contain ${needle}`);
}

requireContains('bridge', bridge, "nativePaintOwnershipAuthorityPhase: 'V172-Q169R27'");
requireContains('bridge', bridge, "readNativeMathfieldValueDetailed('q169r27-native-paint-proof-value-read')");
requireContains('bridge', bridge, "state.nativePaintOwner = (!!field && visibleStyle && hasRect && valueNonEmpty) ? 'mathlive-native-field' : 'not-native-owned'");
requireContains('bridge', bridge, "nativePaintOwner: state.nativePaintOwner || 'unknown'");
requireContains('bridge', bridge, "nativePaintProofValuePath: state.nativePaintProofValuePath");
requireContains('bridge', bridge, "q169r27-final-court-native-after-insert");
requireContains('bridge', bridge, "Q169R27 compatibility marker");
requireContains('surface', surface, "import 'mathlive_native_paint_ownership_authority_policy.dart';");
requireContains('surface', surface, "nativePaintOwnershipAuthorityPhase = MathLiveNativePaintOwnershipAuthorityPolicy.phase");
requireContains('surface', surface, "_q169NativePaintOwner");
requireContains('surface', surface, "MathLiveNativePaintOwnershipAuthorityPolicy.visiblePaint");
requireContains('surface', surface, "MathLiveNativePaintOwnershipAuthorityPolicy.rootCauseForNonNativePaint");
requireContains('policy', policy, "static const String phase = 'V172-Q169R27'");
requireContains('policy', policy, "nativePaintOwnsSurface");
requireContains('policy', policy, "nativeOwner = 'mathlive-native-field'");
requireContains('manifest', manifest, 'v172Q169R27NativePaintOwnershipAuthority');

// Hard gate: native paint proof path should not call mathfieldValue(), because that can fall back to state.latex.
const paintFn = bridge.slice(bridge.indexOf('function updateNativePaintCommitState'), bridge.indexOf('function markJsCommandStatus'));
if (!paintFn.includes('readNativeMathfieldValueDetailed')) failures.push('updateNativePaintCommitState must use native value reader');
if (paintFn.includes('const value = mathfieldValue()')) failures.push('updateNativePaintCommitState still uses mathfieldValue fallback');

if (failures.length) {
  console.error('MATHLIVE_NATIVE_PAINT_OWNERSHIP_AUTHORITY_Q169R27_FAILED');
  for (const failure of failures) console.error(' - ' + failure);
  process.exit(1);
}
console.log('MATHLIVE_NATIVE_PAINT_OWNERSHIP_AUTHORITY_PACKAGE_READY_BUT_REAL_DEVICE_PAINT_EVIDENCE_REQUIRED');
